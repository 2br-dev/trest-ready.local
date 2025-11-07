<?php

namespace kirova\Controller\Admin;

use kirova\Model\ModelApi;
use RS\Controller\Admin\Crud;
use RS\Html\Filter;
use RS\Html\Table;
use RS\Html\Table\Type as TableType;
use RS\Html\Toolbar\Button as ToolbarButton;

/**
 * Контроллер Управление списком магазинов сети
 */
class InvoiceCtrl extends Crud
{
    function __construct()
    {
        //Устанавливаем, с каким API будет работать CRUD контроллер
        parent::__construct(new \Kirova\Model\InvoiceApi());
    }

    function helperIndex()
    {
        $helper = parent::helperIndex(); //Получим helper по-умолчанию
        $helper->setTopTitle('Админ. часть модуля kirova'); //Установим заголовок раздела

        //Отобразим таблицу со списком объектов
        $helper->setTable(new Table\Element([
            'Columns' => [
                new TableType\Text('number', 'Номер', [
                    'Sortable' => SORTABLE_BOTH,
                    'href' => $this->router->getAdminPattern('edit', [':id' => '@id']),
                    'LinkAttr' => ['class' => 'crud-edit'],
                ]),
                new TableType\Userfunc('renter', t('Арендатор'), function($value, $field){
                    $invoice = $field->getRow();
                    $renter = new \Kirova\Model\Orm\Renter($invoice['renter_id']);
                    return '<div><a href="'.$this->router->getAdminPattern('edit', [':id' => $invoice['id']]).'" class="crud-edit">'.$renter['short_title'].'</a></div>';
                }),
                new TableType\Text('period_month', t('Месяц')),
                new TableType\Text('period_year', t('Год')),
                new TableType\Text('sum', t('Сумма')),
                new TableType\Actions('id', [
                    new TableType\Action\Edit($this->router->getAdminPattern('edit', [':id' => '~field~'])),
                ], ['SettingsUrl' => $this->router->getAdminUrl('tableOptions')]),
            ],
        ]));

        //Добавим фильтр значений в таблице по названию
        $helper->setFilter(new Filter\Control([
            'Container' => new Filter\Container([
                'Lines' => [
                    new Filter\Line(['Items' => [
                        new Filter\Type\Text('number', 'Номер счёта'),
                        new Filter\Type\Text('renter_string', 'Название', ['SearchType' => '%like%']),
                    ]]),
                ],
                'SecContainer' => new Filter\Seccontainer([
                    'Lines' => [
                        new Filter\Line(['Items' => [
                            new Filter\Type\Text('period_year', 'Год'),
                            new Filter\Type\Select('period_month', 'Месяц', [
                                null => '',
                                '01' => 'Январь',
                                '02' => 'Февраль',
                                '03' => 'Март',
                                '04' => 'Апрель',
                                '05' => 'Май',
                                '06' => 'Июнь',
                                '07' => 'Июль',
                                '08' => 'Август',
                                '09' => 'Сентябрь',
                                '10' => 'Октябрь',
                                '11' => 'Ноябрь',
                                '12' => 'Декабрь',
                            ])
                        ]]),
                    ]
                ])
            ]),
            'Caption' => 'Поиск по счетам'
        ]));

        return $helper;
    }
}
