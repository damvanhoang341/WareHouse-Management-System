const ctx1 = document.getElementById('lineChart').getContext('2d');
const lineChart = new Chart(ctx1, {
    type: 'line',
    data: {
        labels: ['T1', 'T2', 'T3', 'T4','T5', 'T6', 'T7', 'T8','T9', 'T10', 'T11', 'T12'],
        datasets: [
            {
                label: 'Nhập khẩ',
                data: [50, 60, 70, 100,50, 60, 70, 100,50, 60, 70, 100],
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1,
                fill: true
            },
            {
                label: 'Xuất khẩu',
                data: [40, 50, 60, 90,40, 50, 60, 90,40, 50, 60, 90],
                backgroundColor: 'rgba(76, 175, 80, 0.2)',
                borderColor: 'rgba(76, 175, 80, 1)',
                borderWidth: 1,
                fill: true
            }
        ]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

const ctx2 = document.getElementById('doughnutChart').getContext('2d');
const doughnutChart = new Chart(ctx2, {
    type: 'doughnut',
    data: {
        labels: ['Nhập khẩu', 'Xuất khẩu'],
        datasets: [
            {
                data: [60, 40],
                backgroundColor: ['rgba(54, 162, 235, 1)', 'rgba(255, 99, 132, 1)'],
                borderWidth: 0
            }
        ]
    },
    options: {
        responsive: true
    }
});
