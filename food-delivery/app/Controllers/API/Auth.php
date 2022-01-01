<?php

namespace App\Controllers\API;

use CodeIgniter\RESTful\ResourceController;
use App\Models\AuthModel;

class Auth extends ResourceController
{
    protected $auth;

    public function __construct()
    {
        $this->auth = new AuthModel();
    }

    public function getValidateEmail()
    {
        $result = $this->auth->getValidateEmail(
            $this->request->getVar('email')
        );

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Email terdaftar.',
                'data'      => [
                    'id' => $result,
                ]
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Email belum terdaftar !',
            ], 400);
        }
    }

    public function login()
    {
        $data = [
            'email'     => $this->request->getVar('email'),
            'password'  => $this->request->getVar('password'),
        ];

        $result = $this->auth->login($data);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Login berhasil.',
                'data'      => [
                    'id' => $result,
                ]
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Data tidak ditemukan !',
            ], 400);
        }
    }

    public function register()
    {
        $data = [
            'nama'      => $this->request->getVar('nama'),
            'no_telp'   => $this->request->getVar('no_telp'),
            'email'     => $this->request->getVar('email'),
            'password'  => $this->request->getVar('password'),
            'status'    => '1',
        ];

        $result = $this->auth->register($data);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Registrasi berhasil.',
                'data'      => [
                    'id' => $result,
                ]
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Data tidak ditemukan !',
            ], 400);
        }
    }

    public function simpanPassword()
    {
        $data = [
            'id'        => $this->request->getVar('id'),
            'password'  => $this->request->getVar('password'),
        ];

        $result = $this->auth->simpanPassword($data);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Berhasil mengubah password.',
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Gagal mengubah password!',
            ], 400);
        }
    }
}
