<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đăng nhập CRM | CRM ICTU</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shared/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shared/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth/auth.css" />
    <style>
        .test-accounts-section {
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px dashed #cbd5e1;
        }
        .test-accounts-title {
            font-size: 0.85rem;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .test-account-pill {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 12px;
            margin-bottom: 8px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.82rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .test-account-pill:hover {
            background: #eff6ff;
            border-color: #93c5fd;
            transform: translateX(2px);
        }
        .test-account-role {
            font-weight: 600;
            color: #1e40af;
        }
        .test-account-target {
            font-size: 0.75rem;
            color: #64748b;
            background: #e2e8f0;
            padding: 2px 6px;
            border-radius: 4px;
        }
        .lockout-badge {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 0.82rem;
            margin-top: 12px;
            display: flex;
            align-items: flex-start;
            gap: 8px;
        }
        .btn-simulate-fail {
            width: 100%;
            background: #f1f5f9;
            border: 1px solid #cbd5e1;
            color: #475569;
            font-size: 0.8rem;
            padding: 6px 10px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 8px;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-simulate-fail:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
    </style>
</head>
<body class="auth-page">
    <main class="auth-shell">
        <section class="auth-card" aria-labelledby="login-title">
            <div class="auth-brand" aria-label="Thương hiệu CRM">
                <div class="brand-mark">CRM</div>
                <span class="brand-name">CRM ICTU</span>
            </div>

            <header class="auth-header">
                <h1 id="login-title">Đăng nhập CRM</h1>
                <p>Truy cập không gian quản trị người dùng và khách hàng tập trung.</p>
            </header>

            <form class="auth-form" method="post" action="${pageContext.request.contextPath}/login" id="loginForm">
                <% if (request.getAttribute("csrfToken") != null) { %>
                    <input type="hidden" name="csrfToken" value="<%= request.getAttribute("csrfToken") %>">
                <% } %>
                <div class="field-group crm-form-group">
                    <label for="email">Email công ty</label>
                    <input class="crm-input"
                        id="email"
                        type="email"
                        name="email"
                        value="${requestScope.email != null ? requestScope.email : (param.email != null ? param.email : '')}"
                        placeholder="name@crm.ictu.vn"
                        required
                        autocomplete="email"
                    />
                </div>

                <div class="field-group crm-form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="password-field">
                        <input class="crm-input"
                            id="password"
                            type="password"
                            name="password"
                            placeholder="••••••••"
                            required
                            autocomplete="current-password"
                        />
                        <button type="button" class="password-toggle" id="passwordToggle" aria-label="Hiện mật khẩu">Hiện</button>
                    </div>
                </div>

                <div class="auth-actions">
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="auth-button crm-btn crm-btn-primary" id="btnLoginSubmit">Đăng nhập</button>

                <div class="auth-message ${empty requestScope.error ? 'auth-message--empty' : 'auth-error'}" id="loginErrorMessage" role="alert">
                    ${requestScope.error}
                </div>
            </form>

            <!-- Khối thông tin kiểm thử theo Jira SCRUM-6 -->
            <div class="test-accounts-section">
                <div class="test-accounts-title">
                    <span>Tài khoản kiểm thử (SCRUM-6)</span>
                    <span style="font-size: 0.72rem; color: #64748b; font-weight: normal;">Nhấp để điền nhanh</span>
                </div>

                <div class="test-account-pill" onclick="fillAccount('admin@crm.ictu.vn', 'Admin@123')" title="Vai trò Admin: Vào trang Tổng quan Quản trị">
                    <div>
                        <span class="test-account-role">👑 Admin:</span> admin@crm.ictu.vn
                    </div>
                    <span class="test-account-target">→ /dashboard</span>
                </div>

                <div class="test-account-pill" onclick="fillAccount('bich.tt@crm.ictu.vn', 'Bich@12345')" title="Vai trò Sales Rep: Vào Danh mục khách hàng">
                    <div>
                        <span class="test-account-role">💼 Sales Rep:</span> bich.tt@crm.ictu.vn
                    </div>
                    <span class="test-account-target">→ /customers</span>
                </div>

                <div class="test-account-pill" onclick="fillAccount('an.nv@crm.ictu.vn', 'An@12345')" title="Vai trò Team Lead: Vào Tổng quan đội nhóm">
                    <div>
                        <span class="test-account-role">📊 Team Lead:</span> an.nv@crm.ictu.vn
                    </div>
                    <span class="test-account-target">→ /dashboard</span>
                </div>

                <div class="test-account-pill" onclick="fillAccount('mai.pt@crm.ictu.vn', 'Mai@12345')" title="Vai trò Accountant: Vào Sản phẩm & Báo giá">
                    <div>
                        <span class="test-account-role">📋 Kế toán:</span> mai.pt@crm.ictu.vn
                    </div>
                    <span class="test-account-target">→ /products</span>
                </div>

                <button type="button" class="btn-simulate-fail" onclick="simulateWrongPassword()" title="Tự động điền email và mật khẩu sai để kiểm tra thông báo và khóa tạm 15 phút sau 5 lần">
                    ⚡ Thử nhập sai mật khẩu (Kiểm tra khóa 15 phút)
                </button>
            </div>
        </section>
    </main>
    <script>
        (function () {
            var input = document.getElementById('password');
            var toggle = document.getElementById('passwordToggle');
            if (toggle && input) {
                toggle.addEventListener('click', function () {
                    var showing = input.type === 'text';
                    input.type = showing ? 'password' : 'text';
                    toggle.textContent = showing ? 'Hiện' : 'Ẩn';
                    toggle.setAttribute('aria-label', showing ? 'Hiện mật khẩu' : 'Ẩn mật khẩu');
                });
            }
        }());

        function fillAccount(email, pass) {
            document.getElementById('email').value = email;
            document.getElementById('password').value = pass;
            var err = document.getElementById('loginErrorMessage');
            if (err) {
                err.textContent = '';
                err.className = 'auth-message auth-message--empty';
            }
        }

        function simulateWrongPassword() {
            var emailInput = document.getElementById('email');
            if (!emailInput.value) {
                emailInput.value = 'bich.tt@crm.ictu.vn';
            }
            document.getElementById('password').value = 'SaiMatKhau_' + Math.floor(Math.random() * 1000);
            document.getElementById('loginForm').submit();
        }
    </script>
</body>
</html>
