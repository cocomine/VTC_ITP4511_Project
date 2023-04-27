console.log("script loading...");
const jq_seemore = $('#seemore');

$('[data-seemore]').click(function () {
    const id = $(this).data('seemore');
    fetch(location.pathname, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({id})
    }).then(async response => {
        const json = await response.json();
        if(response.ok){
            bootstrap.Modal.getOrCreateInstance(jq_seemore[0]).show();

            jq_seemore.find('#forMonthly').off().click(function () {
                console.log(json); //debug
                jq_seemore.find('#showRecord').html(`
                    <div class="market-status-table mt-4">
                        <div class="table-responsive">
                            <table class="dbkit-table">
                                <tr class="heading-td">
                                    <th>Month</th>
                                    <th>No. of Booking</th>
                                    <th>No. of Attendance</th>
                                    <th>Attendance rate</th>
                                </tr>
                                ${(json.monthly.map(month => `
                                    <tr>
                                        <td>${month.month}</td>
                                        <td>${month.total}</td>
                                        <td>${month.attendance}</td>
                                        <td>${month.avg} %</td>
                                    </tr>`
                                )).join('')}
                            </table>
                        </div>
                    </div>`)
            }).click();

            jq_seemore.find('#forYearly').off().click(function () {
                console.log(json); //debug
                jq_seemore.find('#showRecord').html(`
                <div class="market-status-table mt-4">
                    <div class="table-responsive">
                        <table class="dbkit-table">
                            <tr class="heading-td">
                                <th>Year</th>
                                <th>No. of Booking</th>
                                <th>No. of Attendance</th>
                                <th>Attendance rate</th>
                            </tr>
                            ${(json.yearly.map(month => `
                                <tr>
                                    <td>${month.year}</td>
                                    <td>${month.total}</td>
                                    <td>${month.attendance}</td>
                                    <td>${month.avg} %</td>
                                </tr>`
                            )).join('')}
                        </table>
                    </div>
                </div>`)
            })
        }else {
            toastr.error(json.message);
        }
    })
})
//以上是預約次數, 出席次數(以成功check-out 計算), 出席率(出席數/預約數)
