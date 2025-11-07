<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Additional extends OrmObject
{
    protected static $table = 'additional';

    function _init()
    {
        parent::_init()->append([
            t('Основные'),
                'number' => new Type\Varchar([
                    'description' => t('Номер дополнительного соглашения'),
                ]),
                'date' => new Type\Date([
                    'description' => t('Дата доп. соглашения')
                ]),
                'date_start_additional' => new Type\Date([
                    'description' => t('Дата вступления в силу')
                ]),
                'contract_id' => new Type\Integer([
                    'description' => t('Договор'),
                    'list' => [['\Kirova\Model\ContractApi', 'staticSelectList'], [0 => 'Не выбран']]
                ]),
                'room' => new Type\ArrayList([
                    'description' => t('Помещение'),
                    'list' => [['\Kirova\Model\RoomsApi', 'staticSelectList'], [0 => 'Не выбрано']],
                    'Attr' => [['multiple' => 'multiple', 'class' => 'multiselect']],
                ]),
                '_room' => new Type\Varchar([
                    'description' => t('Помещение (сериализованное)'),
                    'visible' => false
                ]),
                'date_start' => new Type\Date([
                    'description' => t('Дата начала аренды')
                ]),
                'date_finish' => new Type\Date([
                    'description' => t('Дата окончания аренды')
                ]),
                'sum' => new Type\Double([
                    'description' => t('Сумма арнеды в месяц')
                ]),
                'sum_discount' => new Type\Double([
                    'description' => t('Сумма аренды со скидкой')
                ]),
        ]);
    }

    function beforeWrite($flag)
    {

        if($this->isModified('room')){
            $this['_room'] = serialize($this['room']);
        }
        $contract = new \Kirova\Model\Orm\Contract($this['contract_id']);
        $contract['has_dop'] = 1;
        $contract->update();

    }

    function afterObjectLoad()
    {
        $this['room'] = @unserialize($this['_room']);
    }

    /**
     * Возвращает объект помещения по договору
     * @return array
     */
    public function getRooms()
    {
        $rooms = [];
        foreach ($this['room'] as $room_id){
            $rooms[] = new \Kirova\Model\Orm\Room($room_id);
        }
        return $rooms;
    }
}
