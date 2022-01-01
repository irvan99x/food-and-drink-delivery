<?php

namespace App\Controllers;

class Dashboard extends BaseController
{
    protected $title;
    protected $halaman;

    public function __construct()
    {
        $this->title = 'Dashboard';
        $this->halaman = 'dashboard';
    }

    public function index()
    {
        $data = [
            'title' => $this->title,
            'halaman' => $this->halaman,
            'main' => 'dashboard/index'
        ];
        return view('layout/template', $data);
    }
}
