package com.crm.controller.auth;

import com.crm.util.SessionRegistry;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * SCRUM-33 / CRM-22: Logout Servlet
 * Invalidate session immediately on server, clear registry, and redirect/respond.
 */
@WebServlet({"/api/auth/logout", "/logout"})
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Gson GSON = new GsonBuilder().serializeNulls().create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        invalidateSession(request);
        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        invalidateSession(request);

        if ("true".equalsIgnoreCase(request.getParameter("redirectToLogin")) || "/logout".equals(request.getServletPath())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setStatus(HttpServletResponse.SC_OK);
        GSON.toJson(new LogoutResponse(true, "Đăng xuất thành công", null), response.getWriter());
    }

    private void invalidateSession(HttpServletRequest request) {
        HttpSession session = null;
        try {
            session = request.getSession(false);
            if (session != null) {
                SessionRegistry.unregister(session);
                session.invalidate();
            }
        } catch (IllegalStateException ignored) {
            // Session may have already been invalidated concurrently
        }
    }

    private record LogoutResponse(boolean success, String message, Object data) { }
}
