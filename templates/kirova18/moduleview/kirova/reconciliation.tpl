<main>
    <div class="global-wrapper" id="statistics">
        <section>
            {if $is_auth && $user['is_admin']}
                <div class="container">
                    <h1>Статистика</h1>
                    <ul class="tabs">
                        <li class="tab"><a class="waves-effect" href="#communal">Коммуналка</a></li>
                        <li class="tab"><a class="waves-effect" href="#repair">Ремонт</a></li>
                    </ul>
                    <div id="communal">
                        <h2>Коммунальные платежи</h2>
                        <form id="communal-form">
                            <div class="input-field filter">
                                {include file="%kirova%/helpers/month_select.tpl"}
                            </div>
                            <div class="input-field filter">
                                {include file="%kirova%/helpers/year_input.tpl"}
                            </div>
                            <div class="input-field filter">
                                <select name="type" id="communal_type" class="styled">
                                    <option value="0">Вид</option>
                                    <option value="energy">Электроэнергия</option>
                                    <option value="water">Водоснабжение</option>
                                    <option value="heating">Отопление</option>
                                    <option value="trash">Вывоз мусора</option>
                                    <option value="other">Прочее</option>
                                </select>
                            </div>
                            <div class="input-field">
                                <input type="text" name="summa" class="styled" placeholder="Сумма">
                                 <label for="">Сумма</label>
                            </div>
                            <div class="input-field">
                                <input type="text" name="volume" class="styled" placeholder="Объем">
                                <label for="">Объем</label>
                            </div>
                            <div class="form-button right-align">
                                <a data-url="{$router->getUrl('kirova-front-communal', ['Act' => 'addCommunal'])}" id="add-communal" class="btn">Добавить</a>
                            </div>
                        </form>
                        <div class="communal-filter">
                            <h2>Фильтр</h2>
                            <form id="communal-filter">
                                <div class="input-field filter">
                                    {include file="%kirova%/helpers/month_select.tpl"}
                                </div>
                                <div class="input-field filter">
                                    {include file="%kirova%/helpers/year_input.tpl"}
                                </div>
                                <div class="input-field filter">
                                    <select name="type" id="communal_type" class="styled">
                                        <option value="0">Вид</option>
                                        <option value="energy">Электроэнергия</option>
                                        <option value="water">Водоснабжение</option>
                                        <option value="heating">Отопление</option>
                                        <option value="trash">Вывоз мусора</option>
                                        <option value="other">Прочее</option>
                                    </select>
                                </div>
                                <div class="form-button right-align">
                                    <a data-url="{$router->getUrl('kirova-front-communal', ['Act' => 'setFiler'])}" id="set-communal-filter" class="btn">Показать</a>
                                </div>
                            </form>
                        </div>
                        <div class="row">
                            <div class="col">
                                <table class="page-table">
                                    <thead>
                                        <th>Месяц</th>
                                        <th>Год</th>
                                        <th>Тип услуги</th>
                                        <th>Объем</th>
                                        <th>Тариф</th>
                                        <th>Сумма</th>
                                        <th class="right-align">Действия</th>
                                    </thead>
                                    <tbody id="communalt-table">
                                    {foreach $communal as $item}
                                        <tr>
                                            <td>{$item['month_string']}</td>
                                            <td>{$item['year']}</td>
                                            <td>{$item['type_string']}</td>
                                            <td>{$item['volume']}</td>
                                            <td>{$item['rate']}</td>
                                            <td>{$item['summa']}</td>
                                            <td class="right-align actions-td">
                                                {*                                            <a href="#register-payment" class="modal-trigger action" data-header="Редактирование платежа"><i class="mdi mdi-pencil"></i></a>*}
                                                <a href="" class="action"><i class="mdi mdi-delete"></i></a>
                                            </td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="repair">
                        <h2>Ремонты</h2>
                    </div>
                </div>
            {/if}
        </section>
    </div>
</main>

{literal}
    <script type="text/template7" id="communal-row-template">
        <tbody id="communalt-table">
        {{#each communal}}
            <tr>
                <td>{{month_string}}</td>
                <td>{{year}}</td>
                <td>{{type_string}}</td>
                <td>{{volume}}</td>
                <td>{{rate}}</td>
                <td>{{summa}}</td>
                <td class="right-align actions-td">
                    <a href="" class="action"><i class="mdi mdi-delete"></i></a>
                </td>
            </tr>
        {{else}}
            <tr colspan="6">
                не найдено
            </tr>
        {{/each}}
        </tbody>
    </script>
{/literal}

