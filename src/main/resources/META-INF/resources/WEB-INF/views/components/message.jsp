<%
    String status=(String)request.getAttribute("status");
if(status != null){
	boolean flag = true;
    if(status.contains("Failed")){
    	flag = false;
    }
    if(flag)
    {
%>
    <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
        <strong><%=status %></strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">×</span>
        </button>
   </div>
<%    		
    }
    else {
%>
	<div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
        <strong><%=status %></strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">×</span>
        </button>
   </div>
<%
   }
}
%>
