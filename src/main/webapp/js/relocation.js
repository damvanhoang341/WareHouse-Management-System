document.getElementById('select-all').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('input[name="selectedProduct"]');
    checkboxes.forEach(checkbox => checkbox.checked = this.checked);
});
