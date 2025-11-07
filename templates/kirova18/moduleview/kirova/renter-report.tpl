<main>
    <div class="global-section" id="main">
            <section>
                <div class="container">
                    <div class="h1-wrapper">
                        <h1>Акт Сверки</h1>
                    </div>
                    <div class="contract">
                        <p>Договор № {$contract['number']} от {$contract['date']|date_format: '%d.%m.%Y'}</p>
                        <p><strong>Баланс:</strong> <span class="{if $contract['balance'] > 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span></p>
                    </div>
                    <div id="active">
                        <table class="page-table checkbox-table">
                            <thead>
                            <tr>
                                <th>Номер счёта</th>
                                <th>Сумма</th>
                                <th>Период</th>
                                <th class="right-align">Действия</th>
                            </tr>
                            </thead>
                            <tbody id="print-table">
                            {foreach $invoices as $invoice}
                                {if $already_exposed && ($invoice['period_month'] == $current_month && $invoice['period_year'] == $current_year)}
                                    <tr id="invoice-row-{$invoice['id']}" {if $invoice['is_modified']}class="invoice-modified"{/if}>
{*                                        <td class="check-field">{$invoice['number']}{if $invoice['is_modified']}<span> (мод.)</span>{/if}</td>*}
                                        <td class="check-field">{$is_discount}</td>
                                        <td>
                                            {if $invoice['is_modified']}
                                                {$invoice['sum']}
                                            {else}
                                                {if $invoice['is_discount']}
                                                    {$invoice['discount_sum']}
                                                {else}
                                                    {if $is_discount}
                                                        {$invoice['discount_sum']}
                                                    {else}
                                                        {$invoice['sum']}
                                                    {/if}
                                                {/if}
                                            {/if} ₽
                                        </td>
                                        <td>{$invoice['period_month_string']} {$invoice['period_year']}</td>
                                        <td class="right-align actions-td">
                                            <ul class="actions-wrapper">
                                                <li>
                                                    <a class="black-text actions-wrapper action">
                                                        <i class="mdi mdi-printer"></i>
                                                    </a>
                                                    <ul>
                                                        <li>
                                                            <a>Счёт</a>
                                                            <ul>
                                                                {if $item['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1/">с печатью</a></li>
                                                                {else}
                                                                    {if $is_discount}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&disc=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&disc=1/">с печатью</a></li>
                                                                    {else}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&disc=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&disc=0/">с печатью</a></li>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a>Акт</a>
                                                            <ul>
                                                                {if $item['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1/">с печатью</a></li>
                                                                {else}
                                                                    {if $is_discount}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&disc=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&disc=1/">с печатью</a></li>
                                                                    {else}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&disc=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&disc=0/">с печатью</a></li>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a>Счёт-фактура</a>
                                                            <ul>
                                                                {if $item['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1/">с печатью</a></li>
                                                                {else}
                                                                    {if $is_discount}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&disc=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&disc=1/">с печатью</a></li>
                                                                    {else}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&disc=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&disc=0/">с печатью</a></li>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                {else}
                                    <tr id="invoice-row-{$invoice['id']}" {if $invoice['is_modified']}class="invoice-modified"{/if}>
                                        <td class="check-field">{$invoice['number']}{if $invoice['is_modified']}<span> (мод.)</span>{/if}</td>
                                        <td>
                                            {if $invoice['is_modified']}
                                                {$invoice['sum']}
                                            {else}
                                                {if $invoice['is_discount']}
                                                    {$invoice['discount_sum']}
                                                {else}
                                                    {$invoice['sum']}
                                                {/if}
                                            {/if} ₽
                                        </td>
                                        <td>{$invoice['period_month_string']} {$invoice['period_year']}</td>
                                        <td class="right-align actions-td">
                                            <ul class="actions-wrapper">
                                                <li>
                                                    <a class="black-text actions-wrapper action">
                                                        <i class="mdi mdi-printer"></i>
                                                    </a>
                                                    <ul>
                                                        <li>
                                                            <a>Счёт</a>
                                                            <ul>
                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1/">с печатью</a></li>
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a>Акт</a>
                                                        </li>
                                                        <li>
                                                            <a>Счёт-фактура</a>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>
                                {/if}
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
    </div>
</main>
