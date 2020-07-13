<?php

namespace app\admin\controller;

use app\common\controller\AdminBase;
use app\models\AdminUser as AdminUserModel;
use app\models\AuthGroup;
use app\models\AuthGroupAccess;
use think\Request;
use think\exception\ValidateException;

/**
 * Class AdminUser
 * @package app\admin\controller
 */
class AdminUser extends AdminBase
{
    /**
     * Model AdminUser
     * @var model object
     */
    protected $admin_user_model;

    /**
     * Model AuthGroup
     * @var model object
     */
    protected $auth_group_model;

    /**
     * Model AuthGroup
     * @var model object
     */
    protected $auth_group_access_model;

    /**
     * 初始化
     */
    public function __construct()
    {
        parent::initialize();
        $this->admin_user_model = new AdminUserModel();
        $this->auth_group_model = new AuthGroup();
        $this->auth_group_access_model = new AuthGroupAccess();
    }

    /**
     * 管理员页面
     * @return mixed
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 管理员数据获取
     */
    public function data()
    {
        $param = input('param.');
        $list = $this->admin_user_model->paginate($param['limit']);

        foreach ($list as $k => $v) {
            $v->status = $v->status ? '启用' : '未启用';
            $list[$k] = $v;
        }

        $list = $list->toArray();
        return layui_show(0, '请求成功', $list['total'], $list['data']);
    }

    /**
     * 添加
     */
    public function add()
    {
        $auth_group = $this->auth_group_model->field('id,title')->where('status',1)->select();
        $this->assign('auth_group',$auth_group);
        return $this->fetch();
    }

    /**
     * 保存
     */
    public function save(Request $request)
    {
        if (!$request->isPost() || !$request->isAjax()) {
            return ret_json(0, '请求错误');
        }

        $data = $request->param();

        try {
            $this->validate($data, 'app\admin\validate\AdminUser');
        } catch (ValidateException $e) {
            // 验证失败 输出错误信息
            return layui_show(0, $e->getError());
        }

        $data['password'] = md5($data['password']);
        $result = $this->admin_user_model->save($data);

        if ($result) {
            $auth_group_access['uid'] = $this->admin_user_model->id;
            $auth_group_access['group_id'] = $data['group_id'];
            $this->auth_group_access_model->save($auth_group_access);
            return layui_show(1, '保存成功');
        } else {
            return layui_show(0, '保存失败');
        }
    }

    /**
     * 编辑
     * @param string $id
     */
    public function edit($id)
    {
        $admin_user = $this->admin_user_model->find($id);
        $auth_group = $this->auth_group_model->field('id,title')->where('status', 1)->select();
        $auth_group_access = $this->auth_group_access_model->where('uid', $id)->find();

        $this->assign('admin_user', $admin_user);
        $this->assign('auth_group', $auth_group);
        $this->assign('auth_group_access', $auth_group_access);

        return $this->fetch();
    }

    /**
     * 更新
     */
    public function update(Request $request)
    {
        if (!$request->isPost()) {
            return layui_show(0, '请求错误');
        }

        $data = $request->param();
        try {
            $this->validate($data, 'app\admin\validate\AdminUser');
        } catch (ValidateException $e) {
            // 验证失败 输出错误信息
            return layui_show(0, $e->getError());
        }

        $admin_user = $this->admin_user_model->find($data['id']);

        $admin_user->id = $data['id'];
        $admin_user->username = $data['username'];
        $admin_user->status = $data['status'];

        if (!empty($data['password']) && !empty($data['confirm_password'])) {
            $admin_user->password = md5($data['password']);
        }

        if ($admin_user->save() !== false) {
            $auth_group_access['uid'] = $data['id'];
            $auth_group_access['group_id'] = $data['group_id'];
            $this->auth_group_access_model->where('uid', $data['id'])->update($auth_group_access);
            return layui_show(1, '更新成功');
        } else {
            return layui_show(0, '更新失败');
        }
    }

    /**
     * 批量删除
     * @param $uids
     */
    public function destory(Request $request)
    {
        $param = $request->param();

        if (in_array(1, $param['ids'])) {
            return layui_show(1, '默认管理员不可删除');
        }

        $result = $this->admin_user_model->whereIn('id', $param['ids'])->delete();

        if (empty($result)) {
            return layui_show(1, '删除失败');
        } else {
            // 删除权限关联
            $this->auth_group_access_model->whereIn('uid', $param['ids'])->delete();
            return layui_show(0, '删除成功');
        }
    }

    public function info()
    {
        return $this->fetch('user/base_info');
    }

    public function updatePwd()
    {
        return $this->fetch('user/update_password');
    }
}