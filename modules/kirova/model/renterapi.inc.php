<?php

namespace kirova\Model;

use kirova\Model\Orm\Renter;
use RS\Module\AbstractModel\EntityList;

/**
 * Класс для организации выборок ORM объекта.
 * В этом классе рекомендуется также реализовывать любые дополнительные методы, связанные с заявленной в конструкторе моделью
 */
class RenterApi extends EntityList
{
    function __construct()
    {
        parent::__construct(new Renter(), [
            'nameField' => 'short_title',
        ]);
    }

    public function getByShortTitle($short_title)
    {
        $renter = $this->setFilter('short_title', $short_title)->getFirst()->getValues();
        return $renter;
    }
}
