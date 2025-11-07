var renterAutocomplete;
$(document).ready(function(){
    $('.collapsible').collapsible();

    $('#invoices-submit').on('click', function (e){
        e.preventDefault();
        let form = $('#invoices');
        let fd = new FormData(form[0]);
        let url = form.data('url');
        console.log('data', fd);
        $.ajax({
            url: url,
            type: 'POST',
            data: fd,
            processData: false,
            contentType: false,
            dataType: 'JSON',
            success: function(res){
                if(!res.success){
                    if(res.error === 'date'){
                        M.toast({html: '<p>Не указана дата</p>', classes: 'toast_error'});
                    }
                    if(res.error === 'period_month'){
                        M.toast({html: '<p>Укажите месяц</p>', classes: 'toast_error'});
                    }
                    if(res.error === 'period_year'){
                        M.toast({html: '<p>Укажите год</p>', classes: 'toast_error'});
                    }
                    if(res.error === 'contracts'){
                        M.toast({html: '<p>Не выбран договор</p>', classes: 'toast_error'});
                    }
                    if(res.error === 'same'){
                        M.toast({html: '<p>' + res.same_renter + ' уже есть</p>', classes: 'toast_error', displayLength: 7000});
                    }
                }else{
                    M.toast({html: '<p>Счета выставлены</p>', classes: 'toast_success'});
                    form[0].reset();
                }
            },
            error: function(err){
                console.error(err);
                M.toast({html: '<p>Произошла ошибка</p>', classes: 'toast_error'});
            }
        })
    });

    // Заполняем автокомплит всеми арендаторами
    if ($('.autocomplete#renters').length) {
        let renters = {};
        let elem = $('.autocomplete#renters');
        $.ajax({
            url: elem.data('action'),
            type: 'POST',
            dataType: 'JSON',
            success: function(res) {
                for(let i = 0; i < res.renters.length; i++){
                    let st = res['renters'][i]['short_title'];
                    renters[st] = null;
                }
            }
        });

        renterAutocomplete = M.Autocomplete.init(
            document.querySelector('.autocomplete#renters'),
            {
                minLength: 0,
                data: renters,
                onAutocomplete: function(val){
                    if(elem.data('option') === 'contract-next'){
                        showRenterContracts(val, elem);
                    }
                }
            }
        );
    }

    if ($('.autocomplete#renters-payment-filer').length) {
        let renters = {};
        let elem = $('.autocomplete#renters-payment-filer');
        $.ajax({
            url: elem.data('action'),
            type: 'POST',
            dataType: 'JSON',
            success: function(res) {
                for(let i = 0; i < res.renters.length; i++){
                    let st = res['renters'][i]['short_title'];
                    renters[st] = null;
                }
            }
        });

        renterAutocomplete = M.Autocomplete.init(
            document.querySelector('.autocomplete#renters-payment-filer'),
            {
                minLength: 0,
                data: renters
            }
        );
    }

    $('#print-form-submit').on('click', selectInvoices); // отфильтровать счета по выбранным параметрам
    $('#auth-renter-submit').on('click', authRenter);
    $('body').on('click', '#add-payment', addPayment); // добавление в бд оплаты
    $('body').on('click', '.remove-invoice',  removeInvoice); // удаление счета
    $('body').on('click', '#payment-filter-submit', paymentFilter);
    $('body').on('click', '#payment-filter-reset', paymentFilterReset);
    $('body').on('click', '.refresh-balance', refreshBalance);
    $('body').on('click', '.check-last-invoice', checkLastInvoice);
    $('body').on('click', '.generate-last-invoice', generateLastInvoice);
    $('body').on('click', '.forced-discount', invoiceForcedDiscount);
    $('body').on('click', '#add-communal', addCommunal);
    $('body').on('click', '#set-communal-filter', setCommunalFilter);
});

/**
 * Отображает договоры по выбранному арендатору из поля автозаполнения
 * @param name
 * @param elem
 */
function showRenterContracts(name, elem){
    if($('#select-contract').length){
        $('#select-contract').remove();
    }
    if(name !== ''){
        $.ajax({
            url:elem.data('getcontracts'),
            type: 'POST',
            dataType: 'JSON',
            data: {
                short_title: name
            },
            success: function(res){
                let contracts = res.contracts;
                if(contracts.length > 0){
                    createSelectContracts(contracts, elem);
                }
            },
            error: function(err){
                console.error(err);
            }
        })
    }
}

/**
 * создает элемент select с договорами по выбранному арендатору
 * @param arr
 * @param elem
 * @returns {HTMLSelectElement}
 */
