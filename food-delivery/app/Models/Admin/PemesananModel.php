<?php

namespace App\Models\Admin;

use CodeIgniter\Model;

class PemesananModel extends Model
{
    protected $table = 'pemesanan';
    protected $primaryKey = 'kd_pemesanan';
    protected $allowedFields = ['status', 'noteCancel'];

    public function ajaxGetData($length, $start)
    {
        $result = $this->join('pelanggan', 'pelanggan.id = pemesanan.id_pelanggan')
            ->orderBy('kd_pemesanan', 'desc')
            ->findAll($length, $start);

        return $result;
    }

    public function ajaxGetDataSearch($search, $length, $start)
    {
        $result = $this->like('kd_pemesanan', $search)
            ->orderBy('kd_pemesanan', 'desc')
            ->findAll($length, $start);

        return $result;
    }

    public function ajaxGetTotal()
    {
        $result = $this->countAll();

        if (isset($result)) {
            return $result;
        }

        return 0;
    }

    public function ajaxGetTotalSearch($search)
    {
        $result = $this->like('kd_pemesanan', $search)
            ->countAllResult();

        return $result;
    }

    public function getDetailPesanan($kd_pemesanan)
    {
        $result = $this->db->table('log_pemesanan')
            ->where('kd_pemesanan', $kd_pemesanan)
            ->get();

        return $result;
    }

    public function getDataPesanan($kd_pemesanan)
    {
        $result = $this->where('kd_pemesanan', $kd_pemesanan)
            ->limit(1)
            ->first();

        return $result;
    }
}
