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
                                <td>No. of Attendance</td>
                                <td>Attendance rate</td>
                            </tr>
                            <tr>
                                <td>Jan</td>
                                <td>10</td>
                                <td>9</td>
                                <td>0.9</td>
                            </tr>
                            <tr>
                                <td>Feb</td>
                                <td>20</td>
                                <td>18</td>
                                <td>0.9</td>
                            </tr>
                        </table>
                    </div>
                </div>`;
    //以上是預約次數, 出席次數(以成功check-out 計算), 出席率(出席數/預約數)

    $('#showRecord').html(showRecord);
});

$('#forYearly').click(function () {
    showRecord = `<div class="market-status-table mt-4">
                    <div class="table-responsive">
                        <table class="dbkit-table">
                            <tr class="heading-td">
                                <td>Year</td>
                                <td>No. of Booking</td>
                                <td>No. of Attendance</td>
                                <td>Attendance rate</td>
                            </tr>
                            <tr>
                                <td>2021</td>
                                <td>300</td>
                                <td>290</td>
                                <td>0.82</td>
                            </tr>
                            <tr>
                                <td>2022</td>
                                <td>150</td>
                                <td>140</td>
                                <td>0.96</td>
                            </tr>
                        </table>
                    </div>
                </div>`;

    $('#showRecord').html(showRecord);
});
