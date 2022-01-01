<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class Produk extends Migration
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
            'deskripsi' => [
                'type'              => 'TEXT',
            ],
            'gambar' => [
                'type'              => 'TEXT',
            ],
            'status' => [
                'type'              => 'ENUM',
                'constraint'        => ['0', '1'],
            ],
            'kategori' => [
                'type'              => 'VARCHAR',
                'constraint'        => 50,
            ],
            'created_at' => [
                'type'              => 'DATETIME',
            ],
            'updated_at' => [
                'type'              => 'DATETIME',
            ],
        ]);
        $this->forge->addKey('id', TRUE);
        $this->forge->createTable('produk');
    }

    public function down()
    {
        $this->forge->dropTable('produk');
    }
}
