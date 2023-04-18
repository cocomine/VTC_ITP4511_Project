
<%--
  Created by IntelliJ IDEA.
  User: rogui
  Date: 18/4/2023
  Time: 17:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld"%>
<html class="login" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Register - EPL</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/themify-icons.css">
    <link rel="stylesheet" href="assets/css/typography.css">
    <link rel="stylesheet" href="assets/css/default-css.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="assets/css/responsive.css">
    <script src="assets/js/vendor/modernizr-2.8.3.min.js"></script>
</head>

<body>
<div id="preloader">
    <div class="loader"></div>
</div>
<!-- login area start -->
<div class="login-area login-s2">
    <div class="container">
        <div class="login-box ptb--100">
            <form method="post" novalidate action="register">
                <div class="login-form-head">
                    <h4>Sign up</h4>
                    <p>Hello there, Sign up and Join with Us</p>
                </div>

                <alert:danger display="${!empty error_msg}">
                    ${error_msg}
                </alert:danger>
                <alert:success display="${!empty success_msg}">
                    ${success_msg}
                </alert:success>

                <div class="login-form-body">
                    <div class="form-gp">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" maxlength="20" required>
                        <i class="ti-user"></i>
                        <div class="invalid-feedback">Required field</div>
                    </div>
                    <div class="form-gp">
                        <label for="email">Email address</label>
                        <input type="email" id="email" name="email" maxlength="100" required>
                        <i class="ti-email"></i>
                        <div class="invalid-feedback">Required field</div>
                    </div>
                    <div class="form-gp">
                        <label for="phone">Phone</label>
                        <input type="text" id="phone" name="phone" maxlength="8" required>
                        <i class="fa fa-phone"></i>
                        <div class="invalid-feedback">Required field</div>
                    </div>
                    <div class="form-gp">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                        <i class="ti-lock"></i>
                        <div class="invalid-feedback">Required field</div>
                    </div>
                    <div class="form-gp">
                        <label for="C_password">Confirm Password</label>
                        <input type="password" id="C_password" name="C_password" required>
                        <i class="ti-lock"></i>
                        <div class="invalid-feedback">Required field</div>
                    </div>
                    <div class="submit-btn-area">
                        <button id="form_submit" type="submit">Submit <i class="ti-arrow-right"></i></button>
                    </div>
                    <div class="form-footer text-center mt-5">
                        <p class="text-light">Have an account? <a href="login">Sign in</a></p>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- login area end -->

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>
<script src="assets/js/plugins.js"></script>
<script src="assets/js/scripts.js"></script>
</body>

</html>
