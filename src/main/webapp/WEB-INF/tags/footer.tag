<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<footer id="footer" class="midnight-blue">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    &copy; 2015 宏信达. All Rights Reserved.
                </div>
                <div class="col-sm-6">
                    <ul class="pull-right">

                        <li><a href="<c:url value='/login'/>">后台登录</a></li>
                    </ul>
                </div>
            </div>
        </div>
</footer><!--/#footer-->

 <script src="<c:url value='/html/js/jquery.js'/>"></script>
    <script src="<c:url value='/html/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/html/js/jquery.prettyPhoto.js'/>"></script>
    <script src="<c:url value='/html/js/jquery.isotope.min.js'/>"></script>
    <script src="<c:url value='/html/js/main.js'/>"></script>
    <script src="<c:url value='/html/js/wow.min.js'/>"></script>
    <script src="<c:url value='/bootstrap/js/Jslib.js'/>"></script>
    
    <script type="text/javascript">
	
	$("#moreBtn").click(getMoreData); 
	function getMoreData() {
		var start = parseInt($('#start').val());
		var limit = parseInt($('#limit').val());
		start = start+limit;
		var json = {"menuid":$('#menuid').val(), "start":start,"limit":limit};
		var url = "<c:url value='/getMoreData'/>";
		
		fnAjaxPost(url,JSON.stringify(json),function(res){
			//alert(JSON.stringify(res));
			var list = JSON.parse(JSON.stringify(res));	
			for (var i in list) {
				var d = list[i];
				var myDate = new Date(d.addtime);
				var dateStr = myDate.Format("yyyy-MM-dd");
				var html = '<li><a href="'+d.htmlurl+'/'+d.id+'"><i class="fa fa-angle-double-right"></i> ';
					html += d.title+'<span class="pull-right">'+dateStr+'</span></a></li>';
				$('#newsList').append(html);
			}
			$('#start').val(start);
			
		});
		
	}
	
	</script>