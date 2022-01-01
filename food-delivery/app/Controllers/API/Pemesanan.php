<?php

namespace App\Controllers\API;

use CodeIgniter\RESTful\ResourceController;
use App\Models\PemesananModel;

class Pemesanan extends ResourceController
{
    protected $pemesanan;

    public function __construct()
    {
        helper('template');
        $this->pemesanan = new PemesananModel();
    }

    public function index()
    {
        $data = [
            'tgl_pesan'     => date('Y-m-d H: i: s'),
            'total_bayar'   => $this->request->getVar('total_bayar'),
            'alamat_kirim'  => $this->request->getVar('alamat_kirim'),
            'latitude'      => $this->request->getVar('latitude'),
            'longitude'     => $this->request->getVar('longitude'),
            'id_pelanggan'  => $this->request->getVar('id_pelanggan'),
            'note'          => $this->request->getVar('note'),
            'payment'       => $this->request->getVar('payment'),
            'ongkir'        => $this->request->getVar('ongkir'),
            'status'        => '1',
        ];

        $result = $this->pemesanan->kirimPesanan($data);

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Pesanan berhasil dikirim.',
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Pesanan gagal dikirim !',
            ], 400);
        }
    }

    public function getTotalBayar()
    {
        $result = $this->pemesanan->getTotalBayar(
            $this->request->getVar('id_pelanggan')
        );

        if ($result) {
            return $this->respond([
                'status'    => true,
                'message'   => 'Data ditemukan.',
                'data'      => [
                    'totalBayar'    => $result,
                    'totalOngkir'   => 0.05 * $result,
                ]
            ], 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Data tidak ditemukan !',
            ], 400);
        }
    }

    public function getTransaksi()
    {
        $result = $this->pemesanan->getTransaksi($this->request->getVar('id_pelanggan'));

        if ($result) {
            return $this->respond($result, 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Data tidak ditemukan !',
            ], 400);
        }
    }

    public function getItemTransaksi()
    {
        $result = $this->pemesanan->getItemTransaksi(
            $this->request->getVar('kd_pemesanan'),
            $this->request->getVar('id_pelanggan'),
        );

        if ($result) {
            return $this->respond($result, 200);
        } else {
            return $this->respond([
                'status'    => false,
                'message'   => 'Data tidak ada !',
            ], 400);
        }
    }
}
