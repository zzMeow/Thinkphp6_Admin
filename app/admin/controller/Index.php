<?php
namespace app\admin\controller;

use app\common\controller\AdminBase;

/**
 * Class Index
 * @package app\admin\controller
 */
class Index extends AdminBase
{
    public function index()
    {
        return $this->fetch();
    }
}