package com.example.qlkh.Servlet.Filter;

import com.example.qlkh.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Logger;

@WebFilter(value = "/*")
public class AccessControlFilter implements Filter {

    private static final Logger LOGGER = Logger.getLogger(AccessControlFilter.class.getName());

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        String url = req.getRequestURI();
        User user = (User) session.getAttribute("account");

        // Check if the user is logged in
        if (user == null ) {
            // User is not logged in
            LOGGER.info("User not logged in, URL: " + url);
            if (isProtectedUrl(url)) {
                LOGGER.info("Redirecting to index.jsp");
                res.sendRedirect("index.jsp");
                return;
            }
        } else {
            // User is logged in
            int roleId = user.getRoleId();
            LOGGER.info("User logged in with role ID: " + roleId + ", URL: " + url);
            if (roleId == 0) {
                LOGGER.info("Role ID 0 detected, redirecting to index.jsp with error message");
                session.invalidate(); // Invalidate the session
                req.setAttribute("error", "Tài khoản đã bị cấm vui lòng liên hệ với quản trị viên.");
                req.getRequestDispatcher("index.jsp").forward(req, res);
                return;

            }

            if (!hasAccess(roleId, url)) {
                LOGGER.info("User does not have access to URL: " + url + ", Redirecting to /generanity");
                res.sendRedirect(req.getContextPath() + "/generanity");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private boolean isProtectedUrl(String url) {
        return url.contains("/RevenueReportServlet")
                || url.contains("/inventory")
                || url.contains("/ListUserServlet")
                || url.contains("/CreateUserServlet")
                || url.contains("/UpdateUserServlet")
                || url.contains("/supplier")
                || url.contains("/AddSupplierServlet")
                || url.contains("/UpdateSupplierServlet")
                || url.contains("/importServlet")
                || url.contains("/listImport")
                || url.contains("/repayment")
                || url.contains("/listRepayment")
                || url.contains("detailImport");

    }

    private boolean hasAccess(int roleId, String url) {
        switch (roleId) {
            case 1:
                // Admin has access to everything
                return true;

            case 2:
                // Role 2 has access to everything except RevenueReportServlet
                return !url.contains("RevenueReportServlet")
                        && !url.contains("/repayment")
                        && !url.contains("/listRepayment");

            case 3:
                // Role 3 is restricted from several URLs including product-category add/edit
                return !isProtectedUrl(url);

            default:
                // Default case: No access to protected URLs
                return !isProtectedUrl(url);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code, if needed
    }
}
