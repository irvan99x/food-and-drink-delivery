<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\Admin\KategoriModel;

class Kategori extends BaseController
{
    protected $halaman;
    protected $title;
    protected $kategori;

    public function __construct()
    {
        $this->halaman  = 'kategori';
        $this->title   = 'Kategori';

        $this->kategori = new KategoriModel();
    }

    public function index()
    {
        $data = [
            'halaman'   => $this->halaman,
            'title'     => $this->title,
            'main'      => 'kategori/index',
        ];

        return view('layout/template', $data);
    }

    public function ajaxList()
    {
        $draw   = $_REQUEST['draw'];
        $length = $_REQUEST['length'];
        $start  = $_REQUEST['start'];
        $search = $_REQUEST['search']['value'];

        $total = $this->kategori->ajaxGetTotal();
        $output = [
            'length'            => $length,
            'draw'              => $draw,
            'recordsTotal'      => $total,
            'recordsFiltered'   => $total
        ];

        if ($search !== '') {
            $list = $this->kategori->ajaxGetDataSearch($search, $length, $start);
        } else {
            $list = $this->kategori->ajaxGetData($length, $start);
        }

        if ($search !== '') {
            $total_search = $this->kategori->ajaxGetTotalSearch($search);
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

            $row = [];
            $row[] = $no++;
            $row[] = $temp['nama_kategori'];
            $row[] = $status;
            $row[] = $aksi;

            $data[] = $row;
        }

        $output['data'] = $data;

        echo json_encode($output);
        exit();
    }

    public function ajaxSave()
    {
        $this->_validate('save');

        $data = [
            'nama_kategori' => $this->request->getVar('nama_kategori'),
            'status'        => '1'
        ];

        if ($this->kategori->save($data)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function ajaxEdit($id)
    {
        $kategori = $this->kategori->find($id);
        echo json_encode($kategori);
    }

    public function ajaxUpdate()
    {
        $this->_validate('update');

        $data = [
            'id'            => $this->request->getVar('id'),
            'nama_kategori' => $this->request->getVar('nama_kategori'),
        ];

        if ($this->kategori->save($data)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function ajaxDelete($id)
    {
        if ($this->kategori->delete($id)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function ajaxStatus($id)
    {
        $kategori = $this->kategori->find($id);
        $data['id'] = $id;

        if ($kategori['status'] == '0') {
            $data['status'] = '1';
        } else {
            $data['status'] = '0';
        }

        if ($this->kategori->save($data)) {
            echo json_encode(['status' => TRUE]);
        } else {
            echo json_encode(['status' => FALSE]);
        }
    }

    public function _validate($method)
    {
        if (!$this->validate($this->kategori->getRulesValidation($method))) {
            $validation = \Config\Services::validation();

            $data = [];
            $data['error_string']   = [];
            $data['inputerror']     = [];
            $data['status']         = TRUE;

            if ($validation->hasError('nama_kategori')) {
                $data['inputerror'][]   = 'nama_kategori';
                $data['error_string'][] = $validation->getError('nama_kategori');
                $data['status']         = FALSE;
            }

            if ($data['status'] === FALSE) {
                echo json_encode($data);
                exit();
            }
        }
    }
}
