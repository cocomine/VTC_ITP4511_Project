console.log("script loading...");

const backgroundColor = ['#815DF6', '#67B7DC', '#9c82f4', '#FDD400', '#fd0059'];
const totalRate = JSON.parse($('#totalRate').text());
const jq_showRecord = $('#showRecord')
let Booking_Rate = {
    monthly: [],
    yearly: []
};

// AmCharts
AmCharts.makeChart("ampiechart1", {
    "type": "pie",
    "labelRadius": -35,
    "labelText": "[[percents]]%",
    "dataProvider": totalRate.map((rate, index) => {
        return {
            "location": rate.location,
            "count": rate.count,
            "backgroundColor": backgroundColor[index]
        };
    }),
    "color": "#fff",
    "colorField": "backgroundColor",
    "valueField": "count",
    "titleField": "location"
});

//get data from server
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
            Booking_Rate = json;
        }else {
            toastr.error(json.message);
        }
        $('#forMonthly').click();
    })
});

$('#forMonthly').click(function () {
    const showRecord = `
        <div class="market-status-table mt-4">
            <div class="table-responsive">
                <table class="dbkit-table">
                    <tr class="heading-td">
                        <th>Month</th>
                        <th>No. of Booking</th>
                        <th>Booking Rate</th>
                    </tr>
                    ${Booking_Rate.monthly.length <= 0 ? `<tr><td colspan="3">No record found</td></tr>` :
                        (Booking_Rate.monthly.map((rate) => `
                            <tr>
                                <td>${rate.month}</td>
                                <td>${rate.total}</td>
                                <td>${rate.avg} %</td>
                            </tr>
                        `)).join('')
                    }
                </table>
            </div>
        </div>`;

    jq_showRecord.html(showRecord);
});

$('#forYearly').click(function () {
    const showRecord = `
        <div class="market-status-table mt-4">
            <div class="table-responsive">
                <table class="dbkit-table">
                    <tr class="heading-td">
                        <th>Year</th>
                        <th>No. of Booking</th>
                        <th>Booking Rate</th>
                    </tr>
                    ${Booking_Rate.yearly.length <= 0 ? `<tr><td colspan="3">No record found</td></tr>` :
                        (Booking_Rate.yearly.map((rate) => `
                            <tr>
                                <td>${rate.year}</td>
                                <td>${rate.total}</td>
                                <td>${rate.avg} %</td>
                            </tr>
                        `)).join('')
                    }
                </table>
            </div>
        </div>`;

    jq_showRecord.html(showRecord);
});
