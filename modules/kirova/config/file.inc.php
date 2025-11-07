<?php

namespace kirova\Config;

use RS\Orm\ConfigObject;
use RS\Orm\Type;

/**
 * Класс конфигурации модуля
 */
class File extends ConfigObject
{
    public function _init()
    {
        parent::_init()->append([
            'day_with_discount' => new Type\Integer([
                'description' => t('Количество дней со скидкой')
            ]),
            'first_month_discount_day' => new Type\Integer([
                'description' => t('Количество дней со скидкой в первом месяце')
            ])
        ]);
    }

    /**
     * Проверка выставлен ли счет за выбранный период указанным договорам
     * @param array $contract_ids
     * @param $month
     * @param $year
     * @return array|bool
     */
     public function checkTheSameInvoices(array $contract_ids, $month, $year)
     {
         foreach ($contract_ids as $contract_id){
             $res = \RS\Orm\Request::make()
                ->select('renter_id')
                ->from(new \Kirova\Model\Orm\Invoice())
                ->where([
                    'contract_id' => $contract_id,
                    'period_month' => $month,
                    'period_year' => $year
                ])->exec()->fetchRow();
             if($res){
                 $same[] = $res;
             }
             else {
                 $same = '';
             }
         }
//         if(!empty($res)){
//             return $res;
//         }
         return $same;
     }

    /**
     * Возвращает строковое значение месяца по номеру месяца
     * @param $number
     * @param bool $diclination
     * @return string
     */
     public function getMonthStringByNumber($number, $diclination = false){
         $string = '';
         if($diclination) {
             switch ($number) {
                 case '01':
                     $string = 'Января';
                     break;
                 case '02':
                     $string = 'Февраля';
                     break;
                 case '03':
                     $string = 'Марта';
                     break;
                 case '04':
                     $string = 'Апреля';
                     break;
                 case '05':
                     $string = 'Мая';
                     break;
                 case '06':
                     $string = 'Июня';
                     break;
                 case '07':
                     $string = 'Июля';
                     break;
                 case '08':
                     $string = 'Августа';
                     break;
                 case '09':
                     $string = 'Сентября';
                     break;
                 case '10':
                     $string = 'Октября';
                     break;
                 case '11':
                     $string = 'Ноября';
                     break;
                 case '12':
                     $string = 'Декабря';
                     break;
             }
         }else{
             switch ($number) {
                 case '01':
                     $string = 'Январь';
                     break;
                 case '02':
                     $string = 'Февраль';
                     break;
                 case '03':
                     $string = 'Март';
                     break;
                 case '04':
                     $string = 'Апрель';
                     break;
                 case '05':
                     $string = 'Май';
                     break;
                 case '06':
                     $string = 'Июнь';
                     break;
                 case '07':
                     $string = 'Июль';
                     break;
                 case '08':
                     $string = 'Август';
                     break;
                 case '09':
                     $string = 'Сентябрь';
                     break;
                 case '10':
                     $string = 'Октябрь';
                     break;
                 case '11':
                     $string = 'Ноябрь';
                     break;
                 case '12':
                     $string = 'Декабрь';
                     break;
             }
         }
         return $string;
     }

