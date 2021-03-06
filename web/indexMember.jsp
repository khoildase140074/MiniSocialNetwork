<%-- 
    Document   : index
    Created on : Sep 15, 2020, 8:42:04 PM
    Author     : HOME
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/index.css"/>
        <title>T-FaceBook</title>
    </head>
    <body>
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.validate.js"></script>
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript">
            $(function() {
              $("#testform").validate({
                      rules: {
                          txtPostTitle: {
                              required: true,
                              rangelength: [6,100]
                          }
                          txtPostDescription: {
                              required: true
                          }
                      
                          txtFile: {
                              accept: "bmp|png|jpg"
                          }
                      }
              });
        </script>
        <h1>Welcome T-Facebook, ${sessionScope.NAME}!</h1>
        Email: ${sessionScope.EMAILID}
        <form action="MainController" method="POST">
            <input type="hidden" value="${sessionScope.EMAILID}" name="txtAccID"/>
            <input type="submit" value="Log Out" name="action"/>
        </form>
        <br/><br/>
        ${requestScope.NOTI}
        <form name="testform" action="PostController" id="testform" enctype="multipart/form-data" method="POST">
            Title: <input type="text" name="txtPostTitle" value="" placeholder="What do you think today ?"/><br/>
            Description: <input type="text" name="txtPostDescription" value="" placeholder="More and more..."/><br/>
<!--            <input type="file" name="txtFile" id="file" class="inputfile">
            <label for="file">Choose a file (Click me)</label><br/>-->
            Choose a file: <input type="file" name="txtFile"/><br/>
<!--            <button name="action" value="Post">POST</button>-->
            <input type="submit" value="Post" name="action"/>
        </form>
        
        <br/><br/>
        <form action="MainController" method="POST">
            Search a post: <input type="text" name="txtSearch" value="${param.txtSearch}"/>
            <input type="hidden" name="txtCheck" value="True">
            <input type="submit" name="action" value="Search"/>
        </form>
        <c:if test="${requestScope.LIST_ARTICLE != null}">
            <c:if test="${not empty requestScope.LIST_ARTICLE}" var="checkList">             
                <c:forEach items="${requestScope.LIST_ARTICLE}" var="article">
                    <form action="MainController" method="POST">
                        <button name="action" value="ShowDetails" style="text-align: left; width: 520px; height: 700px; border-radius: 15px;">
                            <h2>${article.accID.accName}</h2> 
                            ${article.articleDate}<br/><br/>
                            ${article.articleTitle}<br/><br/>
                            ${article.articleDescription}<br/><br/>
                            <c:if test="${article.articleImage != null}">
                                <img src="images/${article.articleImage}" style="width: 500px; height: 500px; border-radius: 15px;"/>                     
                            </c:if>
                            <input type="hidden" name="txtArticleID" value="${article.articleID}"/>
                            <input type="hidden" name="txtAcc" value="${article.accID}"/>
                            <input type="hidden" name="txtAccName" value="${article.accID.accName}"/>
                            <input type="hidden" name="txtArcDate" value="${article.articleDate}"/>
                            <input type="hidden" name="txtArcTitle" value="${article.articleTitle}"/>
                            <input type="hidden" name="txtArcDes" value="${article.articleDescription}"/>
                            <input type="hidden" name="txtArcImage" value="${article.articleImage}"/>
                            <c:if test="${article.accID.roleName == admin}">
                                <input type="submit" name="action" value="Delete"/>
                            </c:if>
                            <c:if test="${article.accID.accID == sessionScope.EMAILID}">
                                <input type="submit" name="action" value="Delete" onclick="return confirm('Are you sure ?')"/>
                            </c:if>
                        </button>
                        <br/><br/>
                    </form>
                </c:forEach>            
            </c:if>

            <c:if test="${!checkList}">
                <font color="red">Not Found Any Article</font>
            </c:if>
        </c:if>

        <c:forEach begin="1" end="${requestScope.ARTICLE_COUNT}" var="page" varStatus="counter">
            <c:url value="SearchArticleController" var="pageNum">
                <c:param name="pageIDPaging" value="${counter.count}"/>
                <c:param name="txtSearch" value="${param.txtSearch}"/>
            </c:url>
            <a href="${pageScope.pageNum}">
                <span style="margin-right: 2rem">${page}</span>
            </a>
        </c:forEach>
                
        
    </body>
</html>
