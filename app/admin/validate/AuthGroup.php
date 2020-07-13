<?php
namespace app\admin\validate;

use think\Validate;

/**
 * 权限组验证器
 * Class AuthGroup
 * @package app\admin\validate
 * @author zz
 */
class AuthGroup extends Validate
{
    protected $rule = [
        'title'               => 'require',
        'status'           => 'require'
    ];

    protected $message = [];
}