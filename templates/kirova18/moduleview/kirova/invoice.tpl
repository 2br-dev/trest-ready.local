{block name="content"}
    <main>
        <div class="global-wrapper" id="bills">
            {if $is_auth && $user['is_admin']}
                <form id="invoices" data-url="{$router->getUrl('kirova-front-invoice', ['Act' => 'generateInvoices'])}">
                    <section>
                        <div class="container">
                            <div class="h1-wrapper">
                                <h1>Выставление счетов</h1>
                            </div>
                            <div class="header">
                                <div class="h2-wrapper">
                                    <h2>Договоры аренды</h2>
                                </div>
                                <ul class="tabs">
                                    <li class="tab"><a class="waves-effect" href="#active">Текущие <span class="hide-m-down"> договоры</span></a></li>
                                    <li class="tab"><a class="waves-effect" href="#archive">Архивные <span class="hide-m-down"> договоры</span></a></li>
                                </ul>
                            </div>

                            <div class="filters-wrapper">

                                <div class="filters">

                                    <div class="input-field filter">
                                        <input type="text" class="styled datepicker" placeholder="Дата выставления счёта">
                                        <label for="">Дата выставления счёта</label>
                                    </div>
                                    <input type="hidden" class="datepicker_timestamp" name="date-timestamp" value="0">
                                    <div class="input-field filter">
                                        {include file="%kirova%/helpers/month_select.tpl"}
                                    </div>
                                    <div class="input-field filter">
                                        {include file="%kirova%/helpers/year_input.tpl"}
                                    </div>
                                </div>
                            </div>
                            <div id="active">
                                <table class="page-table checkbox-table">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Наименование организации</th>
                                        <th>Номер договора</th>
                                        <th>Сумма оплаты</th>
                                        <th>Сброс</th>
    {*                                    <th class="right-align">Оплатить</th>*}
                                    </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $active_contracts as $contract}
                                            {$renter = $contract->getRenter()}
                                            <tr>
                                                <td class="check-field">
                                                    <input
                                                        type="checkbox"
                                                        id="check{$contract['id']}"
                                                        name="contract[]"
                                                        value="{$contract['id']}"
                                                        data-discount = 'false'
                                                    >
                                                    <label for="check{$contract['id']}"></label>
                                                </td>
                                                <td class="autofill">{$renter['short_title']}</td>
                                                <td class="autofill">{$contract['number']}</td>
                                                <td>
                                                    <span
                                                        contenteditable
                                                        data-initial-value="{$contract['sum']}"
                                                        class="editable"
                                                        data-contract="{$contract['id']}"
                                                        id="sum_{$contract['id']}"
                                                    >{$contract['sum']}</span>
                                                    <span class="currency"> ₽</span>
    {*                                                <input type="hidden" id="discount_{$contract['id']}" name="discount[{$contract['id']}]" value="0">*}
                                                </td>
                                                <td>
                                                    <a href="" class="restore hidden"><i class="mdi mdi-restore"></i></a>
                                                </td>
    {*                                            <td class="right-align">*}
    {*                                                <a href="#register-payment" class="modal-trigger" data-header="Регистрация платежа">*}
    {*                                                    <i class="mdi mdi-currency-usd"></i>*}
    {*                                                </a>*}
    {*                                            </td>*}
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            <div id="archive">
                                <table class="page-table checkbox-table">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Наименование организации</th>
                                        <th>Номер договора</th>
                                        <th>Сумма оплаты</th>
                                        <th>Сброс</th>
                                        {*                                    <th class="right-align">Оплатить</th>*}
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $arch_contracts as $contract}
                                        {$renter = $contract->getRenter()}
                                        <tr>
                                            <td class="check-field">
                                                <input
                                                        type="checkbox"
                                                        id="check{$contract['id']}"
                                                        name="contract[]"
                                                        value="{$contract['id']}"
                                                        data-discount = 'false'
                                                >
                                                <label for="check{$contract['id']}"></label>
                                            </td>
                                            <td class="autofill">{$renter['short_title']}</td>
                                            <td class="autofill">{$contract['number']}</td>
                                            <td>
                                                    <span
                                                            contenteditable
                                                            data-initial-value="{$contract['sum']}"
                                                            class="editable"
                                                            data-contract="{$contract['id']}"
                                                            id="sum_{$contract['id']}"
                                                    >{$contract['sum']}</span>
                                                <span class="currency"> ₽</span>
                                                {*                                                <input type="hidden" id="discount_{$contract['id']}" name="discount[{$contract['id']}]" value="0">*}
                                            </td>
                                            <td>
                                                <a href="" class="restore hidden"><i class="mdi mdi-restore"></i></a>
                                            </td>
                                            {*                                            <td class="right-align">*}
                                            {*                                                <a href="#register-payment" class="modal-trigger" data-header="Регистрация платежа">*}
                                            {*                                                    <i class="mdi mdi-currency-usd"></i>*}
                                            {*                                                </a>*}
                                            {*                                            </td>*}
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>
                    <div class="bottom-action">
                        <div class="check-field">
                            <input type="hidden" name="date_timestamp" value="0">
                            <input type="checkbox" id="manual-numeration" name="is_custom_number">
                            <label for="manual-numeration">Ручная нумерация</label>
                        </div>
                        <div class="input-field">
                            <input type="number" name="custom_number" class="styled" val="1" min="1" step="1">
                        </div>
                        <a id="invoices-submit" class="btn">Выставить счёт</a>
                    </div>
                </form>
            {else}
                <div class="container">
                    <p>У вас нет прав для просмотра данной страницы</p>
                </div>
            {/if}
        </div>
    </main>
{/block}

