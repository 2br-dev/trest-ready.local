<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\RenterApi;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Reestr extends Front
{
    function actionIndex()
    {
        // Каждый раз проверять статусы договоров, текущую дату и дату окончания. Подсвечивать арендаторов у которых через 2 мес. заканчивается договор
        $contract_api = new ContractApi();
        $active_contracts = $contract_api
                                ->setFilter('status', 1 )
                                ->setFilter('status', 100, '=', 'OR')
                                ->getList();
        $current_date = date('Y-m-d');
        // Проходим по всем действующим договорам и проверяем не закончились ли они
        foreach ($active_contracts as $key => $value){
            /**
             * @var \Kirova\Model\Orm\Contract $value
             */
            $date_finish = $value['date_finish']; // Дата окончания договора
            // Если есть доп. соглашение в котором меняется дата окончания аренды то меняем дату окончания аренды
            if($value['has_dop']){
                $dop = $value->getActualDop('date_finish');
                if(!empty($dop)){
                    $date_finish = $dop['date_finish'];
                }
            }
            if(strtotime($current_date) > strtotime($date_finish)){
                $active_contracts[$key]['status'] = 0; // Договор Закончился
                $active_contracts[$key]->update();
            }else {
                if ((strtotime($date_finish) - strtotime($current_date)) < 2419200) {
                    $active_contracts[$key]['status'] = 100; // Договор скоро заканчивается
                    $active_contracts[$key]->update();
                }
            }
        }
        $active_contracts = $contract_api
            ->setFilter('status', 1 )
            ->setFilter('status', 100, '=', 'OR')
            ->setOrder('number ASC')
            ->getList();
        foreach($active_contracts as $key => $value){
            $renter = new \Kirova\Model\Orm\Renter($value['renter']);
            $active_contracts[$key]['renter_short_title'] = $renter['short_title'];
            $rooms = [];
            foreach ($value['room'] as $room_id){
                $room = new \Kirova\Model\Orm\Room($room_id);
                $rooms[] = $room['number'];
            }
            $active_contracts[$key]['rooms'] = $rooms;
            $invoice = $contract_api->checkLastInvoice($value['id']);
            if($invoice){
                $active_contracts[$key]['last-invoice'] = true;
            }else{
                $active_contracts[$key]['last-invoice'] = false;
            }
        }
//        echo '<pre>';
//        var_dump($active_contracts);
//        exit();
        $this->view->assign('active_contracts', $active_contracts);
        $current_user = \RS\Application\Auth::getCurrentUser();
        $this->view->assign('user', $current_user);
        return $this->result->setTemplate('%kirova%/reestr.tpl');
    }

    public function actionGetFullData(){
        $id = $this->request('id', TYPE_INTEGER);
        $contract_api = new ContractApi();
        $renter_api = new RenterApi();
        $contract = $contract_api->getById($id)->getValues();
        $contract['date_start'] = date_format(date_create($contract['date_start']), 'd.m.Y');
        $contract['date_finish'] = date_format(date_create($contract['date_finish']), 'd.m.Y');
        foreach ($contract['room'] as $key => $value){
            $room = new \Kirova\Model\Orm\Room($value);
            $contract['rooms_number'][$key] = $room['number'];
        }
        $renter = $renter_api->getById($contract['renter'])->getValues();
        $this->result->addSection('contract', $contract);
        $this->result->addSection('renter', $renter);
        return $this->result;
    }
}
