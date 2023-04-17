<%! String title = "View Order"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp"%>
<!--Menu-->
<div class="sidebar-menu">
    <div class="sidebar-header">
        <div class="logo">
            <a href="">XXX</a>
        </div>
    </div>
    <div class="main-menu">
        <div class="menu-inner">
            <nav>
                <ul class="metismenu" id="menu">
                    <li class="active">
                        <a href="javascript:void(0)" aria-expanded="true"><span>Order</span></a>
                        <ul class="collapse">
                            <li class="active"><a href="">View Order</a></li>
                            <li><a href="">Create Order</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<!--Header-->
<div class="main-content">
    <div class="header-area">
        <div class="row align-items-center">
            <!--Nav Button-->
            <div class="col-md-6 col-sm-8 clearfix">
                <div class="nav-btn pull-left">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
                <!--Directory-->
                <h4 class="page-title pull-left">View Order</h4>
                <ul class="breadcrumbs pull-left">
                    <li><a href="">Order</a></li>
                    <li><span>View Order</span></li>
                </ul>
            </div>
            <!--User Profile-->
            <div class="col-md-6 col-sm-4 clearfix">
                <ul class="notification-area pull-right">
                    <ul class="user-profile pull-right">
                        <h4 class="user-name dropdown-toggle" data-bs-toggle="dropdown" id="username"><%-- name --%>
                            <i class="fa fa-angle-down"></i></h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="logout" id="logout">Log Out</a>
                        </div>
                    </ul>
                </ul>
            </div>
        </div>
    </div>

    <!--Main-->
    <div class="main-content-inner">
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Order List</h4>
                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer's Name</th>
                                    <th>Customer's Email</th>
                                    <th>Customer's Phone</th>
                                    <th>Staff ID</th>
                                    <th>Staff's Name</th>
                                    <th>Order Date & Time</th>
                                    <th>Delivery Address</th>
                                    <th>Delivery Date</th>
                                    <th>Total Price</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- show order item -->
<div class="modal fade" id="order-item" tabindex="-1" aria-labelledby="Order Item" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Order Item</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="single-table">
                    <div class="table-responsive">
                        <table class="table table-striped text-center" id="orderItems">
                            <thead class="text-uppercase">
                            <tr>
                                <th>Item ID</th>
                                <th>Item Name</th>
                                <th>Quantity</th>
                                <th>Total Price</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Edit delivery informationEdit delivery information -->
<div class="modal fade" id="edit-order" tabindex="-1" aria-labelledby="Order Item" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit delivery information</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editOrder" class="needs-validation" novalidate data-ss-orderid="000000">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="dAddress" class="col-form-label">Delivery Address
                            <span style="color: red">*</span></label>
                        <textarea class="form-control" id="dAddress" name="dAddress" required></textarea>
                        <div class="invalid-feedback">
                            Please fill in delivery address
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dDate" class="col-form-label">Delivery Date
                            <span style="color: red">*</span></label>
                        <input class="form-control" type="date" id="dDate" name="dDate" required>
                        <div class="invalid-feedback">
                            Please fill in delivery date
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <p class="mt-4"><span style="color: red">*</span> Required</p>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- load this page script -->
<script>
    const load_script = ["./assets/js/page/view-order.js"];
</script>
<%@ include file="function/footer.jsp"%>
