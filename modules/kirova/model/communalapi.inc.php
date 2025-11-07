<?php

namespace kirova\Model;

use kirova\Model\Orm\Communal;
use RS\Module\AbstractModel\EntityList;

/**
 * Класс для организации выборок ORM объекта.
 * В этом классе рекомендуется также реализовывать любые дополнительные методы, связанные с заявленной в конструкторе моделью
 */
class CommunalApi extends EntityList
{
    function __construct()
    {
        parent::__construct(new Communal(), [
            'nameField' => 'id',
        ]);
    }

    public function checkTheSame($month, $year, $type)
    {
        $same = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Communal())
            ->where([
                'month' => $month,
                'year' => $year,
                'type' => $type
            ])->exec()->fetchRow();
        if($same){
            return true;
        }
        return false;
    }
}
