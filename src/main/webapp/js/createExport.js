document.getElementById('nameProd').addEventListener('input', function() {
    const searchTerm = this.value.toLowerCase();
    const items = document.querySelectorAll('.infoPro td');

    items.forEach(function(item) {
        if (item.textContent.toLowerCase().includes(searchTerm)) {
            item.classList.remove('hidden');
        } else {
            item.classList.add('hidden');
        }
    });
});

const today = new Date();
const day = today.getDate();
const month = today.getMonth() + 1; // Tháng trong JavaScript bắt đầu từ 0
const year = today.getFullYear();

document.getElementById('today').value = `${month}-${day}-${year}`;

document.getElementById('searchInput').addEventListener('input', function() {
    const searchTerm = this.value.toLowerCase();
    const rows = document.querySelectorAll('#productTable tbody tr');
    let hasResults = false;

    rows.forEach(function(row) {
        const nameCell = row.querySelector('td[nameProd]');
        if (nameCell) {
            if (nameCell.textContent.toLowerCase().includes(searchTerm)) {
                row.style.display = '';
                hasResults = true;
            } else {
                row.style.display = 'none';
            }
        }
    });

    if (!hasResults) {
        document.getElementById('no-results').style.display = '';
    } else {
        document.getElementById('no-results').style.display = 'none';
    }
});


