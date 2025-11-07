<section>
    <div class="container">
        <div class="h1-wrapper">
            <h1>Реестр Договоров</h1>
            <p>вывести дату последнего занесенного платежа</p>
        </div>
        <ul class="tabs">
            <li class="tab"><a href="#active">Текущие</a></li>
            <li class="tab"><a href="#archive">Архивные</a></li>
        </ul>
        <div class="row flex">
            <div class="col xl4 l4 m12">
                <div id="active">
                    <table class="page-table">
                        <thead>
                            <tr>
                                <th>№ Помещения</th>
                                <th>Номер договора</th>
                                <th>Текущий баланс</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $active_contracts as $contract}
                                <tr class="arenda-row" data-id="{$contract['id']}" data-url="{$router->getUrl('kirova-front-reestr', ['Act' => 'getFullData'])}">
                                    <td>
                                        {foreach $contract['rooms_number'] as $room}
                                            {$room} {if !$room@last},{/if}
                                        {/foreach}
                                    </td>
                                    <td>{$contract['number']}</td>
                                    <td class="{if $contract['balance'] >= 0}balance_green{else}balance_red{/if}">{$contract['balance']}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                <div id="archive">
                    <table class="page-table">
                        <thead>
                            <tr>
                                <th>Наименование организации</th>
                                <th>Текущий баланс</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="arenda-row">
                                <td>Арендатор</td>
                                <td>Баланс</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col xl8 l8 hide-l-down">
                <div class="data-wrapper">
                    <h2>Подробные сведения</h2>
{*                    <div class="null-value-prompt">*}
{*                        Выберите арендатора*}
{*                    </div>*}
                    <div class="data" id="renter_full_data">

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
{literal}
    <script id="renter_full_data_template" type="text/template7">
        <div class="data" id="renter_full_data">
            <article>
                <div class="article-header">Данные договора</div>
                <div class="row">
                    <div class="col l2 s12 small-text">Помещения</div>
                    <div class="col l4 s12">
                        {{#each rooms_number}}
                            {{this}} {{#unless @last}},{{/unless}}
                        {{/each}}
                    </div>
                    <div class="col l2 s12 small-text">Сумма</div>
                    <div class="col l4 s12">{{sum}} ₽</div>
                    <div class="col l2 s12 small-text">Сумма со скидкой</div>
                    <div class="col l4 s12">{{sum_discount}} ₽</div>
                    <div class="col l2 s12 small-text">Период аренды</div>
                    <div class="col l4 s12">{{date_start}} - {{date_finish}}</div>
                    <div class="col l2 s12 small-text">Пени</div>
                    <div class="col l4 s12">{{peni}}%</div>
                </div>
            </article>
            <article>
                <div class="article-header">Арендатор</div>
                <div class="row">
                    <div class="col s12">{{renter_title}}</div>
                    <div class="col l2 s12 small-text">Логин</div>
                    <div class="col l4 s12">{{login}}</div>
                    <div class="col l2 s12 small-text">Пароль</div>
                    <div class="col l4 s12">{{password}}</div>
                </div>
            </article>
        </div>
    </script>
{/literal}
