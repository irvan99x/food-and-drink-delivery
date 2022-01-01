<?php

function formatStatus($status)
{
    if ($status == '0') {
        $result = '
            <div class="text-center">
                <span class="label label-danger">Tidak Aktif</span>
            </div>            
        ';
    } else {
        $result = '
            <div class="text-center">
                <span class="label label-success">Aktif</span>
            </div>            
        ';
    }

    return $result;
}

function formatStatusProduk($status)
{
    if ($status == '0') {
        $result = '
            <div class="text-center">
                <span class="label label-danger">Tidak Tersedia</span>
            </div>            
        ';
    } else {
        $result = '
            <div class="text-center">
                <span class="label label-success">Tersedia</span>
            </div>            
        ';
    }

    return $result;
}

function formatStatusPesan($status)
{
    if ($status == '0') {
        $result = '
            <div class="text-center">
                <span class="label label-danger">Belum Diproses</span>
            </div>
        ';
    } else if ($status == '1') {
        $result = '
            <div class="text-center">
                <span class="label label-primary">Diproses</span>
            </div>
        ';
    } else if ($status == '2') {
        $result = '
            <div class="text-center">
                <span class="label label-primary">Dalam Pengiriman</span>
            </div>
        ';
    } else {
        $result = '
            <div class="text-center">
                <span class="label label-success">Selesai</span>
            </div>
        ';
    }

    return $result;
}

function formatTgl($waktu, $tipe)
{
    if ($tipe == 0) {
        $hari_array = array(
            'Minggu',
            'Senin',
            'Selasa',
            'Rabu',
            'Kamis',
            'Jumat',
            'Sabtu'
        );
        $hr = date('w', strtotime($waktu));
        $hari = $hari_array[$hr];

        $tanggal = date('j', strtotime($waktu));

        $bulan_array = array(
            1 => 'Januari',
            2 => 'Februari',
            3 => 'Maret',
            4 => 'April',
            5 => 'Mei',
            6 => 'Juni',
            7 => 'Juli',
            8 => 'Agustus',
            9 => 'September',
            10 => 'Oktober',
            11 => 'November',
            12 => 'Desember',
        );
        $bl = date('n', strtotime($waktu));
        $bulan = $bulan_array[$bl];

        $tahun = date('Y', strtotime($waktu));

        return "$hari, $tanggal $bulan $tahun";
    } else if ($tipe == 1) {
        $tanggal = date('j', strtotime($waktu));

        $bulan_array = array(
            1 => 'Januari',
            2 => 'Februari',
            3 => 'Maret',
            4 => 'April',
            5 => 'Mei',
            6 => 'Juni',
            7 => 'Juli',
            8 => 'Agustus',
            9 => 'September',
            10 => 'Oktober',
            11 => 'November',
            12 => 'Desember',
        );
        $bl = date('n', strtotime($waktu));
        $bulan = $bulan_array[$bl];

        $tahun = date('Y', strtotime($waktu));

        return "$tanggal $bulan $tahun";
    } else {
        $tanggal = date('j', strtotime($waktu));

        $bulan_array = array(
            1 => '01',
            2 => '02',
            3 => '03',
            4 => '04',
            5 => '05',
            6 => '06',
            7 => '07',
            8 => '08',
            9 => '09',
            10 => '10',
            11 => '11',
            12 => '12',
        );
        $bl = date('n', strtotime($waktu));
        $bulan = $bulan_array[$bl];

        $tahun = date('Y', strtotime($waktu));

        return "$tanggal/$bulan";
    }
}

function formatWaktu($waktu)
{
    $newDateTime = date('h:i A', strtotime($waktu));
    return "$newDateTime";
}

function formatRupiah($angka, $tipe)
{
    if ($tipe == 0) {
        $hasil = number_format($angka, 0, ',', '.');
    } else {
        $hasil =  'Rp. ' . number_format($angka, 0, ',', '.');
    }

    return $hasil;
}

function uploadImage($img)
{
    $img_name = $img->getRandomName();
    $img->move('uploads/img', $img_name);

    return $img_name;
}

function getDropdownList($table, $columns, $title)
{
    $db = \Config\Database::connect();
    $query = $db->table($table)->select($columns)->orderBy('nama_kategori', 'asc')->get();
    $count = $db->table($table)->select($columns)->countAllResults();

    if ($count >= 1) {
        $options1 = ['' => '- Pilih ' . $title . ' -'];
        $options2 = array_column($query->getResultArray(), $columns[1], $columns[0]);
        $options = $options1 + $options2;
        return $options;
    }

    return $options = ['' => '- Pilih -'];
}

function field_enums($table = '', $field = '', $title = '')
{
    $enums = array();
    if ($table == '' || $field == '') return $enums;
    $db = \Config\Database::connect();
    preg_match_all("/'(.*?)'/", $db->query("SHOW COLUMNS FROM {$table} LIKE '{$field}'")->getRow()->Type, $matches);

    $enums[''] = '- Pilih ' . $title . ' -';
    foreach ($matches[1] as $key => $value) {
        $enums[$value] = $value;
    }
    return $enums;
}

function _autonumber($field, $table, $Parse, $Digit_Count)
{
    $NOL = "0";
    $query = "Select " . $field . " from " . $table . " where " . $field . " like '" . $Parse . "%' order by " . $field . " DESC LIMIT 0,2";

    $db = \Config\Database::connect();
    $data = $db->query($query)->getResultArray();

    $counter = 2;
    if (sizeof($data) == 0) {
        while ($counter < $Digit_Count) {
            $NOL = "0" . $NOL;
            $counter++;
        }

        return $Parse . $NOL . "1";
    } else {
        $R = $data[0][$field];
        $K = sprintf("%d", substr($R, -$Digit_Count));
        $K = $K + 1;
        $L = $K;

        while (strlen($L) != $Digit_Count) {
            $L = $NOL . $L;
        }

        return $Parse . $L;
    }
}
