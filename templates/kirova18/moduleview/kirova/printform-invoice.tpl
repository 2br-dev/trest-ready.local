{addcss file='akt.css'}
{$config = \RS\Config\Loader::ByModule('kirova')}
{if $is_auth && $user['is_admin']}
    <div class="wrapper-schet">
        {if $item['new_ip']}
            <div class="arendodatel-name">
                <p>Индивидуальный предприниматель Кононович Антон Анатольевич</p>
            </div>
            <div class="arendodatel-address">
                <p>Адрес: 350058, Краснодарский край, Краснодар г., Ставропольская ул, 155/1, кв. 61</p>
            </div>
            <div class="arendodatel-bank">
                <p>Образец заполнения платежного поручения</p>
                <table border="1" cellspacing="0">
                    <tr>
                        <td>ИНН 381800675733</td>
                        <td>КПП</td>
                        <td rowspan="2">Сч. №</td>
                        <td rowspan="2">40802810906810002133</td>
                    </tr>
                    <tr>
                        <td colspan="2">Получатель<br>Индивидуальный предприниматель Кононович Антон Анатольевич</td>

                    </tr>
                    <tr>
                        <td rowspan="2" colspan="2">Банк Получателя<br>ФИЛИАЛ "ЦЕНТРАЛЬНЫЙ" БАНКА ВТБ (ПАО)</td>
                        <td>БИК</td>
                        <td colspan="2">044525411</td>
                    </tr>
                    <tr>
                        <td>Сч. №</td>
                        <td colspan="2">30101810145250000411</td>
                    </tr>
                </table>
            </div>
        {else}
            <div class="arendodatel-name">
                <p>Индивидуальный предприниматель Кононович Галина Павловна</p>
            </div>
            <div class="arendodatel-address">
                <p>Адрес: 666784, Иркутская обл, Усть-Кут г., Кирова ул, 12, кв. 14</p>
            </div>
            <div class="arendodatel-bank">
                <p>Образец заполнения платежного поручения</p>
                <table border="1" cellspacing="0">
                    <tr>
                        <td>ИНН 381800677995</td>
                        <td>КПП</td>
                        <td rowspan="2">Сч. №</td>
                        <td rowspan="2">40802810130000045576</td>
                    </tr>
                    <tr>
                        <td colspan="2">Получатель<br>Индивидуальный предприниматель Кононович Галина Павловна</td>

                    </tr>
                    <tr>
                        <td rowspan="2" colspan="2">Банк Получателя<br>КРАСНОДАРСКОЕ ОТДЕЛЕНИЕ N8619 ПАО СБЕРБАНК</td>
                        <td>БИК</td>
                        <td colspan="2">040349602</td>
                    </tr>
                    <tr>
                        <td>Сч. №</td>
                        <td colspan="2">30101810100000000602</td>
                    </tr>
                </table>
            </div>
        {/if}
        <div class="schet-number">
            <p>Счет № A-{$item['number']} от {$item['day']} {$item['month_string']} {$item['year']} года</p>
        </div>
        <div class="arendator-name">
            <p>Плательщик: {$item.renter_name}</p>
            <p>Грузополучатель: {$item.renter_name}</p>
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
                            {$room}{if !$room@last}, {/if}
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
                    <p>Всего наименований 1 на сумму <input type="text" id='numeric-sum' value="{$item.discount_sum}"></p>
                    <p><input style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="( {$item.sum_discount_string} )"></p>
                {else}
                    <p>Всего наименований 1 на сумму <input type="text" id='numeric-sum' value="{$item.sum}"></p>
                    <p><input style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="( {$item.sum_string} )"></p>
                {/if}
            </div>
        </div>
        {if $item['new_ip']}
            <div class="sign">
                <p>Руководитель ______________________ (Гавриленко Н.В.)</p>
                <p style="font-style: italic; font-size: 12px;">Действующая за Кононовича Антона Анатольевича по Доверенности от 01.04.2025 г.<br>Бланк доверенности: 23АВ6032597</p>
                {if $print == 1}
                    <div class="akt-sign-img">
                        <img src="{$THEME_IMG}/sign_KononovichAA.png" width="100">
                    </div>
                    <div class="akt-print">
                        <img src="{$THEME_IMG}/print_KononovichAA.png" width="146">
                    </div>
                {/if}
                {if $disc == 1}
                    <p style="margin-top: 50px; width: 100%; text-align: center; font-size: 18px;">Счет действителен до "05" {$item['month_string']} {$item['year']} года</p>
                {/if}
            </div>
        {else}
            <div class="sign">
                <p>Руководитель ______________________ (Гавриленко Н.В.)</p>
                <p style="font-style: italic; font-size: 12px;">Действующая за Кононович Галину Павловну по Доверенности от 12.09.2022 г.<br>Бланк доверенности: 23АВ3180284</p>
                {if $print == 1}
                    <div class="akt-sign-img">
                        <img src="{$THEME_IMG}/sign.png" width="100">
                    </div>
                    <div class="akt-print">
                        <img src="{$THEME_IMG}/print.png" width="146">
                    </div>
                {/if}
                {if $disc == 1}
                    <p style="margin-top: 50px; width: 100%; text-align: center; font-size: 18px;">Счет действителен до "05" {$item['month_string']} {$item['year']} года</p>
                {/if}
            </div>
        {/if}
    </div>
{else}
    {if $user['renter_id'] == $item['renter_id']}
        <div class="wrapper-schet">
            {if $item['new_ip']}
                <div class="arendodatel-name">
                    <p>Индивидуальный предприниматель Кононович Антон Анатольевич</p>
                </div>
                <div class="arendodatel-address">
                    <p>Адрес: 350058, Краснодарский край, Краснодар г., Ставропольская ул, 155/1, кв. 61</p>
                </div>
                <div class="arendodatel-bank">
                    <p>Образец заполнения платежного поручения</p>
                    <table border="1" cellspacing="0">
                        <tr>
                            <td>ИНН 381800675733</td>
                            <td>КПП</td>
                            <td rowspan="2">Сч. №</td>
                            <td rowspan="2">40802810906810002133</td>
                        </tr>
                        <tr>
                            <td colspan="2">Получатель<br>Индивидуальный предприниматель Кононович Антон Анатольевич</td>

                        </tr>
                        <tr>
                            <td rowspan="2" colspan="2">Банк Получателя<br>ФИЛИАЛ "ЦЕНТРАЛЬНЫЙ" БАНКА ВТБ (ПАО)</td>
                            <td>БИК</td>
                            <td colspan="2">044525411</td>
                        </tr>
                        <tr>
                            <td>Сч. №</td>
                            <td colspan="2">30101810145250000411</td>
                        </tr>
                    </table>
                </div>
            {else}
                <div class="arendodatel-name">
                    <p>Индивидуальный предприниматель Кононович Галина Павловна</p>
                </div>
                <div class="arendodatel-address">
                    <p>Адрес: 666784, Иркутская обл, Усть-Кут г., Кирова ул, 12, кв. 14</p>
                </div>
                <div class="arendodatel-bank">
                    <p>Образец заполнения платежного поручения</p>
                    <table border="1" cellspacing="0">
                        <tr>
                            <td>ИНН 381800677995</td>
                            <td>КПП</td>
                            <td rowspan="2">Сч. №</td>
                            <td rowspan="2">40802810130000045576</td>
                        </tr>
                        <tr>
                            <td colspan="2">Получатель<br>Индивидуальный предприниматель Кононович Галина Павловна</td>

                        </tr>
                        <tr>
                            <td rowspan="2" colspan="2">Банк Получателя<br>КРАСНОДАРСКОЕ ОТДЕЛЕНИЕ N8619 ПАО СБЕРБАНК</td>
                            <td>БИК</td>
                            <td colspan="2">040349602</td>
                        </tr>
                        <tr>
                            <td>Сч. №</td>
                            <td colspan="2">30101810100000000602</td>
                        </tr>
                    </table>
                </div>
            {/if}
            <div class="schet-number">
                <p>Счет № A-{$item['number']} от {$item['day']} {$item['month_string']} {$item['year']} года</p>
            </div>
            <div class="arendator-name">
                <p>Плательщик: {$item.renter_name}</p>
                <p>Грузополучатель: {$item.renter_name}</p>
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
                                {$room}{if !$room@last}, {/if}
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
                    {if $item['is_discount'] == 1}
                        <tr>
                            <td style="text-align: right; font-weight: bold; border: none;">Скидка:</td>
                            <td style="width: 90px; border: 1px solid #000000; border-top: none;"><input type="text" value="{$item['discount']}"></td>
                        </tr>
                    {else}
                        {if $discount}
                            <tr>
                                <td style="text-align: right; font-weight: bold; border: none;">Скидка:</td>
                                <td style="width: 90px; border: 1px solid #000000; border-top: none;"><input type="text" value="{$item['discount']}"></td>
                            </tr>
                        {/if}
                    {/if}
                    <tr>
                        <td style="text-align: right; font-weight: bold; border: none;">Без налога (НДС).</td>
                        <td style="border: 1px solid #000000;">-</td>
                    </tr>
                    {if $item['is_discount'] == 1}
                        <tr>
                            <td style="text-align: right; font-weight: bold; border: none;">Всего к оплате:</td>
                            <td style="border: 1px solid #000000;"><input type="text" value="{$item.discount_sum}"></td>
                        </tr>
                    {else}
                        {if $discount}
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
                    {if $item['is_discount'] == 1}
                        <p>Всего наименований 1 на сумму <input type="text" id='numeric-sum' value="{$item.discount_sum}"></p>
                        <p><input style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="( {$item.sum_discount_string} )"></p>
                    {else}
                        {if $discount}
                            <p>Всего наименований 1 на сумму <input type="text" id='numeric-sum' value="{$item.discount_sum}"></p>
                            <p><input style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="( {$item.sum_discount_string} )"></p>
                        {else}
                            <p>Всего наименований 1 на сумму <input type="text" id='numeric-sum' value="{$item.sum}"></p>
                            <p><input style="width: 100% !important; max-width: unset; font-weight: bold;" type="text" value="( {$item.sum_string} )"></p>
                        {/if}
                    {/if}
                </div>
            </div>
            {if $item['new_ip']}
                <div class="sign">
                    <p>Руководитель ______________________ (Гавриленко Н.В.)</p>
                    <p style="font-style: italic; font-size: 12px;">Действующая за Кононовича Антона Анатольевича по Доверенности от 01.04.2025 г.<br>Бланк доверенности: 23АВ6032597</p>
                    {if $print == 1}
                        <div class="akt-sign-img">
                            <img src="{$THEME_IMG}/sign_KononovichAA.png" width="100">
                        </div>
                        <div class="akt-print">
                            <img src="{$THEME_IMG}/print_KononovichAA.png" width="146">
                        </div>
                    {/if}
                    {if $disc == 1}
                        <p style="margin-top: 50px; width: 100%; text-align: center; font-size: 18px;">Счет действителен до "05" {$item['month_string']} {$item['year']} года</p>
                    {/if}
                </div>
            {else}
                <div class="sign">
                    <p>Руководитель ______________________ (Гавриленко Н.В.)</p>
                    <p style="font-style: italic; font-size: 12px;">Действующая за Кононович Галину Павловну по Доверенности от 12.09.2022 г.<br>Бланк доверенности: 23АВ3180284</p>
                    {if $print == 1}
                        <div class="akt-sign-img">
                            <img src="{$THEME_IMG}/sign.png" width="100">
                        </div>
                        <div class="akt-print">
                            <img src="{$THEME_IMG}/print.png" width="146">
                        </div>
                    {/if}
                    {if $disc == 1}
                        <p style="margin-top: 50px; width: 100%; text-align: center; font-size: 18px;">Счет действителен до "05" {$item['month_string']} {$item['year']} года</p>
                    {/if}
                </div>
            {/if}
        </div>
    {else}
        <p>У вас нет прав для просмотра данной страницы</p>
    {/if}
{/if}


