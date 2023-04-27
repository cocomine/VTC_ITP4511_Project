console.log("script loading...");
const jq_guestList = $('#guestList')

$('#dataTable').on('click', '[data-approve]', function () {
    const id = $(this).data('approve');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'approve', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok){
            toastr.success(json.message);
            $(this).parent().children('[data-reject]').prop('disabled', true);
            $(this).parents('tr').find('[data-checkin]').prop('disabled', false);
        }else {
            toastr.error(json.message);
        }
    });
});


$('#dataTable').on('click', '[data-reject]', function () {
    const id = $(this).data('reject');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'reject', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok) {
            toastr.success(json.message);
            $(this).parent().children('[data-approve]').prop('disabled', true);
        }else {
            toastr.error(json.message);
        }
    });
});

$('#dataTable').on('click', '[data-checkin]', function () {
    const id = $(this).data('checkin');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'checkin', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok) {
            toastr.success(json.message);
            $(this).prop('disabled', true);
            $(this).parent().children('[data-checkout]').prop('disabled', false);
        }else {
            toastr.error(json.message);
        }
    });
});

$('#dataTable').on('click', '[data-checkout]', function () {
    const id = $(this).data('checkout');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'checkout', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok) {
            toastr.success(json.message);
            $(this).prop('disabled', true);
        }else {
            toastr.error(json.message);
        }
    });
});

$('#dataTable').on('click', '[data-guestlist]', function () {
    const id = $(this).data('guestlist');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'guestlist', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if(res.ok) {
            if(json.guest.length > 0){
                const list = json.guest.map((guest) => {
                    return `<tr><td>${guest.name}</td><td>${guest.email}</td></tr>`
                })

                $('#guestListBody').html(list);
                jq_guestList.find('#template').html(json.template ?? '(Member has not type any template)');

                bootstrap.Modal.getOrCreateInstance(jq_guestList[0]).show();
            }else{
                toastr.warning('No guests have been added to this booking.');
            }
        }else {
            toastr.error(json.message);
        }
    });
})
