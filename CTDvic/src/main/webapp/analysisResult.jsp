<%--
  Created by IntelliJ IDEA.
  User: win12
  Date: 2024/4/2
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="language" content="en" />
    <meta name="author" content="CTDvic" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>CTDvic</title>
    <link rel="shortcut icon" href="IMAGE/c.png" type="image/x-icon">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="js/jquery.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="js/bootstrap.min.js"></script>
    <link href="css/sweetalert.css" rel="stylesheet">
    <script src="js/sweetalert.js"></script>
    <link rel="stylesheet" href="css/nice-select.css">
    <script src="js/jquery.nice-select.js"></script>
    <script src="js/swiper-bundle.js"></script>
    <script src="https://proteinpaint.stjude.org/bin/proteinpaint.js" charset="utf-8"></script>
    <!--    custom      -->
    <link href="css/index.css" rel="stylesheet">
    <link href="css/tools.css" rel="stylesheet">
    <script src="js/index.js"></script>
</head>
<style>
.tit{
    margin-top: 48px;
    text-align: center;
    border-bottom: solid 1px #d5d6d7;
    height: 49px;
    box-shadow: 0px 8px 10px -5px rgba(140, 140, 140, 0.5);
    width: 100%;
}
.inside{
    border: 0;
}
.horizontal-line{
    width: 90%;
}
</style>
<body>
    <div class="container-fluid">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <!-- 标题 -->
                <div class="row clearfix">
                    <div class="col-md-12 column" style="padding: 0">
                        <h1 class="tit">Analysis result</h1>
                    </div>
                </div>
                <!-- 结果 -->
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <div class="part_search" style="height: auto">
                            <div class="outside">
                                <div class="inside" style="height: auto">
                                    <ul>
                                        <li class="re-li">
                                            <div class="result-title" style="margin: 25px auto 25px 2px"><span style="font-weight: 600;">JobID: </span><span>${id}</span></div>
                                        </li>

                                        <div class="horizontal-line" style="margin-left: 0"></div>
                                        <!--  分元件结果下载  -->
                                        <li class="re-li">
                                            <div class="result-title"><img src="IMAGE/icon_result_downt.png"><span>Download</span></div>
                                            <div style=" height: 90px;width: 90%;background-color: rgb(255, 255, 255);"><div id="download-div" style="margin-top: 30px;margin-left: 30px;"></div></div>
                                        </li>

                                        <!--  drivergene选择  -->
                                        <li class="re-li">
                                            <div class="result-title"><img src="IMAGE/icon_list.png"><span>Gene list</span></div>
                                            <div id="genelist-div" style="height: 70px;width: 90%;background-color: rgb(255, 255, 255);"></div>
                                        </li>

                                        <!--  驱动突变位点可视化  -->
                                        <li class="re-li">
                                            <div class="result-title"><img src="IMAGE/icon_visualize.png"><span>Visualization</span></div>
                                            <div id="geneView-div" style="width: 90%;background-color: rgb(255, 255, 255); position: relative;"></div>
                                        </li>

                                        <!--  生存结果  -->
                                        <li class="re-li">
                                            <div class="result-title"><img src="IMAGE/icon_survivial.png"><span>Prognostic Analysis</span></div>
                                            <div id="survival-div" style="width: 90%;background-color:rgb(255, 255, 255);"></div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <script>
                            //生存执行函数
                            function survivalShow(element){
                                $("#survival-div").empty().append("<image style='width: 600px;height: 600px; margin-top: 90px; margin-bottom: 90px; margin-left: 150px; -webkit-box-shadow: 2px 4px 11px #737373; -moz-box-shadow: 2px 4px 11px #737373;' src='"+element+"'>"+
                                    "<a href='"+element + "' style='margin-left: 15px;' download><button class=\"example_button\" type=\"button\">"+
                                    " <span class=\"button__text\">Downlaod</span>"+
                                    "<span class=\"button__icon\"><svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 35 35\" id=\"bdd05811-e15d-428c-bb53-8661459f9307\" data-name=\"Layer 2\" class=\"svg\"><path d=\"M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z\"></path><path d=\"M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z\"></path><path d=\"M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z\"></path></svg></span>\n" +
                                    "                                                    </button>\n" +
                                    "                                                </a>");
                            }

                            function geneView(gene){
                                $("#geneView-div").empty();
                                runproteinpaint(gene);
                            }


                            fetch('/CTDvic/file/data/analysis/results/${id}/visual.json')
                                .then(response => {
                                    if (!response.ok) {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Oops...',
                                            text: "Request error...",
                                        })
                                        throw new Error('Network response was not ok');
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    console.log(data); // 这里的data就是解析后的JSON对象

                                        console.log("返回成功");
                                        switch (data.code){
                                            case "100":
                                                if (data.elementList.length > 0) {
                                                    $("#download-div").empty();
                                                    for (var i = 0; i < data.elementList.length; i++) {
                                                        var str = data.elementList[i].split("_")[0];
                                                        if(str == 'splice'){
                                                            str = 'splice_site';
                                                        }
                                                        $("#download-div").append("<a href='"+ data.pathToAnalysis+"results/"+data.uuid+"/element_filter/"+data.elementList[i] + ".txt' download><button class=\"example_button\" type=\"button\">"+
                                                            " <span class=\"button__text\">"+str+"</span>"+
                                                            "<span class=\"button__icon\"><svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 35 35\" id=\"bdd05811-e15d-428c-bb53-8661459f9307\" data-name=\"Layer 2\" class=\"svg\"><path d=\"M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z\"></path><path d=\"M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z\"></path><path d=\"M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z\"></path></svg></span>\n" +
                                                            "                                                    </button>\n" +
                                                            "                                                </a>");
                                                    }
                                                }
                                                //生成基因下拉列表
                                                $("#genelist-div").empty().append("<select id='geneList' class=\"wide form-control\"></select>")
                                                //给第一个基因添加到select，并设置为默认激活选项
                                                var newGene =  $('<option>').text(data.geneList[0]).attr("selected", "selected");
                                                $('#geneList').append(newGene);
                                                for(var i=1;i < data.geneList.length; i++) {
                                                    var newGene =  $('<option>').text(data.geneList[i]);
                                                    $('#geneList').append(newGene);
                                                }
                                                $('select').niceSelect();
                                                //给所有基因holder属性重新赋值,使能执行js选择器
                                                var keys = Object.keys(data.visual);
                                                for (var i = 0; i < keys.length; i++) {
                                                    data.visual[keys[i]].holder = document.getElementById('geneView-div');
                                                }

                                                //显示默认可视化基因
                                                $("#geneView-div").empty();
                                                let gene_visual_100 = data.geneList[0]
                                                runproteinpaint(data.visual[gene_visual_100]);
                                                console.log(data.visual[gene_visual_100]);

                                                //当下拉列表选中基因时展示对应生存和基因view
                                                $('#geneList').on('change', function() {
                                                    var selectedText = $(this).find('option:selected').text();
                                                    // 在这里执行相应的操作，例如调用一个函数
                                                    geneView(data.visual[selectedText]);
                                                });
                                                break;

                                            case "101":
                                                if (data.elementList.length > 0) {
                                                    $("#download-div").empty();
                                                    for (var i = 0; i < data.elementList.length; i++) {
                                                        var str = data.elementList[i].split("_")[0];
                                                        if(str == 'splice'){
                                                            str = 'splice_site';
                                                        }
                                                        $("#download-div").append("<a href='" + data.pathToAnalysis+"results/"+data.uuid+"/element_hot_mutation/"+data.elementList[i] + ".txt' download><button class=\"example_button\" type=\"button\">"+
                                                            " <span class=\"button__text\">"+str+"</span>"+
                                                            "<span class=\"button__icon\"><svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 35 35\" id=\"bdd05811-e15d-428c-bb53-8661459f9307\" data-name=\"Layer 2\" class=\"svg\"><path d=\"M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z\"></path><path d=\"M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z\"></path><path d=\"M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z\"></path></svg></span>\n" +
                                                            "                                                    </button>\n" +
                                                            "                                                </a>");
                                                    }
                                                }

                                                //生成基因下拉列表
                                                $("#genelist-div").empty().append("<select id='geneList' class=\"wide form-control\"></select>")
                                                //给第一个基因添加到select，并设置为默认激活选项
                                                var newGene =  $('<option>').text(data.geneList[0]).val(data.pathToAnalysis+"survivals/"+data.uuid+"/"+data.geneList[0]+".png").attr("selected", "selected");
                                                $('#geneList').append(newGene);
                                                for(var i=1;i < data.geneList.length; i++) {
                                                    var newGene =  $('<option>').text(data.geneList[i]).val(data.pathToAnalysis+"survivals/"+data.uuid+"/"+data.geneList[i]+".png");
                                                    $('#geneList').append(newGene);
                                                }
                                                $('select').niceSelect();

                                                //显示默认生存图
                                                $("#survival-div").empty().append("<image style='width: 600px;height: 600px;  margin-top: 90px; margin-bottom: 90px; margin-left: 150px; -webkit-box-shadow: 2px 4px 11px #737373; -moz-box-shadow: 2px 4px 11px #737373;' src='" + data.pathToAnalysis+"survivals/"+data.uuid+"/"+data.geneList[0]+".png"+"'>" +
                                                    "<a href='"+ data.pathToAnalysis+"survivals/"+data.uuid+"/"+data.geneList[0] + ".png"+ "' style='margin-left: 15px;' download><button class=\"example_button\" type=\"button\">"+
                                                    " <span class=\"button__text\">Downlaod</span>"+
                                                    "<span class=\"button__icon\"><svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 35 35\" id=\"bdd05811-e15d-428c-bb53-8661459f9307\" data-name=\"Layer 2\" class=\"svg\"><path d=\"M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z\"></path><path d=\"M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z\"></path><path d=\"M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z\"></path></svg></span>\n" +
                                                    "                                                    </button>\n" +
                                                    "                                                </a>")

                                                //给所有基因holder属性重新赋值,使能执行js选择器
                                                var keys = Object.keys(data.visual);
                                                for (var i = 0; i < keys.length; i++) {
                                                    data.visual[keys[i]].holder = document.getElementById('geneView-div');
                                                }

                                                //显示默认可视化基因
                                                $("#geneView-div").empty();
                                                let gene_visual = data.geneList[0]
                                                runproteinpaint(data.visual[gene_visual]);
                                                console.log(data.visual[gene_visual]);

                                                //当下拉列表选中基因是展示对应生存和基因view
                                                $('#geneList').on('change', function() {
                                                    var selectedValue = $(this).val();
                                                    var selectedText = $(this).find('option:selected').text();
                                                    // 在这里执行相应的操作，例如调用一个函数
                                                    survivalShow(selectedValue);
                                                    geneView(data.visual[selectedText]);
                                                });

                                        }


                                })
                                .catch(error => {
                                    console.error('Fetching JSON failed:', error);
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Oops...',
                                        text: "Request error...",
                                    })
                                });
                        </script>
                    </div>
                </div>

                <!-- footer  -->
                <div class="row clearfix shift_down_foot">
                    <div class="col-md-12 column" style="margin: 0; padding: 0;">
                        <div class="foot">© College of Bioinformatics Science and Technology, Harbin Medical University, Harbin, China.</div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
