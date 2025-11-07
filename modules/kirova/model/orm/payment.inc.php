<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Payment extends OrmObject
{
    protected static $table = 'payment';

    function _init()
    {
        parent::_init()->append([
            'date' => new Type\Date([
                'description' => t('Дата'),
            ]),
            'number' => new Type\Integer([
                'description' => t('Номер')
            ]),
            'sum' => new Type\Double([
                'description' => t('Сумма')
            ]),
            'renter_id' => new Type\Integer([
                'description' => t('Арендатор')
            ]),
            'contract_id' => new Type\Integer([
                'description' => t('Договор')
            ])
        ]);
    }
}
