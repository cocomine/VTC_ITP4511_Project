<%! String title = "View Booking"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="/">Book Venue</sidebar:item>
        <sidebar:item href="/booking">Your Booking</sidebar:item>
    </sidebar:parentItem>
    <!--Only Staff can see-->
    <c:if test="${user.role == 1}">
        <sidebar:parentItem name="Venue Management" active="true">
            <sidebar:item href="/venue">View Venue</sidebar:item>
            <sidebar:item href="/venue/create">Create Venue</sidebar:item>
            <sidebar:item href="/venue/booking" active="true">View Booking</sidebar:item>
        </sidebar:parentItem>
    </c:if>
    <!--Only Senior Management can see-->
    <c:if test="${user.role == 2}">
        <sidebar:parentItem name="Account Management">
            <sidebar:item href="/admin/account">View Account</sidebar:item>
            <sidebar:item href="/admin/account/create">Create Account</sidebar:item>
        </sidebar:parentItem>
    </c:if>
    <sidebar:parentItem name="Operating Data">
        <sidebar:item href="analyticAndReport.jsp">Analytic/Report</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Venue Management</a></li>
            <li><span>View Booking</span></li>
        </content:directory>
        <content:profile/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Booking List</h4>

                        <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
                        <alert:danger display="${!empty error_msg}">
                            ${error_msg}
                        </alert:danger>

                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Member Name</th>
                                    <th>Member Email</th>
                                    <th>Venue Name</th>
                                    <th>Book Date</th>
                                    <th>Approval</th>
                                    <th>Check-in/Check-out</th>
                                    <th>Guest list</th>
                                </tr>
                                </thead>
                                <tbody>

                                <fmt:setLocale value="en_US"/>
                                <jsp:useBean id="bookingList" scope="request" class="java.util.ArrayList"/>
                                <c:forEach items="${bookingList}" var="booking">
                                    <tr>
                                        <td>${booking.id}</td>
                                        <td>${booking.userBean.username}</td>
                                        <td>${booking.userBean.email}</td>
                                        <td>${booking.venueBean.name}</td>
                                        <td><fmt:formatDate value="${booking.book_date}" type="date" dateStyle="long"/></td>
                                        <td>
                                            <button class="btn btn-success btn-rounded btn-sm" data-approve="${booking.id}"
                                                    <c:if test="${booking.status == 2}">disabled</c:if> >
                                                Approve
                                            </button>
                                            <button class="btn btn-danger btn-rounded btn-sm" data-reject="${booking.id}"
                                                    <c:if test="${booking.status == 1}">disabled</c:if> >
                                                Reject
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-primary btn-rounded btn-sm" data-checkin="${booking.id}"
                                                    <c:if test="${booking.check_in != null || booking.status != 1}">disabled</c:if> >
                                                Check-in
                                            </button>
                                            <button class="btn btn-outline-primary btn-rounded btn-sm"
                                                    data-checkout="${booking.id}"
                                                    <c:if test="${booking.check_out != null || booking.status != 1}">disabled</c:if> >
                                                Check-out
                                            </button>
                                            <br>
                                            <c:if test="${booking.check_in != null}">
                                                <p>Check-in: <fmt:formatDate value="${booking.check_in}" type="time" timeStyle="short"/></p>
                                            </c:if>
                                            <c:if test="${booking.check_out != null}">
                                                <p>Check-out: <fmt:formatDate value="${booking.check_out}" type="time" timeStyle="short"/></p>
                                            </c:if>
                                        </td>
                                        <td><i class="fa fa-eye" style="cursor: pointer" data-guestlist="${booking.id}"></i></td>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<div class="modal fade" id="guestList"  aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">Guest List</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                    <tr class="table-dark">
                        <th scope="col">Guest Name</th>
                        <th scope="col">Guest Email</th>
                    </tr>
                    </thead>
                    <tbody id="guestListBody">
                    </tbody>
                </table>
                <hr>
                <div class="col-12">
                    <label for="template" class="form-label">Notification template for guest invitations</label>
                    <textarea class="form-control" id="template" readonly></textarea>
                </div>
            </div>
        </div>
    </div>
</div>

<content:script>
    <content:scriptPath path="/assets/js/page/viewBooking.js"/>
</content:script>

<%@ include file="../function/footer.jsp" %>
