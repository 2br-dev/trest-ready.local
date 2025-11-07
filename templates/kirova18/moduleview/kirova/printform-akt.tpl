{addcss file='akt.css'}
{$config = \RS\Config\Loader::ByModule('kirova')}

{if $user['is_admin']}
    {if $item['new_ip']}
        <div class="wrapper-akt">
        <div class="arendodatel-name">
            <p>Индивидуальный предприниматель Кононович Антон Анатольевич</p>
        </div>
        <div class="arendodatel-address">
            <p>Адрес: 350058, г. Краснодар, ул. Ставропольская, д. 155, копр. 1, кв. 61</p>
        </div>
    {else}
        <div class="wrapper-akt">
        <div class="arendodatel-name">
            <p>Индивидуальный предприниматель Кононович Галина Павловна</p>
        </div>
        <div class="arendodatel-address">
            <p>Адрес: 666784, Иркутская обл, Усть-Кут г., Кирова ул, 12, кв. 14</p>
        </div>
    {/if}
    <div class="schet-number">
        <p>Акт № A-{$item['number']} от {$item['day']} {$item['month_string']} {$item['year']} года</p>
    </div>
    <div class="arendator-name">
        <p>Заказчик: {$item.renter_name}</p>
    </div>
    {$count=1}
    <div class="schet">
        <table border="1" cellspacing="0">
            <tr>
                <td>№</td>
                <td>Наименование товара (услуги)</td>
                <td>Единица измерения</td>
                <td>Коли<br>чество</td>
                <td style="width: 90px;">Цена</td>
                <td style="width: 90px;">Сумма</td>
            </tr>
            <tr>
                <td>1</td>
                <td>Арендная плата за аренду нежилого помещения №
                    {foreach $item['rooms_number'] as $room}
                        {$room} {if !$room@last},{/if}
                    {/foreach}
                    за {$config->getMonthStringByNumber($item['period_month'])} {$item['period_year']} года {$allpeni.ed}. Основание: Договор
                аренды нежилого помещения № {$item['contract_number']}
                </td>
                <td>мес.</td>
                <td><input type="text" value="{$item['amount']}"></td>
                <td><input type="text" value="{$item.sum}"></td>
                <td><input type="text" value="{$item.sum}"></td>
            </tr>
        </table>
        <table style="widht: 200px; float: right;">
            <tr>
                <td style="text-align: right; font-weight: bold; border: none;">Итого:</td>
                <td style="width: 90px; border: 1px solid #000000; border-top: none;"><input type="text" value="{$item.sum}"></td>
            </tr>
            {if $discount == 1}
                <tr>
                    <td style="text-align: right; font-weight: bold; border: none;">Скидка:</td>
                    <td style="width: 90px; border: 1px solid #000000; border-top: none;"><input type="text" value="{$item['discount']}"></td>
                </tr>
            {/if}
            <tr>
                <td style="text-align: right; font-weight: bold; border: none;">Без налога (НДС).</td>
                <td style="border: 1px solid #000000;">-</td>
            </tr>
            {if $discount == 1}
                <tr>
                    <td style="text-align: right; font-weight: bold; border: none;">Всего к оплате:</td>
                    <td style="border: 1px solid #000000;"><input type="text" value="{$item.discount_sum}"></td>
                </tr>
            {else}
                <tr>
                    <td style="text-align: right; font-weight: bold; border: none;">Всего к оплате:</td>
                    <td style="border: 1px solid #000000;"><input type="text" value="{$item.sum}"></td>
                </tr>
            {/if}
        </table>
        <div style="clear: both;"></div>
        <div class="podval">
            {if $discount == 1}
                <p style="font-style: italic; font-size: 12px;">Всего оказано услуг на сумму:  <strong> <input class="numeric-sum" style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="{$item.sum_discount_string}"> </strong> в т.ч.: НДС - Ноль рублей 00 копеек</p>
            {else}
                <p style="font-style: italic; font-size: 12px;">Всего оказано услуг на сумму:  <strong> <input class="numeric-sum" style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="{$item.sum_string}"> </strong> в т.ч.: НДС - Ноль рублей 00 копеек</p>
            {/if}

            <p style="font-style: italic; font-size: 12px;">Вышеперечисленные услуги выполнены полностью и в срок. Заказчик претензий по объему, качеству и срокам оказания услуг не имеет</p>
        </div>
    </div>
    {if $item['new_ip']}
        <div class="sign">
            <p style="display: inline-block; margin-right: 120px;">Исполнитель: _____________(Гавриленко Н.В.)</p>
            <p  style="display: inline-block;">Заказчик: ________________________</p>
            <p style="font-style: italic; font-size: 12px;">за Кононович Галину Павловну по доверенности от 01.04.2025 г.<br>Бланк доверенности: 23АВ6032597</p>
            {if $print == 1}
                <div class="akt-print">
                    <img src="{$THEME_IMG}/print_KononovichAA.png" width="146">
                </div>
                <div class="akt-sign-img">
                    <img src="{$THEME_IMG}/sign_KononovichAA.png" width="100">
                </div>
            {/if}
        </div>
    {else}
        <div class="sign">
            <p style="display: inline-block; margin-right: 120px;">Исполнитель: _____________(Гавриленко Н.В.)</p>
            <p  style="display: inline-block;">Заказчик: ________________________</p>
            <p style="font-style: italic; font-size: 12px;">за Кононович Галину Павловну по доверенности от 12.09.2022 г.<br>Бланк доверенности: 23АВ3180284</p>
            {if $print == 1}
                <div class="akt-print">
                    <img src="{$THEME_IMG}/print.png" width="146">
                </div>
                <div class="akt-sign-img">
                    <img src="{$THEME_IMG}/sign.png" width="100">
                </div>
            {/if}
        </div>
    {/if}
