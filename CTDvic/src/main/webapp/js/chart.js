    
window.onload=function(){
    var chartDom1 = document.getElementById('disease');
    var myChart1 = echarts.init(chartDom1,'roma', {renderer: 'svg'});
    var disease;

    disease = {
        title: {
            text: 'Experimental validation_Disease type',
            left:'center',
            top:20
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                // Use axis to trigger tooltip
                type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
            }
        },
        legend: {
            orient: 'vertical',
            right:'10%',
            top:150,
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: {
            type: 'value'
        },
        yAxis: {
            type: 'category',
            axisLabel:{
                rotate:0},
            data: ['others','Intrahepatic Cholangiocarcinoma','Pancreatic Ductal Adenocarcinoma','Metastatic Colorectal Cancer','Lung Cancer','Pancreatic Cancer','Urothelial Carcinoma','Hepatocellular Carcinoma','Prostate Cancer','Gastric Cancer', 'Melanoma' , 'Lung Adenocarcinoma', 'Metastatic Breast Cancer', 'Colorectal Cancer', 'Breast Cancer','Non-Small Cell Lung Cancer']
        },
        series: [
            {
                name: 'Variants-Level',
                type: 'bar',
                stack: 'total',
                emphasis: {
                    focus: 'series'
                },
                data:[208,13,16,19,23,23,24,27,34,39,49,54, 60, 111, 150,320]
            },
            {
                name: 'Genes-Level',
                type: 'bar',
                stack: 'total',
                emphasis: {
                    focus: 'series'
                },
                data:[136,1,9,30,1,15,1,7,15,19,18,14,13,72,57,97]
            }
        ]
    };

    disease && myChart1.setOption(disease);

    //图2
    var chartDom2 = document.getElementById('gene');
    var myChart2 = echarts.init(chartDom2,'roma',{renderer: 'svg'});
    var gene;
    gene = {
        title: {
            text: 'Experimental validation_Gene',
            left:'center',
            top:20
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                // Use axis to trigger tooltip
                type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
            }
        },
        legend: {
            orient: 'vertical',
            right:'10%',
            top:150,
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: {
            type: 'value'
        },
        yAxis: {
            type: 'category',
            axisLabel:{
                rotate:0},
            data: ['others','FGFR3','TERT','HER2','FGFR2','ERBB2','NRAS','AR','MET','TP53', 'ALK' , 'BRAF', 'PIK3CA','ESR1', 'KRAS','EGFR']
        },
        series: [
            {
                name: 'Variant-Level',
                type: 'bar',
                stack: 'total',
                emphasis: {
                    focus: 'series'
                },
                data:[293,15,17,22,23,27,33,33,53,56,60,60, 60, 102, 120,196]
            },
            {
                name: 'Gene-Level',
                type: 'bar',
                stack: 'total',
                emphasis: {
                    focus: 'series'
                },
                data:[208,1,6,2,2,7,18,3,3,65, 4, 32, 28, 14, 58,53]
            }
        ]
    };
    gene && myChart2.setOption(gene);


    //图三

    var chartDom3 = document.getElementById('variants');
    var myChart3 = echarts.init(chartDom3,'roma2',{renderer: 'svg'});
    var variants;
    variants = {
        title: {
            text: 'Experimental validation_Variant type',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            right: '2.5%',
            top:'3%'
        },
        series: [
            {
                name: '',
                type: 'pie',
                radius: ['35%', '55%'],
                label: {
                    show: true,
                    formatter: '{b}: {c} ({d}%)'
                },
                data: [
                    { value: 865, name: 'Missense' },
                    { value: 86, name: 'Amplification' },
                    { value: 57, name: 'Gene fusion' },
                    { value: 45, name: 'Deletion' },
                    { value: 25, name: 'Methylation' },
                    { value: 24, name: 'Frameshift' },
                    { value: 23, name: 'Others' },
                    { value: 17, name: 'Copy number variation' },
                    { value: 13, name: 'insertion' },
                    { value: 7, name: 'Indel' },
                    { value: 5, name: 'Loss' },
                    { value: 3, name: 'Rearrangement' },

                ],
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    variants && myChart3.setOption(variants);
    //图4
    var chartDom4 = document.getElementById('missense');
    var myChart4 = echarts.init(chartDom4,'roma2',{renderer: 'svg'});
    var missense;
    missense = {
        title: {
            text: 'Experimental validation_Missense mutation',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            left: '2.5%',
            top:'3%'
        },
        series: [
            {
                name: '',
                type: 'pie',
                radius: ['35%', '55%'],
                label: {
                    show: true,
                    formatter: '{b}: {c} ({d}%)'
                },
                data: [
                    { value: 60, name: 'T790M' },
                    { value: 33, name: 'V600E' },
                    { value: 25, name: 'G12D' },
                    { value: 24, name: 'L858R' },
                    { value: 22, name: 'G12V' },
                    { value: 20, name: 'Y537S' },
                    { value: 17, name: 'D538G' },
                    { value: 17, name: 'G12C' },
                    { value: 15, name: 'C797S' },
                    { value: 14, name: 'H1047R' },
                    { value: 13, name: 'E545K' },
                    { value: 11, name: 'E542K' },
                    { value: 11, name: 'Q61H' },
                    { value: 11, name: 'Y537N' },
                    { value: 583, name: 'others' }
                ],
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    missense && myChart4.setOption(missense);

    //prediction
    var chartDom5 = document.getElementById('pre_disease');
    var myChart5 = echarts.init(chartDom5,'roma',{renderer: 'svg'});
    var pre_disease;

    pre_disease = {
        title: {
            text: 'Prediction_Disease type',
            left:'center',
            top:20
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                // Use axis to trigger tooltip
                type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
            }
        },
        legend: {
            orient: 'vertical',
            right:'10%',
            top:150,
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                axisLabel:{
                    rotate:40},
                data: ['Breast Cancer', 'Lung Cancer', 'Non-Small Cell Lung Cancer', 'Classical Hodgkin Lymphoma', 'Cholangiocarcinoma', 'Colorectal Cancer', 'Prostate Cancer', 'Diffuse Large B-Cell Lymphoma', 'Esophageal Squamous Cell Carcinoma', 'Hepatocellular Carcinoma', 'Gliomas', 'Melanoma', 'Bladder Cancer', 'Pancreatic Cancer','Esophageal Adenocarcinoma','Gynecologic Cancers','Ovarian Cancer','Esophageal Cancer','Gastric Cancer','Uveal Melanoma','Renal Cell Carcinoma'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
            }
        ],
        series: [
            {
                name: 'Disease type',
                type: 'bar',
                barWidth: '60%',
                data: [7474, 5984, 3018, 1397,990, 914, 847,548,401,352,289,199,185,159,56,55,39,32,30,28,15]
            }
        ]
    };

    chartDom5 && myChart5.setOption(pre_disease);

    var chartDom6 = document.getElementById('pre_gene');
    var myChart6 = echarts.init(chartDom6,'roma',{renderer: 'svg'});
    var pre_gene;

    pre_gene = {
        title: {
            text: 'Prediction_Gene  ',
            left:'center',
            top:20
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                // Use axis to trigger tooltip
                type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
            }
        },
        legend: {
            orient: 'vertical',
            right:'10%',
            top:150,
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                axisLabel:{
                    rotate:40},
                data: ['TP53', 'NF1', 'LRP1B', 'EGFR', 'KMT2C', 'RYR2', 'VPS13A', 'DNMT3A', 'CSMD3', 'ARID1A', 'PTEN', 'PIK3CA', 'APC', 'ERBB2', 'ROS1', 'BRAF', 'NOTCH1', 'BRCA2', 'ALK', 'MET', 'BRCA1','others'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
            }
        ],
        series: [
            {
                name: 'Gene',
                type: 'bar',
                barWidth: '60%',
                data: [2433, 749, 619, 603, 580, 411, 373, 361, 359, 329, 282, 273, 261, 259, 256, 244, 222, 196, 188, 183, 174,13657]
            }
        ]
    };

    chartDom6 && myChart6.setOption(pre_gene);
}

//gene1
