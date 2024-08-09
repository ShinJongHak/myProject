<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="#">Logo</a>

  <!-- Links -->
  <div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="#">게시판</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">Link 2</a>
	    </li>
	  </ul>
		
	  <ul class="navbar-nav">
	    <!-- Dropdown -->
	    <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
	        접속하기
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="#">게시판</a>
	        <a class="dropdown-item" href="#">Link 2</a>
	        <a class="dropdown-item" href="#">Link 3</a>
	      </div>
	    </li>
	  </ul>
  </div>
</nav>