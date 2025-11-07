
<div class="formbox" >
            
    <div class="rs-tabs" role="tabpanel">
        <ul class="tab-nav" role="tablist">
                    <li class=" active"><a data-target="#kirova-contract-tab0" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(0)}</a></li>
                    <li class=""><a data-target="#kirova-contract-tab1" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(1)}</a></li>
        
        </ul>
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="tab-content crud-form">
            <input type="submit" value="" style="display:none"/>
                        <div class="tab-pane active" id="kirova-contract-tab0" role="tabpanel">
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__number->getTitle()}&nbsp;&nbsp;{if $elem.__number->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__number->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__number->getRenderTemplate() field=$elem.__number}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__date->getTitle()}&nbsp;&nbsp;{if $elem.__date->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__date->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__date->getRenderTemplate() field=$elem.__date}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__renter->getTitle()}&nbsp;&nbsp;{if $elem.__renter->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__renter->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__renter->getRenderTemplate() field=$elem.__renter}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__room->getTitle()}&nbsp;&nbsp;{if $elem.__room->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__room->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__room->getRenderTemplate() field=$elem.__room}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__date_start->getTitle()}&nbsp;&nbsp;{if $elem.__date_start->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__date_start->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__date_start->getRenderTemplate() field=$elem.__date_start}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__date_finish->getTitle()}&nbsp;&nbsp;{if $elem.__date_finish->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__date_finish->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__date_finish->getRenderTemplate() field=$elem.__date_finish}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__sum->getTitle()}&nbsp;&nbsp;{if $elem.__sum->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__sum->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__sum->getRenderTemplate() field=$elem.__sum}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__sum_discount->getTitle()}&nbsp;&nbsp;{if $elem.__sum_discount->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__sum_discount->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__sum_discount->getRenderTemplate() field=$elem.__sum_discount}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__peni->getTitle()}&nbsp;&nbsp;{if $elem.__peni->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__peni->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__peni->getRenderTemplate() field=$elem.__peni}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__start_payment->getTitle()}&nbsp;&nbsp;{if $elem.__start_payment->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__start_payment->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__start_payment->getRenderTemplate() field=$elem.__start_payment}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__start_peni->getTitle()}&nbsp;&nbsp;{if $elem.__start_peni->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__start_peni->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__start_peni->getRenderTemplate() field=$elem.__start_peni}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
                        <div class="tab-pane" id="kirova-contract-tab1" role="tabpanel">
                                                                                                                                                                                                                                                                    
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__balance->getTitle()}&nbsp;&nbsp;{if $elem.__balance->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__balance->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__balance->getRenderTemplate() field=$elem.__balance}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__start_balance->getTitle()}&nbsp;&nbsp;{if $elem.__start_balance->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__start_balance->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__start_balance->getRenderTemplate() field=$elem.__start_balance}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__status->getTitle()}&nbsp;&nbsp;{if $elem.__status->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__status->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__status->getRenderTemplate() field=$elem.__status}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
            
        </form>
    </div>
    </div>