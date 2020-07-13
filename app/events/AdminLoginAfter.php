<?php
namespace app\events;

use app\models\UserModel as User;

/**
 * Class AdminLoginAfter
 * @package app\event
 */
class AdminLoginAfter
{
    public $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }
}