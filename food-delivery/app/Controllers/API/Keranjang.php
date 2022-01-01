<?php

namespace App\Controllers\API;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\I18n\Time;
use App\Models\KeranjangModel;

class Keranjang extends ResourceController
{
    protected $keranjang;

    public function __construct()
    {
        $this->keranjang = new KeranjangModel();
    }

    public function index()
    {
        $id_pelanggan = $this->request->getVar('id_pelanggan');
        $result = $this->keranjang->getKeranjang($id_pelanggan);

        if ($result) {
            return $this->respond($result, 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Gagal menampilkan produk!',
            ], 400);
        }
    }


    public function tambahKeranjang()
    {
        // Sesuaikan dengan zona anda
        $expired = Time::now('Asia/Kuala_lumpur', 'id_ID')->addHours(3);

        $data = [
            'nama_produk'   => $this->request->getVar('nama_produk'),
            'harga'         => $this->request->getVar('harga'),
            'qty'           => $this->request->getVar('qty'),
            'gambar'        => $this->request->getVar('gambar'),
            'expired'       => $expired->getTimestamp(),
            'id_pelanggan'  => $this->request->getVar('id_pelanggan'),
        ];

        $result = $this->keranjang->tambahKeranjang($data);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Ditambahkan ke keranjang.',
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Gagal tambah produk!',
            ], 400);
        }
    }

    public function ubahQtyKeranjang()
    {
        $data = [
            'id'    => $this->request->getVar('id'),
            'qty'   => $this->request->getVar('qty'),
        ];

        $result = $this->keranjang->ubahQtyKeranjang($data);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Qty berhasil diubah.',
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Gagal tambah produk!',
            ], 400);
        }
    }

    public function hapusItemKeranjang()
    {
        $id = $this->request->getVar('id');
        $result = $this->keranjang->hapusItemKeranjang($id);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Item berhasil dihapus',
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Gagal tambah produk!',
            ], 400);
        }
    }

    public function getTotalItem()
    {
        $id_pelanggan = $this->request->getVar('id_pelanggan');

        $result = $this->keranjang->getTotalItem($id_pelanggan);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Berhasil menampilan data item.',
                'data'      => [
                    'totalItem' => $result,
                ],
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Gagal tambah produk!',
            ], 400);
        }
    }
}
