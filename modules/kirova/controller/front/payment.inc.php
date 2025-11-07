<?php

namespace kirova\Controller\Front;

use RS\Config\Loader;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Payment extends Front
{
    function actionIndex()
    {
        $payments = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Payment())
            ->limit(100)
            ->orderby('date DESC')
            ->exec()->fetchAll();
        foreach($payments as $key => $value){
            $renter = new \Kirova\Model\Orm\Renter($value['renter_id']);
            $payments[$key]['renter_short_title'] = $renter['short_title'];
        }
        $this->view->assign('payments', $payments);
        $current_user = \RS\Application\Auth::getCurrentUser();
        $this->view->assign('user', $current_user);
        return $this->result->setTemplate('payment.tpl');
    }

    /**
     * Вностит оплаты в бд
     * @return \RS\Controller\Result\Standard
     */
    public function actionAddPayment()
    {
        $renter_short_title = $this->request('renter', TYPE_STRING);
        $contract_id = $this->request('contract', TYPE_INTEGER);
        $number = $this->request('number', TYPE_INTEGER);
        $summa = $this->request('summa', TYPE_INTEGER);
        $date_timestamp = $this->request('date_timestamp', TYPE_MIXED);

        $error = '';
        $success = false;

        $config = Loader::byModule('kirova');
        $renter_api = new \Kirova\Model\RenterApi();

        if($renter_short_title == ''){
            $error = 'renter';
        }
        if($contract_id == 0){
            $error = 'contract';
        }
        if($number == ''){
            $error = 'number';
        }
        if($summa == 0 || $summa == ''){
            $error = 'summa';
        }
        if($date_timestamp == 0){
            $error = 'date';
        }
        if($error == ''){
            $renter = $renter_api->getByShortTitle($renter_short_title);
            // Проверка на существование одинаковых записей в бд
            $same = $config->checkTheSamePayment($renter['id'], $contract_id, $number, $summa, date('Y-m-d', $date_timestamp));
            if($same){
                $error = 'same';
            }
        }

        if($error == ''){
            $payment = new \Kirova\Model\Orm\Payment();
            $payment['date'] = date('Y-m-d', $date_timestamp);
            $payment['renter_id'] = $renter['id'];
            $payment['contract_id'] = $contract_id;
            $payment['sum'] = $summa;
            $payment['number'] = $number;
            $success = $payment->insert();
        }
        $this->result->addSection('error', $error);
        $this->result->setSuccess($success);
        return $this->result;

    }

    /**
     * Фильтр по оплатам
     * @return \RS\Controller\Result\Standard
     */
    public function actionFilterPayments()
    {
        $renter_short_title = $this->request('renter', TYPE_STRING);
        $payment_data_start = $this->request('payment-data-start', TYPE_INTEGER);
        $payment_data_finish = $this->request('payment-data-finish', TYPE_INTEGER);

        $renter_api = new \Kirova\Model\RenterApi();
        $error = '';
        $success = false;
        $payments = [];

        if($payment_data_start > $payment_data_finish){
            $error = 'data';
        }
        if($renter_short_title == '' && !$payment_data_start && !$payment_data_finish){
            $error = 'empty';
        }
        $q = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Payment());
        if(trim($renter_short_title) != ''){
            $renter = $renter_api->getByShortTitle($renter_short_title);
            if(!$renter){
                $error = 'renter';
            }else{
                $q->where(['renter_id' => $renter['id']]);
            }
        }
        // переводим timestamp в формат даты которая хранится в бд для платежей
        $payment_data_start = $payment_data_start ? date('Y-m-d', $payment_data_start) : 0;
        $payment_data_finish = $payment_data_finish ? date('Y-m-d', $payment_data_finish): 0;

        if($payment_data_start && !$payment_data_finish ){
            $q->where('date >= '.$payment_data_start.'');
        }
        if(!$payment_data_start && $payment_data_finish){
            $q->where('date <='.$payment_data_finish.'');
        }
        if($payment_data_start && $payment_data_finish){
            $q->where('date >= '.$payment_data_start.' AND date <= '.$payment_data_finish.'');
        }
        if($error == ''){
            $payments = $q->exec()->fetchAll();
            $success = true;
        }
        if(!empty($payments)){
            foreach($payments as $key => $value) {
                $renter = new \Kirova\Model\Orm\Renter($value['renter_id']);
                $payments[$key]['renter_short_title'] = $renter['short_title'];
                $date = date_create($value['date']);
                $payments[$key]['date'] = date_format($date, 'd.m.Y');
            }
        }
        $this->result->setSuccess($success);
        $this->result->addSection('error', $error);
        $this->result->addSection('payments', $payments);
        return $this->result;
    }

    /**
     * Сброс фильтра платежей
     * @return \RS\Controller\Result\Standard
     */
    public function actionResetFilter()
    {
        $payments = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Payment())
            ->limit(100)
            ->orderby('date DESC')
            ->exec()->fetchAll();
        foreach($payments as $key => $value){
            $renter = new \Kirova\Model\Orm\Renter($value['renter_id']);
            $payments[$key]['renter_short_title'] = $renter['short_title'];
            $date = date_create($value['date']);
            $payments[$key]['date'] = date_format($date, 'd.m.Y');
        }
        $this->result->addSection('payments', $payments);
        return $this->result;
    }

    public function actionGetAddPaymentPopup()
    {
        $contract_id = $this->url->request('id', TYPE_INTEGER);
        $contract = new \Kirova\Model\Orm\Contract($contract_id);
        $renter = new \Kirova\Model\Orm\Renter($contract['renter']);
        $this->view->assign([
            'contract_id' => $contract_id,
            'renter' => $renter
        ]);
        return $this->result->setTemplate('%kirova%/add-payment-popup.tpl');
    }

    public function actionGetListPaymentPopup()
    {
        $contract_id = $this->url->request('id', TYPE_INTEGER);
        $contract = new \Kirova\Model\Orm\Contract($contract_id);
        $payments = $contract->getAllPayments();
        $renter = new \Kirova\Model\Orm\Renter($contract['renter']);
        $this->view->assign([
            'renter' => $renter,
            'payments' => $payments
        ]);
        return $this->result->setTemplate('%kirova%/list-payment-popup.tpl');
    }
}
