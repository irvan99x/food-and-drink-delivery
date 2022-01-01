<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\Admin\ProdukModel;

class produk extends BaseController
{
    protected $halaman;
    protected $title;
    protected $produk;

    public function __construct()
    {
        $this->halaman  = 'produk';
        $this->title    = 'Produk';

        $this->produk   = new ProdukModel();
    }

    public function index()
    {
        $data = [
            'halaman'   => $this->halaman,
            'title'     => $this->title,
            'main'      => 'produk/index',
        ];

        return view('layout/template', $data);
    }

    public function ajaxList()
    {
        $draw   = $_REQUEST['draw'];
        $length = $_REQUEST['length'];
        $start  = $_REQUEST['start'];
        $search = $_REQUEST['search']['value'];

        $total = $this->produk->ajaxGetTotal();
        $output = [
            'length'            => $length,
            'draw'              => $draw,
            'recordsTotal'      => $total,
            'recordsFiltered'   => $total
        ];

        if ($search !== '') {
            $list = $this->produk->ajaxGetDataSearch($search, $length, $start);
        } else {
            $list = $this->produk->ajaxGetData($length, $start);
        }

        if ($search !== '') {
            $total_search = $this->produk->ajaxGetTotalSearch($search);
            $output = [
                'recordsTotal'      => $total_search,
                'recordFiltered'    => $total_search,
            ];
        }

        $data = [];
        $no = $start + 1;
        foreach ($list as $temp) {
            $aksi = '
                <div class="text-center">
                    <a href="javascript:void(0)" class="btn btn-warning btn-sm" data-toggle="tooltip" title="Edit Data" onclick="ajaxEdit(' . $temp['id'] . ')">
                        <i class="fa fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0)" class="btn btn-danger btn-sm" data-toggle="tooltip" title="Hapus Data" onclick="ajaxDelete(' . $temp['id'] . ')">
                        <i class="fa fa-trash"></i>
                    </a>
                </div>
            ';

            $status = '
            <div class="text-center">
                <a href="javascript:void(0)" data-toggle="tooltip" title="' . ($temp['status'] == '0' ? 'Aktifkan' : 'Non-aktifkan') . '" onclick="ajaxStatus(' . $temp['id'] . ')">
                ' . formatStatus($temp['status']) . '
                </a>
            </div>
            ';



            $gambar = '
                <div class="text-center">
                    <img src="' . base_url('/uploads/img/' . $temp['gambar']) . '" alt="' . $temp['gambar'] . '" width="200px" height="125px">
                </div>
            ';

            $row = [];
            $row[] = $no++;
            $row[] = $gambar;
            $row[] = $temp['nama_produk'];
            $row[] = $temp['harga'];
            $row[] = $temp['kategori'];
            $row[] = $temp['deskripsi'];
            $row[] = $status;
            $row[] = $aksi;

            $data[] = $row;
        }

        $output['data'] = $data;

        echo json_encode($output);
        exit();
    }

    public function ajaxEdit($id)
    {
        $data = $this->produk->find($id);
        echo json_encode($data);
    }

    public function ajaxSave()
    {
        $this->_validate('save');

        $data = [
            'nama_produk'   => $this->request->getVar('nama_produk'),
            'harga'         => $this->request->getVar('harga'),
            'deskripsi'     => $this->request->getVar('deskripsi'),
            'kategori'      => $this->request->getVar('kategori'),
            'gambar'        => uploadImage($this->request->getFile('gambar')),
            'status'        => '1',
        ];

        if ($this->produk->save($data)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function ajaxUpdate()
    {
        $this->_validate('update');

        $id = $this->request->getVar('id');
        $produk = $this->produk->find($id);

        if ($this->request->getFile('gambar') == '') {
            $gambar = $produk['gambar'];
        } else {
            unlink('uploads/img/' . $produk['gambar']);
            $gambar = uploadImage($this->request->getFile('gambar'));
        }

        $data = [
            'id'            => $id,
            'nama_produk'   => $this->request->getVar('nama_produk'),
            'harga'         => $this->request->getVar('harga'),
            'deskripsi'     => $this->request->getVar('deskripsi'),
            'kategori'      => $this->request->getVar('kategori'),
            'gambar'        => $gambar,
        ];

        if ($this->produk->save($data)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function ajaxDelete($id)
    {
        $produk = $this->produk->find($id);
        unlink('uploads/img/' . $produk['gambar']);

        if ($this->produk->delete($id)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function ajaxStatus($id)
    {
        $produk = $this->produk->find($id);
        $data['id'] = $id;

        if ($produk['status'] == '0') {
            $data['status'] = '1';
        } else {
            $data['status'] = '0';
        }

        if ($this->produk->save($data)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function _validate($method)
    {
        if (!$this->validate($this->produk->getRulesValidation($method))) {
            $validation = \Config\Services::validation();

            $data = [];
            $data['error_string']   = [];
            $data['inputerror']     = [];
            $data['status']         = TRUE;

            if ($validation->hasError('nama_produk')) {
                $data['inputerror'][]   = 'nama_produk';
                $data['error_string'][] = $validation->getError('nama_produk');
                $data['status']         = FALSE;
            }

            if ($validation->hasError('harga')) {
                $data['inputerror'][]   = 'harga';
                $data['error_string'][] = $validation->getError('harga');
                $data['status']         = FALSE;
            }

            if ($validation->hasError('deskripsi')) {
                $data['inputerror'][]   = 'deskripsi';
                $data['error_string'][] = $validation->getError('deskripsi');
                $data['status']         = FALSE;
            }

            if ($validation->hasError('kategori')) {
                $data['inputerror'][]   = 'kategori';
                $data['error_string'][] = $validation->getError('kategori');
                $data['status']         = FALSE;
            }

            if ($validation->hasError('gambar')) {
                $data['inputerror'][]   = 'gambar';
                $data['error_string'][] = $validation->getError('gambar');
                $data['status']         = FALSE;
            }

            if ($data['status'] === FALSE) {
                echo json_encode($data);
                exit();
            }
        }
    }
}
