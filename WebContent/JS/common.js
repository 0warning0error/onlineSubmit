function count() {
    let times = document.querySelectorAll('.begin .begin_two ul.one li')
    let now = new Date()
    let end = new Date(2022, 7, 10, 9, 0, 0)
    let now_stamp = now.getTime()
    let end_stamp = end.getTime()
    let delta = Math.round((end_stamp - now_stamp) / 1000)
    for (let i = times.length - 1; i >= 1; i--) {
        if (i > 1) {
            let tmp = delta % 60
            times[i].innerText = tmp
            delta = (delta - tmp) / 60
        }
        else {
            let tmp = delta % 24
            times[i].innerText = tmp
            times[i - 1].innerText = (delta - tmp) / 24

        }
    }
}

setInterval(() => {
    count()
}, 1000);