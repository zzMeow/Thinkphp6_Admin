<?php

namespace app\admin\controller;

use think\Request;
use app\common\controller\AdminBase;
use think\exception\ValidateException;
use app\models\AuthRule;
use app\models\Icons;

/**
 * 菜单管理
 * Class Menu
 * @package app\admin\controller
 */
class Menu extends AdminBase
{
    /**
     * Auth Rule Model
     * @var Object
     */
    protected $auth_rule_model;

    /**
     *Icons Model
     * @var Object
     */
    protected $icons_model;

    /**
     * Menu constructor.
     */
    public function __construct()
    {
        parent::initialize();
        $this->auth_rule_model = new AuthRule();
        $this->icons_model = new Icons();
    }

    /**
     * 主页
     * @return mixed|string
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * Layui Table Data
     */
    public function data()
    {
        $list = $this->auth_rule_model->field('id,pid,name,title,sort,status')->order(['sort' => 'DESC', 'id' => 'ASC'])->select();
        $list = array2level($list->toArray());

        foreach ($list as $k => $v) {
            unset($v['level']);
            $list[$k] = $v;
        }

        return layui_show(0, '请求成功', count($list), $list);
    }

    /**
     * 添加菜单
     * @return mixed|string
     */
    public function add(Request $request)
    {
        $this->assign('checkNode',$request->param('id') ?: 0);
        return $this->fetch();
    }

    /**
     * Tree Select Data
     */
    public function getTreeSelect()
    {
        $list = $this->auth_rule_model
            ->field('id,pid,title as name')
            ->order(['sort' => 'DESC', 'id' => 'ASC'])
            ->select();
        $list = treeSelect($list->toArray());

        // 默认菜单
        array_unshift($list, [
            'id' => 0,
            'name' => '一级菜单',
            'open' => false,
            'checked' => true
        ]);

        return json($list);
    }

    /**
     * 所有icon图标
     */
    public function icons()
    {
        $data = $this->icons_model->order('sort desc')->select();
        return json(['code' => 0, 'msg' => '请求成功', 'data' => $data]);
    }

    /**
     * 保存
     * @param Request $request
     */
    public function save(Request $request)
    {
        if (!$request->isPost() || !$request->isAjax()) {
            return layui_show(0,'请求非法');
        }

        $data = $request->param();

        try {
            $this->validate($data, 'app\admin\validate\Menu');
        } catch (ValidateException $e) {
            // 验证失败 输出错误信息
            return layui_show(0, $e->getError());
        }

        $result = $this->auth_rule_model->save($data);
        if (!$result)
            return layui_show(0, '保存失败');
        else
            return layui_show(1, '保存成功');
    }

    /**
     * 菜单修改
     * @param Request $request
     * @param int id
     */
    public function edit(Request $request)
    {
        $id = $request->param();
        $menu = $this->auth_rule_model->find($id);

        $this->assign('menu',$menu);
        return $this->fetch();
    }

    /**
     * 修改
     * @param Request $request
     */
    public function update(Request $request)
    {
        $data = $request->param();

        try {
            $this->validate($data, 'app\admin\validate\Menu');
        } catch (ValidateException $e) {
            // 验证失败 输出错误信息
            return layui_show(0, $e->getError());
        }

        $menu = $this->auth_rule_model->find($data['id']);

        $menu->name = $data['name'];
        $menu->title = $data['title'];
        $menu->sort = $data['sort'];
        $menu->pid = $data['pid'];
        $menu->icon = $data['icon'];
        $menu->status = $data['status'];

        if ($menu->save() !== false)
            return layui_show(1, '更新成功');
        else
            return layui_show(0, '更新失败');
    }

    /**
     * 菜单删除
     * @param Request $request
     * @return \think\response\Json
     */
    public function destory(Request $request)
    {
        $id = $request->param();
        $sub_menu = $this->auth_rule_model->where(['pid' => $id])->find();
        if (!empty($sub_menu)) {
            return layui_show(0 ,'此菜单下存在子菜单，不可删除');
        }

        if ($this->auth_rule_model->destroy($id))
            return layui_show(1, '删除成功');
        else
            return layui_show(0, '删除失败');
    }
}