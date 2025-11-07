<main>
    <div class="global-wrapper" id="rent">
        {if $is_auth && $user['is_admin']}
            <section>
                <div class="container">
                    <div class="row v-center">
                        <div class="col xl9 l8 m7 s12">
                            <div class="h1-wrapper">
                                <h1>Реестр Договоров</h1>

    {*                            <div class="icon-wrapper">*}
    {*                                <a class="toggle-search"></a>*}
    {*                            </div>*}
    {*                            <div class="input-wrapper">*}
    {*                                <input type="text" placeholder="Поиск">*}
    {*                            </div>*}

                            </div>
                        </div>
    {*                    <div class="col xl3 l4 m5 s12 ra m-up">*}
    {*                        <a href="#act-control" class="btn modal-trigger waves-effect waves-light">Сформировать акт сверки</a>*}
    {*                    </div>*}
                    </div>
                    <div class="row">
                        <div class="col s12">
                            <ul class="tabs">
                                <li class="tab"><a href="#active" class="active">Текущие</a></li>
                                <li class="tab"><a href="#archive">Архивные</a></li>
                                <li class="indicator" style="left: 0px; right: 853px;"></li>
                            </ul>
                        </div>
                    </div>
                    <div class="row flex">
                        <div class="col s12">
                            <div id="active" class="active">
                                <table class="page-table">
                                    <thead>
                                        <tr>
                                            <th>Номер договора</th>
                                            <th>Помещения</th>
                                            <th>Арендатор</th>
                                            <th>Сумма</th>
                                            <th>Баланс</th>
                                            <th>действия</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $active_contracts as $contract}
                                            <tr class="arenda-row {if $contract['status'] == 100}ending-soon{/if}" id="contract-row-{$contract['id']}">
                                                <td>{$contract['number']}</td>
                                                <td>
                                                    {foreach $contract['rooms'] as $room}
                                                        {$room}{if !$room@last}, {/if}
                                                    {/foreach}
                                                </td>
                                                <td>{$contract['renter_short_title']}</td>
                                                <td>
                                                    {if $contract->getActualSum()}
                                                        {$dop_sum = $contract->getActualSum()}
                                                        {$dop_sum['sum']}({$dop_sum['sum_discount']})₽
                                                    {else}
                                                        {$contract['sum']}({$contract['sum_discount']})₽
                                                    {/if}
                                                </td>
                                                
                                                <td id="contract-balance-{$contract['id']}" class="{if $contract['balance'] >= 0}green-text{else}red-text{/if}">{$contract['balance']}₽</td>
                                                <td id="action-{$contract['id']}">
                                                    <a
                                                        class="refresh-balance"
                                                        data-id="{$contract['id']}"
                                                        data-url="{$router->getUrl('kirova-front-contracts', ['Act' => 'refreshBalance'])}"
                                                        title="обновить баланс"
                                                    >
                                                        <i class="mdi mdi-restore"></i>
                                                    </a>
                                                    {if $contract['last-invoice']}
                                                        <a title="Счет за текущий месяц выставлен">
                                                            <i class="mdi mdi-book-check green-mdi"></i>
                                                        </a>
                                                    {else}
                                                        <a
                                                                title="счет за текущий месяц не выставлен"
                                                                class="generate-last-invoice"
                                                                data-id="{$contract['id']}"
                                                                data-url="{$router->getUrl('kirova-front-contracts', ["Act" => 'generateLastInvoice'])}"
                                                                id="generate-last-invoice-{$contract['id']}"
                                                        >
                                                            <i class="mdi mdi-book-check red-mdi"></i>
                                                        </a>
                                                    {/if}
                                                    <a
                                                        title="внести оплату"
                                                        class="rs-in-dialog"
                                                        data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'getAddPaymentPopup', 'id' => {$contract['id']}])}"
                                                    >
                                                        <i class="mdi mdi-cash-plus"></i>
                                                    </a>
                                                    <a
                                                            title="список оплат"
                                                            class="rs-in-dialog"
                                                            data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'getListPaymentPopup', 'id' => {$contract['id']}])}"
                                                    >
                                                        <i class="mdi mdi-cash-check"></i>
                                                    </a>
                                                    <a
                                                            title="список счетов"
                                                            class="rs-in-dialog"
                                                            data-url="{$router->getUrl('kirova-front-invoice', ['Act' => 'getListInvoicePopup', 'id' => {$contract['id']}])}"
                                                    >
                                                        <i class="mdi mdi-playlist-check"></i>
                                                    </a>
                                                    <a
                                                        title="список счетов"
                                                        class="rs-in-dialog"
                                                        data-url="{$router->getUrl('kirova-front-invoice', ['Act' => 'index', 'id' => {$contract['id']}])}"
                                                    >
                                                        <i class="mdi mdi-checkbox-marked-circle"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            <div id="archive" style="display: none;">
                                <table class="page-table">
                                    <thead>
                                    <tr>
                                        <th>Номер договора</th>
                                        <th>Помещения</th>
                                        <th>Арендатор</th>
                                        <th>Сумма</th>
                                        <th>Баланс</th>
                                        <th>действия</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach $inactive_contracts as $contract}
                                        <tr class="arenda-row {if $contract['status'] == 100}ending-soon{/if}" id="contract-row-{$contract['id']}">
                                            <td>{$contract['number']}</td>
                                            <td>
                                                {foreach $contract['rooms'] as $room}
                                                    {$room}{if !$room@last}, {/if}
                                                {/foreach}
                                            </td>
                                            <td>{$contract['renter_short_title']}</td>
                                            <td>{$contract['sum']}({$contract['sum_discount']})₽</td>
                                            <td id="contract-balance-{$contract['id']}" class="{if $contract['balance'] >= 0}green-text{else}red-text{/if}">{$contract['balance']}₽</td>
                                            <td id="action-{$contract['id']}">
                                                <a
                                                        class="refresh-balance"
                                                        data-id="{$contract['id']}"
                                                        data-url="{$router->getUrl('kirova-front-contracts', ['Act' => 'refreshBalance'])}"
                                                        title="обновить баланс"
                                                >
                                                    <i class="mdi mdi-restore"></i>
                                                </a>
                                                <a
                                                        title="внести оплату"
                                                        class="rs-in-dialog"
                                                        data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'getAddPaymentPopup', 'id' => {$contract['id']}])}"
                                                >
                                                    <i class="mdi mdi-cash-plus"></i>
                                                </a>
                                                <a
                                                        title="список оплат"
                                                        class="rs-in-dialog"
                                                        data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'getListPaymentPopup', 'id' => {$contract['id']}])}"
                                                >
                                                    <i class="mdi mdi-cash-check"></i>
                                                </a>
                                                <a
                                                        title="список счетов"
                                                        class="rs-in-dialog"
                                                        data-url="{$router->getUrl('kirova-front-invoice', ['Act' => 'getListInvoicePopup', 'id' => {$contract['id']}])}"
                                                >
                                                    <i class="mdi mdi-playlist-check"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        {else}
            <div class="container">
                <p>У вас нет прав для просмотра данной страницы</p>
            </div>
        {/if}
    </div>
</main>
