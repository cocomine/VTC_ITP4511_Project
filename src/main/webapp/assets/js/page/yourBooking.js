console.log("script loading...");
const jq_editGuest = $('#editGuest');
const jq_editDetail = $('#editDetail');

$('#dataTable').on('click', '[data-edit]', function () {
    const id = $(this).data('edit');
    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'detail', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if (res.ok) {
            bootstrap.Modal.getOrCreateInstance(jq_editDetail[0]).show();

            jq_editDetail.find('#date').val(json.date); // set date value
            jq_editDetail.find('#template').val(json.template); // set template value
            jq_editDetail.find('#id').val(id); // set id value
        } else {
            toastr.error(json.message);
        }
    });
});

$('#dataTable').on('click', '[data-guestlist]', function (e) {
    const id = $(this).data('guestlist');

    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify({type: 'guestList', id: id}),
        redirect: 'error',
        headers:{
            'Content-Type': 'application/json'
        }
    }).then(async (res) => {
        const json = await res.json();
        if (res.ok) {
            bootstrap.Modal.getOrCreateInstance(jq_editGuest[0]).show();
            jq_editGuest.find('#guestList').empty(); // clear modal

            // add data to modal
            json.forEach((value) => {
                const tmp = $(`<div class="col-12 mb-2">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" type="text" id="guest" name="name" required placeholder="Name" value="${value.name}">
                                        <label for="guest">Name</label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" type="email" id="email" name="email" required placeholder="Email" value="${value.email}">
                                        <label for="email">Email</label>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <button type="button" class="btn-close"></button>
                                </div>
                            </div>
                        </div>`)

                tmp.find('.btn-close').click(() => tmp.remove()); // add event listener remove guest
                jq_editGuest.find('#guestList').append(tmp); // add to modal
            });

            // add event listener add guest
            jq_editGuest.find('#addGuest').off().click(() => {
                const tmp = $(`<div class="col-12 mb-2">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" type="text" id="guest" name="name" required placeholder="Name">
                                        <label for="guest">Name</label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" type="email" id="email" name="email" required placeholder="Email">
                                        <label for="email">Email</label>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <button type="button" class="btn-close"></button>
                                </div>
                            </div>
                        </div>`)

                tmp.find('.btn-close').click(() => tmp.remove()); // add event listener remove guest
                jq_editGuest.find('#guestList').append(tmp); // add to modal
            });

            // add event listener submit form
            jq_editGuest.find('#guestListForm').off().submit(function (e) {
                if (!e.isDefaultPrevented()) {
                    e.preventDefault() //stop submit

                    const list = $(this).serializeObject()
                    $(this).removeClass('was-validated')
                    bootstrap.Modal.getOrCreateInstance(jq_editGuest[0]).hide();

                    // create guest list
                    const guest = []
                    if(list.name && list.email) {
                        if (list.email instanceof Array) {
                            // if email is array
                            list.email.forEach((value, index) => {
                                guest.push({
                                    name: list.name[index],
                                    email: value
                                });
                            });
                        } else {
                            // if email is string
                            guest.push({
                                name: list.name,
                                email: list.email
                            });
                        }
                    }

                    // send data to server
                    fetch(location.pathname, {
                        method: 'POST',
                        body: JSON.stringify({type: 'updateGuest', id: id, guest: guest}),
                        redirect: 'error',
                        headers:{
                            'Content-Type': 'application/json'
                        }
                    }).then(async (res) => {
                        const json = await res.json();
                        if (res.ok) {
                            toastr.success(json.message);
                        } else {
                            toastr.error(json.message);
                        }
                    });
                }
            })
        } else {
            toastr.error(json.message);
        }
    });
})

