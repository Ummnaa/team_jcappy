<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="css/reset.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <style>
      
        /* -------------------------------로그인 스타일 --------------------------------------*/
            * {
        box-sizing: border-box;
        border-radius: 5px;
    }
   
  body {
    margin: 150px;
  }
  
  .lo {
    font-size: 50px;
  }
   
  .login-form {
      width: 300px;
      background-color: #EEEFF1;
      margin-right: auto;
      margin-left: auto;
      margin-top: 50px;
      padding: 20px;
      text-align: center;
      border: none;
      position: relative;
      top:50px;
  } 
  .text-field {
        font-size: 14px;
        padding: 10px;
        border: none;
        width: 260px;
        margin-bottom: 10px;
  }
  .submit-btn {
    font-size: 14px;
    border: none;
    padding: 10px;
    width: 260px;
    background-color: #1dc5e2;
    margin-bottom: 30px;
    color: white;
    cursor: pointer;
  }
  .links {
      text-align: center;
  }
  .links a {
    font-size: 12px;
    color: #9B9B9B;
  }
  .check {
    margin-bottom: 30px;
    font-size: 12px;
    text-align: left;
  }
  .lo{
    text-align: center;
    position: relative;
    top: 50px;

  }
  
  .txt_lav {
    cursor: pointer;
  }
   /* -------------------------------로그인 스타일 --------------------------------------*/
    </style>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <script>
       $(function(){
           $(".depth1 > li").mouseover(function(){
               $(this).find('.depth2').stop().slideDown(300);
           }).mouseleave(function(){
               $(this).find('.depth2').stop().slideUp(300);
           });
       });
   </script>
</head>
<body>  
   
            <!-- -----------------------------------------로그인 ------------------------------------------ -->
                <div class="lo">
                로그인
                </div>
                <div class="login-form">
                  <form>
                    <input type="text" name="email" class="text-field" placeholder="아이디">
                    <input type="password" name="password" class="text-field" placeholder="비밀번호">
                  </form>
                  
                    <div class="check">
                      <input type="checkbox" id="keepLogin" class="inp_radio"  name="keepLogin">
                      <label for="keepLogin" class="lab_g">
                      <span class="txt_lab">로그인 상태 유지</span>
                        </div>
                  <div class="links">
                    <input type="submit" value="로그인" class="submit-btn" onclick="location.href=''" >
                    <a href="asdasdsd" class="sign">회원가입</a>
                    
                    <a href="" class="link_find">아이디</a>
                          
                    <a href="" class="link_find">비밀번호 찾기</a>
                  </div>
                </div>
             <!-- -----------------------------------------로그인 ------------------------------------------ -->    

    </div>
</body>
</html>