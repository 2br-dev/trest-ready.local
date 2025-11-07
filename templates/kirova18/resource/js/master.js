var tabs, sidenav, datepicker, select, yearAutocomplete, modal, detailsSidenav, activePicker;

$(() => {
    $('body').on('click', '.toggle-search', toggleSearch);
    $('body').on('keydown', '.editable', setEditable);
    $('body').on('click', '.restore', restoreEditable);
    // $('body').on('click', '.arenda-row', toggleDetails);
    $('body').on('click', '.details-trigger', toggleDetailsSection);
    $('body').on('click', '.address-trigger', openAddress);
    $('body').on('click', '.toast-close', closeToast);
    $('body').on('click', 'a.actions-wrapper', openActions);
    $('body').on('click', clickOutside);
    init();
});

//= Инициализация ==================================================================================================
function init(){
    tabs = M.Tabs.init(document.querySelector('.tabs'));
    sidenav = M.Sidenav.init(document.querySelector('.sidenav#mobile-menu'));
    detailsSidenav = M.Sidenav.init(document.querySelector('.sidenav#details'),{
        edge: 'right'
    });

    // $('body').on('click', 'a.btn', function() {
    //     activePicker = this;
    //     console.log(activePicker);
    // });

    datepicker = M.Datepicker.init(document.querySelectorAll('.datepicker'), {
        firstDay: 1,
        container: 'body',
        format: 'dd mmmm yyyy',
        autoClose: true,
        onSelect: function(data){
            fillDateStamp(data, $(this.el));
        },
        i18n:{
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
            monthsShort:[
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
            weekdays:[
                'Воскресенье',
                'Понедельник',
                'Вторник',
                'Среда',
                'Четверг',
                'Пятница',
                'Суббота'
            ],
            weekdaysShort:[
                'Вс',
                'Пн',
                'Вт',
                'Ср',
                'Чт',
                'Пт',
                'Сб'
            ],
            weekdaysAbbrev:[
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
    modal = M.Modal.init(document.querySelectorAll('.modal'),{
        onOpenStart: (modal, link) => {
            var header = $(modal).find('h3');
            var headerText = $(link).data('header');
            if(headerText){
                header.text(headerText);
            }
        }
    });
    select = M.FormSelect.init(document.querySelectorAll('select'), {
        classes: 'select-wrapper-custom'
    });
    if ($('.autocomplete#year').length) {
        yearAutocomplete = M.Autocomplete.init(document.querySelector('.autocomplete#year'), {
            minLength: 0,
            data: {
                "2021": null,
                "2022": null,
                "2023": null,
                "2024": null,
                "2025": null,
            }
        });
    }
    if($('.autocomplete#payment-type').length){
        yearAutocomplete = M.Autocomplete.init(document.querySelector('.autocomplete#payment-type'), {
            minLength: 0,
            data: {
                "Отопление": null,
                "Горячая вода": null,
                "Холодная вода": null,
                "Электричество": null,
                "Интернет/Интернет-ТВ": null,
                "Спутниковое ТВ": null,
                "Вывоз мусора": null,
            }
        })
    }
}

function fillDateStamp(date, el) {
    let hiddenInput = el.parents('.input-field').next();
    hiddenInput.val(date.getTime()/1000);
}

//= Обработчики событий ============================================================================================
function clickOutside(e){

    var path = e.originalEvent.path || (e.originalEvent.composedPath && e.originalEvent.composedPath()) || composedPath(e.originalEvent);
    var action = $(path).filter((index, el) => {
        return $(el).hasClass('actions-wrapper');
    }).length;
    if(!action){
        $('a.actions-wrapper').removeClass('active');
    }
}

function openActions(){
    $('a.actions-wrapper').removeClass('active');
    $(this).addClass('active');
}

function closeToast(){
    var toast = M.Toast.getInstance($(this).parents('.toast').get(0));
    toast.dismiss();
}

function openAddress(){
    var address = $(this).text();
    M.toast({html: address+'<a class="btn-flat toast-action toast-close">Закрыть</a>', displayLength: Math.infinite})
}

function toggleDetailsSection(e){
    e?.preventDefault();
    $('.details-trigger').removeClass('active');
    $(this).addClass('active');
}

function toggleDetails(e){
    e?.preventDefault();
    $('.arenda-row').removeClass('selected');
    $(this).addClass('selected');
    if($(window).outerWidth() <= 1200)
        detailsSidenav.open();

}

function toggleSearch(e){
    $(this).parents('.h1-wrapper').toggleClass('search-visible');
}

function setEditable(e) {
    var code = e.keyCode;
    console.log(code);

    var contract = $(this).data('contract');

    if (code == 13) {
        e.preventDefault();
        $(this).blur();

        if ($(this).text() != $(this).data('initial-value')) {
            // $(this).addClass('modified');
            $(this).parents('tr').find('.restore').removeClass('hidden');
            console.log('check');
            $('<input type="hidden" name="custom_sum['+contract+']" value="'+$(this).text()+'"/>').appendTo($(this).parents('td'));
        } else {
            $(this).removeClass('modified');
            $(this).parents('tr').find('.restore').addClass('hidden');
            var elem = $('input[name="custom_sum['+contract+']"]');
            console.log(elem);
            if(elem.length){
                elem.remove();
            }
        }
        return false;
    }

    var allowedCodes = [8, 35, 36, 37, 39, 46, 110, 191, 16, 48, 49, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, ];
    var allowedIndex = allowedCodes.indexOf(code);

    if (allowedIndex === -1) {
        e.preventDefault();
        return false;
    }
}
function restoreEditable(e) {
    e.preventDefault();
    var initialValue = $(this).parents('tr').find('[contenteditable]').data('initial-value');
    $(this).addClass('hidden').parents('tr').find('[contenteditable]').text(initialValue).removeClass('modified');
    var contract = $(this).parents('tr').find('[contenteditable]').data('contract');
    var elem = $('input[name="custom_sum['+contract+']"]');
    if(elem.length){
        elem.remove();
    }
}

//= Общие функции ==================================================================================================
// function tableInit(){

//     $('.responsive-table').each((index, table) => {

//         let columnsArray = [];
//         var columns = $(table).find('th');
//         columns.each((index, column) => {
//             columnsArray.push(column.innerText);
//         });

//         var rows = $(table).find('tbody tr');
//         rows.each((index, row) => {

//             var cells = $(row).find('td');

//             cells.each((index, td) => {

//                 let prefix = columnsArray[index];
//                 let prefixElement = $('<span class="prefix">' + prefix + '</span>');
//                 $(td).prepend(prefixElement);
//             })
//         })
//     })
// }

function composedPath (el) {

    var path = [];

    while (el) {

        path.push(el);

        if (el.tagName === 'HTML') {

            path.push(document);
            path.push(window);

            return path;
        }

        el = el.parentElement;
    }
}
