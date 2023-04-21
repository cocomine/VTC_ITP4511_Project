console.log("script loading...");
const table = $("#dataTable").DataTable();
const modal = $('#editModal')

// Get data from server
$('[data-edit]').click(function () {
    const id = $(this).data('edit');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'detail', id: id}),
        redirect: 'error',
        contentType: 'text/json'
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok){
            console.log(json);
            bootstrap.Modal.getOrCreateInstance(modal[0]).show();

            modal.find('#id').val(json.id);
            modal.find('#username').val(json.username);
            modal.find('#email').val(json.email);
            modal.find('#phone').val(json.phone);
            modal.find('#password').val('');
            modal.find('#C_password').val('');

            modal.find('[name="role"]').prop('checked', false);
            modal.find(`[name="role"][value="${json.role}"]`).prop('checked', true);
        }else {
            toastr.error(json.message);
        }
    })
});

$('#editForm').submit(function (e) {
    if(e.isDefaultPrevented()) return;
    e.preventDefault();
    e.stopPropagation();

    const data = objectifyForm($(this).serializeArray());
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'edit', ...data}),
        redirect: 'error',
        contentType: 'text/json'
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok){
            toastr.success(json.message);
            bootstrap.Modal.getOrCreateInstance(modal[0]).hide();

            let row = table.row(function(idx, value, node){
                return value[0] === data.id.toString();
            });

            let rowData = row.data();
            rowData[1] = data.username;
            rowData[2] = data.email;
            rowData[3] = data.phone;
            rowData[4] = data.role === 0 ? 'row.data(rowData).draw();' : data.role === 1 ? 'Staff' : 'Senior Management';
            row.data(rowData).draw();

        }else {
            toastr.error(json.message);
        }
    });
});

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
                return value[0] === id.toString();
            }).remove().draw();
        }else {
            toastr.error(json.message);
        }
    });
});

$('#password').on('input', function () {
    if($(this).val().length > 0){
        $('#C_password').prop('disabled', false);
    }else {
        $('#C_password').prop('disabled', true);
    }
});
