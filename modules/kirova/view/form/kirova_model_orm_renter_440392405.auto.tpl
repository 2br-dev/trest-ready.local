
<div class="formbox" >
            
    <div class="rs-tabs" role="tabpanel">
        <ul class="tab-nav" role="tablist">
                    <li class=" active"><a data-target="#kirova-renter-tab1" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(1)}</a></li>
                    <li class=""><a data-target="#kirova-renter-tab2" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(2)}</a></li>
                    <li class=""><a data-target="#kirova-renter-tab3" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(3)}</a></li>
                    <li class=""><a data-target="#kirova-renter-tab4" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(4)}</a></li>
                    <li class=""><a data-target="#kirova-renter-tab5" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(5)}</a></li>
                    <li class=""><a data-target="#kirova-renter-tab6" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(6)}</a></li>
        
        </ul>
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="tab-content crud-form">
            <input type="submit" value="" style="display:none"/>
                        <div class="tab-pane active" id="kirova-renter-tab1" role="tabpanel">
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__title->getTitle()}&nbsp;&nbsp;{if $elem.__title->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__title->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__title->getRenderTemplate() field=$elem.__title}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__short_title->getTitle()}&nbsp;&nbsp;{if $elem.__short_title->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__short_title->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__short_title->getRenderTemplate() field=$elem.__short_title}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__form->getTitle()}&nbsp;&nbsp;{if $elem.__form->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__form->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__form->getRenderTemplate() field=$elem.__form}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__inn->getTitle()}&nbsp;&nbsp;{if $elem.__inn->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__inn->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__inn->getRenderTemplate() field=$elem.__inn}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__kpp->getTitle()}&nbsp;&nbsp;{if $elem.__kpp->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__kpp->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__kpp->getRenderTemplate() field=$elem.__kpp}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__orgn->getTitle()}&nbsp;&nbsp;{if $elem.__orgn->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__orgn->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__orgn->getRenderTemplate() field=$elem.__orgn}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__pasport->getTitle()}&nbsp;&nbsp;{if $elem.__pasport->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__pasport->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__pasport->getRenderTemplate() field=$elem.__pasport}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
                        <div class="tab-pane" id="kirova-renter-tab2" role="tabpanel">
                                                                                                                                                                                                                                                                                                                                        
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone->getTitle()}&nbsp;&nbsp;{if $elem.__phone->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__phone->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone->getRenderTemplate() field=$elem.__phone}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__e_mail->getTitle()}&nbsp;&nbsp;{if $elem.__e_mail->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__e_mail->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__e_mail->getRenderTemplate() field=$elem.__e_mail}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__ur_address->getTitle()}&nbsp;&nbsp;{if $elem.__ur_address->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__ur_address->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__ur_address->getRenderTemplate() field=$elem.__ur_address}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__post_address->getTitle()}&nbsp;&nbsp;{if $elem.__post_address->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__post_address->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__post_address->getRenderTemplate() field=$elem.__post_address}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
                        <div class="tab-pane" id="kirova-renter-tab3" role="tabpanel">
                                                                                                                                                                                                                                                                                                                                        
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__position_leader->getTitle()}&nbsp;&nbsp;{if $elem.__position_leader->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__position_leader->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__position_leader->getRenderTemplate() field=$elem.__position_leader}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__fio_leader->getTitle()}&nbsp;&nbsp;{if $elem.__fio_leader->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__fio_leader->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__fio_leader->getRenderTemplate() field=$elem.__fio_leader}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone_leader->getTitle()}&nbsp;&nbsp;{if $elem.__phone_leader->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__phone_leader->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone_leader->getRenderTemplate() field=$elem.__phone_leader}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__email_leader->getTitle()}&nbsp;&nbsp;{if $elem.__email_leader->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__email_leader->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__email_leader->getRenderTemplate() field=$elem.__email_leader}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
                        <div class="tab-pane" id="kirova-renter-tab4" role="tabpanel">
                                                                                                                                                                                                                                                                    
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__fio_accountant->getTitle()}&nbsp;&nbsp;{if $elem.__fio_accountant->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__fio_accountant->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__fio_accountant->getRenderTemplate() field=$elem.__fio_accountant}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__phone_accountant->getTitle()}&nbsp;&nbsp;{if $elem.__phone_accountant->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__phone_accountant->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__phone_accountant->getRenderTemplate() field=$elem.__phone_accountant}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__email_accountant->getTitle()}&nbsp;&nbsp;{if $elem.__email_accountant->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__email_accountant->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__email_accountant->getRenderTemplate() field=$elem.__email_accountant}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
                        <div class="tab-pane" id="kirova-renter-tab5" role="tabpanel">
                                                                                                                            
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__start_balance->getTitle()}&nbsp;&nbsp;{if $elem.__start_balance->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__start_balance->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__start_balance->getRenderTemplate() field=$elem.__start_balance}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
                        <div class="tab-pane" id="kirova-renter-tab6" role="tabpanel">
                                                                                                                                                                                                
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__login->getTitle()}&nbsp;&nbsp;{if $elem.__login->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__login->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__login->getRenderTemplate() field=$elem.__login}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__password->getTitle()}&nbsp;&nbsp;{if $elem.__password->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__password->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__password->getRenderTemplate() field=$elem.__password}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
            
        </form>
    </div>
    </div>