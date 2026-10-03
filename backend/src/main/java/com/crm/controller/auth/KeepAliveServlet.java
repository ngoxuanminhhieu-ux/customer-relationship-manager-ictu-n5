package com.crm.controller.auth;

import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * SCRUM-33 AC 1: Phiên được gia hạn tự động khi còn hoạt động.
 * Endpoint để client gửi heartbeat gia hạn phiên làm việc khi người dùng tương tác.
 */
@WebServlet({"/api/auth/keepalive", "/api/auth/renew"})
public class KeepAliveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Gson GSON = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());

        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("userId") == null && session.getAttribute("currentUser") == null)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            GSON.toJson(new KeepAliveResponse(false, "Phiên đăng nhập đã hết hạn", 0L), response.getWriter());
            return;
        }

        // Accessing session automatically updates lastAccessedTime in Servlet container
        long now = System.currentTimeMillis();
        session.setAttribute("lastActiveAt", now);

        response.setStatus(HttpServletResponse.SC_OK);
        GSON.toJson(new KeepAliveResponse(true, "Phiên đăng nhập được gia hạn tự động", now), response.getWriter());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    private record KeepAliveResponse(boolean success, String message, long timestamp) { }
}
