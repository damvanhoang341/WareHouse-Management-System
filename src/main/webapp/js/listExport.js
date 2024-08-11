document.addEventListener('DOMContentLoaded', function() {
    const data = [
        { stt: 1, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp A', giaTri: '50.000.000', thoiGian: '13/11/2022 15:30', tinhTrang: 'Chờ duyệt' },
        { stt: 2, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp B', giaTri: '50.000.000', thoiGian: '13/11/2022 11:00', tinhTrang: 'Đã xuất' },
        { stt: 3, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp C', giaTri: '50.000.000', thoiGian: '12/11/2022 14:30', tinhTrang: 'Chờ duyệt' },
        { stt: 4, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp D', giaTri: '50.000.000', thoiGian: '12/11/2022 12:00', tinhTrang: 'Từ chối' },
        { stt: 5, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp E', giaTri: '50.000.000', thoiGian: '11/11/2022 08:30', tinhTrang: 'Đã xuất' },
        { stt: 6, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp F', giaTri: '50.000.000', thoiGian: '10/11/2022 08:00', tinhTrang: 'Từ chối' },
        { stt: 7, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp A', giaTri: '50.000.000', thoiGian: '09/11/2022 08:30', tinhTrang: 'Đã xuất' },
        { stt: 8, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp B', giaTri: '50.000.000', thoiGian: '09/11/2022 08:00', tinhTrang: 'Đã xuất' },
        { stt: 9, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp C', giaTri: '50.000.000', thoiGian: '09/11/2022 07:30', tinhTrang: 'Từ chối' },
        { stt: 10, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp D', giaTri: '50.000.000', thoiGian: '08/11/2022 15:00', tinhTrang: 'Đã xuất' },
        { stt: 11, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp E', giaTri: '50.000.000', thoiGian: '08/11/2022 09:00', tinhTrang: 'Đã xuất' },
        { stt: 12, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp F', giaTri: '50.000.000', thoiGian: '08/11/2022 08:30', tinhTrang: 'Hoàn hàng' },
        { stt: 13, maPhieu: 'XXXXXX', nguonNhan: 'Nhà cung cấp A', giaTri: '50.000.000', thoiGian: '08/11/2022 08:00', tinhTrang: 'Đã xuất' },
    ];

    const tbody = document.querySelector('table tbody');

    data.forEach(item => {
        const row = document.createElement('tr');

        row.innerHTML = `
            <td>${item.stt}</td>
            <td>${item.maPhieu}</td>
            <td>${item.nguonNhan}</td>
            <td>${item.giaTri}</td>
            <td>${item.thoiGian}</td>
            <td class="status-${item.tinhTrang.toLowerCase().replace(' ', '')}">${item.tinhTrang}</td>
            <td class="actions">
                <button class="edit">✎</button>
                <button class="delete">🗑</button>
            </td>
        `;

        tbody.appendChild(row);
    });
});
