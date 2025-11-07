<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\Orm\Contract;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class RenterPayment extends Front
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
        $payments = !empty($contract) ? $contract->getAllPayments() : [];
        $invoices = !empty($contract) ? $contract->getAllInvoices() : [];

        $current_month = date('m');
        $current_year = date('Y');
        $already_exposed = false; // Выставлен ли счет за текущий месяц и год

        foreach ($invoices as $key => $value){
            if(($value['period_month'] == $current_month) && ($value['period_year'] == $current_year)){
                $already_exposed = true;
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
        if(!empty($archive_contracts)){
            foreach ($archive_contracts as $key => $value){
                /**
                 * @var \Kirova\Model\Orm\Contract $value
                 */
                $archive_contracts[$key]['payments'] = $value->getAllPayments();
            }
        }

        $this->view->assign('user', $current_user);
        $this->view->assign('payments', $payments);
        $this->view->assign('contract', $contract);
        $this->view->assign([
            'current_month' => $current_month,
            'current_year' => $current_year,
            'is_discount' => $is_discount,
            'already_exposed' => $already_exposed,
            'fake_balance' => $fake_balance,
            'archive_contracts' => $archive_contracts
        ]);
        return $this->result->setTemplate('%kirova%/renter-payment.tpl');
    }
}
