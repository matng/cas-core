<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<div class="nav">
	<span id="title"><a href="<c:url value='/${parentMenu.menuurl}'/>">${parentMenu.menuname}<i class="fa fa-angle-down"></i></a></span>
	<c:forEach var="lmenu" items="${leftMenuList}" varStatus="s">  															
		<c:choose>
       			<c:when test="${lmenu.count > 1}">	
       				<span ><a href="<c:url value='/${lmenu.menuurl}'/>">${lmenu.menuname}</a></span>
       			</c:when>
       			<c:otherwise>
       				<span ><a href="<c:url value='/${lmenu.menuurl}/${lmenu.id}'/>">${lmenu.menuname}</a></span>
       			</c:otherwise>			                            		
       		</c:choose>	   
	</c:forEach>
</div>