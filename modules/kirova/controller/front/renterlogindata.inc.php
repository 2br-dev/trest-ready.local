<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\RenterApi;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class RenterLoginData extends Front
{
    function actionIndex()
    {
        $renter_api = new \Kirova\Model\RenterApi();
        $renters = $renter_api->getList();
        $this->view->assign('renters', $renters);
        return $this->result->setTemplate('%kirova%/renter-login-data.tpl');
    }
}
