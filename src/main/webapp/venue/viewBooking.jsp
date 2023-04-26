<%! String title = "View Booking"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu href="${pageContext.request.contextPath}">
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="${pageContext.request.contextPath}">Book Venue</sidebar:item>
    </sidebar:parentItem>
    <!--Only Staff can see-->
    <c:if test="${user.role == 1}">
        <sidebar:parentItem name="Venue Management" active="true">
            <sidebar:item href="${pageContext.request.contextPath}/venue">View Venue</sidebar:item>
            <sidebar:item href="${pageContext.request.contextPath}/venue/create">Create Venue</sidebar:item>
            <sidebar:item href="${pageContext.request.contextPath}/venue/booking"
                          active="true">View Booking</sidebar:item>
        </sidebar:parentItem>
    </c:if>
    <!--Only Senior Management can see-->
    <c:if test="${user.role == 2}">
        <sidebar:parentItem name="Account Management">
            <sidebar:item href="${pageContext.request.contextPath}/admin/account">View Account</sidebar:item>
            <sidebar:item href="${pageContext.request.contextPath}/admin/account/create">Create Account</sidebar:item>
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
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Booking List</h4>
                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Member's Name</th>
                                    <th>Member's Email</th>
                                    <th>Info</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Oscar</td>
                                    <td>ccc@abc.com</td>
                                    <td>
                                        <button type="button" class="btn btn-secondary btn-lg btn-rounded me-2"
                                                data-bs-toggle="modal" data-bs-target="#exampleModal">Info
                                        </button>

                                        <div class="modal fade modal-xl" id="exampleModal" tabindex="-1"
                                             aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Venue List
                                                            of the Booking</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form method="" action="">
                                                            <div class="data-tables datatable-dark">
                                                                <table id="dataTable3" class="text-center">
                                                                    <thead class="text-capitalize">
                                                                    <tr>
                                                                        <th>Event Name</th>
                                                                        <th>Booking Date</th>
                                                                        <th>Capacity</th>
                                                                        <th>Location</th>
                                                                        <th>In Charge</th>
                                                                        <th>Booking Fee</th>
                                                                        <th>Approval</th>
                                                                        <th>Check-in/Check-out</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <tr>
                                                                        <td>Ada Chan</td>
                                                                        <td>ccc@abc.com</td>
                                                                        <td>97684664</td>
                                                                        <td>Admin</td>
                                                                        <td>Admin</td>
                                                                        <td>97684664</td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-approval-1" checked
                                                                                   autocomplete="off">
                                                                            <label class="btn btn-success"
                                                                                   for="approval-approval-1">Approval</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-reject-1" checked
                                                                                   autocomplete="off">
                                                                            <label class="btn btn-danger"
                                                                                   for="approval-reject-1">Reject</label>
                                                                        </td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-in-1" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-warning"
                                                                                   for="check-in-1">Check-in</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-out-1" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-info"
                                                                                   for="check-out-1">Check-out</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Peter Sum</td>
                                                                        <td>33yred@sum.com</td>
                                                                        <td>97684661</td>
                                                                        <td>Admin</td>
                                                                        <td>Admin</td>
                                                                        <td>97684664</td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-approval-2" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-success"
                                                                                   for="approval-approval-2">Approval</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-reject-2" checked
                                                                                   autocomplete="on">
                                                                            <label class="btn btn-danger"
                                                                                   for="approval-reject-2">Reject</label>
                                                                        </td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-in-2" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-warning"
                                                                                   for="check-in-2">Check-in</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-out-2" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-info"
                                                                                   for="check-out-2">Check-out</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Peter Sum</td>
                                                                        <td>33yred@sum.com</td>
                                                                        <td>97684661</td>
                                                                        <td>Admin</td>
                                                                        <td>Admin</td>
                                                                        <td>97684664</td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-approval-3" checked
                                                                                   autocomplete="on">
                                                                            <label class="btn btn-success"
                                                                                   for="approval-approval-3">Approval</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-reject-3" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-danger"
                                                                                   for="approval-reject-3">Reject</label>
                                                                        </td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-in-3" checked
                                                                                   autocomplete="off">
                                                                            <label class="btn btn-warning"
                                                                                   for="check-in-3">Check-in</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-out-3" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-info"
                                                                                   for="check-out-3">Check-out</label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Peter Sum</td>
                                                                        <td>33yred@sum.com</td>
                                                                        <td>97684661</td>
                                                                        <td>Admin</td>
                                                                        <td>Admin</td>
                                                                        <td>97684664</td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-approval-4" checked
                                                                                   autocomplete="on">
                                                                            <label class="btn btn-success"
                                                                                   for="approval-approval-4">Approval</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="approval-reject-4" checked
                                                                                   autocomplete="off" disabled>
                                                                            <label class="btn btn-danger"
                                                                                   for="approval-reject-4">Reject</label>
                                                                        </td>
                                                                        <td>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-in-4" checked
                                                                                   autocomplete="on" disabled>
                                                                            <label class="btn btn-warning"
                                                                                   for="check-in-4">Check-in</label>
                                                                            <input type="checkbox" class="btn-check"
                                                                                   id="check-out-4" checked
                                                                                   autocomplete="off">
                                                                            <label class="btn btn-info"
                                                                                   for="check-out-4">Check-out</label>
                                                                        </td>
                                                                    </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<%@ include file="../function/footer.jsp" %>
