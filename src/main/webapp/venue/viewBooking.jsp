<%! String title = "View Booking"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="/">Book Venue</sidebar:item>
        <sidebar:item href="/yourBooking.jsp">Your Booking</sidebar:item> <!--All user can see-->
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
                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Member's Name</th>
                                    <th>Member's Email</th>
                                    <th>Approval</th>
                                    <th>Check-in/Check-out</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Oscar</td>
                                    <td>ccc@abc.com</td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="approval-approval-1" checked autocomplete="off">
                                        <label class="btn btn-success" for="approval-approval-1">Approval</label>
                                        <input type="checkbox" class="btn-check" id="approval-reject-1" checked autocomplete="off">
                                        <label class="btn btn-danger" for="approval-reject-1">Reject</label>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="check-in-1" checked autocomplete="off" disabled>
                                        <label class="btn btn-warning" for="check-in-1">Check-in</label>
                                        <input type="checkbox" class="btn-check" id="check-out-1" checked autocomplete="off" disabled>
                                        <label class="btn btn-info" for="check-out-1">Check-out</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Kitty</td>
                                    <td>ccc@abc.com</td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="approval-approval-2" checked autocomplete="off" disabled>
                                        <label class="btn btn-success" for="approval-approval-2">Approval</label>
                                        <input type="checkbox" class="btn-check" id="approval-reject-2" checked autocomplete="on">
                                        <label class="btn btn-danger" for="approval-reject-2">Reject</label>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="check-in-2" checked autocomplete="off" disabled>
                                        <label class="btn btn-warning" for="check-in-2">Check-in</label>
                                        <input type="checkbox" class="btn-check" id="check-out-2" checked autocomplete="off" disabled>
                                        <label class="btn btn-info" for="check-out-2">Check-out</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>Peter</td>
                                    <td>ccc@abc.com</td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="approval-approval-3" checked autocomplete="on">
                                        <label class="btn btn-success" for="approval-approval-3">Approval</label>
                                        <input type="checkbox" class="btn-check" id="approval-reject-3" checked autocomplete="off" disabled>
                                        <label class="btn btn-danger" for="approval-reject-3">Reject</label>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="check-in-3" checked autocomplete="on" disabled>
                                        <label class="btn btn-warning" for="check-in-3">Check-in</label>
                                        <input type="checkbox" class="btn-check" id="check-out-3" checked autocomplete="off">
                                        <label class="btn btn-info" for="check-out-3">Check-out</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>Sanny</td>
                                    <td>ccc@abc.com</td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="approval-approval-4" checked autocomplete="off" disabled>
                                        <label class="btn btn-success" for="approval-approval-4">Approval</label>
                                        <input type="checkbox" class="btn-check" id="approval-reject-4" checked autocomplete="on">
                                        <label class="btn btn-danger" for="approval-reject-4">Reject</label>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="btn-check" id="check-in-4" checked autocomplete="off" disabled>
                                        <label class="btn btn-warning" for="check-in-4">Check-in</label>
                                        <input type="checkbox" class="btn-check" id="check-out-4" checked autocomplete="off" disabled>
                                        <label class="btn btn-info" for="check-out-4">Check-out</label>
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
