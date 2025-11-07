<input
    name="renter"
    type="text"
    class="styled autocomplete renter-autocomplete"
    id="renters"
    placeholder="Организация"
    data-action="{$router->getUrl('kirova-front-renters', ['Act' => 'getAll'])}"
    data-option="{$option}"
    data-getcontracts="{$router->getUrl('kirova-front-renters', ['Act' => 'getContractsByShortTitle'])}"
>
<label for="">Организация</label>
