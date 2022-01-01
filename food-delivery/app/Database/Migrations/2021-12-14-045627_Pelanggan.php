<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class Pelanggan extends Migration
{
    public function up()
    {
        $this->forge->addField([
            'id' => [
                'type'              => 'INT',
                'constraint'        => 11,
                'unsigned'          => TRUE,
                'auto_increment'    => TRUE,
            ],
            'nama' => [
                'type'              => 'VARCHAR',
                'constraint'        => 50,
            ],
            'no_telp' => [
                'type'              => 'VARCHAR',
                'constraint'        => 50,
            ],
            'email' => [
                'type'              => 'VARCHAR',
                'constraint'        => 50,
            ],
            'password' => [
                'type'              => 'VARCHAR',
                'constraint'        => 255,
            ],
            'status' => [
                'type'              => 'ENUM',
                'constraint'        => ['0', '1'],
            ],
            'created_at' => [
                'type'              => 'DATETIME',
            ],
            'updated_at' => [
                'type'              => 'DATETIME',
            ],
        ]);
        $this->forge->addKey('id', TRUE);
        $this->forge->createTable('pelanggan');
    }

    public function down()
    {
        $this->forge->dropTable('pelanggan');
    }
}
