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
class Renter extends StandartBlock
{
    protected static $controller_title = 'Главная страница для Арендатора';
    protected static $controller_description = 'Отображает страницу для арендатора';

    protected $default_params = [
        'indexTemplate' => '%kirova%/blocks/renter.tpl', //Должен быть задан у наследника
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
        $current_user = \RS\Application\Auth::getCurrentUser();
        $contract_api = new \Kirova\Model\ContractApi();
        $renter = new \Kirova\Model\Orm\Renter($current_user['renter_id']);
        /**
         * @var \Kirova\Model\Orm\Contract $contract
         */
        $contract = $contract_api->setFilter('renter', $current_user['renter_id'])->setFilter('status', 0, '<>')->getFirst();
        $archive_contracts = $contract_api->clearFilter()->setFilter('renter', $current_user['renter_id'])->setFilter('status', 0)->getList();
        if(!empty($contract)){
        	// $contract->refreshBalance(); // Каждый раз при перезагрузки обновляем баланс договора
        	$contract_rooms = $contract->getRooms();
        	foreach ($contract_rooms as $room){
	            $room_array = $room->getValues();
	            $rooms[] = $room_array['number'];
	        }
	        $contract['rooms'] = $rooms;
	        if($contract['has_dop']){
	            $actual_sum = $contract->getActualSum();
	            if($actual_sum){
	                $contract['sum'] = $actual_sum['sum'];
	                $contract['sum_discount'] = $actual_sum['sum_discount'];
	            }

	        }

	        $current_month = date('m');
	        $current_year = date('Y');
	        $already_exposed = false;
	        $invoices = $contract->getAllInvoices();
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
	                        ->setFilter('renter_id', $contract['renter'])
	                        ->getFirst();
	        //Проверяем выставлен ли уже счет за текущий месяц
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
        }
        

        $this->view->assign([
            'renter' => $renter,
            'contract' => $contract,
            'is_discount' => $is_discount,
            'already_exposed' => $already_exposed,
            'fake_balance' => $fake_balance,
            'archive_contracts' => $archive_contracts
        ]);
        return $this->result->setTemplate($this->getParam('indexTemplate'));
    }
}
