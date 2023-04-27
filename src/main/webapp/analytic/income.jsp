<%! String title = "Income"; %>
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
        <sidebar:parentItem name="Analytic">
            <sidebar:item href="/analytic">Booking Rate</sidebar:item>
            <sidebar:item href="/analytic/attendance">Booking Attendance</sidebar:item>
        </sidebar:parentItem>
        <sidebar:parentItem name="Report" active="true">
            <sidebar:item href="/analytic/income" active="true">Income</sidebar:item>
        </sidebar:parentItem>
    </c:if>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Report</a></li>
            <li><span>Income</span></li>
        </content:directory>
        <content:profile/>
    </content:header>
    <content:content>
        <div class="row mt-5 mb-5">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="d-sm-flex justify-content-between align-items-center">
                            <h4 class="header-title mb-0">Income Generated by Venue</h4>

                            <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
                            <alert:danger display="${!empty error_msg}">
                                ${error_msg}
                            </alert:danger>

                            <jsp:useBean id="success_msg" scope="request" class="java.lang.String"/>
                            <alert:success display="${!empty success_msg}">
                                ${success_msg}
                            </alert:success>

                            <div>
                                <select class="form-select" aria-label="Select Venue" id="selectVenue">
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

                        <div class="market-status-table mt-4">
                            <div class="table-responsive">
                                <table class="dbkit-table" id="table">
                                    <tr class="heading-td">
                                        <th>Month</th> <!--gen "Year" text when selected Yearly button-->
                                        <th>Income</th>
                                    </tr>
                                </table>

                                <!--只需提取select的場地的預約記錄即可,與年/月 function無關-->
                                <button type="button" class="btn btn-secondary btn-rounded mt-2"
                                        data-bs-toggle="modal" data-bs-target="#bookingRecordModal">View Booking Record of Venue
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<div class="modal fade modal-xl" id="bookingRecordModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Booking Record</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table text-center">
                        <thead class="text-uppercase table-dark">
                        <tr>
                            <th scope="col">Booking ID</th>
                            <th scope="col">Member's Name</th>
                            <th scope="col">Member's Email</th>
                            <th scope="col">Booking Date</th>
                            <th scope="col">State</th>
                        </tr>
                        </thead>
                        <tbody id="bookingRecord"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- load this page script -->
<content:script>
    <content:scriptPath path="/assets/js/page/income.js"/>
</content:script>

<%@ include file="../function/footer.jsp" %>