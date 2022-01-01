<?php

namespace App\Controllers\API;

use CodeIgniter\RESTful\ResourceController;
use App\Models\ProdukModel;

class Produk extends ResourceController
{
    protected $produk;

    public function __construct()
    {
        $this->produk = new ProdukModel();
    }

    public function index()
    {
        $kategori = $this->request->getVar('kategori');
        $result = $this->produk->getProduk($kategori);

        if ($result) {
            return $this->respond($result, 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Data tidak ditemukan !',
            ], 400);
        }
    }
}
