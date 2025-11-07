<?php

namespace kirova\Controller\Admin;

use kirova\Model\ContractApi;
use RS\Controller\Admin\Crud;
use RS\Html\Filter;
use RS\Html\Table;
use RS\Html\Table\Type as TableType;
use RS\Html\Toolbar\Button as ToolbarButton;
use kirova\Model\ExternalFilter\Contract as ExternalRenter;

/**
 * Контроллер Управление списком магазинов сети
 */
class ContractsCtrl extends Crud
{
    function __construct()
    {
        //Устанавливаем, с каким API будет работать CRUD контроллер
        parent::__construct(new ContractApi());
    }

    function helperIndex()
    {
        $helper = parent::helperIndex(); //Получим helper по-умолчанию
        $helper->setTopTitle('Договоры'); //Установим заголовок раздела

        //Отобразим таблицу со списком объектов
        $helper->setTable(new Table\Element([
            'Columns' => [
                new TableType\Checkbox('id', ['ThAttr' => ['width' => 20]]),
                new TableType\Text('number', 'Номер', [
                    'Sortable' => SORTABLE_BOTH,
                    'href' => $this->router->getAdminPattern('edit', [':id' => '@id']),
                    'LinkAttr' => ['class' => 'crud-edit'],
                ]),
                new TableType\Userfunc('renter', t('Арендатор'), function($value, $field){
                    $contract = $field->getRow();
                    $renter = new \Kirova\Model\Orm\Renter($contract['renter']);
                    return '<div>'.$renter['short_title'].'</div>';
                }),
                new TableType\Actions('id', [
                    new TableType\Action\Edit($this->router->getAdminPattern('edit', [':id' => '~field~'])),
                ], ['SettingsUrl' => $this->router->getAdminUrl('tableOptions')]),
            ],
        ]));

        //Добавим фильтр значений в таблице по названию
        $helper->setFilter(new Filter\Control([
            'Container' => new Filter\Container([
                'Lines' => [
                    new Filter\Line(['items' => [
                        new Filter\Type\Text('number', 'Номер', ['SearchType' => '%like%']),
                        new ExternalRenter('RENTER.title', 'Арендатор', ['SearchType' => '%like%'])
                    ]]),
                ],
            ]),
        ]));

        return $helper;
    }
}
