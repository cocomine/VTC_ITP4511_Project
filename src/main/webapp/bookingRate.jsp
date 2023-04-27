<%! String title = "Booking Rate"; %>
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
        <sidebar:item href="${pageContext.request.contextPath}/bookingRate.jsp" active="true">Booking Rate</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/bookingAttendance.jsp">Booking Attendance</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Report">
        <sidebar:item href="${pageContext.request.contextPath}/income.jsp">Income</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Analytic</a></li>
            <li><span>Booking Rate</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>
    <content:content>
        <div class="row mt-5 mb-5">
            <div class="col-12">
                <div class="card">
                    <div align="center">
                        <h4 class="header-title mb-0">Total Booking Rate</h4>
                    </div>
                    <div id="ampiechart1"></div>
                </div>
            </div>
        </div>
        <div class="row mt-5 mb-5">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="d-sm-flex justify-content-between align-items-center">
                            <h4 class="header-title mb-0">Booking Rate</h4>
                            <div>
                                <select class="form-select" aria-label="Default select example">
                                    <option selected>Select Venue</option>
                                    <option value="selectVenue_1">Tuen Mun</option>
                                    <option value="selectVenue_2">Sha Tin</option>
                                    <option value="selectVenue_3">Tsing Yi</option>
                                    <option value="selectVenue_4">Lee Wai Lee</option>
                                    <option value="selectVenue_5">Chai Wan</option>
                                </select>
                            </div>
                            <div class="btn-group" role="group" aria-label="Basic outlined example">
                                <button type="button" class="btn btn-outline-primary" id="forMonthly">Monthly</button>
                                <button type="button" class="btn btn-outline-primary" id="forYearly">Yearly</button>
                            </div>
                        </div>

                        <div id="showRecord">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<content:script>
    <content:scriptPath path="${pageContext.request.contextPath}/assets/js/page/booking-rate.js"/>
</content:script>

<%@ include file="function/footer.jsp" %>
