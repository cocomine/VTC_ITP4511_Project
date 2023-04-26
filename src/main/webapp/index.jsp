<%! String title = "View Order"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking" active="true">
        <sidebar:item href="/" active="true">Book Venue</sidebar:item>
        <sidebar:item href="/booking">Your Booking</sidebar:item>
    </sidebar:parentItem>
    <!--Only Staff can see-->
    <c:if test="${user.role == 1}">
        <sidebar:parentItem name="Venue Management">
            <sidebar:item href="/venue">View Venue</sidebar:item>
            <sidebar:item href="/venue/create">Create Venue</sidebar:item>
            <sidebar:item href="/venue/booking">View Booking</sidebar:item>
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
            <li><a href="">Venue Booking</a></li>
            <li><span>Book Venue</span></li>
        </content:directory>
        <content:profile/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Venue List</h4>
                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Venue Image</th>
                                    <th>Venue ID</th>
                                    <th>Location</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Max Capacity</th>
                                    <th>Booking Fee</th>
                                    <th>Add select</th>
                                </tr>
                                </thead>
                                <tbody>

                                <jsp:useBean id="venueList" scope="request" class="java.util.ArrayList"/>
                                <c:forEach items="${venueList}" var="venue">
                                    <tr>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/upload/${venue.image}"
                                                 alt="venue image" style="max-width: 200px; max-height: 200px">
                                        </td>
                                        <td>${venue.id}</td>
                                        <td>${venue.location}</td>
                                        <td>${venue.name}</td>
                                        <td>${venue.description}</td>
                                        <td>${venue.max}</td>
                                        <td>$ ${venue.fee}</td>
                                        <td>
                                            <i class="ti-plus" data-add="${venue.id}"></i>
                                        </td>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--Book Venue Form Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Select Venue</h4>

                        <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
                        <alert:danger display="${!empty error_msg}">
                            ${error_msg}
                        </alert:danger>

                        <jsp:useBean id="success_msg" scope="request" class="java.lang.String"/>
                        <alert:success display="${!empty success_msg}">
                            ${success_msg}
                        </alert:success>

                        <table class="table w-100" id="selectVenue">
                            <thead class="table-dark">
                            <tr>
                                <th>Venue ID</th>
                                <th>Name</th>
                                <th>Edit guest</th>
                                <th>Edit detail</th>
                                <th>Remove select</th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>

                        <div class="col-12 mb-2">
                            <button type="button" class="btn btn-primary btn-rounded me-2" id="submit">Submit</button>
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
            <form id="detailForm" novalidate class="needs-validation">
                <div class="modal-body">
                    <div class="col-12 mb-2">
                        <label for="date" class="form-label">Booking Date</label>
                        <input class="form-control" type="datetime-local" id="date" name="date" required>
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

<!-- load this page script -->
<content:script>
    <content:scriptPath path="/assets/js/page/book-venue.js"/>
</content:script>

<%@ include file="function/footer.jsp" %>
