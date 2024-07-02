/* 原先疾病全选全不选.每个全选都要写个js，过于繁琐
$(document).ready(function(){
    $('input[class="Aall"]').on("click",function(){
        if($(this).is(':checked')){
            $('input[class="A"]').each(function(){
                $(this).prop("checked",true);
            });
        }else{
            $('input[class="A"]').each(function(){
                $(this).prop("checked",false);
            });
        }
   })
   //D2
   $('input[class="Ball"]').on("click",function(){
    if($(this).is(':checked')){
        $('input[class="B"]').each(function(){
            $(this).prop("checked",true);
        });
    }else{
        $('input[class="B"]').each(function(){
            $(this).prop("checked",false);
        });
    }
})
//D3
$('input[class="Call"]').on("click",function(){
    if($(this).is(':checked')){
        $('input[class="C"]').each(function(){
            $(this).prop("checked",true);
        });
    }else{
        $('input[class="C"]').each(function(){
            $(this).prop("checked",false);
        });
    }
})

})
*/


    var assem = new Array("gene","element","A","B","C");
    $(document).ready(function(){
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
            console.log(b);
            //把click事件执行的函数用匿名函数的话会用外部循环的最后一个值，因此用函数表达式或者函数声明，return 函数维持内部变量作用域
            //选择器和对应事件绑定
        $('input[class="'+b+'"]').on("click",choose(assem[i]))
    }
        })
    



    $(document).ready(function(){
    
        //curation-example样本填充
        $("#curation-example").click(function(){
      
           $("#disease")[0].reset();
           $("#sample-disease").prop("checked",true); //疾病样本
           $("#sample-gene").prop("checked",true);
           $("#sample-element").prop("checked",true);
           $("#start_position").val("55241707");
           $("#end_position").val("55259554");           
        })
       
        //重置且清空mutation describe
       
       })


