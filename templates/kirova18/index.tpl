{extends file="%THEME%/wrapper.tpl"}
{addcss file="auth.css"}
{$user = \RS\Application\Auth::getCurrentUser()}
{block name="content"}
    {if $user['is_admin']}
        {moduleinsert name="\Kirova\Controller\Block\Reestr" indexTemplate = "%kirova%/reestr.tpl"}
    {else}
        {moduleinsert name="\Kirova\Controller\Block\Renter" indexTemplate = '%kirova%/blocks/renter.tpl'}
    {/if}
{/block}
