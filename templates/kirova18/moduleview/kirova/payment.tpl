<main>
    <div class="global-wrapper">
        {if $is_auth && $user['is_admin']}
            <section>
                <div class="container">
                    <div class="add-payment">
                        <h1>Добавить оплату</h1>
                        <form id="add-payment-form">
                            <div class="row">
                                <div class="input-field filter">
                                    {include file="%kirova%/helpers/renter_select.tpl" option="contract-next"}
                                </div>
                            </div>
                            <div class="row">
                                <div class="col m3">
                                    <div class="input-field">
                                        <input type="text" class="styled" placeholder="Номер документа" name="number">
                                        <label for="" class="active">Номер</label>
                                    </div>
                                </div>
                                <div class="col m4">
                                    <div class="input-field">
                                        <input type="text" class="styled number-only" placeholder="Сумма" name="summa">
                                        <label for="" class="active">Сумма</label>
                                    </div>
                                </div>
                                <div class="col m5">
                                    <div class="input-field">
                                        <input type="text" class="datepicker styled" placeholder="Дата" name="date">
                                        <label for="" class="active">Дата</label>
                                    </div>
                                    <input type="hidden" name="date_timestamp" value="0"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col right-align">
                                    <a class="btn" id="add-payment" data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'addPayment'])}">Сохранить</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
            <section>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="h1-wrapper">
                                <h1>История платежей</h1>
                            </div>
                            <form class="filters" id="payment-filter-form">
                                <div class="filter input-field">
                                    <input
                                            name="renter"
                                            type="text"
                                            class="styled autocomplete renter-autocomplete"
                                            id="renters-payment-filer"
                                            placeholder="Организация"
                                            data-action="{$router->getUrl('kirova-front-renters', ['Act' => 'getAll'])}"
                                    >
                                    <label for="">Организация</label>
                                </div>
                                <div class="input-field filter">
                                    <input type="text" class="styled datepicker" id="start" placeholder="Начало диапазона">
                                    <label for="">Начало диапазона</label>
                                </div>
                                <input type="hidden" class="datepicker_timestamp" name="payment-data-start" value="0">
                                <div class="input-field filter">
                                    <input type="text" class="styled datepicker" id="end" placeholder="Конец диапазона">
                                    <label for="">Конец диапазона</label>
                                </div>
                                <input type="hidden" class="datepicker_timestamp" name="payment-data-finish" value="0">
                                <div class="flex-separator"></div>
                                <div class="actions">
                                    <a class="waves-effect btn btn-flat" id="payment-filter-reset" data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'resetFilter'])}">Сбросить</a>
                                    <a class="waves-effect btn" id="payment-filter-submit" data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'filterPayments'])}">Применить</a>
                                </div>
                            </form>
                            <table class="page-table">
                                <thead>
                                    <th>Дата</th>
                                    <th>Арендатор</th>
                                    <th>Номер документа</th>
                                    <th>Сумма</th>
                                    <th class="right-align">Действия</th>
                                </thead>
                                <tbody id="payment-table">
                                    {foreach $payments as $payment}
                                        <tr>
                                            <td>{$payment['date']|date_format:'%d.%m.%Y'}</td>
                                            <td>{$payment['renter_short_title']}</td>
                                            <td>{$payment['number']}</td>
                                            <td>{$payment['sum']}</td>
                                            <td class="right-align actions-td">
    {*                                            <a href="#register-payment" class="modal-trigger action" data-header="Редактирование платежа"><i class="mdi mdi-pencil"></i></a>*}
                                                <a href="" class="action"><i class="mdi mdi-delete"></i></a>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        {else}
            <div class="container">
                <p>У вас не прав для просмотра данной страницы</p>
            </div>
        {/if}
    </div>
</main>
{literal}
<script type="text/template7" id="payment-row-template">
    <tbody id="payment-table">
    {{#each payments}}
        <tr>
            <td>{{date}}</td>
            <td>{{renter_short_title}}</td>
            <td>{{number}}</td>
            <td>{{sum}}</td>
            <td class="right-align actions-td">
                <a href="" class="action"><i class="mdi mdi-delete"></i></a>
            </td>
        </tr>
    {{else}}
        <tr colspan="5">
            платежи не найдены
        </tr>
    {{/each}}
    </tbody>
</script>
{/literal}
