// Function to remove accents from a string
function removeAccents(str) {
    return str.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toUpperCase();
}

function searchProduct() {
    let input = document.getElementById('searchInput').value;
    let filter = removeAccents(input);

    let table = document.getElementById('productTable');
    let tr = table.getElementsByTagName('tr');
    let found = false;

    for (let i = 1; i < tr.length; i++) {
        let td = tr[i].getElementsByTagName('td')[0];
        if (td) {
            let txtValue = removeAccents(td.textContent || td.innerText);
            if (txtValue.indexOf(filter) > -1) {
                tr[i].style.display = '';
                found = true;
            } else {
                tr[i].style.display = 'none';
            }
        }
    }

    document.getElementById('noResultsMessage').style.display = found ? 'none' : 'block';
}

function selectProduct(row) {
    const table = document.getElementById('productTable');
    const productId = row.getElementsByTagName('td')[1].innerText;
    if (!table.contains(row)) {
        return;
    }
    const selectedProductTable = document.getElementById('selectedProductTable').getElementsByTagName('tbody')[0];

    // Check if the product already exists in the selected table
    for (let i = 0; i < selectedProductTable.rows.length; i++) {
        if (selectedProductTable.rows[i].getElementsByTagName('td')[1].innerText === productId) {
            alert('Sản phẩm đã tồn tại');
            return;
        }
    }

    // Clone the clicked row and modify it for the selected products table
    const newRow = row.cloneNode(true);
    const quantityCell = document.createElement('td');
    const maxQuantity = row.getElementsByTagName('td')[7].innerText; // Assuming the quantity is in the 8th cell
    quantityCell.innerHTML = `<input type="number" value="1" min="1" max="${maxQuantity}" class="form-control" oninput="updateRowTotal(this)"/>`;
    newRow.replaceChild(quantityCell, newRow.getElementsByTagName('td')[7]);

    const totalPriceCell = document.createElement('td');
    totalPriceCell.innerText = calculateRowTotal(newRow);
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
    const quantity = row.getElementsByTagName('input')[0].value;

    form.innerHTML += `<input type="hidden" name="products[${productId}][name]" value="${productName}" />`;
    form.innerHTML += `<input type="hidden" name="${productId}_price" value="${price}" />`;
    form.innerHTML += `<input type="hidden" name="${productId}_quantity" min="0" max="" value="${quantity}" class="quantity-input" />`;
}

function deleteRow(button) {
    const row = button.closest('tr');
    const productId = row.getElementsByTagName('td')[1].innerText;
    row.parentNode.removeChild(row);

    const form = document.querySelector('form');
    form.querySelectorAll(`input[name^="products[${productId}]"]`).forEach(input => input.remove());

    updateTotalPrice();
}

function updateRowTotal(input) {
    const row = input.closest('tr');
    const productId = row.getElementsByTagName('td')[1].innerText;
    const price = parseFloat(row.getElementsByTagName('td')[3].innerText.replace(/[^0-9.-]+/g, ""));
    const quantity = input.value;
    const maxQuantity = parseFloat(input.max);
    const totalCell = row.getElementsByTagName('td')[9];

    if (quantity > maxQuantity) {
        alert('Số lượng không được vượt quá số lượng tồn kho!');
        input.value = maxQuantity;
        totalCell.innerText = (price * maxQuantity).toLocaleString() + " VND";
    } else {
        totalCell.innerText = (price * quantity).toLocaleString() + " VND";
    }

    const form = document.querySelector('form');
    const hiddenQuantityInput = form.querySelector(`input[name="${productId}_quantity"]`);
    if (hiddenQuantityInput) {
        hiddenQuantityInput.value = input.value;
    }

    updateTotalPrice();
}


function calculateRowTotal(row) {
    const price = parseFloat(row.getElementsByTagName('td')[3].innerText.replace(/[^0-9.-]+/g, ""));
    const quantity = row.getElementsByTagName('td')[7].getElementsByTagName('input')[0].value;
    return price * quantity;
}

function updateTotalPrice() {
    const table = document.getElementById('selectedProductTable');
    const rows = table.getElementsByTagName('tbody')[0].rows;
    let totalPrice = 0;

    // Calculate the total price from all selected products
    for (let i = 0; i < rows.length; i++) {
        totalPrice += calculateRowTotal(rows[i]);
    }

    // Get the discount value
    const discount = parseFloat(document.getElementById('discount').value) || 0;
    const discountAmount = totalPrice * (discount / 100);
    const discountedTotalPrice = totalPrice - discountAmount;

    // Update the total price display
    document.getElementById('totalPrice').innerText = discountedTotalPrice.toLocaleString() + " VND";

    // Update the remaining debt display
    updateRemainingDebt();
}

function updateRemainingDebt() {
    const amountPaid = parseFloat(document.getElementById('amountPaid').value) || 0;
    const totalPrice = parseFloat(document.getElementById('totalPrice').innerText.replace(/[^0-9.-]+/g, ""));
    const remainingDebt = totalPrice - amountPaid;
    document.getElementById('remainingDebt').innerText = remainingDebt.toLocaleString() + " VND";
}

// Event listeners for discount and amount paid inputs
document.getElementById('discount').addEventListener('input', updateTotalPrice);
document.getElementById('amountPaid').addEventListener('input', updateRemainingDebt);
function previewImages(input, previewContainerId) {
    const previewContainer = document.getElementById(previewContainerId);
    previewContainer.innerHTML = '';

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



function updateInfo() {
    const select = document.getElementById("nameSelect");
    const phoneInput = document.getElementById("phone");
    const addressInput = document.getElementById("address");

    const selectedOption = select.options[select.selectedIndex];
    const customerId = select.value;

    if (customerId === "0") {
        alert("Hãy chọn khách hàng");
        phoneInput.value = "";
        addressInput.value = "";
        return;
    }

    const phone = selectedOption.getAttribute("data-phone");
    const address = selectedOption.getAttribute("data-address");

    phoneInput.value = phone || "";
    addressInput.value = address || "";
}

function validateForm() {
    const select = document.getElementById("nameSelect");
    const customerId = select.value;

    if (customerId === "0") {
        alert("Hãy chọn khách hàng");
        return false; // Prevent form submission
    }
    return true; // Allow form submission
}


