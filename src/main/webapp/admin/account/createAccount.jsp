<%! String title = "Create Account"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld"%>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu href="${pageContext.request.contextPath}">
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="${pageContext.request.contextPath}">Book Venue</sidebar:item> <!--All user can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/yourBooking.jsp">Your Booking</sidebar:item> <!--All user can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Venue Management">
        <sidebar:item href="${pageContext.request.contextPath}/venue">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/create">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/booking">View Booking</sidebar:item> <!--Only Admin and Operator can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management" active="true">
        <sidebar:item href="${pageContext.request.contextPath}/admin/account">View Account</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/admin/account/create" active="true">Create Account</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Operating Data">
        <sidebar:item href="analyticAndReport.jsp">Analytic/Report</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href=".">Account Management</a></li>
            <li><span>Create Account</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <form method="post" action="" novalidate class="needs-validation">
                        <div class="card-body">
                            <h4 class="header-title">Create Account</h4>

                            <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
                            <alert:danger display="${!empty error_msg}">
                                ${error_msg}
                            </alert:danger>

                            <jsp:useBean id="success_msg" scope="request" class="java.lang.String"/>
                            <alert:success display="${!empty success_msg}">
                                ${success_msg}
                            </alert:success>

                            <div class="col-12 mb-2">
                                <label for="username" class="form-label">Username</label>
                                <input class="form-control" type="text" id="username" name="username" maxlength="20" required>
                                <div class="invalid-feedback">Please enter a username.</div>
                            </div>
                            <div class="col-12 mb-2">
                                <label for="email" class="form-label">Email</label>
                                <input class="form-control" type="email" id="email" name="email" maxlength="100" required>
                                <div class="invalid-feedback">Please enter a valid email address.</div>
                            </div>
                            <div class="col-12 mb-2">
                                <label for="phone" class="form-label">Phone</label>
                                <input class="form-control" type="tel" id="phone" name="phone" maxlength="8" required>
                                <div class="invalid-feedback">Please enter a valid phone number.</div>
                            </div>
                            <div class="col-12 mb-2">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                                <div class="invalid-feedback">Required field</div>
                            </div>
                            <div class="col-12 mb-2">
                                <label for="C_password" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="C_password" name="C_password" required>
                                <div class="invalid-feedback">Required field</div>
                            </div>

                            <b class="text-muted d-block">Role:</b>
                            <div class="form-check form-check-inline">
                                <input type="radio" checked id="rAdministrator" name="role" class="form-check-input" value="2">
                                <label class="form-check-label" for="rAdministrator">Senior Management</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" id="rStaff" name="role" class="form-check-input" value="1">
                                <label class="form-check-label" for="rStaff">Staff</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" id="rCustomer" name="role" class="form-check-input" value="0">
                                <label class="form-check-label" for="rCustomer">Member</label>
                            </div>

                            <div class="col-12">
                                <button type="submit" class="btn btn-primary btn-rounded me-2">Submit</button>
                                <button type="reset" class="btn btn-secondary btn-rounded me-2">Reset</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<%@ include file="../../function/footer.jsp"%>
