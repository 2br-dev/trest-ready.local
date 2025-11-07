{addcss file='akt.css'}
{$config = \RS\Config\Loader::ByModule('kirova')}
<div class="wrapper-sf">
    <div class="forma">
        <p>Приложение № 1<br>к постановлению Правительства Российской Федерации<br>от 26 декабря 2011 г.  № 1137</p>
        <p>(в ред. Постановления Правительства РФ от 02.04.2021 № 534)</p>
    </div>
    <div style="clear: both;"></div>

    <div class="sf-number">
        <p>Счет-фактура № A-{$item['number']} от "{$item['day']}" {$item['month_string']} {$item['year']} года</p>
        <p style="font-size: 16px; font-weight: normal;">Исправление № ---- от ----</p>
    </div>
    {if $item['new_ip']}
        <div class="sf-data">
            <p>Продавец: Индивидуальный предприниматель Кононович Антон Анатольевич</p>
            <p>Адрес: 350058, Краснодарский край, Краснодар г., Ставропольская ул, 155/1, кв. 61</p>
            <p>ИНН/КПП продавца  381800675733</p>
            <p>Грузоотправитель и его адрес: ----</p>
            <p>Грузополучатель и его адрес: ----</p>
            <p>К платежно-расчетному документу №    от</p>
            <p>Документ об отгрузке № п/п __________ № _________ от ________________</p>
            <p>Покупатель: {$item['renter_full_name']}</p>
            <p>Адрес: {$item['renter_address']}</p>
            <p>ИНН/КПП покупателя: {$item.inn} {if $item.kpp != ""}/{/if} {$item.kpp}</p>
            <p>Валюта: наименование, код  Российский рубль, 643</p>
            <p>Идентификатор государственного контракта, договора (соглашения) (при наличии)________________________</p>
        </div>
    {else}
        <div class="sf-data">
            <p>Продавец: Индивидуальный предприниматель Кононович Галина Павловна</p>
            <p>Адрес: 666784, Иркутская обл, Усть-Кут г., Кирова ул, 12, кв. 14</p>
            <p>ИНН/КПП продавца  381800677995</p>
            <p>Грузоотправитель и его адрес: ----</p>
            <p>Грузополучатель и его адрес: ----</p>
            <p>К платежно-расчетному документу №    от</p>
            <p>Документ об отгрузке № п/п __________ № _________ от ________________</p>
            <p>Покупатель: {$item['renter_full_name']}</p>
            <p>Адрес: {$item['renter_address']}</p>
            <p>ИНН/КПП покупателя: {$item.inn} {if $item.kpp != ""}/{/if} {$item.kpp}</p>
            <p>Валюта: наименование, код  Российский рубль, 643</p>
            <p>Идентификатор государственного контракта, договора (соглашения) (при наличии)________________________</p>
        </div>
    {/if}
    <div class="sf-table">
        <table cellspacing="0">
            <tr>
                <td rowspan="2">№<br>п/п</td>
                <td rowspan="2">Наименование товара (описание<br>выполненных работ, оказанных<br>услуг), имущественного права</td>
                <td rowspan="2">Код<br>вида<br>товара</td>
                <td colspan="2">Единица<br>измерения</td>
                <td rowspan="2">Коли-<br>чество<br>(объем)</td>
                <td rowspan="2">Цена (тариф)<br>за единицу<br>измерения</td>
                <td rowspan="2">Стоимость<br>товаров<br>(работ, услуг),<br>имуществен-<br>ных прав<br>без налога-<br>всего</td>
                <td rowspan="2">В том числе<br>сумма<br>акциза</td>
                <td rowspan="2">Налоговая<br>ставка</td>
                <td rowspan="2">Сумма<br>налога,<br>предъявляемая<br>покупателю</td>
                <td rowspan="2">Стоимость<br>товаров<br>(работ, услуг),<br>имуществен-<br>ных прав с<br>налогом-всего</td>
                <td colspan="2">Страна<br>происхождения товара</td>
                <td rowspan="2">Регистр. номер<br>декларации на товары или регистрационный номер партии товара, подлежащего прослеживаемости</td>
                <td colspan="2">Количественая единица измерения товара,<br>используемая в целях осуществления прослеживаемости</td>
                <td rowspan="2">Количество товара,<br>подлежащего прослеживаемости, в количественной единице измерения товара, используемой в целях осуществления прослеживаемости</td>
            </tr>
            <tr>
                <td>Код</td>
                <td>условное<br>обозначение<br>(национальное)</td>
                <td>цифровой<br>код</td>
                <td>краткое<br>наименование</td>
                <td>Код</td>
                <td>условное<br>обозначение</td>
            </tr>
            <tr>
                <td>1</td>
                <td>1a</td>
                <td>1б</td>
                <td>2</td>
                <td>2а</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
                <td>6</td>
                <td>7</td>
                <td>8</td>
                <td>9</td>
                <td>10</td>
                <td>10а</td>
                <td>11</td>
                <td>12</td>
                <td>12а</td>
                <td>13</td>
            </tr>
            <tr>
                <td>1</td>
                <td>Арендная плата за аренду нежилого помещения №
                    {foreach $item['rooms_number'] as $room}
                        {$room}{if !$room@last}, {/if}
                    {/foreach}
                    за {$config->getMonthStringByNumber($item['period_month'])} {$item['period_year']} года {$allpeni.ed}. Основание: Договор
                    аренды нежилого помещения № {$item['contract_number']}
                </td>
                <td> - </td>
                <td>362</td>
                <td><input type="text" value="мес."></td>
                <td><input type="text" value="{$item['amount']}"></td>
                {if $discount == 1}
                    <td><input type="text" value="{$item['discount_sum']}"></td>
                {else}
                    <td><input type="text" value="{$item['sum']}"></td>
                {/if}

                {if $discount == 1}
                    <td><input type="text" value="{$item['discount_sum']}"></td>
                {else}
                    <td><input type="text" value="{$item['sum']}"></td>
                {/if}
                <td>без акциза</td>
                <td>без НДС</td>
                <td>без НДС</td>
                {if $discount == 1}
                    <td><input type="text" value="{$item['discount_sum']}"></td>
                {else}
                    <td><input type="text" value="{$item['sum']}"></td>
                {/if}
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="7" style="text-transform: uppercase;"><strong>Всего к оплате:</strong></td>
                {if $discount == 1}
                    <td><input type="text" value="{$item['discount_sum']}"></td>
                {else}
                    <td><input type="text" value="{$item['sum']}"></td>
                {/if}
                <td colspan="2">X</td>
                <td>без НДС</td>
                {if $discount == 1}
                    <td><input type="text" value="{$item['discount_sum']}"></td>
                {else}
                    <td><input type="text" value="{$item['sum']}"></td>
                {/if}
                <td colspan="3" style="border:none;"></td>
            </tr>
        </table>
    </div>
    {if $item['new_ip']}
        <div class="sign">
            <p style="display: inline-block; margin-right: 100px; ">Индивидуальный предприниматель ________________ (Гавриленко Н.В.)</p>
{*            <p style="display: inline-block;"><span style="text-decoration: underline; padding: 0 100px;">серия 38 № 002688578</span><br><span style="font-style: italic; font-size: 10px;">(реквизиты свидетельства о государственной регистрации индивидуального предпринимателя)</span></p>*}
            <p style="font-style: italic; font-size: 12px;">За Кононовича А.А. по доверенности от 01.04.2025 г.<br>Бланк доверенности: 23АВ6032597</p>
            {if $print == '1'}
                <div class="sf-sign-img">
                    <img src="{$THEME_IMG}/sign_KononovichAA.png" width="100">
                </div>
            {/if}
        </div>
    {else}
        <div class="sign">
            <p style="display: inline-block; margin-right: 100px; ">Индивидуальный предприниматель ________________ (Гавриленко Н.В.)</p>
            <p style="display: inline-block;"><span style="text-decoration: underline; padding: 0 100px;">серия 38 № 002688578</span><br><span style="font-style: italic; font-size: 10px;">(реквизиты свидетельства о государственной регистрации индивидуального предпринимателя)</span></p>
            <p style="font-style: italic; font-size: 12px;">За Кононович Г.П. по доверенности от 12.09.2022 г.<br>Бланк доверенности: 23АВ3180284</p>
            {if $print == '1'}
                <div class="sf-sign-img">
                    <img src="{$THEME_IMG}/sign.png" width="100">
                </div>
            {/if}
        </div>
    {/if}
</div>

