console.log("script loading...");
const table = $("#dataTable").DataTable();

$('#dataTable').on('click', '[data-delete]', function () {
    const id = $(this).data('delete');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'delete', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
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

$('#dataTable').on('change', '[data-enable]', function () {
    const id = $(this).data('enable');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'enable', id: id, enable: $(this).is(':checked')}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok){
            toastr.success(json.message);
        }else {
            toastr.error(json.message);
        }
    });
});
