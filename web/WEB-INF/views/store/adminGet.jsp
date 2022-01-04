<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.styldle.vo.UserVO" %>
<html>
<head>
    <title>Styldle - admin</title>
    <style>
        .uploadResult ul li {
            list-style: none;
            margin-bottom: 30px;
        }
        .uploadResult ul li img {
            width: 600px;
            height: auto;
        }
        .container {
            max-width: 250px;
            margin: 100px auto;
            padding: 20px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link rel="icon" type="image/png" href="/resources/images/icons/favicon_modify.png"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/lux/bootstrap.min.css" integrity="sha384-9+PGKSqjRdkeAU7Eu4nkJU8RFaH8ace8HGXnkiKMP9I9Te0GJ4/km3L1Z8tXigpG" crossorigin="anonymous">
</head>
<body class="animsition" style="animation-duration: 1500ms; opacity: 1;">

    <c:if test="${userVO.role != 'admin'}">
        <script>
            alert("관리자 권한입니다.");
            history.back();
        </script>
    </c:if>

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">STYLDLE 관리자</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse show" id="navbarColor01" style="">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/store/register">상품 등록</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/store/adminList">상품 목록</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/store/adminOrderList">주문 목록</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/store/list">메인 화면</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <fieldset class="container">
        <legend>상품 조회</legend>

        <div class="form-group">
            <fieldset disabled="">
                <label class="form-label" for="productName">상품명</label>
                <input class="form-control" id="productName" type="text" placeholder="${product.productName}" disabled="">
            </fieldset>
        </div>
        <div class="form-group">
            <fieldset disabled="">
                <label class="form-label" for="type">상품분류</label>
                <input class="form-control" id="type" type="text" placeholder="${product.type}" disabled="">
            </fieldset>
        </div>
        <div class="form-group">
            <fieldset disabled="">
                <label class="form-label" for="detail">코멘트</label>
                <input class="form-control" id="detail" type="text" placeholder="${product.detail}" disabled="">
            </fieldset>
        </div>
        <div class="form-group">
            <fieldset disabled="">
                <label class="form-label" for="price">판매가</label>
                <input class="form-control" id="price" type="text" placeholder="<fmt:formatNumber value="${product.price}" pattern="###,###,###"/>원" disabled="">
            </fieldset>
        </div>
        <div class="form-group">
            <fieldset disabled="">
                <label class="form-label" for="stock">재고</label>
                <input class="form-control" id="stock" type="text" placeholder="${product.stock}" disabled="">
            </fieldset>
        </div>
        <div class="form-group">
            <div class="uploadResult">
                <ul>

                </ul>
            </div>
        </div>
        <div>
            <button type="button" data-oper="modify" class="btn btn-warning">상품 수정</button>
            <button type="button" data-oper="list" class="btn btn-outline-secondary">목록</button>
        </div>
    </fieldset>

    <form action="/store/modify" method="get">
        <input type="hidden" id="productId" name="productId" value="${product.productId}">
        <input type="hidden" name="page" value="${cri.page}">
        <input type="hidden" name="perPageNum" value="${cri.perPageNum}">
        <input type="hidden" name="keyword" value="${cri.keyword}">
    </form>

    <script type="text/javascript">
        $(document).ready(function() {
            (function() {
                var productId = ${product.productId}
                $.getJSON("/store/getAttachList", {productId: productId}, function (arr) {
                    console.log(arr)
                    var str = ''
                    $(arr).each(function(i, attach) {
                        var fileCallPath = encodeURIComponent(attach.uploadPath+'/'+attach.uuid+'_'+attach.fileName)
                        str += "<li>"
                        str += "<img src='/display?fileName="+fileCallPath+"'>"
                        str += "</li>"
                    })
                    $('.uploadResult ul').html(str)
                })
            })()

            var formObj = $('form')
            $("button[data-oper='modify']").click(function(e) {
                formObj.submit()
            })
            $("button[data-oper='list']").click(function(e) {
                formObj.find('#productId').remove()
                formObj.attr('action', '/store/adminList')
                formObj.submit()
            })
        })
    </script>
</body>
</html>
