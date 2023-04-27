<%! String title = "Create Venue"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld"%>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu href="${pageContext.request.contextPath}">
    <sidebar:parentItem name="Venue Booking" >
        <sidebar:item href="${pageContext.request.contextPath}">Book Venue</sidebar:item> <!--All user can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/yourBooking.jsp">Your Booking</sidebar:item> <!--All user can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Venue Management" active="true">
        <sidebar:item href="${pageContext.request.contextPath}/venue">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/create" active="true">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/booking">View Booking</sidebar:item> <!--Only Admin and Operator can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management">
        <sidebar:item href="${pageContext.request.contextPath}/admin/account">View Account</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/admin/account/create">Create Account</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Analytic">
        <sidebar:item href="${pageContext.request.contextPath}/bookingRate.jsp">Booking Rate</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/bookingAttendance.jsp">Booking Attendance</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Report">
        <sidebar:item href="${pageContext.request.contextPath}/income.jsp">Income</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Venue Management</a></li>
            <li><span>Create Venue</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Create Account Form Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <form method="post" action="" novalidate class="needs-validation" enctype="multipart/form-data">
                        <div class="card-body">
                            <h4 class="header-title">Create Venue</h4>

                            <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
                            <alert:danger display="${!empty error_msg}">
                                ${error_msg}
                            </alert:danger>

                            <jsp:useBean id="success_msg" scope="request" class="java.lang.String"/>
                            <alert:success display="${!empty success_msg}">
                                ${success_msg}
                            </alert:success>

                            <div class="col-12 mb-2">
                                <label for="location" class="form-label">Location</label>
                                <input class="form-control" type="text" id="location" name="location" required maxlength="100">
                                <div class="invalid-feedback">Please enter a location.</div>
                            </div>
                            <div class="col-12 mb-2">
                                <label for="name" class="form-label">Venue Name</label>
                                <input class="form-control" type="text" id="name" name="name" required maxlength="50">
                                <div class="invalid-feedback">Please enter a name.</div>
                            </div>
                            <div class="col-12 mb-2">
                                <label for="description">Venue Description</label>
                                <textarea class="form-control" placeholder="Leave a venue description here" id="description" name="description" required maxlength="200"></textarea>
                                <div class="invalid-feedback">Please enter a description.</div>
                            </div>

                            <div class="col-12 mb-2">
                                <label for="max" class="form-label">Max Capacity</label>
                                <input class="form-control" type="number" id="max" min="1" name="max" required>
                                <div class="invalid-feedback">Please enter a valid number.</div>
                            </div>

                            <div class="col-12 mb-2">
                                <label for="fee" class="form-label">Booking Fee</label>
                                <input class="form-control" type="number" id="fee" name="fee" min="0" step="0.01" required>
                                <div class="invalid-feedback">Please enter a valid fee.</div>
                            </div>

                            <div class="col-12 mb-2">
                                <label for="image" class="form-label">Venue Image(Only 1 pic)</label>
                                <input class="form-control" type="file" name="image" id="image" accept="image/png, image/jpeg, image/webp" required>
                                <div class="invalid-feedback">Please select a valid image.</div>
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

<%@ include file="../function/footer.jsp"%>
