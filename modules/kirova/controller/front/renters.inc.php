<?php

namespace kirova\Controller\Front;

use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Renters extends Front
{
    function actionIndex()
    {
        return $this->result->setTemplate('test.tpl');
    }

    function actionGetAll()
    {
        $all_renters = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Renter())
            ->exec()->fetchAll();
        $this->result->addSection('renters', $all_renters);
        return $this->result;
    }

    function actionGetContractsByShortTitle()
    {
        $renter_short_title = $this->request('short_title', TYPE_STRING);
        $contracts_api = new \Kirova\Model\ContractApi();
        $renter_api = new \Kirova\Model\RenterApi();
        $renter = $renter_api->getByShortTitle($renter_short_title);
        $contracts = $contracts_api->getAllContractsByRenterId($renter['id']);
        $this->result->addSection('contracts', $contracts);
        return $this->result;
    }
}
