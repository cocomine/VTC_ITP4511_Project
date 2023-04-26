console.log("script loading...");
const table = $("#dataTable").DataTable();
let selectVenue = [];
const jq_editGuest = $('#editGuest');

$('#dataTable').on('click', '[data-add]', function (e) {
    const id = $(this).data('add');

    // get the row data
    const row = table.row(function (idx, value, node) {
        return value[1] === id.toString();
    })

    // create data
    const data = {
        venue: row.data(),
        guest: []
    }

    // create html
    const html = $(`<tr>
            <td>${row.data()[1]}</td>
            <td>${row.data()[3]}</td>
            <td class="text-center"><i class="ti-pencil me-2"></i></td>
            <td class="text-center"><i class="ti-trash text-danger"></i></td>
        </tr>`)

    // add event listener Remove select
    html.find('[class="ti-trash text-danger"]').click(function (e) {
        table.row.add(data.venue).draw(); // add to table
        // remove from array
        selectVenue = selectVenue.filter((value) => {
            return value.venue[1] !== data.venue[1];
        });
        html.remove(); // remove from table
    });

    // add event listener Edit guest
    html.find('[class="ti-pencil me-2"]').click(function (e) {
        bootstrap.Modal.getOrCreateInstance(jq_editGuest[0]).show();
        jq_editGuest.find('#guestList').empty(); // clear modal

        // add data to modal
        data.guest.forEach((value) => {
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
                                        <input class="form-control" type="text" id="email" name="email" required placeholder="Email" value="${value.email}">
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
                                        <input class="form-control" type="text" id="email" name="email" required placeholder="Email">
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
                if(list.email instanceof Array) {
                    // if email is array
                    list.email.forEach((value, index) => {
                        guest.push({
                            name: list.name[index],
                            email: value
                        });
                    });
                    data.guest = guest; // update data
                } else {
                    // if email is string
                    data.guest.push({
                        name: list.name,
                        email: list.email
                    });
                }
            }
        })
    });


    $('#selectVenue > tbody').append(html);//add to table
    row.remove().draw(); // remove from table
    selectVenue.push(data); // add to array
})

$('#bookForm').submit(function (e) {
    if (!e.isDefaultPrevented()) {
        e.preventDefault() //stop submit

        // check is not select venue
        if(selectVenue.length <= 0) {
            toastr.error('Please select venue');
            return;
        }

        const data = {
            ...$(this).serializeObject(),
            venue: selectVenue
        }
        console.log(data); //debug

        fetch(location.pathname, {
            method: 'POST',
            body: JSON.stringify(data),
            redirect: 'error',
            contentType: 'text/json'
        }).then(async (res) => {
            const json = await res.json();
            if (res.ok) {
                toastr.success(json.message);
            } else {
                toastr.error(json.message);
            }
        });
    }
});
