console.log("script loading...");
const table = $("#dataTable").DataTable();
let selectVenue = [];
const jq_editGuest = $('#editGuest');
const jq_editDetail = $('#editDetail');

$('#dataTable').on('click', '[data-add]', function (e) {
    const id = $(this).data('add');

    // get the row data
    const row = table.row(function (idx, value, node) {
        return value[1] === id.toString();
    })

    // create data
    const data = {
        venue: row.data(),
        guest: [],
        detail: {
            date: null,
            template: null
        }
    }

    // create html
    const html = $(`<tr>
            <td>${row.data()[1]}</td>
            <td>${row.data()[3]}</td>
            <td class="text-center"><i class="ti-pencil"></i></td>
            <td class="text-center"><i class="ti-pencil detail"></i></td>
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
    html.find('[class="ti-pencil"]').click(function (e) {
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
                data.guest = []; // clear guest list
                if(list.name && list.email) {
                    if (list.email instanceof Array) {
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
            }
        })
    });

    // add event listener Edit detail
    html.find('[class="ti-pencil detail"]').click(function (e) {
        bootstrap.Modal.getOrCreateInstance(jq_editDetail[0]).show();

        jq_editDetail.find('#date').val(data.detail.date); // set date value
        jq_editDetail.find('#template').val(data.detail.template); // set template value

        jq_editDetail.find('#detailForm').off().submit(function (e) {
            if (!e.isDefaultPrevented()) {
                e.preventDefault() //stop submit

                data.detail = $(this).serializeObject(); // update data
                $(this).removeClass('was-validated')
                bootstrap.Modal.getOrCreateInstance(jq_editDetail[0]).hide();
            }
        });
    });

    $('#selectVenue > tbody').append(html);//add to table
    row.remove().draw(); // remove from table
    selectVenue.push(data); // add to array
})

$('#submit').click(function (e) {

    // check is not select venue
    if (selectVenue.length <= 0) {
        toastr.error('Please select venue');
        return;
    }

    // check is not fill in date
    console.log(selectVenue); //debug
    const x = selectVenue.some((value) => {
        if(value.detail.date === null){
            toastr.error('Please fill in venue ' + value.venue[1] + ' the booking date');
            return true;
        }else {
            return false;
        }
    });
    if (x) return;

    fetch(location.pathname, {
        method: 'POST',
        body: JSON.stringify(selectVenue),
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
});
