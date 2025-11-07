<section>
    <div class="container">
        <div class="h1-wrapper">
            <h1>Личный кабинет Арендатора</h1>
        </div>
        <div class="row">
            <div class="col s12">
                <div class="renter-info">
                    <div class="renter-info-item">Арендатор: {$renter['title']} ({$renter['short_title']})</div>
                </div>
            </div>
        </div>
        <ul class="tabs">
            <li class="tab"><a href="#active">Текущий договор</a></li>
            <li class="tab"><a href="#archive">Оконченные договоры</a></li>
        </ul>
        <div class="row">
            <div id="active">
                {if !empty($contract)}
                <h2>Договор <span>действующий</span></h2>
                <div class="col s12">
                    <div class="contract-info">
                        <div class="contract-info-item"><strong>№</strong> {$contract['number']} от {$contract['date']|date_format: '%d.%m.%Y'}</div>
                        <div class="contract-info-item">
                            <!-- <pre>{$already_exposed|var_dump}</pre>
                            <pre>{$is_discount|var_dump}</pre> -->
                            <strong>Баланс:</strong>
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
                        </div>
                        <div class="contract-info-item"><strong>Помещение: </strong>
                            {foreach $contract['rooms'] as $room}
                                {$room}{if !$room@last}, {/if}
                            {/foreach}
                        </div>
                        <div class="contract-info-item"><strong>Сумма аренды в мес.:</strong> {$contract['sum']} ₽</div>
                        <div class="contract-info-item"><strong>Сумма аренды в мес. со скидкой:</strong> {$contract['sum_discount']} ₽</div>
                    </div>
                </div>
                {else}
                    <p>Нет действующих договоров</p>
                {/if}
            </div>
            <div id="archive">
                <p>Здесь отображаются данные по недействующим договорам арендатора</p>
                <ul class="collapsible">
                    {foreach $archive_contracts as $contract}
                        <li>
                            <div class="collapsible-header"><p>{$contract['number']}</p> <p><strong> Баланс: </strong><span class="{if $contract['balance'] > 0}green-text{else}red-text{/if}">{$contract['balance']} ₽</span></p></div>
                            <div class="collapsible-body"><div class="contract-info-item"><strong>Помещение: </strong>
                            {foreach $contract['rooms'] as $room}
                                {$room}{if !$room@last}, {/if}
                            {/foreach}
                        </div>
                        <div class="contract-info-item"><strong>Сумма аренды в мес.:</strong> {$contract['sum']} ₽</div>
                        <div class="contract-info-item"><strong>Сумма аренды в мес. со скидкой:</strong> {$contract['sum_discount']} ₽</div></div>
                        </li>
                    {/foreach}
                </ul>
{*                <div class="input-field filter">*}
{*                    <select name="arch-contract" class="styled">*}
{*                        <option value="">Выбирете договор</option>*}
{*                        {foreach $archive_contracts as $contract}*}
{*                            <option value="{$contract['id']}">{$contract['number']}</option>*}
{*                        {/foreach}*}
{*                    </select>*}
{*                </div>*}
            </div>
        </div>
    </div>
</section>

