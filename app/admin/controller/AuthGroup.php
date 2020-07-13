<?php
namespace app\admin\controller;

use think\Request;
use app\common\controller\AdminBase;
use app\models\AuthGroup as AuthGroupModel;
use app\models\AuthGroupAccess;
use app\models\AuthRule;
use think\exception\ValidateException;

/**
 * Class AuthGroup
 * @package app\admin\controller
 */
class AuthGroup extends AdminBase
{
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
     * Model Auth_rule_model
     * @var model object
     */
    protected $auth_rule_model;

    /**
     * 初始化
     */
    public function __construct()
    {
        parent::initialize();
        $this->auth_rule_model = new AuthRule();
        $this->auth_group_model = new AuthGroupModel();
        $this->auth_group_access_model = new AuthGroupAccess();
    }

    /**
     * 首页
     * @return mixed
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 表单数据
     */
    public function data()
    {
        $param = input('param.');
        $list = $this->auth_group_model->paginate($param['limit']);

        foreach ($list as $k => $v) {
            $v->status = $v->status ? '启用' : '未启用';
            $list[$k] = $v;
        }

        return layui_show(0, '请求成功', $list->total(), $list->toArray()['data']);
    }

    /**
     * 添加
     * @return mixed
     */
    public function add()
    {
        return $this->fetch();
    }

    /**
     * 保存
     */
    public function save(Request $request)
    {
        if (!$request->isPost()) {
            return ret_json(0, '请求错误');
        }

        $data = $request->param();

        try {
            $this->validate($data, 'app\admin\validate\AuthGroup');
        } catch (ValidateException $e) {
            // 验证失败 输出错误信息
            return layui_show(0, $e->getError());
        }

        $result = $this->auth_group_model->save(array_merge($data,['rules' => '']));
        if ($result)
            return layui_show(1, '保存成功');
        else
            return layui_show(0, '保存失败');
    }

    /**
     * 更新
     */
    public function update(Request $request)
    {
        if (!$request->isPost()) {
            return ret_json(0, '请求错误');
        }

        $data = $request->param();
        try {
            $this->validate($data, 'app\admin\validate\AuthGroup');
        } catch (ValidateException $e) {
            // 验证失败 输出错误信息
            return layui_show(0, $e->getError());
        }

        $authGroup = $this->auth_group_model->find(intval($data['id']));
        if (empty($authGroup)) {
            $this->error('id非法');
        }

        $authGroup->id          = $data['id'];
        $authGroup->title       = $data['title'];
        $authGroup->status   = $data['status'];

        if (!$authGroup->save())
            return layui_show(0, '更新失败');
        else
            return layui_show(1, '更新成功');
    }

    /**
     * 编辑
     * @param string $id
     * @return mixed
     */
    public function edit($id)
    {
        $result = $this->auth_group_model->where('id',intval($id))->find();

        $this->assign('auth_group',$result);
        return  $this->fetch();
    }

    /**
     * 删除
     */
    public function destory(Request $request)
    {
        $param = $request->param();

        if (in_array(1, $param['ids'])) {
            return layui_show(1, '超级管理员权限不可删除');
        }

        $result = $this->auth_group_model->whereIn('id', $param['ids'])->delete();

        if (empty($result))
            return layui_show(1, '删除失败');
        else
            return layui_show(0, '删除成功');
    }

    /**
     * 权限
     * @return mixed|string
     */
    public function auth(Request $request)
    {
        $auth_group = $this->auth_group_model->where('id',intval($request->param('id')))->find();

        $this->assign('auth_group',$auth_group);
        return $this->fetch();
    }

    /**
     * 获取权限数据
     * @return \think\response\Json
     */
    public function getAuthData()
    {
        $list = $this->auth_rule_model->field('id,title as name,pid')->select();
        $list = array2level($list->toArray());

        foreach ($list as $k => $v) {
            unset($v['open'],$v['level']);
            $list[$k] = $v;
        }

        return json([
            'code' => 0,
            'msg' => '获取成功',
            'data' => [
                'list' => $list
            ]
        ]);
    }

    /**
     * 权限保存
     * @param Request $request
     * @return \think\response\Json
     */
    public function authSave(Request $request)
    {
        if (!$request->isPost() || !$request->isPost()) {
            return ret_json(0, '请求错误');
        }

        $id            = $request->param('id');
        $auth_ids = $request->param('auth_ids');

        $auth_group = $this->auth_group_model->find($id);
        $auth_group->rules = $auth_ids ? implode(',',$auth_ids) : '';

        $result = $auth_group->save();
        if (!$result)
            return layui_show(0, '更新失败');
        else
            return layui_show(1, '更新成功');
    }
}