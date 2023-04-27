console.log("script loading...");
const jq_table = $('#table');
let Income = {
    monthly: [],
    yearly: []
};

$('#selectVenue').change(function () {
    const id = $(this).val();

    fetch(location.pathname, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({id}),
        redirect: 'error'
    }).then(async response => {
        const json = await response.json();
        if(response.ok){
            console.log(json);
            Income = json;

            /* booking record */
            let tmp;
            if(json.bookings.length <= 0){
                tmp = ['<tr><td colspan="5">No record found</td></tr>'];
            }else{
                tmp = json.bookings.map(booking => `
                <tr>
                    <th scope="row">${booking.id}</th>
                    <td>${booking.username}</td>
                    <td>${booking.email}</td>
                    <td>${booking.book_date}</td>
                    <td>
                        ${
                            booking.status === 0 ? '<span class="badge rounded-pill bg-warning">Pending</span>' :
                                booking.status === 1 ? '<span class="badge rounded-pill bg-success">Approved</span>' :
                                    '<span class="badge rounded-pill bg-danger">Rejected</span>'
                        }
                    </td>
                </tr>`);
            }

            $('#bookingRecord').html(tmp);
        }else {
            toastr.error(json.message);
        }
        $('#forMonthly').click();
    })
});

$('#forMonthly').click(function () {
    const showRecord = `
        <tr class="heading-td">
            <th>Month</th>
            <th>Income</th>
        </tr>
        ${Income.monthly.length <= 0 ? `<tr><td colspan="2">No record found</td></tr>` :
            (Income.monthly.map((rate) => `
                <tr>
                    <td>${rate.month}</td>
                    <td>$ ${rate.total}</td>
                </tr>
            `)).join('')
        }
    `;

    jq_table.html(showRecord);
});

$('#forYearly').click(function () {
    const showRecord = `
        <tr class="heading-td">
            <th>Year</th>
            <th>Income</th>
        </tr>
        ${Income.yearly.length <= 0 ? `<tr><td colspan="3">No record found</td></tr>` :
            (Income.yearly.map((rate) => `
                <tr>
                    <td>${rate.year}</td>
                    <td>$ ${rate.total}</td>
                </tr>
            `)).join('')
        }
    `;

    jq_table.html(showRecord);
});
