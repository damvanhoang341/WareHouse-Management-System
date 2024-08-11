
function removeAccents(str) {
    return str.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toUpperCase();
}

function searchProduct() {
    // Lấy giá trị của input tìm kiếm và chuẩn hóa
    let input = document.getElementById('searchInput').value;
    let filter = removeAccents(input);

    // Lấy bảng sản phẩm và các hàng trong bảng
    let table = document.getElementById('productTable');
    let tr = table.getElementsByTagName('tr');

    // Biến kiểm tra có hàng nào được hiển thị không
    let found = false;

    // Lặp qua tất cả các hàng trong bảng (bỏ qua tiêu đề bảng)
    for (let i = 1; i < tr.length; i++) {
        // Lấy ô đầu tiên (Tên mặt hàng) trong mỗi hàng và chuẩn hóa
        let td = tr[i].getElementsByTagName('td')[0];
        if (td) {
            let txtValue = removeAccents(td.textContent || td.innerText);
            // Kiểm tra xem giá trị của ô có chứa chuỗi tìm kiếm không
            if (txtValue.indexOf(filter) > -1) {
                tr[i].style.display = '';
                found = true;
            } else {
                tr[i].style.display = 'none';
            }
        }
    }

    // Hiển thị thông báo nếu không có hàng nào phù hợp
    document.getElementById('noResultsMessage').style.display = found ? 'none' : 'block';
}

function selectProduct(row) {
    const table = document.getElementById('productTable');
    const productId = row.getElementsByTagName('td')[1].innerText;
    if (!table.contains(row)) {
        return;
    }
    const selectedProductTable = document.getElementById('selectedProductTable').getElementsByTagName('tbody')[0];

    for (let i = 0; i < selectedProductTable.rows.length; i++) {
        if (selectedProductTable.rows[i].getElementsByTagName('td')[1].innerText === productId && table.contains(row)) {
            alert('Sản phẩm đã tồn tại');
            return;
        }
    }

    const newRow = row.cloneNode(true);

    const quantityCell = document.createElement('td');
    quantityCell.innerHTML = `<input type="number" value="1" min="1" class="form-control" oninput="updateTotalPrice(this)"/>`;
    newRow.replaceChild(quantityCell, newRow.getElementsByTagName('td')[5]);

    const totalPriceCell = document.createElement('td');
    totalPriceCell.innerText = calculateTotalPrice(newRow);
    newRow.appendChild(totalPriceCell);

    const deleteCell = document.createElement('td');
    deleteCell.innerHTML = '<button class="btn btn-danger" onclick="deleteRow(this)">Xóa</button>';
    newRow.appendChild(deleteCell);

    selectedProductTable.appendChild(newRow);

    addHiddenInputs(newRow, productId);
    updateTotalPrice();
}


function addHiddenInputs(row, productId) {
    const form = document.querySelector('form');
    const productName = row.getElementsByTagName('td')[0].innerText;
    const price = row.getElementsByTagName('td')[3].innerText.replace(/,/g, '');
    const quantity = row.getElementsByTagName('input')[0].value; // Correctly fetch the input value for quantity
    const supplier = row.getElementsByTagName('td')[4].innerText;
    const unit = row.getElementsByTagName('td')[6].innerText;


    // Add hidden inputs for each selected product
    form.innerHTML += `<input type="hidden" name="products[${productId}][name]" value="${productName}" />`;
    form.innerHTML += `<input type="hidden" name="${productId}_price" value="${price}" />`;
    form.innerHTML += `<input type="hidden" name="${productId}_quantity" value="${quantity}" class="quantity-input"/>`;
    form.innerHTML += `<input type="hidden" name="${productId}_supplier" value="${supplier}" />`;
    form.innerHTML += `<input type="hidden" name="${productId}_unit" value="${unit}" />`;
}


function deleteRow(button) {
    const row = button.closest('tr');
    const productId = row.getElementsByTagName('td')[1].innerText;
    row.parentNode.removeChild(row);

    // Remove hidden inputs from the form
    const form = document.querySelector('form');
    form.querySelectorAll(`input[name^="products[${productId}]"]`).forEach(input => input.remove());

    // Update total price
    updateTotalPrice();
}

function calculateTotalPrice(row) {
    const price = parseFloat(row.getElementsByTagName('td')[3].innerText.replace(/,/g, ''));
    const quantity = row.getElementsByTagName('td')[5].getElementsByTagName('input')[0].value;
    return (price * quantity);
}

function updateTotalPrice(inputElement) {
    if (inputElement) {
        const row = inputElement.closest('tr');
        const productId = row.getElementsByTagName('td')[1].innerText;
        row.getElementsByTagName('td')[7].innerText = calculateTotalPrice(row);

        // Update hidden input for quantity
        const form = document.querySelector('form');
        const hiddenQuantityInput = form.querySelector(`input[name="${productId}_quantity"]`);
        if (hiddenQuantityInput) {
            hiddenQuantityInput.value = inputElement.value;
        }
    }

    const selectedProductTable = document.getElementById('selectedProductTable').getElementsByTagName('tbody')[0];
    let totalPrice = 0;

    for (let i = 0; i < selectedProductTable.rows.length; i++) {
        const row = selectedProductTable.rows[i];
        const priceText = row.getElementsByTagName('td')[7].innerText.replace(/,/g, '');
        totalPrice += parseFloat(priceText.replace(' VND', ''));
    }

    document.getElementById('totalPrice').innerText = totalPrice.toLocaleString('vi-VN') + ' VND';
}

// Function to preview uploaded images
function previewImages(input, previewContainerId) {
    const previewContainer = document.getElementById(previewContainerId);
    previewContainer.innerHTML = ''; // Clear previous images

    if (input.files) {
        Array.from(input.files).forEach(file => {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '200px';
                img.style.margin = '10px';
                previewContainer.appendChild(img);
            }
            reader.readAsDataURL(file);
        });
    }
}


document.getElementById('evidenceUpload').addEventListener('change', function() {
    previewImages(this, 'evidencePreview');
});
