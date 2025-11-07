<?php

namespace kirova\Controller\Front;

use kirova\Model\ContractApi;
use kirova\Model\Orm\Contract;
use kirova\Model\Orm\Renter;
use kirova\Model\RenterApi;
use RS\Controller\Front;

/**
 * Фронт контроллер
 */
class Contracts extends Front
{
    function actionIndex()
    {
        return $this->result->setTemplate('%kirova%/reestr.tpl');
    }

    /**
     * Обновить баланс договора с учетом всех выставленных счетов и полученных оплат
     * @return \RS\Controller\Result\Standard
     */
    public function actionRefreshBalance()
    {
        $contract_id = $this->request('id', TYPE_INTEGER);

        $contract = new \Kirova\Model\Orm\Contract($contract_id);
        $renter = new \Kirova\Model\Orm\Renter($contract['renter']);

        $invoices = $contract->getAllInvoices();
        $payments = $contract->getAllPayments(true);
        
        
        
        $debit = 0;
        $saldo = 0;
        $saldo_local = 0;

        $discount_miss = false;
        
        $start_balance = $contract['start_balance']; //Старотовый бланс арендатора
        if($start_balance){
            $credit = $start_balance;  
            $credit_local = $start_balance;  
        }else{
            $credit = 0;
            $credit_local = 0;
        }
        $trigger = false; // Выполненно ли условие предоставления скидки
        $info = [];
        $start_balance_inc = false; // Прибавлен ли к оплатам стартовый баланс

        $temp = 0;
        $current_month = date('m');
        $current_year = date('Y');
        $already_exposed = false; // Выставлен ли счет за текущий месяц и год

        $config = \RS\Config\Loader::byModule('kirova');
        
        foreach($invoices as $key_invoice => $invoice){        	
            // Последний день месяца (выставленного счета)
            $last_day = date('t', strtotime($invoice['period_year'].'-'.$invoice['period_month'].'-01'));
            $credit_local = 0;
            if(($invoice['period_month'] == $current_month) && ($invoice['period_year'] == $current_year)){
                $already_exposed = true;
            }
            if(!empty($payments)){
                foreach($payments as $key_payment => $payment){

//                    $log['payment'][] = print_r($payment['date'], true);
//                    $log['invoice'][] = print_r($invoice['date'], true);
//                    file_put_contents(\Setup::$PATH . '/log.txt', print_r($log, true) . PHP_EOL, FILE_APPEND);    
                    // Понять что это за условие???
                    if((strtotime($invoice['period_year'].'-'.$invoice['period_month'].'-'.$last_day) < strtotime($payment['date']))
                        )
                    {   
                    	if(!$trigger){
                    		if($saldo_local < 0){
	                    		$trigger = false;
	                    	}else{
	                    		if($saldo_local - $invoice['discount_sum'] >= 0){
	                    			// $trigger = true;
	                    		}else{
	                    			$trigger = false;
	                    		}
	                    	}       	
                    	}  
                        $credit_local = 0;   	          	
                        break;
                    }

                    $saldo_local = $credit - $debit;

                    // Увеличиваем $credit с учетом стартого баланса арендатора
                    // if(!$start_balance_inc){
                    //     // $credit = $payment['sum'] + $credit + $start_balance;
                    //     $credit_local = $payment['sum'] + $credit_local + $start_balance;
                    //     $start_balance_inc = true;
                    // }else{
                        $credit += $payment['sum'];
                        $credit_local += $payment['sum'];
                    // }
                    // 1. Условие - дата оплаты соответствует льготному периоду оплаты
                    if ((strtotime($payment['date']) < strtotime($invoice['finish_discount']))) {	
                        // 2.Условие - нет задолженности по оплатам т.е. $saldo > 0

                        if ($saldo >= 0) {
                            // 2.a.Условие - сумма платежа больше чем сумма счета со скидкой
                            if ($invoice['discount_sum'] <= $payment['sum']) {
                                $trigger = true;
                            };
                            if($saldo_local >= $invoice['discount_sum']){
                                $trigger = true;
                            }
                            if($credit_local >= $invoice['discount_sum']){
                            	$trigger = true;
                            }
                            if($saldo + $payment['sum'] >= $invoice['discount_sum']){
                                $trigger = true;
                            }
                        } 
                        // 2.1 Условие - $saldo < 0
                        else {
                            //2.1a Условие - сумма плтаежа больше чем $saldo + сумма счета со скидкой
                            if ($credit_local >= abs($saldo) + $invoice['discount_sum']) {
                                $trigger = true;
                            }
                            if($credit - $debit >= $invoice['discount_sum']){
                                $trigger = true;
                            }
                        }

                    }else{  
                        // $trigger = false; 

                        if(!$trigger && $saldo >= $invoice['discount_sum']){ 
                            if($saldo >= $invoice['discount_sum'] || (($credit_local-$saldo_local > $invoice['discount_sum']) && $saldo_local>=0) ){
                                $trigger = true;
                            }else{
                                if($credit_local - $invoice['sum'] > $invoice['discount_sum']){
                                    $trigger = true;
                                }else{
                                    $trigger = false;                                
                                }
                            } 
                        }else{
                        	$discount_miss = true;
                        }
                    }
                    
                    $last_pament_date = strtotime($payment['date']);
                    unset($payments[$key_payment]);
                    if($key_invoice == 0){
                        $saldo = $credit - $debit;
                    }
                }
            }else{
                // Увеличиваем $credit с учетом стартого баланса арендатора
                // if(!$start_balance_inc){
                //     $credit = $credit + $start_balance;
                //     $start_balance_inc = true;
                // }  
            }
            
            if($saldo - $invoice['discount_sum'] >= 0 && $key_invoice != 0){
                $trigger = true;                
            }    
            
            
            // есил итерация по счетам последняя и оплат больше по количеству чем счетов - плюсуем credit
            if ($key_invoice === (count($invoices) - 1)){            
            	if(!empty($payments)){                    
            		foreach ($payments as $key => $value){
	                    $credit += $value['sum'];
	                    $last_pament_date = strtotime($value['date']);
	                }	
            	} 
            	// $info['credit'][] = $credit;
            	// $info['debit'][] = $debit; 
            	// $info['saldo_local'][] = $saldo_local;             
                // if(!$already_exposed){

	        		if(($debit + $invoice['discount_sum'] <= $credit) && ($last_pament_date < strtotime($invoice['finish_discount']))){    	
	                    $trigger = true;
	                }else{                        
                        if($saldo - $invoice['discount_sum'] >= 0){
                            $trigger = true;
                        }else{
                            if($credit - $debit - $invoice['discount_sum'] >= $invoice['discount_sum'] && $saldo >= 0 && ($last_pament_date < strtotime($invoice['finish_discount']))){
                                $info['already_exposed_false'][] = $credit - $debit - $invoice['discount_sum'];
                                $trigger = true;
                            }else{
                                $trigger = false;                                
                            }                            
                        }	                    
	                }	
	        	// Если счет за последний месяц уже выставлен и дата меньше 5 выставленного месяца
                if($already_exposed && $saldo >= 0 && date('j') <= 5 && $trigger == false){
                    $trigger = true;
                }

                // if($credit - $debit - $invoice['sum'] > 0){
                // 	$trigger = true;	
                // }        
            }

            //Если у счета признак - Принудительно со скидкой
            if($invoice['forced_discount']){
                $trigger = true;
            }

            if($trigger){
                $debit += $invoice['discount_sum'];
                $invoice['is_discount'] = 1;
            }
            else{
                if($saldo_local - $invoice['sum'] > 0 && $saldo >= 0 && $saldo_local >= 0){	
                	$info['count'][] = $debit;
                    if($credit_local > 0 && !$discount_miss){
                        $debit += $invoice['discount_sum'];
                        $invoice['is_discount'] = 1;
                        $trigger = true;    
                    }else{
                        if($saldo >= $invoice['discount_sum']){
                            $debit += $invoice['discount_sum'];
                            $invoice['is_discount'] = 1;
                            $trigger = true;    
                        }else{
                            $debit += $invoice['sum'];
                            $invoice['is_discount'] = 0;
                            $trigger = false;
                        }
                        
                    }
                }else{
                     
                    // if($saldo - $invoice['discount_sum'] >= 0 && $key_invoice == 0){
                    //     $debit = $invoice['sum_discount'];
                    //     $invoice['is_discount'] = 1;
                    //     $trigger = true;    
                    // }else{
                        $debit += $invoice['sum'];
                        $invoice['is_discount'] = 0;
                        // $trigger = false;
                    // }
                }
            }
            
           
            $saldo = $credit - $debit;
            $info['saldo'][] = $saldo.' - '.$credit. ' - ' .$debit; 
            $info['trigger'][] = $trigger;
            $info['credit_local'][] = $saldo_local;
            
            $trigger = false;
            $invoice->update();

        }
        // echo "<pre>";
        // var_dump($info);
        // exit();
        $contract['balance'] = round($saldo, 1);
        $contract->update();
        $this->result->addSection('balance', round($saldo, 1));
        $this->result->addSection('id', $contract['id']);
        return $this->result;
    }

