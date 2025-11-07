
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
                                    <td class="otitle">{$elem.__date_start_additional->getTitle()}&nbsp;&nbsp;{if $elem.__date_start_additional->getHint() != ''}<a class="help-icon" title="{$elem.__date_start_additional->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__date_start_additional->getRenderTemplate() field=$elem.__date_start_additional}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__contract_id->getTitle()}&nbsp;&nbsp;{if $elem.__contract_id->getHint() != ''}<a class="help-icon" title="{$elem.__contract_id->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__contract_id->getRenderTemplate() field=$elem.__contract_id}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__room->getTitle()}&nbsp;&nbsp;{if $elem.__room->getHint() != ''}<a class="help-icon" title="{$elem.__room->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__room->getRenderTemplate() field=$elem.__room}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__date_start->getTitle()}&nbsp;&nbsp;{if $elem.__date_start->getHint() != ''}<a class="help-icon" title="{$elem.__date_start->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__date_start->getRenderTemplate() field=$elem.__date_start}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__date_finish->getTitle()}&nbsp;&nbsp;{if $elem.__date_finish->getHint() != ''}<a class="help-icon" title="{$elem.__date_finish->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__date_finish->getRenderTemplate() field=$elem.__date_finish}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__sum->getTitle()}&nbsp;&nbsp;{if $elem.__sum->getHint() != ''}<a class="help-icon" title="{$elem.__sum->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__sum->getRenderTemplate() field=$elem.__sum}</td>
                                </tr>
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__sum_discount->getTitle()}&nbsp;&nbsp;{if $elem.__sum_discount->getHint() != ''}<a class="help-icon" title="{$elem.__sum_discount->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__sum_discount->getRenderTemplate() field=$elem.__sum_discount}</td>
                                </tr>
                                                            
                        
                    </table>
                            </div>
        </form>
    </div>