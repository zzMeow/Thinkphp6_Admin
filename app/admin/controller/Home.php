<?php

namespace app\admin\controller;

use think\facade\View;

/**
 * Class Home
 * @package app\admin\controller
 */
class Home
{
    public function index()
    {
        return View::fetch();
    }
}