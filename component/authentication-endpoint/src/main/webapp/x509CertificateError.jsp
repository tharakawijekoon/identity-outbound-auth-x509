<%--
  ~ Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.TenantDataManager" %>
<%@ page import="java.util.ResourceBundle" %>
<fmt:bundle basename="org.wso2.carbon.identity.application.authentication.endpoint.i18n.Resources">

    <%
        String BUNDLE = "org.wso2.carbon.identity.application.authentication.endpoint.i18n.Resources";
        ResourceBundle resourceBundle = ResourceBundle.getBundle(BUNDLE, request.getLocale());
        request.getSession().invalidate();
        Map<String, String> idpAuthenticatorMapping = null;
        if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
            idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
        }

        String errorCode = resourceBundle.getString("unknown.error.code");
        String authenticationFailed = "false";
        String errorMessage = resourceBundle.getString("unknown.error.message");

        if (Boolean.parseBoolean(request.getParameter("authFailure"))) {
            authenticationFailed = "true";

            if (request.getParameter("errorCode") != null) {
                errorCode = request.getParameter("errorCode");

                if (errorCode.equalsIgnoreCase("18013")) {
                    errorMessage = resourceBundle.getString("certificateNotFound.error.message");
                } else if (errorCode.equalsIgnoreCase("18003")) {
                    errorMessage = resourceBundle.getString("userNotFound.error.message");
                } else if (errorCode.equalsIgnoreCase("20015")) {
                    errorMessage = resourceBundle.getString("userNamesConflict.error.message");
                } else if (errorCode.equalsIgnoreCase("17001")) {
                    errorMessage = resourceBundle.getString("userNotFoundInUserStore.error.message");
                } else if (errorCode.equalsIgnoreCase("18015")) {
                    errorMessage = resourceBundle.getString("not.valid.certificate");
                } else if (errorCode.equalsIgnoreCase("17003")) {
                    errorMessage = resourceBundle.getString("fail.validation.certificate");
                } else if (errorCode.equalsIgnoreCase("17004")) {
                    errorMessage = resourceBundle.getString(
                            "x509certificateauthenticator.alternativenames.regex.multiplematches.code.17004.error.message");
                } else if (errorCode.equalsIgnoreCase("17005")) {
                    errorMessage = resourceBundle
                            .getString("x509certificateauthenticator.alternativenames.regex.nomatches.code.17005.error.message");
                } else if (errorCode.equalsIgnoreCase("17006")) {
                    errorMessage = resourceBundle
                            .getString("x509certificateauthenticator.subjectdn.regex.multiplematches.code.17006.error.message");
                } else if (errorCode.equalsIgnoreCase("17007")) {
                    errorMessage = resourceBundle
                            .getString("x509certificateauthenticator.subjectdn.regex.nomatches.code.17007.error.message");
                } else if (errorCode.equalsIgnoreCase("17008")) {
                    errorMessage = resourceBundle
                            .getString("x509certificateauthenticator.alternativenames.notfound.code.17008.error.message");
                }
            }
        }
    %>

    <html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>WSO2 Identity Server</title>

        <link href="libs/bootstrap_3.4.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/custom-common.css" rel="stylesheet">
        <script src="js/scripts.js"></script>
        <script src="assets/js/jquery-3.4.1.min.js"></script>
        <!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
    </head>

    <body>

    <!-- header -->
    <header class="header header-default">
        <div class="container-fluid"><br></div>
        <div class="container-fluid">
            <div class="pull-left brand float-remove-xs text-center-xs">
                <a href="#">
                    <img src="images/logo-inverse.svg" alt="wso2" title="wso2" class="logo">

                    <h1><em>Identity Server</em></h1>
                </a>
            </div>
        </div>
    </header>

    <!-- page content -->
    <div class="container-fluid body-wrapper">

        <div class="row">
            <div class="col-md-12">

                <!-- content -->
                <div class="container col-xs-10 col-sm-6 col-md-6 col-lg-4 col-centered wr-content wr-login col-centered">
                    <div>
                        <h2 class="wr-title blue-bg padding-double white boarder-bottom-blue margin-none">
                            Failed Authentication with X509Certificate &nbsp;&nbsp;</h2>

                    </div>
                    <div class="boarder-all ">
                        <div class="clearfix"></div>
                        <div class="padding-double login-form">
                            <div id="errorDiv"></div>
                            <%
                                if ("true".equals(authenticationFailed)) {
                            %>
                                    <div class="alert alert-danger" id="failed-msg"><%=errorMessage%></div>
                            <% } %>
                            <div id="alertDiv"></div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <!-- /content -->
                </div>
            </div>
            <!-- /content/body -->
        </div>
    </div>

    <!-- footer -->
    <footer class="footer">
        <div class="container-fluid">
            <p>WSO2 Identity Server | &copy;
                <script>document.write(new Date().getFullYear());</script>
                <a href="http://wso2.com/" target="_blank"><i class="icon fw fw-wso2"></i> Inc</a>. All Rights Reserved.
            </p>
        </div>
    </footer>
    <script src="libs/jquery_3.4.1/jquery-3.4.1.js"></script>
    <script src="libs/bootstrap_3.4.1/js/bootstrap.min.js"></script>
    </body>
    </html>
</fmt:bundle>