<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Communal extends OrmObject
{
    protected static $table = 'communal';

    function _init()
    {
        parent::_init()->append([
            t('Основные'),
                'month' => new Type\Varchar([
                    'description' => t('Месяц')
                ]),
                'year' => new Type\Varchar([
                    'description' => t('Год')
                ]),
                'type' => new Type\Varchar([
                    'description' => t('Вид'),
                    'listFromArray' => [[
                        '0' => 'Не выбрано',
                        'energy' => 'Электроэнергия',
                        'water' => 'Вода',
                        'heating' => 'Отопление',
                        'trash' => 'Вывоз мусора',
                        'other' => 'Прочее',
                    ]]
                ]),
                'summa' => new Type\Double([
                    'description' => t('Сумма')
                ]),
                'volume' => new Type\Double([
                    'description' => t('Объем'),
                ]),
                'rate' => new Type\Double([
                    'description' => t('Тариф'),
                ])
        ]);
    }
}
