<main>
    <div class="global-wrapper">
        <section>
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="h1-wrapper">
                            <h1>История платежей</h1>
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
                                        <span class="{if $contract['balance'] >= 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span>
                                    {/if}
                                </p>
                            </div>
                            <table class="page-table">
                                <thead>
                                <th>Дата</th>
                                <th>Номер документа</th>
                                <th>Сумма</th>
                                </thead>
                                <tbody id="payment-table">
                                {foreach $payments as $payment}
                                    <tr>
                                        <td>{$payment['date']|date_format:'%d.%m.%Y'}</td>
                                        <td>{$payment['number']}</td>
                                        <td>{$payment['sum']} ₽</td>
                                    </tr>
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
                                        <div class="collapsible-header contract">
                                            <p>Договор № {$contract['number']} от {$contract['date']|date_format: '%d.%m.%Y'}</p>
                                            <p><strong>Баланс:</strong> <span class="{if $contract['balance'] >= 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span></p>
                                        </div>
                                        <div class="collapsible-body">
                                            <table class="page-table">
                                                <thead>
                                                <th>Дата</th>
                                                <th>Номер документа</th>
                                                <th>Сумма</th>
                                                </thead>
                                                <tbody id="payment-table">
                                                {foreach $contract['payments'] as $payment}
                                                    <tr>
                                                        <td>{$payment['date']|date_format:'%d.%m.%Y'}</td>
                                                        <td>{$payment['number']}</td>
                                                        <td>{$payment['sum']} ₽</td>
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
                </div>
            </div>
        </section>
    </div>
</main>
