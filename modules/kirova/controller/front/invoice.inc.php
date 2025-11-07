<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\Orm\Contract;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Invoice extends Front
{
    function actionIndex()
    {
        $contracts_api = new ContractApi();
        $active_contracts = $contracts_api->getActiveContracts();
        $arch_contracts = $contracts_api->getArchContracts();
        $this->view->assign('active_contracts', $active_contracts);
        $this->view->assign('arch_contracts', $arch_contracts);
        $current_user = \RS\Application\Auth::getCurrentUser();
        $this->view->assign('user', $current_user);
        return $this->result->setTemplate('%kirova%/invoice.tpl');
    }

    /**
     * Выставление счетов
     * @return \RS\Controller\Result\Standard
     */
    function actionGenerateInvoices()
    {
        // TO-DO - проверить период выставляемого счета на соответстве даты начала договора
        $contracts_id = $this->request('contract', TYPE_MIXED, []); // Список договоров для выставления счетов
        $custom_sum = $this->request('custom_sum', TYPE_MIXED); // Списко кастомынх сумм для договоров (ключ - номер договора)
        $is_custom_number = $this->request('is_custom_number', TYPE_STRING); // Начать нумерацию с еденицы
        $custom_number = $this->request('custom_number', TYPE_INTEGER, 0); // Начать нумерацию с еденицы
        $date = $this->request('date-timestamp', TYPE_MIXED, 0); // таймстэмп выбранной даты
        $period_month = $this->request('period_month', TYPE_STRING, ''); // Месяц выставления счета
        $period_year = $this->request('period_year', TYPE_STRING, ''); // Года выставленеия счета
        $amount = 1;

        $invoice_api = new \Kirova\Model\InvoiceApi();

        $config = \RS\Config\Loader::byModule('kirova');

        $error = '';
        $success = false;

        if(!$date){
            $error = 'date';
        }
        if(!$period_month){
            $error = 'period_month';
        }
        if(!$period_year){
            $error = 'period_year';
        }
        if(empty($contracts_id)){
            $error = 'contracts';
        }
        // Проверка - был ли уже выставлен счет за выбранный период
        $same = $config->checkTheSameInvoices($contracts_id, $period_month, $period_year); // Проверка - был ли выставлени счет для выбранных договоров за выбранный период
        $same_renter = ''; // Те арендаторы которым были уже выставленные счета за выбранный период
        if($same != ''){
            $error = 'same';
            foreach ($same as $item){
                $renter = new \Kirova\Model\Orm\Renter($item['renter_id']);
                $same_renter = $same_renter . $renter['short_title'] . ', ';
            }
        }
        // Проверка на то что выбранный период не соответствует условиям договора.
//        $fail_period = $config->checkInvoicePeriod($contracts_id, $period_month, $period_year);
//        $contract_error_period = '';
//        if($fail_period != ''){
//            $error = 'period';
//            foreach($fail_period as $id){
//                $contract_with_error = new \Kirova\Model\Orm\Contract($id);
//                $contract_error_period = $contract_error_period . $contract_with_error['number'] . ', ';
//            }
//        }

        if($error == ''){
            // Получим запись с максимальным значением id - чтоб от неё продолжить нумерацию.
            $last_invoice = $invoice_api->getLast();

            if($last_invoice)
                if($is_custom_number == 'on'){
                    $next_number = $custom_number;
                }else {
                    $next_number = $last_invoice['number'] + 1;
                }
            else{
                $next_number = 1;
            }
            foreach ($contracts_id as $contract_id){
                /**
                 * @var \Kirova\Model\Orm\Contract $contract
                 */
                $contract = new \Kirova\Model\Orm\Contract($contract_id);
                $renter = $contract->getRenter();
                $invoice = new \Kirova\Model\Orm\Invoice();
                $invoice['number'] = $next_number;
                $next_number++;
                $invoice['date'] = date('Y-m-d', $date);
                $invoice['renter_string'] = $renter['title'];
                $invoice['renter_id'] = $renter['id'];
                $invoice['contract_id'] = $contract_id;
                $invoice['period_month'] = $period_month;
                $invoice['period_year'] = $period_year;
                $dop = false;
                if($contract['has_dop']){
                    $dop = $contract->getActualSumForInvoice($period_month, $period_year);
                }
                //Определить дату начала аренды
                $contract_start_payment_month = date('m',strtotime($contract['start_payment'])); // месяц начала аренды
                $contract_start_payment_year = date('Y',strtotime($contract['start_payment'])); // год начала аренды

                if($period_month == $contract_start_payment_month && $period_year == $contract_start_payment_year){
                    $contract_start_payment_day = date('j',strtotime($contract['start_payment'])); // день начала аренды без первого 0
                    if($contract_start_payment_day > 1){
                        $count_day_in_month = date('t',strtotime($contract['start_payment']));
                        $amount = ($count_day_in_month - $contract_start_payment_day + 1)/$count_day_in_month; // +1 - чтоб учесть первый день аренды включительно
                        $amount = round($amount, 2);

                    }
                    $finish_discount = date('Y-m-d', strtotime('+'.$config['first_month_discount_day'].' days', strtotime($contract['start_payment'])));
                }else{
                    $finish_discount = date('Y-m-d', strtotime('+'.$config['day_with_discount'].' days', strtotime($period_year.'-'.$period_month.'-01')));
                }
                if($custom_sum != NULL){
                    foreach ($custom_sum as $key => $value) {
                        if($key == $contract_id){
                            $invoice['sum'] = intval($custom_sum[$contract_id]);
                            $invoice['discount_sum'] = intval($custom_sum[$contract_id]);
                            $invoice['is_modified'] = 1;
                        } else{
                            if($dop){
                                $invoice['sum'] = $dop['sum'] * $amount;
                                $invoice['discount_sum'] = $dop['sum_discount'] * $amount;
                                $invoice['is_modified'] = 0;
                            }else {
                                $invoice['sum'] = $contract['sum'] * $amount;
                                $invoice['discount_sum'] = $contract['sum_discount'] * $amount;
                                $invoice['is_modified'] = 0;
                            }
                        }
                    }
                } else{
                    if($dop){
                        $invoice['sum'] = $dop['sum'] * $amount;
                        $invoice['discount_sum'] = $dop['sum_discount'] * $amount;
                        $invoice['is_modified'] = 0;
                    }else {
                        $invoice['sum'] = $contract['sum'] * $amount;
                        $invoice['discount_sum'] = $contract['sum_discount'] * $amount;
                        $invoice['is_modified'] = 0;
                    }
                }
                $invoice['is_discount'] = 0;
                $invoice['amount'] = $amount;
                $invoice['finish_discount'] = $finish_discount;
                $success = $invoice->insert();
//                $contract['balance'] = $contract['balance'] + $invoice['sum'];
//                $contract->update();
            }
//        }else {
//            $success = false;
        }
        $this->result->addSection('error', $error);
        $this->result->addSection('success', $success);
        $this->result->addSection('same_renter', $same_renter);
        return $this->result;
    }

    /**
     * Удаление счета
     * @return \RS\Controller\Result\Standard
     */
    public function actionRemove()
    {
        $id = $this->url->request('id', TYPE_INTEGER);
        $invoice = new \Kirova\Model\Orm\Invoice($id);
        $this->result->addSection('id', $id);
        if($invoice->delete()){
            $this->result->setSuccess(true);
        }else{
            $this->result->setSuccess(false);
        }
        return $this->result;
    }

    public function actionGetListInvoicePopup()
    {
        $contract_id = $this->url->request('id', TYPE_INTEGER);
        $contract = new \Kirova\Model\Orm\Contract($contract_id);
        $invoices = $contract->getAllInvoices();
        $renter = new \Kirova\Model\Orm\Renter($contract['renter']);
        foreach ($invoices as $key => $value){
            switch ($value['period_month']){
                case '01':
                    $invoices[$key]['period_month_string'] = 'Январь';
                    break;
                case '02':
                    $invoices[$key]['period_month_string'] = 'Февраль';
                    break;
                case '03':
                    $invoices[$key]['period_month_string'] = 'Март';
                    break;
                case '04':
                    $invoices[$key]['period_month_string'] = 'Апрель';
                    break;
                case '05':
                    $invoices[$key]['period_month_string'] = 'Май';
                    break;
                case '06':
                    $invoices[$key]['period_month_string'] = 'Июнь';
                    break;
                case '07':
                    $invoices[$key]['period_month_string'] = 'Июль';
                    break;
                case '08':
                    $invoices[$key]['period_month_string'] = 'Август';
                    break;
                case '09':
                    $invoices[$key]['period_month_string'] = 'Сентябрь';
                    break;
                case '10':
                    $invoices[$key]['period_month_string'] = 'Октябрь';
                    break;
                case '11':
                    $invoices[$key]['period_month_string'] = 'Ноябрь';
                    break;
                case '12':
                    $invoices[$key]['period_month_string'] = 'Декабрь';
                    break;
            }
        }
        $this->view->assign([
            'renter' => $renter,
            'invoices' => $invoices,
            'contract' => $contract
        ]);
        return $this->result->setTemplate('%kirova%/list-invoice-popup.tpl');
    }

    /**
     * Переводит счет в статус - принудительно со скидкой
     * @return \RS\Controller\Result\Standard
     */
    public function actionForcedDiscount()
    {
        $invoice_id = $this->url->request('id', TYPE_INTEGER);
        $success = false;
        $invoice = new \Kirova\Model\Orm\Invoice($invoice_id);
        $sum_discount = $invoice['discount_sum'];
        $invoice['forced_discount'] = 1;
        $invoice['is_discount'] = 1;
        $invoice['sum'] = $sum_discount;
        $success = $invoice->update();
        $this->result->setSuccess($success);
        $this->result->addSection('id', $invoice_id);
        return $this->result;
    }

}
