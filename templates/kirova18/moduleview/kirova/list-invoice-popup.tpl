<div class="list-invoice-popup">
    <h1>{$contract['number']} (счета)</h1>
    <table class="page-table checkbox-table">
        <thead>
        <tr>
            <th>Номер</th>
            <th>Сумма</th>
            <th>Период</th>
        </tr>
        </thead>
        <tbody id="print-table">
        {foreach $invoices as $invoice}
            <tr id="invoice-row-{$invoice['id']}" {if $invoice['is_modified']}class="invoice-modified"{/if}>
                <td class="check-field">{$invoice['number']}{if $invoice['is_modified']}<span> (мод.)</span>{/if}</td>
                <td>{$invoice['sum']}{if !$invoice['is_modified']}({$invoice['discount_sum']}){/if} ₽</td>
                <td>{$invoice['period_month_string']} {$invoice['period_year']}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
