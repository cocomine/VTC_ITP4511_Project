console.log("script loading...");

const backgroundColor = ['#815DF6', '#67B7DC', '#9c82f4', '#FDD400', '#fd0059'];
const totalRate = JSON.parse($('#totalRate').text());

// AmCharts
const chart = AmCharts.makeChart("ampiechart1", {
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

$(function() {
    $('#forMonthly').focus().click();
});

$('#forMonthly').click(function () {
    const showRecord = `<div class="market-status-table mt-4">
                    <div class="table-responsive">
                        <table class="dbkit-table">
                            <tr class="heading-td">
                                <td>Month</td>
                                <td>No. of Booking</td>
                                <td>Booking Rate</td>
                            </tr>
                            <tr>
                                <td>Jan</td>
                                <td>20</td>
                                <td>0.67</td>
                            </tr>
                            <tr>
                                <td>feb</td>
                                <td>15</td>
                                <td>0.5</td>
                            </tr>
                        </table>
                    </div>
                </div>`;

    $('#showRecord').html(showRecord);
});

$('#forYearly').click(function () {
    const showRecord = `<div class="market-status-table mt-4">
                    <div class="table-responsive">
                        <table class="dbkit-table">
                            <tr class="heading-td">
                                <td>Year</td>
                                <td>No. of Booking</td>
                                <td>Booking Rate</td>
                            </tr>
                            <tr>
                                <td>2021</td>
                                <td>300</td>
                                <td>0.82</td>
                            </tr>
                            <tr>
                                <td>2022</td>
                                <td>150</td>
                                <td>0.41</td>
                            </tr>
                        </table>
                    </div>
                </div>`;

    $('#showRecord').html(showRecord);
});