function createSelectContracts(arr, elem) {
    const body = elem.parent();
    const parent = document.createElement('div');
    parent.className = 'input-field filter';
    parent.setAttribute('id', 'select-contract');
    const select = document.createElement('select');
    select.className = 'styled';
    select.setAttribute('name', 'contract');
    body.after(parent);
    parent.appendChild(select);
    const firstOption = document.createElement('option');
    firstOption.value = '0';
    firstOption.innerHTML = 'Выбирете договор';
    select.append(firstOption);
    arr.forEach(function(el) {
        const option = document.createElement('option');
        option.value = el.id;
        option.innerHTML = el.number;

        select.append(option);
        // if (option.value === str) {
        //     option.setAttribute('selected', true);
        // }
    });

    return select
}

function authRenter(e) {
    e.preventDefault();
    $.ajax({
        url: $(this).data('url'),
        data: $('#auth-renter-form').serialize(),
        type: 'POST',
        dataType: 'JSON',
        success: function (res) {
            console.log(res);
        },
        error: function (err) {
            console.error(err);
        }
    });
    console.log($(this).data('url'));
}

/**
 * выбирает все счета по выбранным параметрам
 * @param e
 */
function selectInvoices(e)
{
    if(e !== 'undefined') {
        e.preventDefault();
    }
    let form = $('#print-form');
    let fd = new FormData(form[0]);
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'JSON',
        processData: false,
        contentType: false,
        data: fd,
        success: function(res){
            let context = {
                invoices: res.invoices
            };
            let elem = document.getElementById('print-table');
            let source = $('#print-row-template').html();
            let template = Template7.compile(source);
            elem.innerHTML = template(context);
        },
        error: function(err){
            console.error(err);
            M.toast({html: '<p>Ошибка. Попробуйет еще раз</p>', classes: 'toast_error'});
        }
    });
}

function addPayment(e){
    if(e !== 'undefined') {
        e.preventDefault();
    }
    let form = $('#add-payment-form');
    let fd = new FormData(form[0]);
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'json',
        data: fd,
        contentType: false,
        processData: false,
        success: function(res){
            console.log(res);
            if(!res.success){
                if(res.error === 'date'){
                    M.toast({html: '<p>Не указана дата</p>', classes: 'toast_error'});
                }
                if(res.error === 'renter'){
                    M.toast({html: '<p>Не выбран арендатор</p>', classes: 'toast_error'});
                }
                if(res.error === 'contract'){
                    M.toast({html: '<p>Не выбран договор</p>', classes: 'toast_error'});
                }
                if(res.error === 'number'){
                    M.toast({html: '<p>Не указан номер</p>', classes: 'toast_error'});
                }
                if(res.error === 'summa'){
                    M.toast({html: '<p>Не указана сумма</p>', classes: 'toast_error'});
                }
                if(res.error === 'same'){
                    M.toast({html: '<p>Оплата с такими параметрами уже есть</p>', classes: 'toast_error'});
                }
            }else{
                M.toast({html: '<p>Оплата сохранена</p>', classes: 'toast_success'});
                $('#select-contract').remove();
                form[0].reset();
            }
        },
        error: function(err){
            console.error(err);
            M.toast({html: '<p>Ошибка</p>', classes: 'toast_error'});
        }
    });
}

function removeInvoice(e) {
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'json',
        data: {id: $(this).data('id')},
        success: function (res) {
            if(res.success){
                $('#invoice-row-'+res['id']+'').remove();
                M.toast({html: '<p>Счет удален</p>', classes: 'toast_success'});
            }
        },
        error: function(err){
            console.error(err);
            M.toast({html: '<p>Ошибка. Попробуйет еще раз</p>', classes: 'toast_error'});
        }
    });
}

function paymentFilter(e){
    if(e !== 'undefined'){
        e.preventDefault();
    }
    let form = $('#payment-filter-form');
    let fd = new FormData(form[0]);
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'json',
        contentType: false,
        processData: false,
        data: fd,
        success: function(res){
            if(!res.success){
                if(res.error === 'date'){
                    M.toast({html: '<p>Не правильно указан дипазон</p>', classes: 'toast_error'});
                }
                if(res.error === 'empty'){
                    M.toast({html: '<p>Параметры не выбраны</p>', classes: 'toast_error'});
                }
                if(res.error === 'renter'){
                    M.toast({html: '<p>Нет такого арендатора</p>', classes: 'toast_error'});
                }
            }else{
                let context = {
                    payments: res.payments
                };
                let elem = document.getElementById('payment-table');
                let source = $('#payment-row-template').html();
                let template = Template7.compile(source);
                elem.innerHTML = template(context);
            }
        },
        error: function(err){
            console.error(err);
        }
    });
}

function paymentFilterReset(e) {
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'json',
        contentType: false,
        processData: false,
        success: function(res){
            let context = {
                payments: res.payments
            };
            let elem = document.getElementById('payment-table');
            let source = $('#payment-row-template').html();
            let template = Template7.compile(source);
            elem.innerHTML = template(context);
        },
        error: function(err){
            console.error(err);
        }
    });
}

