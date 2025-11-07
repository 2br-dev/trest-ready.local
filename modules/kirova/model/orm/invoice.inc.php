<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Invoice extends OrmObject
{
    protected static $table = 'invoice';

    function _init()
    {
        parent::_init()->append([
            'number' => new Type\Integer([
                'description' => t('Номер')
            ]),
            'date' => new Type\Date([
                'description' => t('Дата'),
            ]),
            'renter_string' => new Type\Varchar([
                'description' => t('Арендатор')
            ]),
            'renter_id' => new Type\Integer([
                'description' => t('Арендатор (id)')
            ]),
            'contract_id' => new Type\Integer([
                'description' => t('Договор (id)')
            ]),
            'period_month' => new Type\Varchar([
                'description' => t('Период (месяц)')
            ]),
            'period_year' => new Type\Varchar([
                'description' => t('Период (год)')
            ]),
            'sum' => new Type\Double([
                'description' => t('Сумма')
            ]),
            'discount_sum' => new Type\Double([
                'description' => t('Сумма со скидкой')
            ]),
            'is_discount' => new Type\Integer([
                'description' => t('Со скидкой?')
            ]),
            'forced_discount' => new Type\Integer([
                'description' => t('Принудительно со скидкой'),
                'default' => 0
            ]),
            'is_modified' => new Type\Integer([
                'description' => t('Модифицирован?')
            ]),
            'amount' => new Type\Double([
                'description' => t('Количество'),
                'visible' => false
            ]),
            'finish_discount' => new Type\Date([
                'description' => t('Окончание периода для оплты со скидкой (timestamp)'),
                'visible' => false
            ]),
            'new_ip' => new Type\Integer([
                'description' => t('ИП Кононович АА'),
                'checkboxView' => [1, 0]
            ])
        ]);
    }

    /**
     * Возвращает строковое значение месяца по номеру
     * @return string
     */
    public function getStringMonthByNumber()
    {
        switch ($this['period_month']){
            case '01':
                $string = 'Январь';
                break;
            case '02':
                $string = 'Февраль';
                break;
            case '03':
                $string = 'Март';
                break;
            case '04':
                $string = 'Апрель';
                break;
            case '05':
                $string = 'Май';
                break;
            case '06':
                $string = 'Июнь';
                break;
            case '07':
                $string = 'Июль';
                break;
            case '08':
                $string = 'Август';
                break;
            case '09':
                $string = 'Сентябрь';
                break;
            case '10':
                $string = 'Октябрь';
                break;
            case '11':
                $string = 'Ноябрь';
                break;
            case '12':
                $string = 'Декабрь';
                break;
            default:
                $string = 'Неопределено';
                break;
        }
        return $string;
    }

    public function beforeWrite($flag)
    {
        if($this == self::INSERT_FLAG){
            $this['new_ip'] = 1;
        }

    }
}
