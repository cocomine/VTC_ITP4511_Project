console.log("script loading...");

let showRecord = '';

$(function() {
    $('#forMonthly').focus().click();

});

$('#forMonthly').click(function () {
    showRecord = `<div class="market-status-table mt-4">
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
    showRecord = `<div class="market-status-table mt-4">
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
