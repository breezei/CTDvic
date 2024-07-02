//多个页面需要全选的组
var assem = new Array("disease","gene","element","function","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
$(document).ready(function(){
    //向ul插入疾病/基因list
    var liAssem = ["Variant_disease","Gene_disease","Gene_gene","Curation_disease","Curation_gene"]
    var obj;
    liAssem.forEach(function (value,index){
        console.log(value)
        if ($("#"+value).length>0){
            console.log(value)
            if(value === "Variant_disease" || value ==="Gene_disease") {
                switch (value) {
                    case "Variant_disease" :
                        obj = Variant_disease;
                        break
                    case "Gene_disease" :
                        obj = Gene_disease;
                        break
                }
                console.log(obj)
                var length_obj = Object.keys(obj).length;
                var var_d = Object.keys(obj);
                console.log(Object.keys(obj))
                for (var i = 0; i < length_obj; i++) {
                    console.log(Letter[i])
                    let innerLi = "<li><label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='alldisease' class='" + Letter[i] + "all'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>" + var_d[i] + "</span></label><ul>";
                    let var_d_class = obj[var_d[i]];
                    console.log(i)
                    console.log(obj[var_d[i]])
                    for (let j = 0; j < var_d_class.length; j++) {
                        innerLi += "<li><label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='diseasetype' class='" + Letter[i] + "' value='" + var_d_class[j] + "'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>" + var_d_class[j] + "</span></label></li>"
                    }
                    innerLi += "</ul></li>";
                    console.log(innerLi);
                    $("#" + value).append(innerLi);
                }
            }else{
                switch (value) {
                    case "Gene_gene" :
                        obj = Gene_gene;
                        console.log(obj)
                        var length_obj = Object.keys(obj).length;
                        var vart_g = Object.keys(obj);
                        console.log(Object.keys(obj))
                        for (var i = 0; i < length_obj; i++) {
                            let innerLi = "<li><label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='geneall' class='geneall'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>All</span></label><ul>";
                            let vart_g_class = obj[vart_g[i]];
                            console.log(i)
                            console.log(obj[vart_g[i]])
                            for (let j = 0; j < vart_g_class.length; j++) {
                                innerLi += "<li><label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='gene' class='gene' value='" + vart_g_class[j] + "'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>" + vart_g_class[j] + "</span></label></li>"
                            }
                            innerLi += "</ul></li>";
                            console.log(innerLi);
                            $("#" + value).append(innerLi);
                        }
                        break

                    case "Curation_disease" :
                        obj = Curation_disease;
                        console.log(obj)
                        var length_obj = Object.keys(obj).length;
                        var vart_g = Object.keys(obj);
                        console.log(Object.keys(obj))
                        for (var i = 0; i < length_obj; i++) {
                            let innerLi = "<li><label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='diseaeseall' class='diseaseall'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>All</span></label><ul>";
                            let vart_g_class = obj[vart_g[i]];
                            console.log(i)
                            console.log(obj[vart_g[i]])
                            for (let j = 0; j < vart_g_class.length; j++) {
                                innerLi += "<li><label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='diseasetype' class='disease' value='" + vart_g_class[j] + "'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>" + vart_g_class[j] + "</span></label></li>"
                            }
                            innerLi += "</ul></li>";
                            console.log(innerLi);
                            $("#" + value).append(innerLi);
                        }
                        break

                    case "Curation_gene" :
                        obj = Curation_gene;
                        console.log(obj)
                        var length_obj = Object.keys(obj).length;
                        var vart_g = Object.keys(obj);
                        console.log(Object.keys(obj)) //<label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='geneall' class='geneall'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>All</span></label>
                        for (var i = 0; i < length_obj; i++) {
                            let innerLi = "<ul>";
                            let vart_g_class = obj[vart_g[i]];
                            console.log(i)
                            console.log(obj[vart_g[i]])
                            for (let j = 0; j < vart_g_class.length; j++) {
                                innerLi += "<li><label class='check_label'><div class='checkbox-wrapper-31'><input type='checkbox' name='gene' class='gene' value='" + vart_g_class[j] + "'><svg viewBox='0 0 35.6 35.6'><circle class='background' cx='17.8' cy='17.8' r='17.8'></circle><circle class='stroke' cx='17.8' cy='17.8' r='14.37'></circle><polyline class='check' points='11.78 18.12 15.55 22.23 25.17 12.87'></polyline></svg></div> <span>" + vart_g_class[j] + "</span></label></li>"
                            }
                            innerLi += "</ul>";
                            console.log(innerLi);
                            $("#" + value).append(innerLi);
                        }
                        break


                }

            }
        }
    })


    //全选或全不选
    var choose=function(arg){
        return function(){
        if($(this).is(':checked')){
            $('input[class="'+arg+'"]').each(function(){
                $(this).prop("checked",true);
            });
        }else{
            $('input[class="'+arg+'"]').each(function(){
                $(this).prop("checked",false);
            });
        }
    }
    }
    for(i in assem){
        var b= assem[i]+"all";
        //把click事件执行的函数用匿名函数的话会用外部循环的最后一个值，因此用函数表达式或者函数声明，return 函数维持内部变量作用域
        //选择器和对应事件绑定
    $('input[class="'+b+'"]').on("click",choose(assem[i]))
}

//mo-ml: 非missense时禁用mutation describe
$('#mt').on("change",function(){
    console.log("执行");
    var select=$(this).children('option:selected').val();
   if(select=="missense"){
    //先清空value的值，否则无法显示placeholder
    $('#mutation_describe').val("").attr("placeholder","T790M:C797S...").removeAttr("disabled");
   }else
   {
    $('#mutation_describe').val("").attr("placeholder","This parameter can be filled only in missense").prop("disabled","true");
   }

})
 //填充不用分页写js
 //mutation-orient-example样本填充
 $("#example").click(function(){
   
    $("#search_form")[0].reset();
    //$("#sample-disease").prop("checked",true); //疾病样本
    // $("#Variant_disease li:eq(1) ul:first li:eq(0) input").prop("checked", true); 0,0可以选中，1,0不行

     //variant_disease选中并滑到中央
     $("#Variant_disease li input.E:eq(7)").prop("checked", true);

     const Variant_disease_inside= $("#Variant_disease_inside");
     if(Variant_disease_inside.length > 0){
         const Variant_disease_inside_dom = $("#Variant_disease_inside")[0];
         Variant_disease_inside_dom.scrollTop = 850;
     }
    //variant-level gene sample
    $("#sample-gene").prop("checked",true);
     const Variant_gene_inside= $("#Variant_gene_inside");
     if(Variant_gene_inside.length > 0){
         const Variant_gene_inside_dom= $("#Variant_gene_inside")[0];
         Variant_gene_inside_dom.scrollTop = 2600;
     }

     $("#Gene_disease li input.F:eq(0)").prop("checked", true);
     const Gene_disease_inside= $("#Gene_disease_inside");
     if(Gene_disease_inside.length > 0){
         const Gene_disease_inside_dom = $("#Gene_disease_inside")[0];
         Gene_disease_inside_dom.scrollTop = 950;
     }


     $("#Gene_gene li input.gene:eq(13)").prop("checked", true);
     const Gene_gene_inside= $("#Gene_gene_inside");
     if(Gene_gene_inside.length > 0){
         const Gene_gene_inside_dom = $("#Gene_gene_inside")[0];
         Gene_gene_inside_dom.scrollTop = 330;
     }

    //debugger
    $("#mt option[value='missense']").prop("selected", true).change();
    $('#mutation_describe').removeAttr("disabled");
    $("#mutation_describe").val("K57T");

    //功能sample
    $("#sample-function").prop("checked",true);
     const Variant_function_inside= $("#Variant_function_inside");
     if(Variant_function_inside.length > 0){
         const Variant_function_inside_dom= $("#Variant_function_inside")[0];
         Variant_function_inside_dom.scrollTop = 30;
     }

    //curation特有Curation_disease
    $("#Curation_disease ul li:eq(15) input[type='checkbox']").prop("checked",true); //使列表内第i+1个li的input为选中状态
     const Curation_disease_inside= $("#Curation_disease_inside");
     if(Curation_disease_inside.length > 0){
         const Curation_disease_inside_dom= $("#Curation_disease_inside")[0];
         Curation_disease_inside_dom.scrollTop = 400;
     }
    $("#Curation_gene ul li:eq(2053) input[type='checkbox']").prop("checked",true);
     const Curation_gene_inside= $("#Curation_gene_inside");
     if(Curation_gene_inside.length > 0){
         const Curation_gene_inside_dom= $("#Curation_gene_inside")[0];
         Curation_gene_inside_dom.scrollTop = 63600;
     }

    $("#sample-element").prop("checked",true);
    $("#chr").val("chr17");
    $("#start_position").val("7574000");
    $("#end_position").val("7575000");
 })

//重置且清空mutation describe
$("#reset_cus").click(function(){
    console.log("重置");
    $("#search_form")[0].reset();
    $('#mutation_describe').attr("placeholder","This parameter can be filled only in missense").prop("disabled","true");
 })

    //初始化下拉选框
    if($('select').length>0){
        $('select').niceSelect();
    }
 })

function enExample(){
    // 假设你有一个ul元素，并且要操作第i个li元素
    var ulElement = document.getElementById("Variant_disease");
    var i = 0; // 假设要操作第2个li元素（索引从0开始）

// 获取第i个li元素
    var liElement = ulElement.getElementsByTagName("li")[i];

// 查找li元素下的input元素
    var inputElement = liElement.querySelector("input");

// 添加checked属性
    inputElement.checked = true;
}

//curation快速匹配基因
function geneQuickSearch() {
    // 获取 id 为 'pre_gene_quick' 的输入框的值
    var searchValue = document.getElementById('pre_gene_quick').value;

    // 查找所有 class 包含 'gene' 的输入框
    var geneInputs = document.querySelectorAll('.gene');

    // 遍历这些输入框
    geneInputs.forEach(function(input) {
        // 如果输入框的值与搜索值匹配
        if (input.value === searchValue) {
            // 如果是 checkbox 或 radio，则设置为选中状态
            if (input.type === 'checkbox' || input.type === 'radio') {
                input.checked = true;
            }
            // 对于其他类型的 input，根据需要进行操作
        }
    });
}
//curation快速匹配疾病
function preDiseaseQuickSearch() {
    // 获取 id 为 'pre_disease_quick' 的输入框的值
    var searchValue = document.getElementById('pre_disease_quick').value;

    // 查找所有 class 包含 'disease' 的输入框
    var diseaseInputs = document.querySelectorAll('.disease');

    // 遍历这些输入框
   diseaseInputs.forEach(function(input) {
        // 如果输入框的值与搜索值匹配
        if (input.value === searchValue) {
            // 如果是 checkbox 或 radio，则设置为选中状态
            if (input.type === 'checkbox' || input.type === 'radio') {
                input.checked = true;
            }
            // 对于其他类型的 input，根据需要进行操作
        }
    });
}
//search 快速匹配基因
function m_gQuickSearch() {
    var searchValue = document.getElementById('m_gene_quick').value;

    var geneInputs = document.querySelectorAll('.gene');

    // 遍历这些输入框
    geneInputs.forEach(function(input) {
        // 如果输入框的值与搜索值匹配
        if (input.value === searchValue) {
            // 如果是 checkbox 或 radio，则设置为选中状态
            if (input.type === 'checkbox' || input.type === 'radio') {
                input.checked = true;
            }
            // 对于其他类型的 input，根据需要进行操作
        }
    });
}

function m_dQuickSearch() {
    var searchValue = document.getElementById('m_disease_quick').value;

    // 定义要遍历的类名数组
    var classNames = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];

    // 遍历每个类名
    classNames.forEach(function(className) {
        // 查找每个类名对应的所有输入框
        var diseaseInputs = document.querySelectorAll('.' + className);

        // 遍历这些输入框
        diseaseInputs.forEach(function(input) {
            // 如果输入框的值与搜索值匹配
            if (input.value === searchValue) {
                // 如果是 checkbox 或 radio，则设置为选中状态
                if (input.type === 'checkbox' || input.type === 'radio') {
                    input.checked = true;
                }
                // 对于其他类型的 input，根据需要进行操作
            }
        });
    });
}

function g_dQuickSearch() {
    var searchValue = document.getElementById('g_disease_quick').value;

    // 定义要遍历的类名数组
    var classNames = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];

    // 遍历每个类名
    classNames.forEach(function(className) {
        // 查找每个类名对应的所有输入框
        var diseaseInputs = document.querySelectorAll('.' + className);

        // 遍历这些输入框
        diseaseInputs.forEach(function(input) {
            // 如果输入框的值与搜索值匹配
            if (input.value === searchValue) {
                // 如果是 checkbox 或 radio，则设置为选中状态
                if (input.type === 'checkbox' || input.type === 'radio') {
                    input.checked = true;
                }
                // 对于其他类型的 input，根据需要进行操作
            }
        });
    });
}

function g_gQuickSearch() {
    var searchValue = document.getElementById('g_gene_quick').value;

    var geneInputs = document.querySelectorAll('.gene');

    // 遍历这些输入框
    geneInputs.forEach(function(input) {
        // 如果输入框的值与搜索值匹配
        if (input.value === searchValue) {
            // 如果是 checkbox 或 radio，则设置为选中状态
            if (input.type === 'checkbox' || input.type === 'radio') {
                input.checked = true;
            }
            // 对于其他类型的 input，根据需要进行操作
        }
    });
}