    /**
     * Переводит число в строковое значение
     * @param $num
     * @return string
     */
    function num2str($num)
    {
        /* 	$num = str_replace('.', $num, ','); */
        $nul = 'ноль';
        $ten = array(
            array('', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять'),
            array('', 'одна', 'две', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять'),
        );
        $a20 = array('десять', 'одиннадцать', 'двенадцать', 'тринадцать', 'четырнадцать', 'пятнадцать', 'шестнадцать', 'семнадцать', 'восемнадцать', 'девятнадцать');
        $tens = array(2 => 'двадцать', 'тридцать', 'сорок', 'пятьдесят', 'шестьдесят', 'семьдесят', 'восемьдесят', 'девяносто');
        $hundred = array('', 'сто', 'двести', 'триста', 'четыреста', 'пятьсот', 'шестьсот', 'семьсот', 'восемьсот', 'девятьсот');
        $unit = array( // Units
            array('копейка', 'копейки', 'копеек', 1),
            array('рубль', 'рубля', 'рублей', 0),
            array('тысяча', 'тысячи', 'тысяч', 1),
            array('миллион', 'миллиона', 'миллионов', 0),
            array('миллиард', 'милиарда', 'миллиардов', 0),
        );
        //
        list($rub, $kop) = explode('.', sprintf("%015.2f", floatval($num)));
        $out = array();
        if (intval($rub) > 0) {
            foreach (str_split($rub, 3) as $uk => $v) { // by 3 symbols
                if (!intval($v)) continue;
                $uk = sizeof($unit) - $uk - 1; // unit key
                $gender = $unit[$uk][3];
                list($i1, $i2, $i3) = array_map('intval', str_split($v, 1));
                // mega-logic
                $out[] = $hundred[$i1]; # 1xx-9xx
                if ($i2 > 1) $out[] = $tens[$i2] . ' ' . $ten[$gender][$i3]; # 20-99
                else $out[] = $i2 > 0 ? $a20[$i3] : $ten[$gender][$i3]; # 10-19 | 1-9
                // units without rub & kop
                if ($uk > 1) $out[] = $this->morph($v, $unit[$uk][0], $unit[$uk][1], $unit[$uk][2]);
            } //foreach
        } else $out[] = $nul;
        $out[] = $this->morph(intval($rub), $unit[1][0], $unit[1][1], $unit[1][2]); // rub
        $out[] = $kop . ' ' . $this->morph($kop, $unit[0][0], $unit[0][1], $unit[0][2]); // kop
        return trim(preg_replace('/ {2,}/', ' ', join(' ', $out)));
    }

    function morph($n, $f1, $f2, $f5)
    {
        $n = abs(intval($n)) % 100;
        if ($n > 10 && $n < 20) return $f5;
        $n = $n % 10;
        if ($n > 1 && $n < 5) return $f2;
        if ($n == 1) return $f1;
        return $f5;
    }

    /**
     * Проверяет была ли ранее занесена оплата с указанными параметрами
     * @param $renter_id
     * @param $contract_id
     * @param $number
     * @param $summa
     * @param $date
     * @return bool
     */
    public function checkTheSamePayment($renter_id, $contract_id, $number, $summa, $date)
    {
        $res = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Payment())
            ->where([
                'renter_id' => $renter_id,
                'contract_id' => $contract_id,
                'number' => $number,
                'sum' => $summa,
                'date' => $date
            ])->exec()->fetchRow();
        if($res){
            return true;
        }
        return false;
    }

    /*
     * @param $array - что пишем в лог $date - указывать дату и время записи лога
     * Пишем логи
     */
    public function writeLog($array, $date = false, $clear = false)
    {
        if($date){
            $log = date('Y-m-d H:i:s') . ' ' . print_r($array, true);
        }else{
            $log = print_r($array, true);
        }
        if($clear){
            file_put_contents(\Setup::$PATH . '/log.txt', '', FILE_TEXT);
        }
        file_put_contents(\Setup::$PATH . '/log.txt', $log . PHP_EOL, FILE_APPEND);
    }

    public static function checkInvoicePeriod(array $contracts_id, $period_month, $period_year)
    {
        $error = [];
        foreach($contracts_id as $contract_id){
            $contract = \RS\Orm\Request::make()
                ->select('payment_start, date_finish')
                ->from(new \Kirova\Model\Orm\Contract())
                ->where([
                    'id' => $contract_id
                ])->exec()->fetchRow();
            $start_payment_month = date('m', strtotime($contract['payment_start']));
            $start_payment_year = date('Y', strtotime($contract['payment_start']));
            $finish_month = date('m', strtotime($contract['date_finish']));
            $finish_year = date('Y', strtotime($contract['date_finish']));
            if((int)$start_payment_month > (int)$period_month && $start_payment_year == $period_year){
                $error[] = $contract_id;
                break;
            }
            if($start_payment_year > $period_year){
                $error[] = $contract_id;
                break;
            }
            if($period_year > $finish_year){
                $error[] = $contract_id;
                break;
            }elseif($period_year == $finish_year) {
                if($period_month > $finish_month){
                    $error[] = $contract_id;
                    break;
                }
            }
        }
        return $error;
    }
}
