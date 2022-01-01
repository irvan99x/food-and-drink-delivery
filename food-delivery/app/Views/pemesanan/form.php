<div class="modal fade" id="modal-form" role="dialog" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h3 class="modal-title"></h3>
            </div>
            <div class="modal-body form">
                <form action="#" id="form" class="form-horizontal">
                    <?= csrf_field(); ?>
                    <input type="hidden" name="kd_pemesanan">

                    <div class="form-group">
                        <div class="control-label col-md-3">Status Pesanan</div>
                        <div class="col-md-8">
                            <?php
                            $dropdown = field_enums('pemesanan', 'status', 'Pilih Status');
                            echo form_dropdown('status', $dropdown, '', 'class="form-control" id="status"')
                            ?>
                            <span class="help-block"></span>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="form-group" id="keterangan">
                        <label for="noteCancel" class="control-label col-md-3">Keterangan</label>
                        <div class="col-md-8">
                            <textarea name="noteCancel" id="noteCancel" rows="3" class="form-control" placeholder="Alasan pesanan dibatalkan"></textarea>
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="btn-save" onclick="ajaxSave()" class="btn btn-primary">Simpan</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Batal</button>
            </div>
        </div>
    </div>
</div>