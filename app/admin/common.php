<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
if (!function_exists('ret_json')) {

    /**
     * json化
     * @param integer $code
     * @param string $message
     * @param array $data
     * @param int $httpCode
     * @return \think\response\Json
     */
    function ret_json($code, $message, $data = [], $httpCode = 200)
    {
        $data = [
            'code' => $code,
            'message' => $message,
            'data' => $data
        ];
        return json($data, $httpCode);
    }
}

if (!function_exists('layui_show')) {
    /**
     * layui dataTable 数据返回格式
     * @param integer 0:成功 1:失败
     * @param string $msg 返回消息
     * @param integer $count
     * @param array $data
     * @return \think\response\Json
     */
    function layui_show($code = 0, $msg = '请求成功', $count = 0, $data = [])
    {
        $data = [
            'code' => $code,
            'msg' => $msg,
            'count' => $count,
            'data' => $data
        ];
        return json($data);
    }
}

if (!function_exists('array2level')) {
    /**
     * 数组层级缩进转换
     * @param array $array 源数组
     * @param int $pid
     * @param int $level
     * @return array
     */
    function array2level($array, $pid = 0, $level = 1)
    {
        static $list = [];
        foreach ($array as $v) {
            if ($v['pid'] == $pid) {
                $v['level'] = $level;
                $v['open'] = true;
                $list[] = $v;
                array2level($array, $v['id'], $level + 1);
            }
        }

        return $list;
    }
}

if (!function_exists('treeSelect')) {
    /**
     * 下拉选择树
     * @param array $array 源数组
     * @param int $pid
     * @param int $level
     * @return array
     */
    function treeSelect($array, $pid = 0)
    {
        $list = [];
        $child = [];
        foreach ($array as $v) {
            if ($v['pid'] == $pid) {

                $v['open'] = true;
                $v['checked'] = false;
                unset($v['pid']);

                $list[$v['id']] = $v;
                $child = treeSelect($array, $v['id']);

                if ($child) {
                    $list[$v['id']]['children'] = $child;
                } else {
                    $list[$v['id']]['open'] = false;
                }
            }
        }

        return array_column($list, null);
    }
}

