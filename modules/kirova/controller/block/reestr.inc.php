<?php
/**
 * ReadyScript (http://readyscript.ru)
 *
 * @copyright Copyright (c) ReadyScript lab. (http://readyscript.ru)
 * @license http://readyscript.ru/licenseAgreement/
 */

namespace Kirova\Controller\Block;

use Catalog\Model\Api as ProductApi;
use Catalog\Model\DirApi;
use Catalog\Model\Orm\Dir;
use kirova\Model\ContractApi;
use kirova\Model\RenterApi;
use RS\Cache\Manager as CacheManager;
use RS\Controller\StandartBlock;
use RS\Debug\Action as DebugAction;
use RS\Debug\Tool as DebugTool;
use RS\Helper\Paginator;
use RS\Helper\Tools as HelperTools;
use RS\Module\AbstractModel\TreeList\AbstractTreeListIterator;
use RS\Orm\Type;

/**
 * Контроллер - топ товаров из указанных категорий одним списком
 */
class Reestr extends StandartBlock
{
    protected static $controller_title = 'Реестр Арендаторов';
    protected static $controller_description = 'Отображает реестр арендаторов с иформацией по договорам';

    protected $default_params = [
        'indexTemplate' => '%kirova%/blocks/reestr.tpl', //Должен быть задан у наследника
        'pageSize' => 100,
    ];
    protected $page;

    /** @var ProductApi $api */
    public $api;

    function init()
    {
        $this->api = new RenterApi();
    }

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
                    $active_contracts[$key]['status'] = 100; // Договор скоро заканчивается (через 2 месяца)
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
            foreach ($value->getRooms() as $room){
                // $room = new \Kirova\Model\Orm\Room($room_id);
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
        // Не действующие договоры
        $inactive_contracts = $contract_api->clearFilter()->setFilter('status', "0")->setOrder('number ASC')->getList();
        foreach($inactive_contracts as $key => $value){
            $renter = new \Kirova\Model\Orm\Renter($value['renter']);
            $inactive_contracts[$key]['renter_short_title'] = $renter['short_title'];
            $rooms = [];
            foreach ($value->getRooms() as $room){
                // $room = new \Kirova\Model\Orm\Room($room_id);
                $rooms[] = $room['number'];
            }
            $inactive_contracts[$key]['rooms'] = $rooms;
        }
        $this->view->assign('active_contracts', $active_contracts);
        $this->view->assign('inactive_contracts', $inactive_contracts);

        $current_user = \RS\Application\Auth::getCurrentUser();
        $this->view->assign('user', $current_user);
        return $this->result->setTemplate($this->getParam('indexTemplate'));
    }
}
