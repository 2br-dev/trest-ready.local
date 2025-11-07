<div class="renter-login-data">
    <table>
        <thead>
            <tr>
                <th>Арендатор</th>
                <th>Логин</th>
                <th>Пароль</th>
                <th>Сайт</th>
            </tr>
        </thead>
        <tbody>
            {foreach $renters as $renter}
                <tr>
                    <td>{$renter['short_title']}</td>
                    <td>{$renter['login']}</td>
                    <td>{$renter['password']}</td>
                    <td>trest.2-br.ru</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
