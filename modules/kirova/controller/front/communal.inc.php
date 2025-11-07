<?php

namespace kirova\Controller\Front;

use kirova\Model\CommunalApi;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Communal extends Front
{
    function actionIndex()
    {
        return $this->result->setTemplate('%kirova%/statistics.tpl');
    }

    /**
     * Добавляет запись коммунальные платежи в бд
     * @return \RS\Controller\Result\Standard
     */
    public function actionAddCommunal()
    {
        $data = $_POST;
        $error = '';
        $success = false;
        $api = new CommunalApi();
        if($data['period_month'] == '0' || $data['period_year'] == ''){
            $error = 'period';
        }
        if($data['summa'] == '' || $data['summa'] == 0){
            $error = 'summa';
        }
        if($data['volume'] == '' || $data['volume'] == 0){
            $error = 'volume';
        }
        if($data['type'] == '0'){
            $error = 'type';
        }
        if($api->checkTheSame($data['period_month'], $data['period_year'], $data['type'])){
            $error = 'same';
        }
        if($error == ''){
            $communal = new \Kirova\Model\Orm\Communal();
            $communal['month'] = $data['period_month'];
            $communal['year'] = $data['period_year'];
            $communal['type'] = $data['type'];
            $communal['summa'] = floatval($data['summa']);
            $communal['volume'] = floatval($data['volume']);
            $communal['rate'] = number_format((floatval($data['summa']) / floatval($data['volume'])), 2);
            $success = $communal->insert();
        }
        $this->result->setSuccess($success);
        $this->result->addSection('error', $error);
        return $this->result;
    }

    public function actionSetFilter()
    {
        $data = $_POST;
        $q = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Communal());
        if($data['period_month'] != '0'){
            $q->where(['month' => $data['period_month']]);
        }
        if($data['year'] != ''){
            $q->where(['year' => $data['year']]);
        }
        if($data['type'] != '0'){
            $q->where(['type' => $data['type']]);
        }
        $communal = $q->exec()->fetchAll();
        foreach ($communal as $key => $value){
            switch ($value['month']){
                case '01':
                    $communal[$key]['month_string'] = 'Январь';
                    break;
                case '02':
                    $communal[$key]['month_string'] = 'Февраль';
                    break;
                case '03':
                    $communal[$key]['month_string'] = 'Март';
                    break;
                case '04':
                    $communal[$key]['month_string'] = 'Апрель';
                    break;
                case '05':
                    $communal[$key]['month_string'] = 'Май';
                    break;
                case '06':
                    $communal[$key]['month_string'] = 'Июнь';
                    break;
                case '07':
                    $communal[$key]['month_string'] = 'Июль';
                    break;
                case '08':
                    $communal[$key]['month_string'] = 'Август';
                    break;
                case '09':
                    $communal[$key]['month_string'] = 'Сентябрь';
                    break;
                case '10':
                    $communal[$key]['month_string'] = 'Октябрь';
                    break;
                case '11':
                    $communal[$key]['month_string'] = 'Ноябрь';
                    break;
                case '12':
                    $communal[$key]['month_string'] = 'Декабрь';
                    break;
            }
            switch ($value['type']){
                case 'energy':
                    $communal[$key]['type_string'] = 'Электроэнергия';
                    break;
                case 'water':
                    $communal[$key]['type_string'] = 'Вода';
                    break;
                case 'heating':
                    $communal[$key]['type_string'] = 'Отопление';
                    break;
                case 'trash':
                    $communal[$key]['type_string'] = 'Вывоз мусора';
                    break;
                case 'other':
                    $communal[$key]['type_string'] = 'Прочее';
                    break;
            }
        }
        return $communal;
    }
}
