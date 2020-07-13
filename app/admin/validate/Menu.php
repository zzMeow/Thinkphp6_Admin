<?php

namespace app\admin\validate;

use think\Validate;

/**
 * Class Menu
 * @package app\admin\validate
 */
class Menu extends Validate
{
    /**
     * 验证规则
     * @var array
     */
    protected $rule = [
        'name' => 'require',
        'title' => 'require'
    ];

    /**
     * 验证消息
     * @var array
     */
    protected $message = [

    ];
}