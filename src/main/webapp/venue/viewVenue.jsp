<%! String title = "View Venue"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp" %>
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
    <sidebar:parentItem name="Venue Management" active="true">
        <sidebar:item href="${pageContext.request.contextPath}/venue" active="true">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/create">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/booking">View Booking</sidebar:item> <!--Only Admin and Operator can see-->
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
            <li><a href="">Venue Management</a></li>
            <li><span>View Venue</span></li>
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
                                    <th>Enable</th>
                                </tr>
                                </thead>
                                <tbody>

                                <jsp:useBean id="venueList" scope="request" class="java.util.ArrayList"/>
                                <c:forEach items="${venueList}" var="venue">
                                    <tr>
                                        <td><img src="${pageContext.request.contextPath}/upload/${venue.image}"
                                                 alt="venue image" style="max-width: 200px; max-height: 200px"></td>
                                        <td>${venue.id}</td>
                                        <td>${venue.location}</td>
                                        <td>${venue.name}</td>
                                        <td>${venue.description}</td>
                                        <td>${venue.max}</td>
                                        <td>$ ${venue.fee}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/venue/edit?id=${venue.id}">
                                                <i class="ti-pencil me-2"></i></a>
                                            <i class="ti-trash text-danger" data-delete="${venue.id}"></i>
                                        </td>
                                        <td>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" role="switch"
                                                       id="enableSwitch1" aria-label="Enable Switch" data-enable="${venue.id}"
                                                       <c:if test="${venue.enable}">checked</c:if> >
                                            </div>
                                        </td>
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

<content:script>
    <content:scriptPath path="${pageContext.request.contextPath}/assets/js/page/viewVenue.js"/>
</content:script>

<%@ include file="../function/footer.jsp" %>
