<?php

namespace kirova\Controller\Front;

use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Reconciliation extends Front
{
    function actionIndex()
    {
        return $this->result->setTemplate('%kirova%/reconciliation.tpl');
    }
}
