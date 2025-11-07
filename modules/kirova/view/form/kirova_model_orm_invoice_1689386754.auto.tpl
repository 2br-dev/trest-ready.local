
<div class="formbox" >
                
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="crud-form">
            <input type="submit" value="" style="display:none">
            <div class="notabs">
                                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                    
                
                
                                    <table class="otable">
                                                                                                                    
                                <tr>
                                    <td class="otitle">{$elem.__number->getTitle()}&nbsp;&nbsp;{if $elem.__number->getHint() != ''}<a class="help-icon" title="{$elem.__number->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__number->getRenderTemplate() field=$elem.__number}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__date->getTitle()}&nbsp;&nbsp;{if $elem.__date->getHint() != ''}<a class="help-icon" title="{$elem.__date->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__date->getRenderTemplate() field=$elem.__date}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__renter_string->getTitle()}&nbsp;&nbsp;{if $elem.__renter_string->getHint() != ''}<a class="help-icon" title="{$elem.__renter_string->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__renter_string->getRenderTemplate() field=$elem.__renter_string}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__renter_id->getTitle()}&nbsp;&nbsp;{if $elem.__renter_id->getHint() != ''}<a class="help-icon" title="{$elem.__renter_id->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__renter_id->getRenderTemplate() field=$elem.__renter_id}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__contract_id->getTitle()}&nbsp;&nbsp;{if $elem.__contract_id->getHint() != ''}<a class="help-icon" title="{$elem.__contract_id->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__contract_id->getRenderTemplate() field=$elem.__contract_id}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__period_month->getTitle()}&nbsp;&nbsp;{if $elem.__period_month->getHint() != ''}<a class="help-icon" title="{$elem.__period_month->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__period_month->getRenderTemplate() field=$elem.__period_month}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__period_year->getTitle()}&nbsp;&nbsp;{if $elem.__period_year->getHint() != ''}<a class="help-icon" title="{$elem.__period_year->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__period_year->getRenderTemplate() field=$elem.__period_year}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__sum->getTitle()}&nbsp;&nbsp;{if $elem.__sum->getHint() != ''}<a class="help-icon" title="{$elem.__sum->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__sum->getRenderTemplate() field=$elem.__sum}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__discount_sum->getTitle()}&nbsp;&nbsp;{if $elem.__discount_sum->getHint() != ''}<a class="help-icon" title="{$elem.__discount_sum->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__discount_sum->getRenderTemplate() field=$elem.__discount_sum}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__is_discount->getTitle()}&nbsp;&nbsp;{if $elem.__is_discount->getHint() != ''}<a class="help-icon" title="{$elem.__is_discount->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__is_discount->getRenderTemplate() field=$elem.__is_discount}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__forced_discount->getTitle()}&nbsp;&nbsp;{if $elem.__forced_discount->getHint() != ''}<a class="help-icon" title="{$elem.__forced_discount->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__forced_discount->getRenderTemplate() field=$elem.__forced_discount}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__is_modified->getTitle()}&nbsp;&nbsp;{if $elem.__is_modified->getHint() != ''}<a class="help-icon" title="{$elem.__is_modified->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__is_modified->getRenderTemplate() field=$elem.__is_modified}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__new_ip->getTitle()}&nbsp;&nbsp;{if $elem.__new_ip->getHint() != ''}<a class="help-icon" title="{$elem.__new_ip->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__new_ip->getRenderTemplate() field=$elem.__new_ip}</td>
                                </tr>
                                                            
                        
                    </table>
                            </div>
        </form>
    </div>