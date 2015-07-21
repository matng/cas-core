<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="keywords" content="宏信达"/>
    <meta name="description" content="宏信达是一家专注于交通安全的软件公司。">
    <title>宏信达网站</title>	
	<tags:header />
    
</head><!--/head-->

<body class="homepage">

	<!-- 首页菜单 -->
	<tags:menu />
   
    

    <section id="main-slider" class="no-margin">
        <div class="carousel slide">
            <ol class="carousel-indicators">
                <li data-target="#main-slider" data-slide-to="0" class="active"></li>
                <li data-target="#main-slider" data-slide-to="1"></li>
                <li data-target="#main-slider" data-slide-to="2"></li>
				<li data-target="#main-slider" data-slide-to="3"></li>
            </ol>
            <div class="carousel-inner">

                <div class="item active" style="background-image: url(html/images/logo/banner1.jpg)">
                    <div class="container">
                        <div class="row slide-margin">
                            <div class="col-sm-6">
                                <div class="carousel-content">
                                    
                                </div>
                            </div>

                        </div>
                    </div>
                </div><!--/.item-->
				
				<div class="item" style="background-image: url(html/images/logo/banner2.jpg)">
                    <div class="container">
                        <div class="row slide-margin">
                            <div class="col-sm-6">
                                <div class="carousel-content">
                                    <a class="btn-slide animation animated-item-1" href="#"><img src="html/images/logo/wBtn.png" alt="点击查看"></a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div><!--/.item-->

                <div class="item" style="background-image: url(html/images/logo/banner3.jpg)">
                    <div class="container">
                        <div class="row slide-margin">
                            <div class="col-sm-6">
                                <div class="carousel-content">
                                    <a class="btn-slide animation animated-item-1" href="#"><img src="html/images/logo/wBtn.png" alt="点击查看"></a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div><!--/.item-->

                <div class="item" style="background-image: url(html/images/logo/banner4.jpg)">
                    <div class="container">
                        <div class="row slide-margin">
                            <div class="col-sm-6">
                                <div class="carousel-content">
                                    <a class="btn-slide2 animation animated-item-1" href="#"><img src="html/images/logo/bBtn.png" alt="点击查看"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--/.item-->
            </div><!--/.carousel-inner-->
        </div><!--/.carousel-->
        <a id="prev" class="prev hidden-xs" href="#main-slider" data-slide="prev">
            <i class="fa fa-chevron-left"></i>
        </a>
        <a id="sNext" class="next hidden-xs" href="#main-slider" data-slide="next">
            <i class="fa fa-chevron-right"></i>
        </a>
    </section><!--/#main-slider-->
	
	
	
	<!-- 热点图数据 -->
	<section id="feature" >
        <div class="container">
            <div class="row">
                <div class="imgbox">
                    <ul class="portfolio-filter">
						<li><a class="active" href="#" data-filter="*">全部</a></li>
						<c:forEach var="gn" items="${groupNameList}" varStatus="s">  															
							<li><a  href="#" data-filter=".${gn.menuUrl}">${gn.groupName}</a></li>
						</c:forEach>
					</ul><!--/#portfolio-filter-->
                        
				<div class="row">			
	                <div class="portfolio-items">
	                	
	                	<c:forEach var="hot" items="${hotPicList}" varStatus="s">  															
							<div class="portfolio-item ${hot.menuUrl} col-xs-12 col-sm-4 col-md-3">
		                        <div class="recent-work-wrap">
		                            <img class="img-responsive" src="<c:url value='${hot.smallpicurl}'/>" alt="">
		                            <div class="overlay">
		                                <div class="recent-work-inner">
		                                    <h3><a href="#">${hot.resName}</a></h3>
		                                    <a class="preview" href="<c:url value='${hot.bigpicurl}'/>" rel="prettyPhoto"><i class="fa fa-eye"></i> 看大图</a><br>
											<a class="preview" href="<c:url value='${hot.menuUrl}'/>"><i class="fa fa-eye"></i> 看内容</a>
		                                </div> 
		                            </div>
		                        </div>
		                    </div><!--/.portfolio-item-->						
						</c:forEach>	                
					</div>
                </div>
												
                </div><!--/.services-->
            </div><!--/.row-->    
        </div><!--/.container-->
    </section><!--/#feature-->
	

	 <!-- 新闻数据 -->
	<section id="feature" >
        <div class="container">
            <div class="row">
                <div class="features">
                     <div class="col-sm-6 col-md-6">
						<div class="widget">
							<h3>公司动态 <span class="pull-right"><a href="${type1.moreUrl}">更多 <i class="fa fa-angle-right"></i></a></span></h3>
							<div class="row">
								<div class="col-sm-12">
									<ul class="newsBox">
										<c:forEach var="t1" items="${type1.contentList}" varStatus="s">  
											<li><a href="${t1.htmlurl}/${t1.id}"><i class="fa fa-angle-double-right"></i> ${t1.title} <span class="pull-right"><fmt:formatDate value="${t1.addtime}" pattern="yyyy-MM-dd"/></span></a></li>
										</c:forEach>
									</ul>
									
								</div>
							</div>                     
						</div><!--/.archieve-->
					</div>

					<div class="col-sm-6 col-md-6">
							<div class="widget">
								<h3>行业新闻 <span class="pull-right"><a href="${type2.moreUrl}">更多 <i class="fa fa-angle-right"></i></a></span></h3>
								<div class="row">
									<div class="col-sm-12">
										<ul class="newsBox">
											<c:forEach var="t2" items="${type2.contentList}" varStatus="s">  
												<li><a href="${t2.htmlurl}/${t2.id}"><i class="fa fa-angle-double-right"></i> ${t2.title} <span class="pull-right"><fmt:formatDate value="${t2.addtime}" pattern="yyyy-MM-dd"/></span></a></li>
											</c:forEach>
										</ul>
										
									</div>
								</div>    
						  </div>
					</div>                    
                </div><!--/.services-->
            </div><!--/.row-->    
        </div><!--/.container-->
    </section><!--/#feature-->
	
	<section id="feature" >
        <div class="container">
            <div class="row">
                <div class="features">
                     <div class="col-sm-6 col-md-6">
						<div class="widget">
							<h3>产品 <span class="pull-right"><a href="${type3.moreUrl}">更多 <i class="fa fa-angle-right"></i></a></span></h3>
							<div class="row">
								<div class="col-sm-12">
									<ul class="newsBox">
										<c:forEach var="t3" items="${type3.contentList}" varStatus="s">  
											<li><a href="${t3.htmlurl}/${t3.id}"><i class="fa fa-angle-double-right"></i> ${t3.title} <span class="pull-right"><fmt:formatDate value="${t3.addtime}" pattern="yyyy-MM-dd"/></span></a></li>
										</c:forEach>
									</ul>
									
								</div>
							</div>                     
						</div><!--/.archieve-->
					</div>

					<div class="col-sm-6 col-md-6">
							<div class="widget">
								<h3>服务 <span class="pull-right"><a href="${type4.moreUrl}">更多 <i class="fa fa-angle-right"></i></a></span></h3>
								<div class="row">
									<div class="col-sm-12">
										<ul class="newsBox">
											<c:forEach var="t4" items="${type4.contentList}" varStatus="s">  
												<li><a href="${t4.htmlurl}/${t4.id}"><i class="fa fa-angle-double-right"></i> ${t4.title} <span class="pull-right"><fmt:formatDate value="${t4.addtime}" pattern="yyyy-MM-dd"/></span></a></li>
											</c:forEach>
										</ul>
										
									</div>
								</div>    
						  </div>
					</div>                    
                </div><!--/.services-->
            </div><!--/.row-->    
        </div><!--/.container-->
    </section><!--/#feature-->
	
	
	<!-- 友情连接 -->
	<section id="feature" >
        <div class="container">
            <div class="row">
                <div class="LinkBox">
                     <div class="col-sm-12 col-md-12">
						<div class="media linkBox-wrap">
							<div class="pull-left">
								<img class="img-responsive" src="html/images/logo/link.png">
							</div>
							<div class="media-body">
								<h3 class="media-heading">友情连接</h3>
								<p>
								<c:forEach var="link" items="${linkList}" varStatus="s">  
									<c:choose>
										<c:when test="${link.linktype == 1}">															
											  <a href="${link.siteurl}" target="_blank">${link.sitename}</a>&nbsp;&nbsp;&nbsp;
										</c:when>
										<c:otherwise>
										
											<a href="${link.siteurl}" target="_blank"><img src="${link.logourl}" alt="${link.sitename}"></a>&nbsp;&nbsp;&nbsp;
																				
										</c:otherwise>							
									</c:choose>
								
								</c:forEach>

								</p>
							</div>
						</div>
					</div>                   
                </div><!--/.services-->
            </div><!--/.row-->    
        </div><!--/.container-->
    </section><!--/#feature-->
	

    <tags:footer />
   
    <script type="text/javascript">
	
	setInterval(sNextFunc,5000);
	function sNextFunc() {
		$('#sNext').click();
	}
	
	</script>
</body>
</html>