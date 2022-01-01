<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;
use phpDocumentor\Reflection\PseudoTypes\True_;

class Keranjang extends Migration
{
    public function up()
    {
        // $this->db->enableForeignKeyChecks();
        $this->forge->addField([
            'id' => [
                'type'              => 'INT',
                'constraint'        => 11,
                'unsigned'          => TRUE,
                'auto_increment'    => TRUE,
            ],
            'nama_produk' => [
                'type'              => 'VARCHAR',
                'constraint'        => 50,
            ],
            'harga' => [
                'type'              => 'INT',
                'constraint'        => 10,
            ],
            'qty' => [
                'type'              => 'INT',
                'constraint'        => 2,
            ],
            'total' => [
                'type'              => 'INT',
                'constraint'        => 10,
            ],
            'gambar' => [
                'type'              => 'TEXT',
            ],
            'expired' => [
                'type'              => 'INT',
                'constraint'        => 10,
            ],
            'id_pelanggan' => [
                'type'              => 'INT',
                'constraint'        => 11,
                'unsigned'          => TRUE,
            ],
            'created_at' => [
                'type'              => 'DATETIME',
            ],
            'updated_at' => [
                'type'              => 'DATETIME',
            ],
        ]);
        $this->forge->addKey('id', TRUE);
        $this->forge->addForeignKey('id_pelanggan', 'pelanggan', 'id', 'CASCADE', 'CASCADE');
        $this->forge->createTable('keranjang');
    }

    public function down()
    {
        $this->forge->dropTable('keranjang');
    }
}
