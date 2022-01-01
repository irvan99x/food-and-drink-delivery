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
                    <input type="hidden" name="id">

                    <div class="form-group">
                        <div class="control-label col-md-3">Nama Produk</div>
                        <div class="col-md-8">
                            <input type="text" id="nama_produk" class="form-control" name="nama_produk">
                            <span class="help-block"></span>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="form-group">
                        <div class="control-label col-md-3">Harga</div>
                        <div class="col-md-8">
                            <input type="text" id="harga" class="form-control" name="harga">
                            <span class="help-block"></span>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="form-group">
                        <div class="control-label col-md-3">Kategori</div>
                        <div class="col-md-8">
                            <?php
                            $dropdown = getDropdownList('kategori', ['nama_kategori', 'nama_kategori'], 'Kategori Produk');
                            echo form_dropdown('kategori', $dropdown, '', 'class="form-control"');
                            ?>
                            <span class="help-block"></span>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="form-group">
                        <div class="control-label col-md-3">Deskripsi</div>
                        <div class="col-md-8">
                            <textarea name="deskripsi" id="deskripsi" rows="3" class="form-control"></textarea>
                            <span class="help-block"></span>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="form-group">
                        <div class="control-label col-md-3">Gambar</div>
                        <div class="col-md-8">
                            <input type="file" id="gambar" class="form-control" name="gambar" onchange="imgPreview()">
                            <span class="help-block"></span>
                            <img class="img-preview" width="100%" height="250px">
                        </div>
                        <div class="col-md-1"></div>
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