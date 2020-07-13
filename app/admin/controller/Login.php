<?php

namespace app\admin\controller;

use app\common\controller\AdminBase;
use app\models\AdminUser;
use think\facade\Session;
use think\facade\Route as Url;
use think\exception\ValidateException;

/**
 * 登录验证控制器
 * Class Login
 * @package app\admin\controller
 */
class Login extends AdminBase
{
    /**
     * Login constructor.
     */
    public function __construct()
    {
        
    }
    
    /**
     * 主页
     * @return string
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 验证码
     * @return mixed|\think\Response
     */
    public function captcha()
    {
        ob_clean();
        return captcha();
    }

    /**
     * 登录校验
     * @return \think\response\Json
     */
    public function verify()
    {
        if (!request()->isPost()) {
            return ret_json(0, '错误请求');
        }

        $post = input('post.');

        // 参数校验
        try {
            $this->validate($post, 'app\admin\validate\Login');
        } catch (ValidateException $validateException) {
            return ret_json(0, $validateException->getMessage());
        }

        //检验验证码
        if (!captcha_check($post['verify'])) {
            return ret_json(0, '验证码错误，请重新输入');
        }

        $error = Session::get('login_error') ?: ['num' => 0, 'time' => time()];
        if ($error['num'] >= 5 && $error['time'] > strtotime('- 5 minutes')) {
            return ret_json(0, '错误次数过多,请稍候再试!');
        }

        //检验帐号密码
        $res = AdminUser::login($post['username'], $post['password']);
        if ($res) {
            Session::set('login_error', null);
            Session::save();
            return ret_json(1, '登录成功', [Url::buildUrl('Index/index')->build()]);
        } else {
            $error['num'] += 1;
            $error['time'] = time();
            Session::set('login_error', $error);
            Session::save();
            return ret_json(0, AdminUser::getErrorInfo('用户名错误，请重新输入'));
        }
    }

    /**
     * 退出登录
     */
    public function logout()
    {
        AdminUser::clearLoginInfo();
        $this->success('退出成功', 'admin/login/index');
    }
}