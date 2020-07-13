<?php
namespace app\models;

use app\models\BaseModel;
use think\facade\Session;

/**
 * Class AdminUser
 * @package app\models
 */
class AdminUser extends BaseModel
{
    /**
     * 数据表主键
     * @var string
     */
    protected $pk = 'id';

    /**
     * 模型名称
     * @var string
     */
    protected $name = 'admin_user';

    /**
     * 用户登陆
     * @param $account
     * @param $pwd
     * @return bool
     */
    public static function login($username, $pwd)
    {
        $adminInfo = self::where(compact('username'))->find();
        if (!$adminInfo) return self::setErrorInfo('登陆的账号不存在!');
        if ($adminInfo['password'] != md5($pwd)) return self::setErrorInfo('账号或密码错误，请重新输入');
        if (!$adminInfo['status']) return self::setErrorInfo('该账号已被关闭!');
        self::setLoginInfo($adminInfo);
        event('AdminLoginAfter', [$adminInfo]);
        return true;
    }

    /**
     *  保存当前登陆用户信息
     */
    public static function setLoginInfo($adminInfo)
    {
        Session::set('admin_id', $adminInfo['id']);
        Session::set('admin_name', $adminInfo['username']);
        Session::set('adminInfo', $adminInfo->toArray());
        Session::save();
    }

    /**
     * 清空当前登陆用户信息
     */
    public static function clearLoginInfo()
    {
        Session::delete('admin_id');
        Session::delete('admin_name');
        Session::delete('adminInfo');
        Session::save();
    }
}