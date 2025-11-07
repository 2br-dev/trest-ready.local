<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\Orm\Contract;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class RenterInvoice extends Front
{
    function actionIndex()
    {
        $current_user = \RS\Application\Auth::getCurrentUser();
        $contract_api = new \Kirova\Model\ContractApi();
        /**
         * @var \Kirova\Model\Orm\Contract $contract
         */
        $contract = $contract_api->setFilter('renter', $current_user['renter_id'])->setFilter('status', 0, '<>')->getFirst();
        $archive_contracts = $contract_api->clearFilter()->setFilter('renter', $current_user['renter_id'])->setFilter('status', 0)->getList();
        $invoices = !empty($contract) ? $contract->getAllInvoices() : [];
        $current_date_timestamp = strtotime(date('Y-m-d'));
        $current_month = date('m');
        $current_year = date('Y');
        $already_exposed = false; // Выставлен ли счет за текущий месяц и год    
        foreach ($invoices as $key => $value){
            /**
             * @var \Kirova\Model\Orm\Invoice $value
             */
            if(($value['period_month'] == $current_month) && ($value['period_year'] == $current_year)){
                $already_exposed = true;
            }
            $invoices[$key]['period_month_string'] = $value->getStringMonthByNumber();
        }
        foreach ($archive_contracts as $key => $archive_contract){
            /**
             * @var \Kirova\Model\Orm\Contract $archive_contract
             */
            $archive_invoices = !empty($archive_contract) ? $archive_contract->getAllInvoices() : [];
            $archive_contracts[$key]['invoices'] = $archive_invoices;
            foreach ($archive_invoices as $key_invoice => $invoice){
                /**
                 * @var \Kirova\Model\Orm\Invoice $invoice
                 */
                $archive_contracts[$key]['invoices'][$key_invoice]['period_month_string'] = $invoice->getStringMonthByNumber();
            }
        }
        $config = \RS\Config\Loader::byModule('kirova');
        $is_discount = false;
        $invoice_api = new \Kirova\Model\InvoiceApi();
        $last_invoice = $invoice_api->setFilter('period_month', $current_month)
                        ->setFilter('period_year', $current_year)
                        ->setFilter('contract_id', $contract['id'])
                        ->getFirst();
        $fake_balance = 0;
        if($already_exposed){
            // Проверяем условие - если текущий день уже после дня для представления скидки
           
            if(intval(date('d')) > $config['day_with_discount']){
                // Проверяем условие если баланс положительный то скидка все равно будет предоставлена
                if($contract['balance'] >= 0){
                    $is_discount = true;
                }else{
                    $is_discount = false;
                }
            }else{
                // Если счет за последний месяц выставлен и баланс отрицателен на сумму счета без скидки
                if(($contract['balance'] < 0)){
                    $is_discount = true;
                    $fake_balance = $contract['balance'] + ($last_invoice['sum'] - $last_invoice['discount_sum']);
                }
                if($contract['balance'] > 0){
                    $is_discount = true;
                }
            }
        }
        // echo '<pre>';
        // var_dump($already_exposed);
        // var_dump($is_discount);
        // var_dump($invoices);
        // exit();
        $this->view->assign('user', $current_user);
        $this->view->assign('invoices', $invoices);
        $this->view->assign([
            'current_month' => $current_month,
            'current_year' => $current_year,
            'is_discount' => $is_discount,
            'already_exposed' => $already_exposed,
            'contract' => $contract,
            'fake_balance' => $fake_balance,
            'archive_contracts' => $archive_contracts
        ]);
        return $this->result->setTemplate('%kirova%/renter-invoice.tpl');
    }
}
