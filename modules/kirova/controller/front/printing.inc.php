<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Printing extends Front
{
    function actionIndex()
    {
        $invoices = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Invoice())
            ->exec()->fetchAll();
        foreach ($invoices as $key => $value){
            $renter = new \Kirova\Model\Orm\Renter($value['renter_id']);
            $contract = new \Kirova\Model\Orm\Contract($value['contract_id']);
            $invoices[$key]['renter_short_title'] = $renter['short_title'];
            $invoices[$key]['contract_number'] = $contract['number'];
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
        $this->view->assign('invoices', $invoices);
        $current_user = \RS\Application\Auth::getCurrentUser();
        $this->view->assign('user', $current_user);
        return $this->result->setTemplate('%kirova%/print.tpl');
    }

    function actionGetForPrint()
    {
        $renter = $this->request('renter', TYPE_STRING);
        $period_month = $this->request('period_month', TYPE_STRING);
        $period_year = $this->request('period_year', TYPE_STRING);
        $error = '';

        $q = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Invoice());
        if($period_month){
            $q->where([
                'period_month' => $period_month,
            ]);
        }
        if($period_year != ''){
            $q->where([
                'period_year' => $period_year
            ]);
        }
        if(trim($renter) != ''){
            $renter_obj = \RS\Orm\Request::make()
                ->from(new \Kirova\Model\Orm\Renter())
                ->where([
                    'short_title' => $renter
                ])->object();
            $q->where([
                'renter_id' => $renter_obj['id']
            ]);
        }
        $q->orderby('number ASC');
        $invoices = $q->exec()->fetchAll();
        if(empty($invoices)){
            $error = 'empty';
        } else{
            foreach ($invoices as $key => $value){
                $renter = new \Kirova\Model\Orm\Renter($value['renter_id']);
                $contract = new \Kirova\Model\Orm\Contract($value['contract_id']);
                $invoices[$key]['renter_short_title'] = $renter['short_title'];
                $invoices[$key]['contract_number'] = $contract['number'];
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
        }
        $this->result->addSection('error', $error);
        $this->result->addSection('invoices', $invoices);
        return $this->result;
    }
}
