<?php

namespace App\Models;

use CodeIgniter\Model;

class KeranjangModel extends Model
{
    protected $table = 'keranjang';
    protected $useTimestamps = true;
    protected $allowedFields = [
        'nama_produk',
        'harga',
        'qty',
        'gambar',
        'total',
        'expired',
        'id_pelanggan',
    ];

    public function getKeranjang($id_pelanggan)
    {
        $result = $this->where('id_pelanggan', $id_pelanggan)
            ->findAll();

        if ($result) {
            return $result;
        }

        return FALSE;
    }

    public function tambahKeranjang($data)
    {
        $keranjang = $this->where('id_pelanggan', $data['id_pelanggan'])
            ->where('nama_produk', $data['nama_produk'])
            ->limit(1)
            ->first();

        if ($keranjang) {
            $data['qty'] = $data['qty'] + $keranjang['qty'];
            $data['total'] = $data['harga'] * $data['qty'];

            $result = $this->update($keranjang['id'], $data);
        } else {
            $data['total'] = $data['harga'] * $data['qty'];

            $result = $this->save($data);
        }

        return $result;
    }

    public function ubahQtyKeranjang($data)
    {
        $keranjang = $this->where('id', $data['id'])
            ->limit(1)
            ->first();

        if ($keranjang) {
            $data['total'] = $keranjang['harga'] * $data['qty'];

            $result = $this->update($keranjang['id'], $data);

            if ($result) {
                return TRUE;
            }

            return FALSE;
        }

        return FALSE;
    }

    public function hapusItemKeranjang($id)
    {
        $result = $this->delete($id);

        if ($result) {
            return TRUE;
        }

        return FALSE;
    }

    public function getTotalItem($id_pelanggan)
    {
        $result = $this->where('id_pelanggan', $id_pelanggan)
            ->findAll();

        if ($result) {
            return count($result);
        }

        return FALSE;
    }
}
