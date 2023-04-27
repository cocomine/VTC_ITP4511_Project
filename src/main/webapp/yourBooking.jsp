<%! String title = "Your Booking"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking" active="true">
        <sidebar:item href="/">Book Venue</sidebar:item>
        <sidebar:item href="/booking" active="true">Your Booking</sidebar:item>
    </sidebar:parentItem>
    <!--Only Staff can see-->
    <c:if test="${user.role >= 1}">
        <sidebar:parentItem name="Venue Management">
            <sidebar:item href="/venue">View Venue</sidebar:item>
            <sidebar:item href="/venue/create">Create Venue</sidebar:item>
            <sidebar:item href="/venue/booking">View Booking</sidebar:item>
        </sidebar:parentItem>
    </c:if>
    <!--Only Senior Management can see-->
    <c:if test="${user.role >= 2}">
        <sidebar:parentItem name="Account Management">
            <sidebar:item href="/admin/account">View Account</sidebar:item>
            <sidebar:item href="/admin/account/create">Create Account</sidebar:item>
        </sidebar:parentItem>
        <sidebar:parentItem name="Analytic">
            <sidebar:item href="/analytic">Booking Rate</sidebar:item>
            <sidebar:item href="/analytic/attendance">Booking Attendance</sidebar:item>
        </sidebar:parentItem>
        <sidebar:parentItem name="Report">
            <sidebar:item href="/analytic/income">Income</sidebar:item>
        </sidebar:parentItem>
    </c:if>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Venue Management</a></li>
            <li><span>Your Booking</span></li>
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
                        <jsp:useBean id="success_msg" scope="request" class="java.lang.String"/>
                        <alert:success display="${!empty success_msg}">
                            ${success_msg}
                        </alert:success>

                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Venue Name</th>
                                    <th>Book date</th>
                                    <th>Venue Fee</th>
                                    <th>Status</th>
                                    <th>Guest List</th>
                                    <th>Edit</th>
                                </tr>
                                </thead>
                                <tbody>

                                <fmt:setLocale value="en_US"/>
                                <jsp:useBean id="bookingList" scope="request" class="java.util.ArrayList"/>
                                <c:forEach items="${bookingList}" var="booking">
                                    <tr>
                                        <td>${booking.id}</td>
                                        <td>${booking.venueBean.name}</td>
                                        <td>
                                            <fmt:formatDate value="${booking.book_date}" type="date" dateStyle="long"/>
                                        </td>
                                        <td>$ ${booking.venueBean.fee}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.status == 0}">
                                                    <span class="badge rounded-pill bg-warning">Pending</span>
                                                </c:when>
                                                <c:when test="${booking.status == 1}">
                                                    <span class="badge rounded-pill bg-success">Approved</span>
                                                </c:when>
                                                <c:when test="${booking.status == 2}">
                                                    <span class="badge rounded-pill bg-danger">Rejected</span>
                                                </c:when>
                                            </c:choose>
                                            <br>
                                            <c:if test="${booking.check_in != null}">
                                                <p>Check-in: <fmt:formatDate value="${booking.check_in}" type="time"
                                                                             timeStyle="short"/></p>
                                            </c:if>
                                            <c:if test="${booking.check_out != null}">
                                                <p>Check-out: <fmt:formatDate value="${booking.check_out}" type="time"
                                                                              timeStyle="short"/></p>
                                            </c:if>
                                        </td>
                                        <td><i class="ti-pencil" data-guestlist="${booking.id}"></i></td>
                                        <td><i class="ti-pencil" data-edit="${booking.id}"></i></td>
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

<div class="modal fade" tabindex="-1" id="editDetail" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Guest list</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="detailForm" novalidate class="needs-validation" method="post" action="">
                <div class="modal-body">
                    <input name="id" id="id" type="hidden">
                    <div class="col-12 mb-2">
                        <label for="date" class="form-label">Booking Date</label>
                        <input class="form-control" type="date" id="date" name="date" required>
                        <div class="invalid-feedback">
                            Please provide a valid booking date.
                        </div>
                    </div>
                    <div class="col-12 mb-2">
                        <label for="template" class="form-label">Notification template for guest invitations</label>
                        <textarea class="form-control" id="template" name="template"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-rounded" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary btn-rounded">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" tabindex="-1" id="editGuest" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Guest list</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="guestListForm" novalidate class="needs-validation">
                <div class="modal-body">
                    <div class="row" id="guestList"></div>
                    <div class="w-100">
                        <button type="button" class="btn btn-outline-primary btn-rounded w-100" id="addGuest">
                            Add new guest
                        </button>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-rounded" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary btn-rounded">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<content:script>
    <content:scriptPath path="/assets/js/page/yourBooking.js"/>
</content:script>

<%@ include file="function/footer.jsp" %>
