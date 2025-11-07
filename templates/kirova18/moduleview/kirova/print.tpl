<main>
    <div class="global-section" id="main">
        {if $is_auth && $user['is_admin']}
            <section>
                <div class="container">
                    <div class="h1-wrapper">
                        <h1>Печать документов</h1>
                    </div>
                    <div class="filters-wrapper">
                        <form class="filters" id="print-form">
                            <div class="h2-wrapper">
                                <h2>Счета</h2>
                            </div>
                            <div class="input-field filter">
                               {include file="%kirova%/helpers/renter_select.tpl"}
                            </div>
                            <div class="input-field filter">
                                {include file="%kirova%/helpers/month_select.tpl"}
                            </div>
                            <div class="input-field filter">
                                {include file="%kirova%/helpers/year_input.tpl"}
                            </div>
                        </form>
                        <div class="print-form-button right-align">
                            <a class="btn" id="print-form-submit" data-url="{$router->getUrl('kirova-front-printing', ['Act' => 'getForPrint'])}">Показать</a>
                        </div>
                    </div>
                    <div id="active">
                        <table class="page-table checkbox-table">
                            <thead>
                            <tr>
                                <th>Номер счёта</th>
                                <th>Наименование организации</th>
                                <th>Договор</th>
                                <th>Сумма</th>
                                <th>Период</th>
                                <th class="right-align">Действия</th>
                            </tr>
                            </thead>
                            <tbody id="print-table">
                                {foreach $invoices as $invoice}
                                    <tr id="invoice-row-{$invoice['id']}" {if $invoice['is_modified']}class="invoice-modified"{/if}>
                                        <td class="check-field">{$invoice['number']}
                                            {if $invoice['is_modified']}<span> (мод.)</span>{/if}
                                            {if $invoice['is_discount']}<span> (скидка)</span>{/if}
                                        </td>
                                        <td>{$invoice['renter_short_title']}</td>
                                        <td>{$invoice['contract_number']}</td>
                                        <td>{$invoice['sum']}{if !$invoice['is_modified']}({$invoice['discount_sum']}){/if} ₽</td>
                                        <td>{$invoice['period_month_string']} {$invoice['period_year']}</td>
                                        <td class="right-align actions-td">
                                            <ul class="actions-wrapper">
                                                <li>
                                                    <a class="black-text actions-wrapper action">
                                                        <i class="mdi mdi-dots-vertical"></i>
                                                    </a>
                                                    <ul>
                                                        <li>
                                                            <a>Счёт</a>
                                                            <ul>
                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                {if !$invoice['is_modified']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=1/">со скидкой</a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=1/">со скидкой и печатью</a></li>
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a>Акт</a>
                                                            <ul>
                                                                <li><a target="_blank" class="waves-effect" href="/printform-akt/{$invoice['id']}/?print=0&discount=0/">Вывод документа</a></li>
                                                                <li><a target="_blank" class="waves-effect" href="/printform-akt/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                {if !$invoice['is_modified']}
                                                                    <li><a target="_blank" class="waves-effect" href="/printform-akt/{$invoice['id']}/?print=0&discount=1/">со скидкой</a></li>
                                                                    <li><a target="_blank" class="waves-effect" href="/printform-akt/{$invoice['id']}/?print=1&discount=1/">со скидкой и печатью</a></li>
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a>Счёт-фактура</a>
                                                            <ul>
                                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                {if !$invoice['is_modified']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=1/">со скидкой</a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=1/">со скидкой и печатью</a></li>
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <div class="divider"></div>
                                                        </li>
                                                        <li><a class="critical-text remove-invoice" data-id="{$invoice['id']}" data-url="{$router->getUrl('kirova-front-invoice', ['Act' => 'remove'])}">Удалить счёт</a></li>
                                                    </ul>
                                                </li>
                                            </ul>
                                            <a
                                                title="Принудительно со скидкой"
                                                data-url="{$router->getUrl('kirova-front-invoice', ['Act' => 'forcedDiscount', 'id' => $invoice['id']])}"
                                                data-id="{$invoice['id']}"
                                                id="forced-discount-{$invoice['id']}"
                                                class="forced-discount"
                                            >
                                                <i class="mdi mdi-cash-lock"></i>
                                            </a>
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
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
{literal}
    <script type="text/template7" id="print-row-template">
        <tbody id="print-table">
            {{#each invoices}}
                <tr id="invoice-row-{{id}}" {{#js_if "this.is_modified == '1'"}}class="invoice-modified"{{/js_if}}>
                    <td class="check-field">{{number}} {{#js_if "this.is_modified == '1'"}}<span> (мод.)</span>{{/js_if}}</td>
                    <td>{{renter_short_title}}</td>
                    <td>{{contract_number}}</td>
                    <td>{{sum}}{{#js_if "this.is_modified == '0'"}}({{discount_sum}}){{/js_if}} ₽</td>
                    <td>{{period_month_string}} {{period_year}}</td>
                    <td class="right-align actions-td">
                        <ul class="actions-wrapper">
                            <li>
                                <a class="black-text actions-wrapper action">
                                    <i class="mdi mdi-dots-vertical"></i>
                                </a>
                                <ul>
                                    <li>
                                        <a>Счёт</a>
                                        <ul>
                                            <li><a class="waves-effect" target="_blank" href="/printform-invoice/{{id}}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                            <li><a class="waves-effect" target="_blank" href="/printform-invoice/{{id}}/?print=1&discount=0/">с печатью</a></li>
                                            {{#js_if "this.is_modified == '0'"}}
                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{{id}}/?print=0&discount=1/">со скидкой</a></li>
                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{{id}}/?print=1&discount=1/">со скидкой и печатью</a></li>
                                            {{/js_if}}
                                        </ul>
                                    </li>
                                    <li>
                                        <a>Акт</a>
                                        <ul>
                                            <li><a target="_blank" class="waves-effect" href="/printform-akt/{{id}}/?print=0&discount=0/">Вывод документа</a></li>
                                            <li><a target="_blank" class="waves-effect" href="/printform-akt/{{id}}/?print=1&discount=0/">с печатью</a></li>
                                            {{#js_if "this.is_modified == '0'"}}
                                                <li><a target="_blank" class="waves-effect" href="/printform-akt/{{id}}/?print=0&discount=1/">со скидкой</a></li>
                                                <li><a target="_blank" class="waves-effect" href="/printform-akt/{{id}}/?print=1&discount=1/">со скидкой и печатью</a></li>
                                            {{/js_if}}
                                        </ul>
                                    </li>
                                    <li>
                                        <a>Счёт-фактура</a>
                                        <ul>
                                            <li><a class="waves-effect" target="_blank" href="/printform-sf/{{id}}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                            <li><a class="waves-effect" target="_blank" href="/printform-sf/{{id}}/?print=1&discount=0/">с печатью</a></li>
                                            {{#js_if "this.is_modified == '0'"}}
                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{{id}}/?print=0&discount=1/">со скидкой</a></li>
                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{{id}}/?print=1&discount=1/">со скидкой и печатью</a></li>
                                            {{/js_if}}
                                        </ul>
                                    </li>
                                    <li>
                                        <div class="divider"></div>
                                    </li>
                                    <li><a class="critical-text remove-invoice" data-id="{{id}}" data-url="/invoices/?Act=remove">Удалить счёт</a></li>
                                </ul>
                            </li>
                        </ul>
                        <a
                                title="Принудительно со скидкой"
                                data-url="/invoices/?Act=forcedDiscount&id={{id}}"
                                data-id="{{id}}"
                                id="forced-discount-{{id}}"
                                class="forced-discount"
                        >
                            <i class="mdi mdi-cash-lock"></i>
                        </a>
                    </td>
                </tr>
            {{else}}
                <tr>
                    <td colspan="6">Счета не найдены</td>
                </tr>
            {{/each}}
        </tbody>
    </script>
{/literal}
