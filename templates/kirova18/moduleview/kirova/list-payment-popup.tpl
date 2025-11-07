<div class="list-payment-popup">
    <h1>{$renter['short_title']} (оплаты)</h1>
    <table class="page-table">
        <thead>
            <th>Дата</th>
            <th>Номер</th>
            <th>Сумма</th>
        </thead>
        <tbody id="payment-table">
            {foreach $payments as $payment}
                <tr>
                    <td>{$payment['date']|date_format:'%d.%m.%Y'}</td>
                    <td>{$payment['number']}</td>
                    <td>{$payment['sum']}₽</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
