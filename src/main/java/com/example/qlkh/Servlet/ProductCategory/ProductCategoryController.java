package com.example.qlkh.Servlet.ProductCategory;

import com.example.qlkh.DAO.*;
import com.example.qlkh.Servlet.uploads.Upload;
import com.example.qlkh.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Set;
import java.util.function.Supplier;

@WebServlet(name = "ProductCategoryController", urlPatterns = {"/product-category"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50)   // 50 MB
public class ProductCategoryController extends HttpServlet {

    private static final String STATIC_UPLOAD_DIRECTORY = "./uploads/";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        Integer userRole = user.getRoleId();

        ProductDao productDao = new ProductDao();
        WareHouseDAO wareDao = new WareHouseDAO();
        SupplierDAO supplierDAO = new SupplierDAO();
        ProducerDAO producerDAO = new ProducerDAO();

        CarDAO carDao = new CarDAO();
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "add":
                if (userRole == 3) {
                    response.sendRedirect("/generanity"); // Redirect đến trang không được phép
                    return;
                }

                List<Car> cars = carDao.getAllCar();
                List<WareHouse> waresAdd = wareDao.getAllWarehouses();
                List<Suppliers> suppliers = supplierDAO.getAllSupplier();
                List<producers> producers = producerDAO.getAllProducer();
                request.setAttribute("producers", producers);
                request.setAttribute("cars", cars);
                request.setAttribute("wares", waresAdd);
                request.setAttribute("suppliers", suppliers);
                request.getRequestDispatcher("./productCategory/addProduct.jsp").forward(request, response);
                break;
            case "inventory":
                List<WareHouse> waresI = wareDao.getAllWarehouses();
                List<Suppliers> suppliersViewI = supplierDAO.getAllSupplier();
                request.setAttribute("suppliers", suppliersViewI);
                request.setAttribute("wares", waresI);
                String inventory = request.getParameter("sort");
                inventory = inventory != null ? inventory : "";
                List<product> productsSortInventory = productDao.listAllProductsSortInventory(inventory);
                request.setAttribute("inventory", inventory);
                request.setAttribute("products", productsSortInventory);
                request.getRequestDispatcher("./productCategory/productCategory.jsp").forward(request, response);
                break;
            case "edit":
                if (userRole == 3) {
                    response.sendRedirect("/generanity"); // Redirect đến trang không được phép
                    return;
                }
                try {
                    List<Car> carsEdit = carDao.getAllCar();
                    List<WareHouse> waresEdit = wareDao.getAllWarehouses();
                    int id = Integer.parseInt(request.getParameter("id"));
                    product productEdit = productDao.getProduct(id);
                    if (productEdit != null) {
                        List<Suppliers> supplierList = supplierDAO.getAllSupplier();
                        request.setAttribute("cars", carsEdit);
                        request.setAttribute("wares", waresEdit);
                        request.setAttribute("supplierList", supplierList);
                        request.setAttribute("product", productEdit);
                        request.getRequestDispatcher("./productCategory/editProductCategory.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("product-category?error=Can not found product");
                    }
                } catch (Exception e) {
                    System.out.println(e);
                    response.sendRedirect("product-category?error=Id product is not valid");
                }

                break;
            default:
                String search = request.getParameter("search");
                search = search != null ? search.trim().replaceAll("\\s++", " ") : "";
                String ware = request.getParameter("ware");
                String supplier = request.getParameter("supplier");
                int wareNumber = 0;
                int supplierNumber = 0;
                try {
                    wareNumber = Integer.parseInt(ware);
                } catch (Exception e) {
                    wareNumber = 0;
                }
                try {
                    supplierNumber = Integer.parseInt(supplier);
                } catch (Exception e) {
                    supplierNumber = 0;
                }
                String sort = request.getParameter("sort");
                sort = sort != null ? sort : "";
                List<product> products = productDao.listAllProducts(search, wareNumber, supplierNumber, sort);
                List<WareHouse> wares = wareDao.getAllWarehouses();
                List<Suppliers> suppliersView = supplierDAO.getAllSupplier();
                request.setAttribute("search", search);
                request.setAttribute("suppliers", suppliersView);
                request.setAttribute("supplier", supplier);
                request.setAttribute("ware", ware);
                request.setAttribute("sort", sort);
                request.setAttribute("wares", wares);
                request.setAttribute("products", products);
                System.out.println(products.size());
                request.getRequestDispatcher("./productCategory/productCategory.jsp").forward(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "edit":
                this.edit(request, response);
                break;
            case "add":
                try {
                    this.addProduct(request, response);
                } catch (Exception e) {
                    response.sendRedirect("product-category?error=Data is not valid");
                }
                break;
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            ProductDao productDao = new ProductDao();
            Upload upload = new Upload();
            String productName = request.getParameter("productName");
            String carId = request.getParameter("carId");
            String unit = request.getParameter("unit");
            String supplierId = request.getParameter("supplierId");
            String importPriceStr = request.getParameter("importPrice");
            String salesPriceStr = request.getParameter("salesPrice");
            String producerStr = request.getParameter("producerId");
            Part mainImgParth = request.getPart("img");
            String productCode = request.getParameter("productCode");
            String desc = request.getParameter("desc");
            String pathProduct = "./product_image/";
            String uploadPath = getServletContext().getRealPath(pathProduct);

            // Tạo thư mục upload nếu chưa tồn tại
            File dynamicUploadDirFile = new File(uploadPath);
            if (!dynamicUploadDirFile.exists()) {
                dynamicUploadDirFile.mkdir();
            }

            // Upload ảnh và lấy tên ảnh đã lưu
            String nameImg = upload.uploadImg(mainImgParth, uploadPath);
            String imageSaveDb = pathProduct + nameImg;

            // Lưu vào thư mục tĩnh
            File staticUploadDirFile = new File(STATIC_UPLOAD_DIRECTORY);
            if (!staticUploadDirFile.exists()) {
                staticUploadDirFile.mkdirs();
            }
            String staticFilePath = STATIC_UPLOAD_DIRECTORY + File.separator + nameImg;

            // Sao chép file từ thư mục tạm đến thư mục tĩnh
            Path dynamicFilePath = Paths.get(uploadPath + File.separator + nameImg);
            Path staticFilePathPath = Paths.get(staticFilePath);
            Files.copy(dynamicFilePath, staticFilePathPath, StandardCopyOption.REPLACE_EXISTING);
            String errorMessage = null;
            int inventory = 0;
            if (productCode == null || productCode.trim().equals("")) {
                errorMessage = "Mã sản phẩm không được để trống.";
            } else if (productDao.getProductByCode(0, productCode) != null) {
                errorMessage = "Mã sản phẩm đã tồn tại.";
            } else if (nameImg == null) {
                errorMessage = "Hình ảnh sản phẩm là bắt buộc.";
            } else if (productName == null || productName.trim().equals("")) {
                errorMessage = "Tên sản phẩm là bắt buộc.";
            } else if (carId == null || carId.trim().equals("")) {
                errorMessage = "Loại xe phải được điền.";
            } else if (unit == null || unit.trim().equals("")) {
                errorMessage = "Đơn vị là bắt buộc.";
            } else if (producerStr == null || producerStr.trim().equals("")) {
                errorMessage = "Nhà sản xuất là bắt buộc.";
            } else if (supplierId == null || supplierId.trim().equals("")) {
                errorMessage = "Nhà cung cấp là bắt buộc.";
            } else if (importPriceStr == null || importPriceStr.isEmpty()) {
                errorMessage = "Giá nhập khẩu phải là một số hợp lệ.";
            } else if (Double.parseDouble(importPriceStr) <= 0) {
                errorMessage = "Giá nhập khẩu phải lớn hơn 0.";
            } else if (salesPriceStr == null || salesPriceStr.isEmpty()) {
                errorMessage = "Giá bán phải là một con số hợp lệ.";
            } else if (Double.parseDouble(salesPriceStr) <= 0) {
                errorMessage = "Giá bán phải lớn hơn 0.";
            } else if (Double.parseDouble(salesPriceStr) <= Double.parseDouble(importPriceStr)) {
                errorMessage = "Giá bán phải lớn hơn hoặc bằng giá nhập.";
            }

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                doGet(request, response);
            } else {
                double importPrice = Double.parseDouble(importPriceStr);
                double salesPrice = Double.parseDouble(salesPriceStr);

                product product = new product();
                product.setInventory(inventory);
                product.setProduct_name(productName);
                Car car = new Car();
                car.setCarId(Integer.parseInt(carId));
                product.setCar_id(car);
                product.setProducer(Integer.parseInt(producerStr));
                product.setUnit(unit);
                Suppliers sup = new Suppliers();
                sup.setSupplierId(Integer.parseInt(supplierId));
                product.setSupplier_id(sup);
                product.setImport_price(importPrice);
                product.setSale_price(salesPrice);
                product.setImage_Link(imageSaveDb);
                product.setDesc(desc);
                product.setProductCode(productCode);

                boolean result = productDao.addProduct(product);
                if (result) {
                    String message = "Thêm sản phẩm thành công";
                    String encodedMessage = URLEncoder.encode(message, "UTF-8");
                    response.sendRedirect("product-category?success=" + encodedMessage);
                } else {
                    request.setAttribute("errorMessage", "Thêm thất bại mới!");
                    doGet(request, response);
                }
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Sản phẩm dữ liệu không hợp lệ");
            doGet(request, response);
            System.out.println("Add new: " + e);
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int pId = Integer.parseInt(request.getParameter("pId"));
        try {
            Upload upload = new Upload();
            SupplierDAO supplierDAO = new SupplierDAO();
            ProductDao productDao = new ProductDao();
            WareHouseDAO wareDao = new WareHouseDAO();
            CarDAO carDao = new CarDAO();
            String productName = request.getParameter("productName");
            String productCode = request.getParameter("productCode");
            String desc = request.getParameter("desc");
            String carId = request.getParameter("carId");
            String unit = request.getParameter("unit");
            String warehouseId = request.getParameter("warehouseId");
            double importPrice = Double.parseDouble(request.getParameter("importPrice"));
            double salesPrice = Double.parseDouble(request.getParameter("salesPrice"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            String name = request.getParameter("productName");
            Part mainImgParth = request.getPart("img");
            String pathProduct = "./uploads/";
            String uploadPath = getServletContext().getRealPath(pathProduct);

            // Tạo thư mục upload nếu chưa tồn tại
            File dynamicUploadDirFile = new File(uploadPath);
            if (!dynamicUploadDirFile.exists()) {
                dynamicUploadDirFile.mkdir();
            }

            // Upload ảnh và lấy tên ảnh đã lưu
            String nameImg = upload.uploadImg(mainImgParth, uploadPath);
            String nameSaveDb = pathProduct + nameImg;

            // Lưu vào thư mục tĩnh
            File staticUploadDirFile = new File(STATIC_UPLOAD_DIRECTORY);
            if (!staticUploadDirFile.exists()) {
                staticUploadDirFile.mkdirs();
            }
            String staticFilePath = STATIC_UPLOAD_DIRECTORY + File.separator + nameImg;

            // Sao chép file từ thư mục tạm đến thư mục tĩnh
            if (nameImg == null) {
                nameSaveDb = request.getParameter("oldImage");
            } else {
                Path dynamicFilePath = Paths.get(uploadPath + File.separator + nameImg);
                Path staticFilePathPath = Paths.get(staticFilePath);
                Files.copy(dynamicFilePath, staticFilePathPath, StandardCopyOption.REPLACE_EXISTING);
            }
            product productEdit = productDao.getProduct(pId);
            if (productEdit == null) {
                response.sendRedirect("product-category?error=Can not found product");
                return;
            }
            String errorMessage = null;
            if (productName == null || productName.trim().equals("")) {
                errorMessage = "Tên sản phẩm là bắt buộc.";
            }

            if (productCode == null || productCode.trim().equals("")) {
                errorMessage = "Mã sản phẩm không được để trống.";
            }
            if (productDao.getProductByCode(pId, productCode) != null) {
                errorMessage = "Mã sản phẩm đã tồn tại.";
            } else if (salesPrice <= importPrice) {
                errorMessage = "Giá bán phải lớn hơn giá nhập khẩu.";
            }

            if (unit == null || unit.trim().equals("")) {
                errorMessage = "Đơn vị là bắt buộc.";
            }

            if (productCode == null || productCode.trim().equals("")) {
                errorMessage = "Mã hàng là bắt buộc.";
            }
            if (errorMessage != null) {
                List<Suppliers> supplierList = supplierDAO.getAllSupplier();
                List<Car> carsEdit = carDao.getAllCar();
                List<WareHouse> waresEdit = wareDao.getAllWarehouses();
                request.setAttribute("cars", carsEdit);
                request.setAttribute("wares", waresEdit);
                request.setAttribute("supplierList", supplierList);
                request.setAttribute("product", productEdit);
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("./productCategory/editProductCategory.jsp").forward(request, response);
                return;
            }
            if (pId <= 0 || importPrice <= 0 || salesPrice <= 0 || supplierId <= 0) {
                List<Suppliers> supplierList = supplierDAO.getAllSupplier();
                request.setAttribute("supplierList", supplierList);
                request.setAttribute("product", productEdit);
                request.setAttribute("errorMessage", "Tất cả các giá trị phải lớn hơn 0.");
                request.getRequestDispatcher("./productCategory/editProductCategory.jsp").forward(request, response);
                return;
            }

            product p = productDao.getProduct(pId);
            p.setImport_price(importPrice);
            p.setProduct_name(productName);
            p.setUnit(unit);
            Car car = new Car();
            car.setCarId(Integer.parseInt(carId));
            p.setCar_id(car);
            p.setSale_price(salesPrice);
            Suppliers sup = new Suppliers();
            sup.setSupplierId(supplierId);
            p.setSupplier_id(sup);
            p.setP_id(pId);
            p.setImage_Link(nameSaveDb);
            p.setDesc(desc);
            p.setProductCode(productCode);

//            PrintWriter out = response.getWriter();
//            out.println(pId + " " + importPrice + " " + salesPrice + " " + supplierId);
            int result = productDao.editProduct(p);

            if (result > 0) {
                String message = "Chỉnh sửa sản phẩm thành công";
                String encodedMessage = URLEncoder.encode(message, "UTF-8");
                response.sendRedirect("product-category?success=" + encodedMessage);

            } else {
                List<Suppliers> supplierList = supplierDAO.getAllSupplier();
                List<Car> carsEdit = carDao.getAllCar();
                List<WareHouse> waresEdit = wareDao.getAllWarehouses();
                request.setAttribute("cars", carsEdit);
                request.setAttribute("wares", waresEdit);
                request.setAttribute("supplierList", supplierList);
                request.setAttribute("product", productEdit);
                request.setAttribute("errorMessage", "Chỉnh sửa thất bại.");
                request.getRequestDispatcher("./productCategory/editProductCategory.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("product-category?action=edit&id=" + pId + "&error=" + URLEncoder.encode("Sản phẩm dữ liệu không hợp lệ!", "UTF-8"));
            System.out.println("Edit fail: " + e);
        }
    }
}
