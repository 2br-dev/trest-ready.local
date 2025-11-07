<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Room extends OrmObject
{
    const IMAGES_TYPE = 'room';
    protected static $table = 'room';

    function _init()
    {
        parent::_init()->append([
            t('Основные'),
                'number' => new Type\Varchar([
                    'description' => t('Номер офиса'),
                ]),
                'number_scheme' => new Type\Varchar([
                    'description' => t('Номер помещения на схеме'),
                ]),
                'square' => new Type\Double([
                    'description' => t('Площадь'),
                ]),
                'floor' => new Type\Integer([
                    'description' => t('Этаж'),
                    'listFromArray' => [[
                        0 => 'Цоколь',
                        1 => '1',
                        2 => '2',
                        3 => '3',
                        4 => '4',
                    ]]
                ]),
                'free' => new Type\Integer([
                    'description' => t('Свободно'),
                    'checkBoxView' => [1,0],
                    'default' => 1
                ]),
                'need_repair' => new Type\Integer([
                    'description' => t('Требуется ремонт'),
                    'checkBoxView' => [1,0],
                    'default' => 0
                ]),
            t('Фото'),
                '_photo_' => new Type\UserTemplate('%kirova%/form/room/photos.tpl'),
        ]);
    }
}
