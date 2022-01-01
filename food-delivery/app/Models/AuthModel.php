<?php

namespace App\Models;

use CodeIgniter\Model;

class AuthModel extends Model
{
    protected $table = 'pelanggan';
    protected $useTimestamps = true;
    protected $beforeInsert = ['hashPassword'];
    protected $beforeUpdate = ['hashPassword'];
    protected $allowedFields = [
        'nama',
        'no_telp',
        'email',
        'password',
        'status',
    ];

    protected function hashPassword(array $data)
    {
        if (!isset($data['data']['password'])) {
            return $data;
        }

        $options = ['cost' => 10];
        $data['data']['password'] = password_hash($data['data']['password'], PASSWORD_DEFAULT, $options);

        return $data;
    }

    public function getValidateEmail($email)
    {
        $result = $this->where('email', $email)
            ->limit(1)
            ->first();

        if ($result) {
            return $result['id'];
        }

        return FALSE;
    }

    public function login($data)
    {
        $result = $this->where('email', $data['email'])
            ->limit(1)
            ->first();

        if ($result) {
            if (password_verify($data['password'], $result['password'])) {
                return $result['id'];
            } else {
                return FALSE;
            }
        }

        return FALSE;
    }

    public function register($data)
    {
        $result = $this->insert($data);

        if ($result > 0) {
            $query = $this->find($result);

            return $query['id'];
        }

        return FALSE;
    }

    public function simpanPassword($data)
    {
        $result = $this->save($data);

        if ($result) {
            return TRUE;
        }

        return FALSE;
    }
}
