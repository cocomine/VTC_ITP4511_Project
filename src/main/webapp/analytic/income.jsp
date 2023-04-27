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
        <sidebar:parentItem name="Analytic" active="true">
            <sidebar:item href="/analytic">Booking Rate</sidebar:item>
            <sidebar:item href="/analytic/attendance">Booking Attendance</sidebar:item>
        </sidebar:parentItem>
        <sidebar:parentItem name="Report">
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
                        <div class="btn-group" role="group" aria-label="Basic outlined example">
                            <button type="button" class="btn btn-outline-primary" id="forMonthly">Monthly</button>
                            <button type="button" class="btn btn-outline-primary" id="forYearly">Yearly</button>
                        </div>
                    </div>
                    <div class="market-status-table mt-4">
                        <div class="table-responsive">
                            <table class="dbkit-table">
                                <tr class="heading-td">
                                    <td>Venue(Location)</td>
                                    <td>Booking Fee</td>
                                    <td>Monthly Income</td> <!--gen "Yearly Income" by Yearly selected-->
                                    <td>Booking Record</td>
                                </tr>
                                <tr>
                                    <td>Lee Wai Lee</td>
                                    <td>$ 2400</td>
                                    <td>$ 446,857</td>
                                    <td>
                                        <button type="button" class="btn btn-secondary btn-lg btn-rounded me-2" data-bs-toggle="modal" data-bs-target="#exampleModal">See More</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </content:content>
</content:main>

<div class="modal fade modal-xl" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Booking Record</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="" action="">
                    <div class="data-tables datatable-dark">
                        <table id="dataTable3" class="text-center">
                            <thead class="text-capitalize">
                            <tr>
                                <th>Booking ID</th>
                                <th>Member's Name</th>
                                <th>Member's Email</th>
                                <th>Booking Date</th>
                                <th>State</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td>Ada Chan</td>
                                <td>ccc@abc.com</td>
                                <td>12/6/2022</td>
                                <td><button type="button" class="btn btn-flat btn-danger mb-3">Reject</button></td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>Ada Chan</td>
                                <td>ccc@abc.com</td>
                                <td>12/6/2022</td>
                                <td><button type="button" class="btn btn-flat btn-success mb-3">Finish</button></td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>Ada Chan</td>
                                <td>ccc@abc.com</td>
                                <td>12/6/2022</td>
                                <td><button type="button" class="btn btn-flat btn-warning mb-3">Progress</button></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- load this page script -->
<content:script>
    <content:scriptPath path="${pageContext.request.contextPath}/assets/js/page/income.js"/>
</content:script>

<%@ include file="../function/footer.jsp" %>