function refreshBalance(e){
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'json',
        data: {id: $(this).data('id')},
        success: function(res){
            console.log(res);
            let tr = $('#contract-balance-'+res.id+'');
            tr.text(res.balance+'₽');
            if(res.balance < 0){
                tr.removeClass('green-text').addClass('red-text');
            }else{
                tr.removeClass('red-text').addClass('green-text');
            }
        },
        error: function(err){
            console.error(err);
        }
    });
}

function checkLastInvoice(e){
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'json',
        data: {id: $(this).data('id')},
        success: function(res){
            console.log(res);
            if(res.success){
                M.toast({html: '<p>Счет за текущий месяц выставлен</p>', classes: 'toast_success'});
            }else{
                M.toast({html: '<p>Счет за текущий месяц не выставлен</p>', classes: 'toast_error'});
            }


        },
        error: function(err){
            console.error(err);
        }
    });
}

function generateLastInvoice(e) {
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        dataType: 'JSON',
        data: {
            id: $(this).data('id')
        },
        success: function(res){
            if(!res.success){
                if(res.error === 'date'){
                    M.toast({html: '<p>Не указана дата</p>', classes: 'toast_error'});
                }
                if(res.error === 'period_month'){
                    M.toast({html: '<p>Укажите месяц</p>', classes: 'toast_error'});
                }
                if(res.error === 'period_year'){
                    M.toast({html: '<p>Укажите год</p>', classes: 'toast_error'});
                }
                if(res.error === 'contracts'){
                    M.toast({html: '<p>Не выбран договор</p>', classes: 'toast_error'});
                }
                if(res.error === 'same'){
                    M.toast({html: '<p>' + res.same_renter + ' уже есть</p>', classes: 'toast_error', displayLength: 7000});
                }
            }else{
                M.toast({html: '<p>Счет выставлены</p>', classes: 'toast_success'});
                $('#contract-balance-'+res.id+'').text(res.balance+'₽');
                if(res.balance < 0){
                    $('#contract-balance-'+res.id+'').removeClass('green-text').addClass('red-text');
                }
                $('#generate-last-invoice-'+res.id+'').removeAttr('title class data-id data-url');
                $('#generate-last-invoice-'+res.id+' .mdi').removeClass('red-mdi').addClass('green-mdi');
            }
        },
        error: function(err){
            console.error(err);
            M.toast({html: '<p>Произошла ошибка</p>', classes: 'toast_error'});
        }
    });
}

function invoiceForcedDiscount(e){
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        data: {id: $(this).data('id')},
        dataType: 'JSON',
        success: function(res){
            if(res.success){
                M.toast({html: '<p>Счет обновлен. Принудительно со скидкой</p>', classes: 'toast_success'});
            }else{
                M.toast({html: '<p>Произошла ошибка11</p>', classes: 'toast_error'});
            }
        },
        error: function(err){
            console.error(err);
            M.toast({html: '<p>Произошла ошибка</p>', classes: 'toast_error'});
        }
    });
}

function addCommunal(e) {
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        data: $('#communal-form').serialize(),
        dataType: 'JSON',
        success: function(res){
            if(res.success){
                M.toast({html: '<p>Добавлено</p>', classes: 'toast_success'});
                $('#communal-form')[0].reset();
            }else{
                if(res.error === 'period'){
                    M.toast({html: '<p>Не указан период</p>', classes: 'toast_error'});
                }
                if(res.error === 'type'){
                    M.toast({html: '<p>Не выбран Тип</p>', classes: 'toast_error'});
                }
                if(res.error === 'summa'){
                    M.toast({html: '<p>Не указана сумма</p>', classes: 'toast_error'});
                }
                if(res.error === 'volume'){
                    M.toast({html: '<p>Не указан объем</p>', classes: 'toast_error'});
                }
                if(res.error === 'same'){
                    M.toast({html: '<p>Такой виду за выбранный период уже занесен</p>', classes: 'toast_error'});
                }
            }
        },
        error: function(err){
            console.error(err);
            M.toast({html: '<p>Произошла ошибка</p>', classes: 'toast_error'});
        }
    });
}

function setCommunalFilter(e) {
    if(e !== 'undefined'){
        e.preventDefault();
    }
    $.ajax({
        url: $(this).data('url'),
        type: 'POST',
        data: $('#communal-filter').serialize(),
        dataType: 'JSON',
        success: function(res){
            let context = {
                communal: res.communal
            };
            let elem = document.getElementById('communal-table');
            let source = $('#communal-row-template').html();
            let template = Template7.compile(source);
            elem.innerHTML = template(context);
        },
        error: function(err){
            console.error(err);
            M.toast({html: '<p>Произошла ошибка</p>', classes: 'toast_error'});
        }
    });
}
