<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh mục khách hàng - CRM ICTU</title>

    <!-- CSS dùng chung của hệ thống CRM -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shared/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shared/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shared/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shared/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shared/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/users/users.css">
    <style>
        .cust-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }
        .cust-stat-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .cust-stat-info h3 {
            font-size: 0.85rem;
            color: #64748b;
            margin: 0 0 6px 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .cust-stat-info .stat-value {
            font-size: 1.6rem;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
        }
        .cust-stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }
        .badge-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 0.78rem;
            font-weight: 600;
        }
        .badge-lead { background: #e0f2fe; color: #0369a1; }
        .badge-active { background: #dcfce7; color: #15803d; }
        .badge-negotiating { background: #fef3c7; color: #b45309; }
        .badge-churned { background: #fee2e2; color: #b91c1c; }
        .cust-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.85rem;
            margin-right: 10px;
        }
        .customer-meta {
            display: inline-flex;
            align-items: center;
        }
        .customer-names strong {
            display: block;
            color: #1e293b;
            font-size: 0.92rem;
        }
        .customer-names small {
            color: #64748b;
            font-size: 0.8rem;
        }
    </style>
</head>
<body class="crm-body">

    <!-- Header dùng chung của hệ thống -->
    <jsp:include page="/jsp/shared/header.jsp" />

    <div class="crm-main-layout">
        <!-- Sidebar dùng chung của hệ thống -->
        <jsp:include page="/jsp/shared/sidebar.jsp" />

        <!-- Khu vực nội dung chính của màn hình Khách hàng -->
        <main class="user-page crm-page" id="customerApp" role="main">
            <div class="user-container crm-page-container">

                <!-- Breadcrumb điều hướng -->
                <nav class="user-breadcrumb crm-breadcrumb" aria-label="Đường dẫn trang">
                    <a href="${pageContext.request.contextPath}/">CRM</a>
                    <span class="separator">/</span>
                    <span>Kinh doanh</span>
                    <span class="separator">/</span>
                    <span class="active">Danh mục khách hàng</span>
                </nav>

                <!-- Header màn hình -->
                <header class="user-header crm-page-header">
                    <div class="user-header-info">
                        <h1 class="crm-page-title">Danh mục khách hàng</h1>
                        <p class="crm-page-description">Quản lý toàn bộ thông tin khách hàng, cơ hội kinh doanh và lịch sử tương tác theo phân quyền vai trò.</p>
                    </div>
                    <div class="user-header-actions">
                        <button type="button" class="crm-btn crm-btn-primary" id="btnOpenAddCustomerModal">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <line x1="12" y1="5" x2="12" y2="19"></line>
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                            </svg>
                            Thêm khách hàng
                        </button>
                    </div>
                </header>

                <!-- Thống kê sơ bộ -->
                <div class="cust-stats">
                    <div class="cust-stat-card">
                        <div class="cust-stat-info">
                            <h3>Tổng khách hàng</h3>
                            <div class="stat-value" id="statTotalCustomers">24</div>
                        </div>
                        <div class="cust-stat-icon" style="background: #eff6ff; color: #2563eb;">
                            👥
                        </div>
                    </div>
                    <div class="cust-stat-card">
                        <div class="cust-stat-info">
                            <h3>Cơ hội tiềm năng</h3>
                            <div class="stat-value" id="statLeadCustomers">9</div>
                        </div>
                        <div class="cust-stat-icon" style="background: #f0fdf4; color: #16a34a;">
                            🎯
                        </div>
                    </div>
                    <div class="cust-stat-card">
                        <div class="cust-stat-info">
                            <h3>Đang đàm phán</h3>
                            <div class="stat-value" id="statNegotiatingCustomers">7</div>
                        </div>
                        <div class="cust-stat-icon" style="background: #fffbeb; color: #d97706;">
                            🤝
                        </div>
                    </div>
                    <div class="cust-stat-card">
                        <div class="cust-stat-info">
                            <h3>Doanh số dự kiến</h3>
                            <div class="stat-value" id="statTotalValue">450.000.000 đ</div>
                        </div>
                        <div class="cust-stat-icon" style="background: #faf5ff; color: #9333ea;">
                            💰
                        </div>
                    </div>
                </div>

                <!-- Thẻ Card danh sách khách hàng -->
                <section class="user-card crm-card" aria-labelledby="customerCardTitle">
                    <div class="user-card-header">
                        <div>
                            <h2 id="customerCardTitle" class="user-card-title crm-card-title">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="9" cy="7" r="4"></circle>
                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                </svg>
                                Danh sách khách hàng được phân công
                            </h2>
                            <p class="user-card-subtitle">Hiển thị các khách hàng thuộc phạm vi quản lý của vai trò hiện tại</p>
                        </div>
                    </div>

                    <!-- Filter Toolbar -->
                    <div class="user-toolbar">
                        <div class="user-search-box">
                            <svg class="search-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                            </svg>
                            <input type="search" id="customerSearchInput" class="crm-input" placeholder="Tìm theo tên, email, công ty hoặc SĐT..." aria-label="Tìm kiếm khách hàng">
                        </div>

                        <div class="user-filter-group">
                            <select id="statusFilter" class="crm-select" aria-label="Lọc theo trạng thái">
                                <option value="">Tất cả trạng thái</option>
                                <option value="LEAD">Tiềm năng (Lead)</option>
                                <option value="NEGOTIATING">Đang đàm phán</option>
                                <option value="ACTIVE">Khách hàng chính thức</option>
                                <option value="CHURNED">Tạm ngưng</option>
                            </select>

                            <button type="button" class="crm-btn crm-btn-secondary" id="btnResetFilters">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                                    <path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path>
                                    <path d="M3 3v5h5"></path>
                                </svg>
                                Đặt lại
                            </button>
                        </div>
                    </div>

                    <!-- Bảng dữ liệu khách hàng -->
                    <div class="table-responsive">
                        <table class="crm-table" id="customerTable">
                            <thead>
                                <tr>
                                    <th>Mã KH</th>
                                    <th>Khách hàng</th>
                                    <th>Công ty / Tổ chức</th>
                                    <th>Số điện thoại</th>
                                    <th>Người phụ trách</th>
                                    <th>Doanh số tiềm năng</th>
                                    <th>Trạng thái</th>
                                    <th style="text-align: right;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="customerTableBody">
                                <!-- Data rendered via JavaScript -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Phân trang -->
                    <div class="user-pagination">
                        <div class="pagination-info" id="paginationInfo">
                            Hiển thị <span id="showingCount">1 - 6</span> trên tổng số <span id="totalCustomerCount">6</span> khách hàng
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>

    <!-- Client-side script for interactive customer listing -->
    <script>
        (function() {
            var customers = [
                { id: 1, code: 'KH-001', name: 'Nguyễn Tiến Dũng', email: 'tiendung@fpt.com.vn', phone: '0912 345 678', company: 'Công ty Cổ phần Công nghệ FPT', salesRep: 'Trần Thị Bích', value: 85000000, status: 'ACTIVE', statusText: 'Chính thức', statusClass: 'badge-active' },
                { id: 2, code: 'KH-002', name: 'Lê Hoàng Nam', email: 'namlh@viettel.com.vn', phone: '0988 765 432', company: 'Tập đoàn Công nghiệp - Viễn thông Viettel', salesRep: 'Trần Thị Bích', value: 120000000, status: 'NEGOTIATING', statusText: 'Đang đàm phán', statusClass: 'badge-negotiating' },
                { id: 3, code: 'KH-003', name: 'Vũ Thị Minh Hạnh', email: 'hanh.vu@vnpt.vn', phone: '0903 112 233', company: 'Tập đoàn Bưu chính Viễn thông VNPT', salesRep: 'Lê Hoàng Nam', value: 45000000, status: 'LEAD', statusText: 'Tiềm năng', statusClass: 'badge-lead' },
                { id: 4, code: 'KH-004', name: 'Phạm Quang Huy', email: 'huy.pq@techcombank.com.vn', phone: '0979 556 789', company: 'Ngân hàng TMCP Kỹ Thương Việt Nam', salesRep: 'Trần Thị Bích', value: 150000000, status: 'ACTIVE', statusText: 'Chính thức', statusClass: 'badge-active' },
                { id: 5, code: 'KH-005', name: 'Đỗ Thùy Trang', email: 'trang.do@shopee.vn', phone: '0945 998 877', company: 'Công ty TNHH Shopee Việt Nam', salesRep: 'Trần Thị Bích', value: 65000000, status: 'NEGOTIATING', statusText: 'Đang đàm phán', statusClass: 'badge-negotiating' },
                { id: 6, code: 'KH-006', name: 'Hoàng Minh Tuấn', email: 'tuan.hm@vng.com.vn', phone: '0933 445 566', company: 'Công ty Cổ phần VNG', salesRep: 'Lê Hoàng Nam', value: 30000000, status: 'LEAD', statusText: 'Tiềm năng', statusClass: 'badge-lead' }
            ];

            function formatCurrency(num) {
                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(num);
            }

            function renderTable() {
                var search = document.getElementById('customerSearchInput').value.toLowerCase().trim();
                var status = document.getElementById('statusFilter').value;

                var filtered = customers.filter(function(c) {
                    if (status && c.status !== status) return false;
                    if (search) {
                        return c.name.toLowerCase().includes(search) ||
                               c.email.toLowerCase().includes(search) ||
                               c.company.toLowerCase().includes(search) ||
                               c.phone.includes(search) ||
                               c.code.toLowerCase().includes(search);
                    }
                    return true;
                });

                var tbody = document.getElementById('customerTableBody');
                if (filtered.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; padding: 40px; color: #64748b;">Không tìm thấy khách hàng nào phù hợp với điều kiện tìm kiếm.</td></tr>';
                    document.getElementById('showingCount').textContent = '0';
                    document.getElementById('totalCustomerCount').textContent = '0';
                    return;
                }

                var html = '';
                filtered.forEach(function(c) {
                    var initials = c.name.split(' ').map(function(w) { return w[0]; }).slice(-2).join('').toUpperCase();
                    html += '<tr>' +
                        '<td><strong style="color: #2563eb;">' + c.code + '</strong></td>' +
                        '<td>' +
                            '<div class="customer-meta">' +
                                '<div class="cust-avatar">' + initials + '</div>' +
                                '<div class="customer-names">' +
                                    '<strong>' + c.name + '</strong>' +
                                    '<small>' + c.email + '</small>' +
                                '</div>' +
                            '</div>' +
                        '</td>' +
                        '<td>' + c.company + '</td>' +
                        '<td>' + c.phone + '</td>' +
                        '<td><span style="font-weight: 500; color: #334155;">' + c.salesRep + '</span></td>' +
                        '<td><strong style="color: #059669;">' + formatCurrency(c.value) + '</strong></td>' +
                        '<td><span class="badge-status ' + c.statusClass + '">' + c.statusText + '</span></td>' +
                        '<td style="text-align: right;">' +
                            '<button type="button" class="crm-btn crm-btn-secondary" style="padding: 4px 8px; font-size: 0.8rem;" onclick="alert(\'Xem chi tiết: ' + c.name + '\')">Chi tiết</button>' +
                        '</td>' +
                    '</tr>';
                });

                tbody.innerHTML = html;
                document.getElementById('showingCount').textContent = '1 - ' + filtered.length;
                document.getElementById('totalCustomerCount').textContent = String(filtered.length);
            }

            document.getElementById('customerSearchInput').addEventListener('input', renderTable);
            document.getElementById('statusFilter').addEventListener('change', renderTable);
            document.getElementById('btnResetFilters').addEventListener('click', function() {
                document.getElementById('customerSearchInput').value = '';
                document.getElementById('statusFilter').value = '';
                renderTable();
            });

            document.getElementById('btnOpenAddCustomerModal').addEventListener('click', function() {
                alert('Tính năng tạo mới khách hàng sẽ ghi nhận cơ hội cho nhân viên kinh doanh.');
            });

            renderTable();
        })();
    </script>
</body>
</html>