</div>
{else}
    {if $user['renter_id'] == $item['renter_id']}
            {if $item['new_ip']}
            <div class="wrapper-akt">
                <div class="arendodatel-name">
                    <p>Индивидуальный предприниматель Кононович Антон Анатольевич</p>
                </div>
                <div class="arendodatel-address">
                    <p>Адрес: 350058, г. Краснодар, ул. Ставропольская, д. 155, копр. 1, кв. 61</p>
                </div>
                {else}
                <div class="wrapper-akt">
                    <div class="arendodatel-name">
                        <p>Индивидуальный предприниматель Кононович Галина Павловна</p>
                    </div>
                    <div class="arendodatel-address">
                        <p>Адрес: 666784, Иркутская обл, Усть-Кут г., Кирова ул, 12, кв. 14</p>
                    </div>
                    {/if}
            <div class="schet-number">
                <p>Акт № A-{$item['number']} от {$item['day']} {$item['month_string']} {$item['year']} года</p>
            </div>
            <div class="arendator-name">
                <p>Заказчик: {$item.renter_name}</p>
            </div>
            {$count=1}
            <div class="schet">
                <table border="1" cellspacing="0">
                    <tr>
                        <td>№</td>
                        <td>Наименование товара (услуги)</td>
                        <td>Единица измерения</td>
                        <td>Коли<br>чество</td>
                        <td style="width: 90px;">Цена</td>
                        <td style="width: 90px;">Сумма</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>Арендная плата за аренду нежилого помещения №
                            {foreach $item['rooms_number'] as $room}
                                {$room} {if !$room@last},{/if}
                            {/foreach}
                            за {$config->getMonthStringByNumber($item['period_month'])} {$item['period_year']} года {$allpeni.ed}. Основание: Договор
                            аренды нежилого помещения № {$item['contract_number']}
                        </td>
                        <td>мес.</td>
                        <td><input type="text" value="{$item['amount']}"></td>
                        <td><input type="text" value="{$item.sum}"></td>
                        <td><input type="text" value="{$item.sum}"></td>
                    </tr>
                </table>
                <table style="widht: 200px; float: right;">
                    <tr>
                        <td style="text-align: right; font-weight: bold; border: none;">Итого:</td>
                        <td style="width: 90px; border: 1px solid #000000; border-top: none;"><input type="text" value="{$item.sum}"></td>
                    </tr>
                    {if $item['is_discount']}
                        <tr>
                            <td style="text-align: right; font-weight: bold; border: none;">Скидка:</td>
                            <td style="width: 90px; border: 1px solid #000000; border-top: none;"><input type="text" value="{$item['discount']}"></td>
                        </tr>
                    {else}
                        {if $discount == 1}
                            <tr>
                                <td style="text-align: right; font-weight: bold; border: none;">Скидка:</td>
                                <td style="width: 90px; border: 1px solid #000000; border-top: none;"><input type="text" value="{$item['discount']}"></td>
                            </tr>
                        {else}
                            <tr>
                                <td style="text-align: right; font-weight: bold; border: none;">Без налога (НДС).</td>
                                <td style="border: 1px solid #000000;">-</td>
                            </tr>
                        {/if}
                    {/if}
                    {if $item['is_discount']}
                        <tr>
                            <td style="text-align: right; font-weight: bold; border: none;">Всего к оплате:</td>
                            <td style="border: 1px solid #000000;"><input type="text" value="{$item.discount_sum}"></td>
                        </tr>
                    {else}
                        {if $discount == 1}
                            <tr>
                                <td style="text-align: right; font-weight: bold; border: none;">Всего к оплате:</td>
                                <td style="border: 1px solid #000000;"><input type="text" value="{$item.discount_sum}"></td>
                            </tr>
                        {else}
                            <tr>
                                <td style="text-align: right; font-weight: bold; border: none;">Всего к оплате:</td>
                                <td style="border: 1px solid #000000;"><input type="text" value="{$item.sum}"></td>
                            </tr>
                        {/if}
                    {/if}
                </table>
                <div style="clear: both;"></div>
                <div class="podval">
                    {if $item['is_discount']}
                        <p style="font-style: italic; font-size: 12px;">Всего оказано услуг на сумму:  <strong> <input class="numeric-sum" style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="{$item.sum_discount_string}"> </strong> в т.ч.: НДС - Ноль рублей 00 копеек</p>
                    {else}
                        {if $discount == 1}
                            <p style="font-style: italic; font-size: 12px;">Всего оказано услуг на сумму:  <strong> <input class="numeric-sum" style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="{$item.sum_discount_string}"> </strong> в т.ч.: НДС - Ноль рублей 00 копеек</p>
                        {else}
                            <p style="font-style: italic; font-size: 12px;">Всего оказано услуг на сумму:  <strong> <input class="numeric-sum" style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="{$item.sum_string}"> </strong> в т.ч.: НДС - Ноль рублей 00 копеек</p>
                        {/if}
                    {/if}

                    <p style="font-style: italic; font-size: 12px;">Вышеперечисленные услуги выполнены полностью и в срок. Заказчик претензий по объему, качеству и срокам оказания услуг не имеет</p>
                </div>
            </div>
            {if $item['new_ip']}
                <div class="sign">
                    <p style="display: inline-block; margin-right: 120px;">Исполнитель: _____________(Гавриленко Н.В.)</p>
                    <p  style="display: inline-block;">Заказчик: ________________________</p>
                    <p style="font-style: italic; font-size: 12px;">за Кононович Галину Павловну по доверенности от 01.04.2025 г.<br>Бланк доверенности: 23АВ6032597</p>
                    {if $print == 1}
                        <div class="akt-print">
                            <img src="{$THEME_IMG}/print_KononovichAA.png" width="146">
                        </div>
                        <div class="akt-sign-img">
                            <img src="{$THEME_IMG}/sign_KononovichAA.png" width="100">
                        </div>
                    {/if}
                </div>
            {else}
                <div class="sign">
                    <p style="display: inline-block; margin-right: 120px;">Исполнитель: _____________(Гавриленко Н.В.)</p>
                    <p  style="display: inline-block;">Заказчик: ________________________</p>
                    <p style="font-style: italic; font-size: 12px;">за Кононович Галину Павловну по доверенности от 12.09.2022 г.<br>Бланк доверенности: 23АВ3180284</p>
                    {if $print == 1}
                        <div class="akt-print">
                            <img src="{$THEME_IMG}/print.png" width="146">
                        </div>
                        <div class="akt-sign-img">
                            <img src="{$THEME_IMG}/sign.png" width="100">
                        </div>
                    {/if}
                </div>
            {/if}
        </div>
    {else}
        <p>У вас нет прав для просмотра данной страницы!!</p>
    {/if}
{/if}
