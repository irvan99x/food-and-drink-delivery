<?php

namespace App\Database\Seeds;

class PelangganSeeder extends \CodeIgniter\Database\Seeder
{
    public function run()
    {
        $options = [
            'cost' => 10,
        ];

        $data = [
            'nama'          => 'Muhammad Irvan',
            'no_telp'       => '082112367972',
            'email'         => 'mirvan3107@gmail.com',
            'password'      => password_hash('irvan123', PASSWORD_DEFAULT, $options),
            'status'        => '1',
            'created_at'    => date("Y-m-d H:i:s"),
            'updated_at'    => date("Y-m-d H:i:s"),
        ];

        $this->db->table('pelanggan')->insert($data);
    }
}
