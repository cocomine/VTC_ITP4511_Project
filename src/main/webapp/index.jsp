<%! String title = "View Order"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu href="${pageContext.request.contextPath}">
    <sidebar:parentItem name="Venue Booking" active="true">
        <sidebar:item href="${pageContext.request.contextPath}" active="true">Book Venue</sidebar:item> <!--All user can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Venue Management">
        <sidebar:item href="${pageContext.request.contextPath}/venue">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/create">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management">
        <sidebar:item href="${pageContext.request.contextPath}/admin/account">View Account</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/admin/account/create">Create Account</sidebar:item>
    </sidebar:parentItem>
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
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Venue List</h4>

                        <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
                        <alert:danger display="${!empty error_msg}">
                            ${error_msg}
                        </alert:danger>

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
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>

                                <jsp:useBean id="venueList" scope="request" class="java.util.ArrayList"/>
                                <c:forEach items="${venueList}" var="venue">
                                    <tr>
                                        <td><img src="${pageContext.request.contextPath}/upload/${venue.image}" alt="venue image" style="max-width: 200px; max-height: 200px"></td>
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
                    <form method="post" action="">
                        <div class="card-body">
                            <h4 class="header-title">Book Venue</h4>
                            <div class="form-group">
                                <img src="assets/images/LWL.jpg" class="owl-lazy" alt="" style="height: 30vh; overflow: hidden;">
                                <!--根據地點不同,show不同照片-->
                            </div>
                            <div class="form-group">
                                <label for="venueLocation" class="col-form-label">Location</label><p>
                                <input class="form-control" type="text" value="" id="venueLocation" disabled>
                            </div>
                            <div class="form-group">
                                <label for="venueName" class="col-form-label">Venue Name</label>
                                <input class="form-control" type="text" value="" id="venueName" disabled>
                            </div>
                            <div class="form-group">
                                <label for="venueDescription">Venue Description</label>
                                <textarea class="form-control" placeholder="" id="venueDescription" disabled></textarea>
                            </div>
                            <div class="form-group">
                                <label for="bookingDate" class="col-form-label">Booking Date</label>
                                <input class="form-control" type="datetime-local" value="2023-01-01T15:30:00" id="bookingDate">
                            </div>
                            <div class="form-group">
                                <label for="bookingCapacity" class="col-form-label">Booking Capacity</label>
                                <input class="form-control" type="number" value="" id="bookingCapacity" min="1" max="">
                                <span>The maximum capacity of XXX(地點) venue is XXX</span>
                            </div>

                            <div class="form-group">
                                <label for="venuePersonInCharge" class="col-form-label">Person In Charge</label>
                                <input class="form-control" type="text" value="${user.username}" id="venuePersonInCharge" disabled>
                            </div>
                            <div class="form-group">
                                <label for="venueBookingFee" class="col-form-label">Booking Fee</label>
                                <input class="form-control" type="text" value="" id="venueBookingFee" disabled>
                            </div>
                            <div align="left">
                                <button type="submit" class="btn btn-primary btn-lg btn-rounded me-2">Add to Booking List</button>
                                <button type="reset" class="btn btn-primary btn-lg btn-rounded me-2">Reset</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <form method="" action="">
                            <h4 class="header-title">Your Booking List</h4>
                            <div class="data-tables datatable-dark">
                                <table id="dataTable2" class="text-center">
                                    <thead class="text-capitalize">
                                    <tr>
                                        <th>Event Name</th>
                                        <th>Booking Date</th>
                                        <th>Capacity</th>
                                        <th>Location</th>
                                        <th>In Charge</th>
                                        <th>Booking Fee</th>
                                        <th>Action</th>
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
                                        <td><i class="ti-pencil"></i><i class="ti-trash" style="color:red;"></i></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg btn-rounded me-2">Submit Booking</button>
                            <!--Submit後創建一個booking ID-->
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<!-- load this page script -->
<content:script>
    <content:scriptPath path="./assets/js/page/book-venue.js" />
</content:script>

<%@ include file="function/footer.jsp"%>
