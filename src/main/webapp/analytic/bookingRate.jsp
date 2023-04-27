<%! String title = "Booking Rate"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="/">Book Venue</sidebar:item>
        <sidebar:item href="/booking">Your Booking</sidebar:item>
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
        <sidebar:parentItem name="Analytic" active="true">
            <sidebar:item href="/analytic" active="true">Booking Rate</sidebar:item>
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
            <li><a href="">Analytic</a></li>
            <li><span>Booking Rate</span></li>
        </content:directory>
        <content:profile/>
    </content:header>

    <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
    <alert:danger display="${!empty error_msg}">
        ${error_msg}
    </alert:danger>

    <jsp:useBean id="success_msg" scope="request" class="java.lang.String"/>
    <alert:success display="${!empty success_msg}">
        ${success_msg}
    </alert:success>

    <content:content>
        <div class="row mt-5 mb-5">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Total Booking Rate</h4>
                        <jsp:useBean id="totalRate" scope="request" class="java.lang.String"/>
                        <pre class="d-none" id="totalRate">${totalRate}</pre>
                        <div id="ampiechart1"></div>
                    </div>
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
                                <select class="form-select" id="selectVenue" aria-label="Select Venue">
                                    <option selected disabled>Select Venue</option>

                                    <jsp:useBean id="venueList" scope="request" class="java.util.ArrayList"/>
                                    <c:forEach items="${venueList}" var="venue">
                                        <option value="${venue.id}">${venue.name}</option>
                                    </c:forEach>

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
    <content:scriptPath path="/assets/js/page/booking-rate.js"/>
</content:script>

<%@ include file="../function/footer.jsp" %>
