
<div class="formbox" >
            
    <div class="rs-tabs" role="tabpanel">
        <ul class="tab-nav" role="tablist">
                    <li class=" active"><a data-target="#kirova-room-tab0" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(0)}</a></li>
                    <li class=""><a data-target="#kirova-room-tab1" data-toggle="tab" role="tab">{$elem->getPropertyIterator()->getGroupName(1)}</a></li>
        
        </ul>
        <form method="POST" action="{urlmake}" enctype="multipart/form-data" class="tab-content crud-form">
            <input type="submit" value="" style="display:none"/>
                        <div class="tab-pane active" id="kirova-room-tab0" role="tabpanel">
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                                            <table class="otable">
                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__number->getTitle()}&nbsp;&nbsp;{if $elem.__number->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__number->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__number->getRenderTemplate() field=$elem.__number}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__number_scheme->getTitle()}&nbsp;&nbsp;{if $elem.__number_scheme->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__number_scheme->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__number_scheme->getRenderTemplate() field=$elem.__number_scheme}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__square->getTitle()}&nbsp;&nbsp;{if $elem.__square->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__square->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__square->getRenderTemplate() field=$elem.__square}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__floor->getTitle()}&nbsp;&nbsp;{if $elem.__floor->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__floor->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__floor->getRenderTemplate() field=$elem.__floor}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__free->getTitle()}&nbsp;&nbsp;{if $elem.__free->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__free->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__free->getRenderTemplate() field=$elem.__free}</td>
                                </tr>
                                
                                                                                                                            
                                <tr>
                                    <td class="otitle">{$elem.__need_repair->getTitle()}&nbsp;&nbsp;{if $elem.__need_repair->getHint() != ''}<a class="help-icon" data-placement="right" title="{$elem.__need_repair->getHint()|escape}">?</a>{/if}
                                    </td>
                                    <td>{include file=$elem.__need_repair->getRenderTemplate() field=$elem.__need_repair}</td>
                                </tr>
                                
                                                            
                        </table>
                                                </div>
                        <div class="tab-pane" id="kirova-room-tab1" role="tabpanel">
                                                                                                            {include file=$elem.___photo_->getRenderTemplate() field=$elem.___photo_}
                                                                                                
                                                </div>
            
        </form>
    </div>
    </div>