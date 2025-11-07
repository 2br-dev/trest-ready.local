<?php

namespace kirova\Model;

use kirova\Model\Orm\Invoice;
use RS\Module\AbstractModel\EntityList;

/**
 * Класс для организации выборок ORM объекта.
 * В этом классе рекомендуется также реализовывать любые дополнительные методы, связанные с заявленной в конструкторе моделью
 */
class InvoiceApi extends EntityList
{
    function __construct()
    {
        parent::__construct(new Invoice());
    }

    public function getMonthStringByNumber(){
        $string = '';
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
        }
        return $string;
    }

    /**
     * Возвращает последний выставленный счет
     * @return array
     */
    public function getLast()
    {
        $last_invoice = \RS\Orm\Request::make()
            ->select('number')
            ->from(new \Kirova\Model\Orm\Invoice())
            ->orderby('id DESC')
            ->limit(1)
            ->exec()->fetchRow();
        return $last_invoice;
    }
}
