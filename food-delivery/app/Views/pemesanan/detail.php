<script src="<?= base_url(); ?>/ajax/ajaxDetailPemesanan.js"></script>

<section class="content-header">
    <h1> <?= $title; ?> </h1>
    <ol class="breadcrumb">
        <li class="active">
            <a href="<?= site_url('dashboard'); ?>">
                <i class="fa fa-dashboard"></i>
                Dashboard
            </a>
        </li>
        <li>
            <a href="#">
                <i class="fa fa-cubes"></i>
                <?= $title; ?>
            </a>
        </li>
        <li class="active">
            <a href="#">
                <i class="fa fa-cubes"></i>
                Detail Pemesanan
            </a>
        </li>
    </ol>
</section>

<section class="content">
    <div class="box box-primary">
        <div class="box-header">
            <div class="row">
                <div class="col-md-12">
                    <a href="<?= site_url('pemesanan'); ?>" class="btn btn-primary btn-md">
                        <i class="fa fa-chevron-left"></i> &nbsp; Kembali
                    </a>
                </div>
            </div>
        </div>

        <div class="box-body">
            <table class="table table-striped table-hover" id="mytable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th style="text-align: center; width: 5%;">No</th>
                        <th style="text-align: center;">Nama Produk</th>
                        <th style="text-align: center;">Harga</th>
                        <th style="text-align: center; width: 5%;">Qty</th>
                        <th style="text-align: center;">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 1;
                    foreach ($pesanan->getResult() as $row) { ?>
                        <tr>
                            <td><?= $i++; ?></td>
                            <td><?= $row->nama_produk; ?></td>
                            <td><?= formatRupiah($row->harga, 1); ?></td>
                            <td><?= $row->qty; ?></td>
                            <td><?= formatRupiah($row->total, 1); ?></td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</section>