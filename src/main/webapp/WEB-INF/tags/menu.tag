<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<header id="header">    
        <nav class="navbar navbar-inverse" role="banner">
            <div class="container">
                <div class="navbar-header">      
                    <a class="navbar-brand" href="#"><img src="<c:url value='/html/images/logo/logo.png'/>" alt="logo"></a>
                </div>
				
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">                 
						<c:forEach var="m" items="${menuList}" varStatus="s">   
							<c:choose>
								<c:when test="${m.subMenuLength == 0}">															
									<li class="${m.menu.menuurl eq activeMenu ? 'active' : ''}"><a href="<c:url value='/${m.menu.menuurl}'/>">${m.menu.menuname}</a></li>    
								</c:when>
								<c:otherwise>								
									<li class="dropdown ">
			                            <a href="<c:url value='/${m.menu.menuurl}'/>" class="dropdown-toggle" data-toggle="dropdown">${m.menu.menuname}<i class="fa fa-angle-down"></i></a>
			                            <ul class="dropdown-menu">
			                            	<c:forEach var="sMenu" items="${m.subMenu}" varStatus="s">   
			                            		<c:choose>
			                            			<c:when test="${sMenu.count > 1}">	
			                            				<li><a href="<c:url value='/${sMenu.menuurl}'/>">${sMenu.menuname}</a></li>
			                            			</c:when>
			                            			<c:otherwise>
			                            				<li><a href="<c:url value='/${sMenu.menuurl}/${sMenu.id}'/>">${sMenu.menuname}</a></li>
			                            			</c:otherwise>			                            		
			                            		</c:choose>	                            		
			                            	</c:forEach>		                               
			                            </ul>
			                        </li>																	
								</c:otherwise>							
							</c:choose>											
						</c:forEach>                                             
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->		
    </header><!--/header-->
