console.log("script loading...");
const table = $("#dataTable").DataTable();

$('[data-delete]').click(function () {
    const id = $(this).data('delete');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'delete', id: id}),
        redirect: 'error',
        contentType: 'text/json'
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok){
            toastr.success(json.message);
            table.row(function(idx, value, node){
                return value[1] === id.toString();
            }).remove().draw();
        }else {
            toastr.error(json.message);
        }
    });
});

$('[data-enable]').change(function () {
    const id = $(this).data('enable');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'enable', id: id, enable: $(this).is(':checked')}),
        redirect: 'error',
        contentType: 'text/json'
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok){
            toastr.success(json.message);
        }else {
            toastr.error(json.message);
        }
    });
});
