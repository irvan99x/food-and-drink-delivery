<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class Pemesanan extends Migration
{
    public function up()
    {
        // $this->db->enableForeignKeyChecks();
        $this->forge->addField([
            'kd_pemesanan' => [
                'type'              => 'VARCHAR',
                'constraint'        => 11,
            ],
            'tgl_pesan' => [
                'type'              => 'DATETIME',
            ],
            'total_bayar' => [
                'type'              => 'INT',
                'constraint'        => 10,
            ],
            'latitude' => [
                'type'              => 'DOUBLE',
            ],
            'longitude' => [
                'type'              => 'DOUBLE',
            ],
            'id_pelanggan' => [
                'type'              => 'INT',
                'constraint'        => 11,
                'unsigned'          => TRUE,
            ],
            'status' => [
                'type'              => 'ENUM',
                'constraint'        => ['0', '1', '2', '3'],
            ],
        ]);
        $this->forge->addKey('kd_pemesanan', TRUE);
        $this->forge->addForeignKey('id_pelanggan', 'pelanggan', 'id');
        $this->forge->createTable('pemesanan');
    }

    public function down()
    {
        $this->forge->dropTable('pemesanan');
    }
}
