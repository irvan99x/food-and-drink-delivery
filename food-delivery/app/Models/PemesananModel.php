<?php

namespace App\Models;

use CodeIgniter\Model;

class PemesananModel extends Model
{
    protected $table = 'pemesanan';
    protected $allowedFields = [
        'kd_pemesanan',
        'tgl_pesan',
        'total_bayar',
        'alamat_kirim',
        'latitude',
        'longitude',
        'id_pelanggan',
        'status',
        'note',
        'payment',
        'ongkir',
    ];

    public function getTotalBayar($id_pelanggan)
    {
        $result = $this->db->table('keranjang')->where('id_pelanggan', $id_pelanggan)->get();

        if ($result) {
            $totalBayar = 0;
            foreach ($result->getResultArray() as $row) {
                $totalBayar += $row['total'];
            }

            return $totalBayar;
        }

        return FALSE;
    }

    public function kirimPesanan($data)
    {
        $result = $this->insert($data);

        if ($result > 0) {
            $keranjang = $this->db->table('keranjang')->where('id_pelanggan', $data['id_pelanggan'])->get();

            $dataLog = [];
            foreach ($keranjang->getResultArray() as $row) {
                $dataLog[] = [
                    'nama_produk'   => $row['nama_produk'],
                    'harga'         => $row['harga'],
                    'qty'           => $row['qty'],
                    'total'         => $row['total'],
                    'kd_pemesanan'  => $result,
                    'id_pelanggan'  => $row['id_pelanggan'],
                    'created_at'    => date('Y-m-d H:i:s'),
                    'updated_at'    => date('Y-m-d H:i:s'),
                ];
            }

            if ($this->db->table('log_pemesanan')->insertBatch($dataLog)) {
                $this->db->table('keranjang')->where('id_pelanggan', $data['id_pelanggan'])->delete();
            }

            return TRUE;
        }

        return FALSE;
    }

    public function getTransaksi($id_pelanggan)
    {
        $result = $this->where('id_pelanggan', $id_pelanggan)->orderBy('kd_pemesanan', 'desc')->findAll();

        if ($result) {
            $data = [];

            foreach ($result as $row) {
                $data[] = [
                    'kd_pemesanan'  => $row['kd_pemesanan'],
                    'tgl_pesan'     => formatTgl($row['tgl_pesan'], 1),
                    'total_bayar'   => $row['total_bayar'],
                    'alamat_kirim'  => $row['alamat_kirim'],
                    'status'        => $row['status'],
                    'noteCancel'    => $row['noteCancel'],
                    'note'          => $row['note'],
                    'payment'       => $row['payment'],
                    'ongkir'        => $row['ongkir'],
                    'id_pelanggan'  => $row['id_pelanggan'],
                ];
            }

            return $data;
        }

        return FALSE;
    }

    public function getItemTransaksi($kd_pemesanan, $id_pelanggan,)
    {
        $result = $this->db->table('log_pemesanan')->where('kd_pemesanan', $kd_pemesanan)
            ->where('id_pelanggan', $id_pelanggan)
            ->get();

        if ($result) {
            $data = [];
            foreach ($result->getResultArray() as $row) {
                $data[] = $row;
            }

            return $data;
        }

        return FALSE;
    }
}