    /**
     * Проверяем выставлен ли счет по договора за текущий месяц
     * @return \RS\Controller\Result\Standard
     */
    public function actionCheckLastInvoice()
    {
        $contract_id = $this->request('id', TYPE_INTEGER);
        $contract_api = new \Kirova\Model\ContractApi();
        $invoice = $contract_api->checkLastInvoice($contract_id);
        if($invoice){
            $this->result->setSuccess(true);
        }else{
            $this->result->setSuccess(false);
        }
        return $this->result;
    }

    /**
     * Выставляет счет за текущий месяц
     * @return \RS\Controller\Result\Standard
     */
    public function actionGenerateLastInvoice()
    {
        $id = $this->request('id', TYPE_INTEGER);
        $date = strtotime(date('Y').'-'.date('m').'-01');
        $contract_api = new \Kirova\Model\ContractApi();
        $invoice_api = new \Kirova\Model\InvoiceApi();
        $last_invoice = $invoice_api->getLast();
        $next_number = $last_invoice['number'] + 1;
        $error = '';
        $success = false;
        $config = \RS\Config\Loader::byModule('kirova');
        $same = $same = $config->checkTheSameInvoices([$id], date('m'), date('Y'));
        $same_renter = ''; // Те арендаторы которым были уже выставленные счета за выбранный период
        if($same != ''){
            $error = 'same';
            $success = false;
            foreach ($same as $item){
                $renter = new \Kirova\Model\Orm\Renter($item['renter_id']);
                $same_renter = $same_renter . $renter['short_title'] . ', ';
            }
        }
        if($error == ''){
            $success = $contract_api->generateInvoice([$id], $next_number, $date, date('m'), date('Y'), $config, null);
        }
        if($success){
            $contract = new \Kirova\Model\Orm\Contract($id);
            $contract->refreshBalance();
            $balance = $contract->getBalance();
        }
        $this->result->setSuccess($success);
        $this->result->addSection('error', $error);
        $this->result->addSection('id', $id);
        $this->result->addSection('balance', $balance);
        return $this->result;
    }
}
