<?php
namespace app\models;

use app\models\BaseModel;

/**
 * Class AuthGroup
 * @package app\models
 */
class AuthGroup extends BaseModel
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
    protected $name = 'auth_group';
}