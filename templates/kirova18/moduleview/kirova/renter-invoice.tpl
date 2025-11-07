<main>
    <div class="global-section" id="main">
            <section>
                <div class="container">
                    <div class="h1-wrapper">
                        <h1>Печать документов</h1>
                    </div>
                    <ul class="tabs">
                        <li class="tab"><a href="#active">Текущий договор</a></li>
                        <li class="tab"><a href="#archive">Оконченные договоры</a></li>
                    </ul>
                    <div id="active">
                        {if !empty($contract)}
                        <div class="contract">
                            <p>Договор № {$contract['number']} от {$contract['date']|date_format: '%d.%m.%Y'}</p>
                            <p><strong>Баланс:</strong>
                                {if $already_exposed}
                                    {if $is_discount}
                                        {if $contract['balance'] < 0}
                                            {if $fake_balance != 0}
                                                <span class="red-text">{$fake_balance} ₽</span>
                                            {else}
                                                <span class="red-text">???(обратитесь к арендодателю за информацией о балансе договора)</span>
                                            {/if}
                                        {else}
                                            <span class="green-text">{$contract['balance']} ₽</span>
                                        {/if}
                                    {else}
                                        <span class="{if $contract['balance'] > 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span>
                                    {/if}
                                {else}
                                    <span class="{if $contract['balance'] > 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span>
                                {/if}
                            </p>
                        </div>
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
                                        <td class="check-field">
                                            {$invoice['number']}{if $invoice['is_modified']}<span> (мод.)</span>{/if}
                                        </td>
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
                                                                {if $invoice['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                {else}
                                                                    {if $is_discount}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                    {else}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <!-- <li>
                                                            <a>Акт</a>
                                                            <ul>
                                                                {if $invoice['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                {else}
                                                                    {if $is_discount}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                    {else}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </li> -->
                                                        <!-- <li>
                                                            <a>Счёт-фактура</a>
                                                            <ul>
                                                                {if $invoice['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                {else}
                                                                    {if $is_discount}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                    {else}
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                        <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                    {/if}
                                                                {/if}
                                                            </ul>
                                                        </li> -->
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
                                                                {if $invoice['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                {else}                                                                    
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>                                                                   
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a>Акт</a>
                                                            <ul>
                                                                {if $invoice['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                {else}                                                                    
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>                                                                 
                                                                {/if}
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a>Счёт-фактура</a>
                                                            <ul>
                                                                {if $invoice['is_discount']}
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                {else}                                                                    
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                    <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                {/if}
                                                            </ul>
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
                        {else}
                            <p>Нет действующих договоров</p>
                        {/if}
                    </div>
                    <div id="archive">
                        {if !empty($archive_contracts)}
                        <ul class="collapsible">
                            {foreach $archive_contracts as $contract}
                                <li>
                                    <div class="contract collapsible-header">
                                        <p>Договор № {$contract['number']} от {$contract['date']|date_format: '%d.%m.%Y'}</p>
                                        <p><strong>Баланс:</strong> <span class="{if $contract['balance'] >= 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span></p>
                                    </div>
                                    <div class="collapsible-body">
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
                                            {foreach $contract['invoices'] as $invoice}
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
                                                                            {if $invoice['is_discount']}
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                            {else}
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-invoice/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                            {/if}
                                                                        </ul>
                                                                    </li>
                                                                    <li>
                                                                        <a>Акт</a>
                                                                        <ul>
                                                                            {if $invoice['is_discount']}
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                            {else}
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-akt/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                            {/if}
                                                                        </ul>
                                                                    </li>
                                                                    <li>
                                                                        <a>Счёт-фактура</a>
                                                                        <ul>
                                                                            {if $invoice['is_discount']}
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=1/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=1/">с печатью</a></li>
                                                                            {else}
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=0&discount=0/">Вывод <span class="hide-m-down">документа</span></a></li>
                                                                                <li><a class="waves-effect" target="_blank" href="/printform-sf/{$invoice['id']}/?print=1&discount=0/">с печатью</a></li>
                                                                            {/if}
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </li>
                            {/foreach}
                        </ul>
                        {else}
                            <p>Нет оконченных договоров</p>
                        {/if}
                    </div>
                </div>
            </section>
    </div>
</main>
