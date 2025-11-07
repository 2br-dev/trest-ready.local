<div class="payment-popup">
    <h1>Добавить оплату</h1>
    <form id="add-payment-form">
        <input type="hidden" name="renter" value="{$renter['short_title']}">
        <input type="hidden" name="contract" value="{$contract_id}">
        <div class="row">
            <div class="col m3">
                <div class="input-field">
                    <input type="text" class="styled" placeholder="Номер документа" name="number">
                    <label for="" class="active">Номер</label>
                </div>
            </div>
            <div class="col m4">
                <div class="input-field">
                    <input type="text" class="styled number-only" placeholder="Сумма" name="summa">
                    <label for="" class="active">Сумма</label>
                </div>
            </div>
            <div class="col m5">
                <div class="input-field">
                    <input type="text" class="datepicker-payment styled" placeholder="Дата" name="date">
                    <label for="" class="active">Дата</label>
                </div>
                <input type="hidden" name="date_timestamp" value="0"/>
            </div>
        </div>
        <div class="row">
            <div class="col right-align">
                <a class="btn" id="add-payment" data-url="{$router->getUrl('kirova-front-payment', ['Act' => 'addPayment'])}">Сохранить</a>
            </div>
        </div>
    </form>
</div>
{literal}
    <script>
        $(document).ready(function(){
            var datepickerPaymentPopup = M.Datepicker.init(
                document.querySelectorAll('.datepicker-payment'), {
                firstDay: 1,
                container: 'body',
                format: 'dd mmmm yyyy',
                autoClose: true,
                onSelect: function (data) {
                    fillDateStamp(data, $(this.el));
                },
                i18n: {
                    'months': [
                        'Январь',
                        'Февраль',
                        'Март',
                        'Апрель',
                        'Май',
                        'Июнь',
                        'Июль',
                        'Август',
                        'Сентябрь',
                        'Октябрь',
                        'Ноябрь',
                        'Декабрь'
                    ],
                    monthsShort: [
                        'Янв',
                        'Фев',
                        'Мрт',
                        'Апр',
                        'Май',
                        'Июн',
                        'Июл',
                        'Авг',
                        'Сен',
                        'Окт',
                        'Ноя',
                        'Дек'
                    ],
                    weekdays: [
                        'Воскресенье',
                        'Понедельник',
                        'Вторник',
                        'Среда',
                        'Четверг',
                        'Пятница',
                        'Суббота'
                    ],
                    weekdaysShort: [
                        'Вс',
                        'Пн',
                        'Вт',
                        'Ср',
                        'Чт',
                        'Пт',
                        'Сб'
                    ],
                    weekdaysAbbrev: [
                        'В',
                        'П',
                        'В',
                        'С',
                        'Ч',
                        'П',
                        'С'

                    ]
                }
            });
        });
    </script>
{/literal}
