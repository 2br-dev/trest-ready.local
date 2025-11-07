<?php

namespace kirova\Config;

use RS\Event\HandlerAbstract;
use RS\Orm\Type\Integer;
use RS\Orm\Type\Varchar;
use RS\Router\Route as RouterRoute;

/**
 * Класс содержит обработчики событий, на которые подписан модуль
 */
class Handlers extends HandlerAbstract
{
    /**
     * Добавляет подписку на события
     *
     * @return void
     */
    function init()
    {
        $this
            ->bind('orm.init.users-user')
            ->bind('getroute')  //событие сбора маршрутов модулей
            ->bind('getmenus'); //событие сбора пунктов меню для административной панели
    }

    public static function ormInitUsersUser(\Users\Model\Orm\User $orm)
    {
        $orm->getPropertyIterator()->append([
            t('Арендатор'),
                'full_name' => new Varchar([
                    'description' => t('Полное наименование')
                ]),
                'short_name' => new Varchar([
                    'description' => t('Короткое наименование')
                ]),
                'form' => new Varchar([
                    'description' => t('Форма собственности'),
                    'listFromArray' => [[
                        'ip' => 'Индивидуальный предприниматель',
                        'ooo' => "ООО",
                        'zao' => "ЗАО",
                        'oao' => 'ОАО',
                        'fiz' => 'Физическое лицо',
                        'other' => 'Прочее'
                    ]],
                    'default' => 'ip'
                ]),
                'inn' => new Integer([
                    'description' => t('ИНН')
                ]),
                'kpp' => new Integer([
                    'description' => t('КПП')
                ]),
                'ogrn' => new Integer([
                    'description' => t('ОГРН/ОГРНИП')
                ]),
                'uridich_address' => new Varchar([
                    'description' => t('Юридический адрес')
                ]),
                'post_address' => new Varchar([
                    'description' => t('Почтовый адрес')
                ]),
                'is_admin' => new Integer([
                    'description' => t('Админ'),
                    'visible' => true
                ]),
                'renter_id' => new Integer([
                    'description' => t('Арендатор')
                ]),
            t('Банковские реквизиты'),
                'bank_name' => new Varchar([
                    'description' => t('Наименование банка'),
                ]),
                'bank_bik' => new Varchar([
                    'description' => t('БИК'),
                ]),
                'bank_rs' => new Varchar([
                    'description' => t('Расчетный счет'),
                ]),
                'bank_ks' => new Varchar([
                    'description' => t('Кор. счет'),
                ]),
            t('Директор'),
                'chief_fio' => new Varchar([
                    'description' => t('ФИО Директора')
                ]),
                'chief_position' => new Varchar([
                    'description' => t('Должность Директора')
                ]),
                'chief_document' => new Varchar([
                    'description' => t('Документ основане'),
                    'hint' => t('Документ, подтверждающий полномочия Директора')
                ]),
            t('Бухгалтер'),
                'buh_fio' => new Varchar([
                    'description' => t('ФИО Бухгалтера')
                ]),
                'buh_phone' => new Varchar([
                    'description' => t('Телефон Бухгалтера')
                ]),
        ]);
    }

    /**
     * Возвращает маршруты данного модуля. Откликается на событие getRoute.
     * @param array $routes - массив с объектами маршрутов
     * @return array of \RS\Router\Route
     */
    public static function getRoute(array $routes)
    {
        $routes[] = new RouterRoute('kirova-front-reestr', '/reestr/', [
            'controller' => 'kirova-front-reestr',
        ], null, 'Реестр Договоров');
        $routes[] = new RouterRoute('kirova-front-invoice', '/invoices/', [
            'controller' => 'kirova-front-invoice',
        ], null, 'Выставление счетов');
        $routes[] = new RouterRoute('kirova-front-print', '/print/', [
            'controller' => 'kirova-front-printing',
        ], null, 'Печать счетов');
        $routes[] = new RouterRoute('kirova-front-payment', '/payments/', [
            'controller' => 'kirova-front-payment',
        ], null, 'Оплаты');
        $routes[] = new RouterRoute('kirova-front-printakt', '/printform-akt/{id}/', [
            'controller' => 'kirova-front-printakt'
        ], 'Печатная форма (Акт)');
        $routes[] = new RouterRoute('kirova-front-printinvoice', '/printform-invoice/{id}/', [
            'controller' => 'kirova-front-printinvoice'
        ], 'Печатная форма (Счет)');
        $routes[] = new RouterRoute('kirova-front-printsf', '/printform-sf/{id}/', [
            'controller' => 'kirova-front-printsf'
        ], 'Печатная форма (Счет-фактура)');
        $routes[] = new RouterRoute('kirova-front-reports', '/reports/', [
            'controller' => 'kirova-front-reports'
        ], 'Отчеты');
        $routes[] = new RouterRoute('kirova-front-renterinvoice', '/renter-invoice/', [
            'controller' => 'kirova-front-renterinvoice'
        ], 'Счета для Арендатора');
        $routes[] = new RouterRoute('kirova-front-renterpayment', '/renter-payment/', [
            'controller' => 'kirova-front-renterpayment'
        ], 'Оплаты для Арендатора');
        $routes[] = new RouterRoute('kirova-front-renterreport', '/renter-report/', [
            'controller' => 'kirova-front-renterreport'
        ], 'Акт сверки');
        $routes[] = new RouterRoute('kirova-front-renterlogindata', '/renter-logindata/', [
            'controller' => 'kirova-front-renterlogindata'
        ], 'Данные арендаторов для входа');
        $routes[] = new RouterRoute('kirova-front-statistics', '/statistics/', [
            'controller' => 'kirova-front-statistics'
        ], 'Данные арендаторов для входа');
        $routes[] = new RouterRoute('kirova-front-reconciliation', '/reconciliation/', [
            'controller' => 'kirova-front-reconciliation'
        ], 'Данные арендаторов для входа');
        return $routes;
    }

    /**
     * Возвращает пункты меню этого модуля в виде массива
     * @param array $items - массив с пунктами меню
     * @return array
     */
    public static function getMenus($items)
    {
        $items[] = [
            'title' => 'Кирова 18',
            'alias' => 'kirova18',
            'link' => '%ADMINPATH%/kirova-control/',
            'parent' => 0,
            'sortn' => 100,
            'typelink' => 'link',
        ];
        $items[] = [
            'title' => 'Помещения',
            'alias' => 'rooms',
            'link' => '%ADMINPATH%/kirova-roomsctrl/',
            'parent' => 'kirova18',
            'sortn' => 10,
            'typelink' => 'link',
        ];
        $items[] = [
            'title' => 'Арендаторы',
            'alias' => 'renters',
            'link' => '%ADMINPATH%/kirova-rentersctrl/',
            'parent' => 'kirova18',
            'sortn' => 11,
            'typelink' => 'link',
        ];
        $items[] = [
            'title' => 'Договоры',
            'alias' => 'contracts',
            'link' => '%ADMINPATH%/kirova-contractsctrl/',
            'parent' => 'kirova18',
            'sortn' => 20,
            'typelink' => 'link',
        ];
        $items[] = [
            'title' => 'Доп. соглашения',
            'alias' => 'additionals',
            'link' => '%ADMINPATH%/kirova-additionalsctrl/',
            'parent' => 'kirova18',
            'sortn' => 30,
            'typelink' => 'link',
        ];
        $items[] = [
            'title' => 'Счета',
            'alias' => 'invoices',
            'link' => '%ADMINPATH%/kirova-invoicectrl/',
            'parent' => 'kirova18',
            'sortn' => 40,
            'typelink' => 'link',
        ];
        return $items;
    }
}
