<%
if(session.getAttribute("isAuth") == null){
    response.sendRedirect("login.jsp");
	//return;
}
%>
<%@ page import="java.util.List" %>
<%@ page import="com.citrait.listapresenca.Computer" %>
<%@ page import="com.citrait.listapresenca.ComputerDAO" %>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf8">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<style>
			html{ font-size: 14px; }
			.computerlist{
				border: 1px solid black;
				width: 200px;
				float: left;
				margin: 5px;
				padding: 5px;
				border-radius: 5px;
				text-align: center;
			}
			.computerlist:hover{
				background-color: #007bff;
				color: #fff;
				cursor: pointer;
			}
				
		</style>
	</head>
	<body>
	
	<!-- NOT NAVIGATION MENU -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand" href="#">CITRA IT - Usuários Conectados</a>
	</nav>
	<br />
	<!-- END OF NOT NAVIGATION MENU -->
	
	<div class="container-fluid">
	<table id="computertable" class="table table-striped table-bordered border border-gray" style="width:100%">
        <thead class="table table-dark">
            <tr>
                <th>Usuario</th>
                <th>Computador</th>
                <th>IP</th>
				<th>Anydesk</th>
                <th>Último Contato</th>
            </tr>
        </thead>
        <tbody>
		<%
			ComputerDAO computerDAO = new ComputerDAO();
			List<Computer> RegisteredComputers = computerDAO.all();
			for(Computer o : RegisteredComputers){
			%>
				<tr>
					<td><%=o.getConnectedUser()%></td>
					<td><%=o.getComputerName()%></td>
					<td><%=o.getComputerIp()%></td>
					<td><%=o.getAnydeskID()%></td>
					<td><%=o.getLastIncome()%></td>
				</tr>
			<%
			}
		
		%>
		</tbody>
	</table>
	</div> <!-- end of container -->
	

	
		
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
	
	<script>
	$(document).ready(function() {
		$('#computertable').DataTable({
			"searching": true,
			"paging": true,
			"info": true,
			"pageLength": 100,
			"language": {
				"search": "Localizar",
				"emptyTable":     "Nenhum dado disponivel",
				"info":           "Exibindo _START_ a _END_ de _TOTAL_ registros",
				"lengthMenu":     "Exibir _MENU_ registros",
				"loadingRecords": "Carregando...",
				"processing":     "Processando...",
				"zeroRecords":    "Nenhum registro encontrado",
				"paginate": {
					"first":      "Primeiro",
					"last":       "Último",
					"next":       "Próximo",
					"previous":   "Anterior"
				}
			}
		});
	} );
	</script>
	</body>
</html>