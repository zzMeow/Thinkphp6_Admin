<?php

namespace app\common\controller;

use think\facade\Db;
use think\facade\View;
use think\facade\Session;
use think\wenhainan\Auth;
use \liliuwei\think\Jump;
use think\exception\HttpResponseException;

/**
 * Class AdminBase
 * @package app\common\controller
 */
class AdminBase extends BaseController
{
    use Jump;

    /**
     * 初始化
     */
    protected function initialize()
    {
        parent::initialize();
        $this->checkAuth();
        $this->getMenu();
    }

    /**
     * 权限检查
     * @return bool
     */
    protected function checkAuth()
    {
        if (!Session::has('admin_id')) {
            $this->redirect('/admin/login/index');
        }

        $controller = request()->controller();
        $action      = request()->action();

        // 排除权限
        $not_check = ['admin/Index/index'];
        $request_route = "admin/{$controller}/{$action}";

        if (!in_array($request_route, $not_check)) {
            $auth = Auth::instance();
            $admin_id = Session::get('admin_id');

            if (!$auth->check($request_route, $admin_id) && $admin_id != 1) {
                $this->error('没有权限');
            }
        }
    }

    /**
     * 获取侧边栏菜单
     */
    protected function getMenu()
    {
        $menu     = [];
        $admin_id = Session::get('admin_id');
        $auth     = new Auth();

        $auth_rule_list = Db::name('auth_rule')->where('status', 1)->order(['sort' => 'DESC', 'id' => 'ASC'])->select();
        foreach ($auth_rule_list as $value) {
            if ($auth->check($value['name'], $admin_id) || $admin_id == 1) {
                $menu[] = $value;
            }
        }

        $menu = !empty($menu) ? treeSelect($menu) : [];
        $this->assign('menu', $menu);
    }

    /**
     * 模板赋值
     * @param mixed ...$vars
     */
    protected function assign(...$vars)
    {
        View::assign(...$vars);
    }

    /**
     * 解析和获取模板内容
     * @param string $template
     * @return string
     * @throws \Exception
     */
    protected function fetch(string $template = '')
    {
        return View::fetch($template);
    }

    /**
     * 重定向
     * @param mixed ...$args
     */
    protected function redirect(...$args)
    {
        throw new HttpResponseException(redirect(...$args));
    }
}