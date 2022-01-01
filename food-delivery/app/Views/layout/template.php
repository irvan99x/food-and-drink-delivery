<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel | <?= $title; ?></title>

    <link rel="stylesheet" href="<?= base_url(); ?>/dist/css/FontSansFamily.css">
    <link rel="stylesheet" href="<?= base_url(); ?>/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?= base_url(); ?>/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<?= base_url(); ?>/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="<?= base_url(); ?>/dist/css/skins/skin-blue.min.css">
    <link rel="stylesheet" href="<?= base_url(); ?>/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<?= base_url(); ?>/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="<?= base_url(); ?>/css/style.css">

    <script src="<?= base_url(); ?>/plugins/jQuery/jquery-2.2.3.min.js"></script>
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <?= $this->include('layout/navbar'); ?>
        <?= $this->include('layout/sidebar'); ?>
        <div class="content-wrapper">
            <?= view($main); ?>
        </div>
    </div>

    <script src="<?= base_url(); ?>/bootstrap/js/bootstrap.min.js"></script>
    <script src="<?= base_url(); ?>/dist/js/app.min.js"></script>
    <script src="<?= base_url(); ?>/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="<?= base_url(); ?>/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script src="<?= base_url(); ?>/plugins/datepicker/bootstrap-datepicker.js"></script>
    <script src="<?= base_url(); ?>js/alert.js"></script>

</body>

</html>