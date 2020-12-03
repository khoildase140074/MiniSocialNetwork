<%-- 
    Document   : ShowDetails
    Created on : Sep 25, 2020, 9:27:09 PM
    Author     : HOME
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${requestScope.txtAccName}</title>
    </head>
    <body>
        <a href="SearchArticleController?pageIDPaging=1&txtSearch=">Back to Index</a>
        <h3>${requestScope.txtAccName}</h3>
        ${requestScope.txtArcDate}<br/>
        ${requestScope.txtArcTitle}<br/>
        ${requestScope.txtArcDes}<br/>
        <c:if test="${requestScope.txtArcImage != null}">
            <img src="images/${requestScope.txtArcImage}" style="width: 500px; height: 500px; border-radius: 15px;"/>                     
        </c:if>
        <form action="MainController" method="POST">
            <input type="hidden" name="txtImageArt" value="${requestScope.txtArcImage}"/>
            <input type="hidden" name="txtAcc" value="${requestScope.txtAcc}"/>
            <input type="hidden" name="txtAccName" value="${requestScope.txtAccName}"/>
            <input type="hidden" name="txtArcDate" value="${requestScope.txtArcDate}"/>
            <input type="hidden" name="txtArcTitle" value="${requestScope.txtArcTitle}"/>
            <input type="hidden" name="txtArcDes" value="${requestScope.txtArcDes}"/>
                            <input type="hidden" name="txtArticleID" value="${requestScope.txtArticleID}"/>
            <button type="submit" name="action" value="Like">${requestScope.LIKE} Likes</button>
        </form>
        <form action="MainController" method="POST">
            <input type="hidden" name="txtImageArt" value="${requestScope.txtArcImage}"/>
            <input type="hidden" name="txtAcc" value="${requestScope.txtAcc}"/>
            <input type="hidden" name="txtAccName" value="${requestScope.txtAccName}"/>
            <input type="hidden" name="txtArcDate" value="${requestScope.txtArcDate}"/>
            <input type="hidden" name="txtArcTitle" value="${requestScope.txtArcTitle}"/>
            <input type="hidden" name="txtArcDes" value="${requestScope.txtArcDes}"/>
            <input type="hidden" name="txtArticleID" value="${requestScope.txtArticleID}"/>
            <button type="submit" name="action" value="Dislike">${requestScope.DISLIKE} Dislikes</button>
        </form>
        <br/>
        Comment:<br/>
        <c:if test="${requestScope.LIST_COMMENT != null}">
            <c:if test="${not empty requestScope.LIST_COMMENT}" var="checkList">             
                <c:forEach items="${requestScope.LIST_COMMENT}" var="comment">
                    <form action="MainController" method="POST">
                        <br/>
                        ${comment.accID.accName} : ${comment.commentContent}
                        <c:if test="${ROLENAME == 'admin'}">
                            <input type="hidden" name="txtImageArt" value="${requestScope.txtArcImage}"/>
                            <input type="hidden" name="txtAcc" value="${requestScope.txtAcc}"/>
                            <input type="hidden" name="txtAccName" value="${requestScope.txtAccName}"/>
                            <input type="hidden" name="txtArcDate" value="${requestScope.txtArcDate}"/>
                            <input type="hidden" name="txtArcTitle" value="${requestScope.txtArcTitle}"/>
                            <input type="hidden" name="txtArcDes" value="${requestScope.txtArcDes}"/>
                            <input type="hidden" name="txtArticleID" value="${requestScope.txtArticleID}"/>
                            <input type="hidden" name="txtCmtID" value="${comment.cmtID}"/>
                            <input type="submit" name="action" value="Del" onclick="return confirm('Are you sure ?')"/>
                        </c:if>
                        <c:if test="${comment.accID.accID == sessionScope.EMAILID}"><input type="hidden" name="txtImageArt" value="${requestScope.txtArcImage}"/>
                            <input type="hidden" name="txtAcc" value="${requestScope.txtAcc}"/>
                            <input type="hidden" name="txtAccName" value="${requestScope.txtAccName}"/>
                            <input type="hidden" name="txtArcDate" value="${requestScope.txtArcDate}"/>
                            <input type="hidden" name="txtArcTitle" value="${requestScope.txtArcTitle}"/>
                            <input type="hidden" name="txtArcDes" value="${requestScope.txtArcDes}"/>
                            <input type="hidden" name="txtArticleID" value="${requestScope.txtArticleID}"/>
                            <input type="hidden" name="txtCmtID" value="${comment.cmtID}"/>
                            <input type="submit" name="action" value="Del" onclick="return confirm('Are you sure ?')"/>
                        </c:if>
                    </form>
                </c:forEach>            
            </c:if>

            <c:if test="${!checkList}">
                <font color="red">Be the first to comment on this content.</font>
            </c:if>
        </c:if>
        <br/>
        <form action="MainController" method="POST">
            <input type="text" name="txtCmt" placeholder="Write a comment ..."/>
            <input type="hidden" name="txtImageArt" value="${requestScope.txtArcImage}"/>
            <input type="hidden" name="txtAcc" value="${requestScope.txtAcc}"/>
            <input type="hidden" name="txtAccName" value="${requestScope.txtAccName}"/>
            <input type="hidden" name="txtArcDate" value="${requestScope.txtArcDate}"/>
            <input type="hidden" name="txtArcTitle" value="${requestScope.txtArcTitle}"/>
            <input type="hidden" name="txtArcDes" value="${requestScope.txtArcDes}"/>
            <input type="hidden" name="txtArticleID" value="${requestScope.txtArticleID}"/>
            <input type="submit" name="action" value="Post Comment"/>
        </form>
        <br/>
        <br/>
        <form action="MainController" method="POST">       
            <c:if test="${requestScope.txtAccID.roleName == admin}">
                <input type="hidden" name="articleID" value="${requestScope.articleID}"/>
                <input type="submit" name="action" value="Delete" onclick="return confirm('Are you sure ?')"/>
            </c:if>
            <c:if test="${requestScope.txtAccID.accID == sessionScope.EMAILID}">
                <input type="hidden" name="articleID" value="${requestScope.articleID}"/>
                <input type="submit" name="action" value="Delete" onclick="return confirm('Are you sure ?')"/>
            </c:if>
        </form> 
        
    </body>
</html>
