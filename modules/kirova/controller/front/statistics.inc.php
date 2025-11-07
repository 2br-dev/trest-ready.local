<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\RenterApi;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Statistics extends Front
{
    function actionIndex()
    {
        $current_year = date('Y');
        $communal = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Communal())
            ->where(['year' => $current_year])
            ->exec()->fetchAll();
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
        $current_user = \RS\Application\Auth::getCurrentUser();
        $this->view->assign('user', $current_user);
        $this->view->assign('communal', $communal);
        return $this->result->setTemplate('%kirova%/statistics.tpl');
    }
}
