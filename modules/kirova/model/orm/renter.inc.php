<?php

namespace kirova\Model\Orm;

use RS\Orm\OrmObject;
use RS\Orm\Type;

/**
 * ORM объект
 */
class Renter extends OrmObject
{
    protected static $table = 'renter';

    function _init()
    {
        parent::_init()->append([
            t('Основное'),
                'title' => new Type\Varchar([
                    'description' => t('Наименование'),
                    'checker' => ['chkEmpty', t('Заполните наименование')]
                ]),
                'short_title' => new Type\Varchar([
                    'description' => t('Краткое наименование'),
                    'checker' => ['chkEmpty', t('Заполните кр. наименование')]
                ]),
                'form' => new Type\Varchar([
                    'description' => t('Форма'),
                    'ListFromArray' => [[
                        'fiz' => t('Физическое лицо'),
                        'ip' => t('Индивидуальный предприниматель'),
                        'ooo' => t('ООО'),
                        'oao' => t('ОАО'),
                        'zao' => t('ЗАО'),
                        'other' => t('Другое')
                    ]],
                ]),
                'inn' => new Type\Varchar([
                    'description' => t('ИНН')
                ]),
                'kpp' => new Type\Integer([
                    'description' => t('КПП')
                ]),
                'orgn' => new Type\Varchar([
                    'description' => t('ОГРН/ОГРНИП')
                ]),
                'pasport' => new Type\Varchar([
                    'description' => t('Паспортные данные')
                ]),
            t('Контактные данные'),
                'phone' => new Type\Varchar([
                    'description' => t('Телефон')
                ]),
                'e_mail' => new Type\Varchar([
                    'description' => t('Email')
                ]),
                'ur_address' => new Type\Varchar([
                    'description' => t('Юридический адрес')
                ]),
                'post_address' => new Type\Varchar([
                    'description' => t('Почтовый адрес')
                ]),
            t('Руководитель'),
                'position_leader' => new Type\Varchar([
                    'description' => t('Должность руководителя')
                ]),
                'fio_leader' => new Type\Varchar([
                    'description' => t('ФИО руководителя')
                ]),
                'phone_leader' => new Type\Varchar([
                    'description' => t('Телефон руководителя')
                ]),
                'email_leader' => new Type\Varchar([
                    'description' => t('Email руководителя')
                ]),
            t('Бухгалтер'),
                'fio_accountant' => new Type\Varchar([
                    'description' => t('ФИО Бухгалтера')
                ]),
                'phone_accountant' => new Type\Varchar([
                    'description' => t('Телефон бухгалтера')
                ]),
                'email_accountant' => new Type\Varchar([
                    'description' => t('Email бухгалтера')
                ]),
            t('Баланс'),
                'balance' => new Type\Double([
                    'description' => t('Баланс'),
                    'visible' => false
                ]),
                'start_balance' => new Type\Double([
                    'description' => t('Стартовый баланс арендатора')
                ]),
            t('Авторизация'),
                'login' => new Type\Varchar([
                    'description' => t('Логин')
                ]),
                'password' => new Type\Varchar([
                    'description' => t('Пароль')
                ])
        ]);
    }

    /**
     * Создание пользователя RS
     * @param string $save_flag
     * @throws \RS\Exception
     */
    function afterWrite($save_flag)
    {
        if($save_flag == self::INSERT_FLAG){
            $user = new \Users\Model\Orm\User();
            $user['is_admin'] = 0;
            $user['renter_id'] = $this['id'];
            $user['login'] = $this['login'];
            $user['openpass'] = $this['password'];
            $user['full_name'] = $this['title'];
            $user['short_name'] = $this['short_title'];
            $user->insert();
        }else{
            $user_api = new \Users\Model\Api();
            $updated_user = $user_api->setFilter('renter_id', $this['id'])->getFirst();
            if($updated_user){
                if($this->isModified('login')){
                    $updated_user['login'] = $this['login'];
                }
                if($this->isModified('password')){
                    $updated_user['openpass'] = $this['password'];
                }
                if($this->isModified('title')){
                    $updated_user['full_name'] = $this['title'];
                }
                if($this->isModified('short_title')){
                    $updated_user['short_name'] = $this['title'];
                }
                $updated_user->update();
            }
        }
    }

}
