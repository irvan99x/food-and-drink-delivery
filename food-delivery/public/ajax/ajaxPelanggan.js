var table;
var save_method;
var url;

$(document).ready(function() {
    table = $('#mytable').DataTable({
        "pageLength": 10,
        "autoWidth": true,
        "lengthChange": false,
        "ordering": false,
        "processing": true,
        "searching": true,
        "serverSide": true,
        "deferRender": true,
        "ajax": {
            "url": urlList,
            "type": "GET",            
        },
    })
});
   
function reload_table() {
    table.ajax.reload(null, false);
}

function ajaxStatus(id) {
    if (confirm('Apakah status ini akan diubah ? ')) {
        $.ajax({
            url: urlStatus + id,
            type: "GET",
            dataType: "JSON",
            success: function (data) {   
                if (data.status) {
                    // success('Status berhasil dihapus');
                    reload_table();
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                error(errorThrown);
               
            }
        });
    }
}