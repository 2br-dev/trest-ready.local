<?php

namespace kirova\Model;

use kirova\Model\Orm\Contract;
use RS\Module\AbstractModel\EntityList;

/**
 * Класс для организации выборок ORM объекта.
 * В этом классе рекомендуется также реализовывать любые дополнительные методы, связанные с заявленной в конструкторе моделью
 */
class ContractApi extends EntityList
{
    function __construct()
    {
        parent::__construct(new Contract(), [
            'nameField' => 'number',
        ]);
    }

    public static function staticSelectRentersList($params){
        $user_api = new \Users\Model\Api();
        $renters = $user_api->setFilter('group', 'renter')->getList();
        return array_replace($params, $renters);
    }

    /**
     * Возвращает активные договоры
     * @return \RS\Orm\AbstractObject[]
     */
    public function getActiveContracts()
    {
        $contracts = $this->setFilter('status', 1)
                          ->setFilter('status', 100, '=', 'OR')
                          ->getList();
        return $contracts;
    }

    /**
     * Возвращает архивные договоры
     * @return \RS\Orm\AbstractObject[]
     */
    public function getArchContracts()
    {
        $contracts = $this->clearFilter()->setFilter('status', 0)
            ->getList();
        return $contracts;
    }

    /**
     * Получаем все договоры по id арендаторы
     * @param $renter_id
     * @return array
     */
    public function getAllContractsByRenterId($renter_id)
    {
        $contracts = $this->setFilter('renter', $renter_id)->getListAsArray();
        return $contracts;
    }

    /**
     * Проверяпм выставленн ли счет по договору за текущий месяц
     * @param $id
     * @return array
     */
    public function checkLastInvoice($id)
    {
        $current_month = date('m');
        $current_year = date('Y');
        $invoice = \RS\Orm\Request::make()
            ->from(new \Kirova\Model\Orm\Invoice())
            ->where([
                'contract_id' => $id,
                'period_month' => $current_month,
                'period_year' => $current_year
            ])->exec()->fetchRow();
        return $invoice;
    }

    /**
     * Выставляет счет для договора
     * @param $contracts_id
     * @param $next_number
     * @param $date
     * @param $period_month
     * @param $period_year
     * @param $config
     * @param $custom_sum
     * @return bool
     */
    public function generateInvoice($contracts_id, $next_number, $date, $period_month, $period_year, $config, $custom_sum)
    {
        $success = false;
        $amount = 1;

        foreach ($contracts_id as $contract_id) {
            /**
             * @var \Kirova\Model\Orm\Contract $contract
             */
            $contract = new \Kirova\Model\Orm\Contract($contract_id);
            $renter = $contract->getRenter();
            $invoice = new \Kirova\Model\Orm\Invoice();
            $invoice['number'] = $next_number;
            $next_number++;
            $invoice['date'] = date('Y-m-d', $date);
            $invoice['renter_string'] = $renter['title'];
            $invoice['renter_id'] = $renter['id'];
            $invoice['contract_id'] = $contract_id;
            $invoice['period_month'] = $period_month;
            $invoice['period_year'] = $period_year;
            $dop = false;
            if ($contract['has_dop']) {
                $dop = $contract->getActualSumForInvoice($period_month, $period_year);
            }
            // echo '<pre>';
            // var_dump($dop);
            // exit();
            //Определить дату начала аренды
            $contract_start_payment_month = date('m', strtotime($contract['start_payment'])); // месяц начала аренды
            $contract_start_payment_year = date('Y', strtotime($contract['start_payment'])); // год начала аренды

            if ($period_month == $contract_start_payment_month && $period_year == $contract_start_payment_year) {
                $contract_start_payment_day = date('j', strtotime($contract['start_payment'])); // день начала аренды без первого 0
                if ($contract_start_payment_day > 1) {
                    $count_day_in_month = date('t', strtotime($contract['start_payment']));
                    $amount = ($count_day_in_month - $contract_start_payment_day + 1) / $count_day_in_month; // +1 - чтоб учесть первый день аренды включительно
                    $amount = round($amount, 2);

                }
                $finish_discount = date('Y-m-d', strtotime('+' . $config['first_month_discount_day'] . ' days', strtotime($contract['start_payment'])));
            } else {
                $finish_discount = date('Y-m-d', strtotime('+' . $config['day_with_discount'] . ' days', strtotime($period_year . '-' . $period_month . '-01')));
            }
            if ($custom_sum != NULL) {
                foreach ($custom_sum as $key => $value) {
                    if ($key == $contract_id) {
                        $invoice['sum'] = intval($custom_sum[$contract_id]);
                        $invoice['discount_sum'] = intval($custom_sum[$contract_id]);
                        $invoice['is_modified'] = 1;
                    } else {
                        if ($dop) {
                            $invoice['sum'] = $dop['sum'] * $amount;
                            $invoice['discount_sum'] = $dop['sum_discount'] * $amount;
                            $invoice['is_modified'] = 0;
                        } else {
                            $invoice['sum'] = $contract['sum'] * $amount;
                            $invoice['discount_sum'] = $contract['sum_discount'] * $amount;
                            $invoice['is_modified'] = 0;
                        }
                    }
                }
            } else {
                if ($dop) {
                    //Если счет выставления совпадает с месяцем доп. соглашения и соглашение не с 1 числа вычисляем сумму счета
                    if(date('m', strtotime($dop['date_start_additional'])) == $invoice['period_month'] && date('j', strtotime($dop['date_start_additional'])) != 1){
                        $days_in_current_month = date('t');
                        $days_post = $days_in_current_month - date('j', strtotime($dop['date_start_additional']))+1;
                        $days_pre = date('j', strtotime($dop['date_start_additional']))-1;
                        $dop_sum = ($contract['sum']/$days_in_current_month*$days_pre) + ($dop['sum']/$days_in_current_month*$days_post);
                        $dop_sum_discount = ($contract['sum_discount']/$days_in_current_month*$days_pre) + ($dop['sum_discount']/$days_in_current_month*$days_post);
                        $invoice['sum'] = round($dop_sum, 1);
                        $invoice['discount_sum'] = round($dop_sum_discount, 1);
                        $invoice['forced_discount'] = 1;
                    }else{
                        $invoice['sum'] = $dop['sum'] * $amount;
                        $invoice['discount_sum'] = $dop['sum_discount'] * $amount;    
                    }
                    // echo "<pre>";
                    // var_dump($days_in_current_month);
                    // var_dump($days_post);
                    // var_dump($days_pre);
                    // var_dump(round($dop_sum, 1));
                    // var_dump(round($dop_sum_discount, 1));
                    // exit();
                    // $invoice['sum'] = $dop['sum'] * $amount;
                    // $invoice['discount_sum'] = $dop['sum_discount'] * $amount;
                    $invoice['is_modified'] = 0;
                } else {
                    $invoice['sum'] = $contract['sum'] * $amount;
                    $invoice['discount_sum'] = $contract['sum_discount'] * $amount;
                    $invoice['is_modified'] = 0;
                }
            }
            $invoice['is_discount'] = 0;
            $invoice['amount'] = $amount;
            $invoice['finish_discount'] = $finish_discount;
            $success = $invoice->insert();
        }
        return $success;
    }
}
