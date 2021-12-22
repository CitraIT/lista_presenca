<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.citrait.listapresenca.DatabaseFactory" %>
<%@ page import="java.sql.Connection, java.sql.SQLException, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
if(session.getAttribute("isAuth") != null){
    response.sendRedirect("list.jsp");
}else if(request.getMethod().toLowerCase().equals("post")){
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	Connection conn = DatabaseFactory.getConnection();
	String query = "SELECT COUNT(*) FROM users WHERE username=? AND password=?";
	
	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setString(1, username);
	pstmt.setString(2, password);

	ResultSet rs = pstmt.executeQuery();
	rs.next();
	int resultCount = rs.getInt(1);
	out.println("Result count: " + resultCount);

	if(resultCount == 1){
		session.setAttribute("isAuth", true);
		session.setAttribute("authUser", username);
		response.sendRedirect("list.jsp");
		
	}else{
		response.sendRedirect("login.jsp?error=1");
	}
	
	
}else{
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Login</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <style>
            body {
                font-family: "Lato", sans-serif;
            }
            .main-head{
                height: 150px;
                background: #FFF;
            }
            .sidenav{
                height: 100%;
                background-color: #000;
                overflow-x: hidden;
                padding-top: 20px;
            }
            .main{
                padding: 0px 10px;
            }
            @media screen and (max-height: 450px){
                .sidenav{padding-top: 15px;}
            }
            @media screen and (max-width: 450px){
                .login-form{
                    margin-top: 10%;
                }
            }
            @media screen and (min-width: 768px){
                .main{
                    margin-left: 40%;
                }
                .sidenav{
                    width: 40%;
                    position: fixed;
                    z-index: 1;
                    top:0;
                    left: 0;
                }
                .login-form{
                    margin-top: 80%;
                }
            }
            .login-main-text{
                margin-top: 20%;
                padding: 60px;
                color: #FFF;
            }
            .login-main-text h2{
                font-weight: 300;
            }
            .btn-black{
                background-color: #000 !important;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="sidenav">
            <div class="login-main-text">
               <h2>Citra IT<br> Lista de Presença</h2>
               <p>Utilize sua conta corporativa para acesso a este site.</p>
            </div>
         </div>
         <div class="main">
		 
            <div class="col-md-6 col-sm-12">
               <div class="login-form">
                  <form action="login.jsp" method="POST">
                     <div class="form-group">
                        <label>Login</label>
                        <input type="text" class="form-control" name="username" placeholder="User Name" value="">
                     </div>
                     <div class="form-group">
                        <label>Senha</label>
                        <input type="password" class="form-control" name="password" placeholder="Password">
                     </div>
                     <button type="submit" class="btn btn-black">Login</button>
                  </form>
               </div>
            </div>
         </div>





        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<script>
            /* Erro Code List */
			var errorCodes = {1: "Login ou senha inválidos!"}

            /* Serching error code on URI */
			var errorCode = window.location.search.match(/error=(\d+)/);

            /* If error found, create an alert and append to document */
			if(errorCode){
                /* match from error list */
				let errnum = errorCode[1];
				
                /* alert div based on bootstrap */
                var divAlert = document.createElement("div");
				divAlert.classList.add("alert");
				divAlert.classList.add("alert-danger");
				divAlert.role = "";
				divAlert.innerHTML = errorCodes[errnum];
				
                /* append the alerto document on load end */
                var targetForm = document.getElementsByClassName("login-form")[0];
				targetForm.insertBefore(divAlert, targetForm.childNodes[0]);

				
			}
		</script>
    </body>
</html>


<%
}

%>