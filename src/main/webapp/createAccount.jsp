<%! String title = "Create Account"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Order">
        <sidebar:item href="viewOrder">View Order</sidebar:item>
        <sidebar:item href="createOrder">Create Order</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management" active="true">
        <sidebar:item href="viewAccount.jsp">View Account</sidebar:item>
        <sidebar:item href="createAccount.jsp" active="true">Create Account</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Operating Data">
        <sidebar:item href="analyticAndReport.jsp">Analytic/Report</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Account Management</a></li>
            <li><span>Create Account</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <form method="post" action="">
                        <div class="card-body">
                            <h4 class="header-title">Create Account</h4>
                            <div class="form-group">
                                <label for="createUsername" class="col-form-label">Username</label>
                                <input class="form-control" type="text" value="" id="createUsername">
                            </div>
                            <div class="form-group">
                                <label for="createEmail" class="col-form-label">Email</label>
                                <input class="form-control" type="email" value="" id="createEmail">
                            </div>
                            <div class="form-group">
                                <label for="createPhoneNo" class="col-form-label">Phone</label>
                                <input class="form-control" type="tel" value="" id="createPhoneNo">
                            </div>
                            <div class="form-group">
                                <label for="createPassword" class="">Password</label>
                                <input type="password" class="form-control" id="createPassword" value="" placeholder="Password">
                            </div>

                            <b class="text-muted mb-3 mt-4 d-block">Role:</b>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" checked id="rAdministrator" name="createRole" class="custom-control-input">
                                <label class="custom-control-label" for="rAdministrator">Administrator</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="rStaff" name="createRole" class="custom-control-input">
                                <label class="custom-control-label" for="rStaff">Staff</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="rCustomer" name="createRole" class="custom-control-input">
                                <label class="custom-control-label" for="rCustomer">Customer</label>
                            </div>
                            <div align="right">
                                <button type="submit" class="btn btn-primary btn-lg btn-rounded me-2">Submit</button>
                                <button type="reset" class="btn btn-primary btn-lg btn-rounded me-2">Reset</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

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

<%@ include file="function/footer.jsp"%>
