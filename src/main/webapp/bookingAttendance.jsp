<%! String title = "Booking Attendance"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <sidebar:parentItem name="Account Management">
        <sidebar:item href="${pageContext.request.contextPath}/admin/account">View Account</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/admin/account/create">Create Account</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Analytic" active="true">
        <sidebar:item href="${pageContext.request.contextPath}/bookingRate.jsp">Booking Rate</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/bookingAttendance.jsp" active="true">Booking Attendance</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Report">
        <sidebar:item href="${pageContext.request.contextPath}/income.jsp">Income</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Analytic</a></li>
            <li><span>Booking Attendance</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>
    <content:content>
        <div class="row">
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Booking Attendance by Member</h4>
                        <div class="data-tables datatable-dark">
                            <table id="dataTable3" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Account ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Attendance</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Airi Satou</td>
                                    <td>abc@abc.com</td>
                                    <td>12345678</td>
                                    <td>
                                        <button type="button" class="btn btn-secondary btn-lg btn-rounded me-2" data-bs-toggle="modal" data-bs-target="#exampleModal">See More</button>

                                        <div class="modal fade modal-xl" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Booking Attendance</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form method="" action="">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <div class="d-sm-flex justify-content-between align-items-center">
                                                                        <h4 class="header-title mb-0">Booking Rate</h4>
                                                                        <div class="btn-group" role="group" aria-label="Basic outlined example">
                                                                            <button type="button" class="btn btn-outline-primary" id="forMonthly">Monthly</button>
                                                                            <button type="button" class="btn btn-outline-primary" id="forYearly">Yearly</button>
                                                                        </div>
                                                                    </div>

                                                                    <div id="showRecord">

                                                                    </div>
                                                                </div>
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


<content:script>
    <content:scriptPath path="${pageContext.request.contextPath}/assets/js/page/booking-attendance.js"/>
</content:script>

<%@ include file="function/footer.jsp" %>
