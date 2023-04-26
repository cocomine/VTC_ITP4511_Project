<%! String title = "Create Account"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="index.jsp">Book Venue</sidebar:item> <!--All user can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Venue Management">
        <sidebar:item href="viewVenue.jsp">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="createVenue.jsp">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="viewBooking.jsp">View Booking</sidebar:item> <!--Only Admin and Operator can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management" active="true">
        <sidebar:item href="viewAccount.jsp">View Account</sidebar:item> <!--Only Admin  can see-->
        <sidebar:item href="createAccount.jsp" active="true">Create Account</sidebar:item> <!--Only Admin can see-->
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
            <!--Create Account Form Start-->
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

<%@ include file="function/footer.jsp"%>
