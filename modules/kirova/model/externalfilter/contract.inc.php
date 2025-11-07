<?php

namespace Kirova\Model\ExternalFilter;

class Contract extends \RS\Html\Filter\Type\AbstractType
{

	public $tpl = 'system/admin/html_elements/filter/type/string.tpl';

	protected $search_type = 'eq';

	/**
	 * Подключение внешней таблицы
	 * @param \RS\Orm\Request $q Исходный запрос
	 * @return \RS\Orm\Request Модифицированный запрос
	 */
	function modificateQuery(\RS\Orm\Request $q)
	{
		if(!empty($this->value) && !$q->issetTable(new \Kirova\Model\Orm\Renter())){
			$q->select = 'A.*';
			$q->join(new \Kirova\Model\Orm\Renter(), 'A.renter = RENTER.id', 'RENTER');
			$q->groupby('A.id');
		}

		$sql = $q->toSql();

		return $q;
	}
}