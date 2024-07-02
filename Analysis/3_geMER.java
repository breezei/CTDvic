package geMER;
import java.io.*;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class geMER {
    //相比于eleMHRresult2添加循环处理癌症类型中的5个文件，并写出
    public static void main(String[] args) throws IOException {
    	long startTimes = System.currentTimeMillis();
        //读取元件的突变文件  1ms
        //设置当前路径
        String root ="D:\\ctdna mutation program\\data\\result\\element_mapping\\";
        File dir = new File(root);
        //获得路径下的所有文件名
        String[] names=dir.list();
        //测试
        //int i=5;
        //注释掉了for
        for (int i = 0; i < names.length; i++) {
            String filename = names[i];
            //创建写出文件BufferedWriter对象
            String WriterFile ="D:\\ctdna mutation program\\data\\result\\element_result\\";
            BufferedWriter bw = new BufferedWriter(new FileWriter(WriterFile+filename));
            //先将标题写出
            bw.write("gene" + "\t" + "p" + "\t" + "nMut" + "\t" + "MES.max" + "\t" + "maxpos" + "\t" + "MES.min" + "\t" + "minpos" + "\t" + "MES" + "\n");
            //获得每个基因对应的起始位点map 4ms
            LinkedHashMap<String, Integer> geneStart = getStarts(root,filename);
            //System.out.println(geneStart);
            //获得每个基因对应的终止位点map 1ms
            LinkedHashMap<String, Integer> geneEnd = getEnds(root,filename);
            // System.out.println(geneEnd);
            //获取每个基因发生突变的位置map 1ms
            LinkedHashMap<String, ArrayList<Integer>> genePositions = getPositions(root,filename);
            // System.out.println(genePositions);
            //针对map中的每个基因，都可以进行一下操作(先拿一个基因举例)
            //测试
            //注释掉后两行
           Set<String> genes = genePositions.keySet();
            for (String gene : genes) {
                //拿出一个基因测试
                //String gene = "KRAS";
                //获取基因突变位置集合 0ms
                ArrayList<Integer> mutPositions = genePositions.get(gene);
                //获取每个基因发生突变的总数 0ms
                //System.out.println("突变位置向量" + mutPositions);
                int Nm = mutPositions.size();
                //System.out.println("发生突变样本的总数" + Nm);
                //获得基因的start 0ms
                int start = geneStart.get(gene);
                //System.out.println("基因的起始位置" + start);
                //获得基因的end 0ms
                int end = geneEnd.get(gene);
                //System.out.println("基因的终止位置" + end);
                //计算每个基因的长度(其实可以再方法中计算) 0ms
                int length = end - start + 1;
                //System.out.println("基因的长度" + length);
                //生成一个start开始，end结尾的连续整数的list(这一步是从小到大连续的) 49ms
                List<Integer> range = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
                //System.out.println("从基因其实位点到终止位点的连续位点序列"+range);
                //真实突变信息最终得到的es等结果 63ms
                double[] resultTrue = getResult(mutPositions, length, range, start);
                //生成随机突变Nm*times次，每次从中取三个存入集合中，执行随机后的getResult
                int times = 1000;
                //生成list的长度为6*1000
                ArrayList<Integer> list = mutPosRandom(range, Nm, times);//6毫秒
                //System.out.println(list.size());
                //生成一个集合，将得到的esRandom结果存放到集合中，方便后续均值和标准差的计算
                //注：将esRandoms集合转换成线程安全的
                List<Double> esRandoms = Collections.synchronizedList(new LinkedList<>());
                //存放times个集合，每个集合中有Nm个元素    7ms
                List<List<Integer>> lists = TrackSubpackage(list, Nm);
                lists.parallelStream().
                        forEachOrdered(integers -> esRandoms.add(getResult(integers, length, range, start)[4]));
                //计算p值
                //nes 0ms
                double trueES = resultTrue[4];
                double p = getNumber(trueES, esRandoms) / times;
                //  System.out.println(p);
                //将单个基因对应的所有结果输出到文件中
                //先将一个基因的所有信息存放到一个集合中，再写出集合 1ms

                String str = gene + "\t" + p + "\t" + Nm + "\t" + resultTrue[0] + "\t" +
                        resultTrue[1] + "\t" + resultTrue[2] + "\t" + resultTrue[3] + "\t" + resultTrue[4] + "\n";
                //System.out.println(str);
                bw.write(str);
                System.out.println(gene);
            }
            //注释掉
            bw.close();
          
            //注释掉
            System.out.println(i);
            // System.out.println(esRandoms);
            //注释掉
        }
	        long endTimes = System.currentTimeMillis();
	        System.out.println(((endTimes - startTimes)));
        	System.out.print("Process end!  time:" + System.currentTimeMillis());
//注释掉的for
    }
    //index-元素分别是：0-sample,1-gene,2-chrom,3-mutStart,4-mutEnd
    //5-ref,6-alt,7-Amino_Acid_Change,8-effect,9-dna_vaf
    //10-length,11-start,12-end
    //分析用到的方法
    //1、创建一个方法：输入BufferedReader对象，获得每个基因对应的起始位点map
    public static LinkedHashMap<String, Integer> getStarts(String root,String filename) throws IOException {
        FileReader fr = new FileReader(root+filename);
        BufferedReader br = new BufferedReader(fr);
        //删除第一行(各文件信息)
        br.readLine();
        //创建linkedHashMap，记录唯一的基因名-start(Integer)
        LinkedHashMap<String, Integer> geneStart = new LinkedHashMap<>();
        String line = null;
        while ((line = br.readLine()) != null) {
            String[] arrStr = line.split("\\t");
            //提取每一行对应的基因名(第4列)
            String gene = arrStr[3];
            //提取每一行对应的基因元件起始位点（第1列）
            int start = Integer.parseInt(arrStr[0]);
            //将基因名和start信息存入第1个Map中
            geneStart.put(gene, start);
            //index-元素分别是：0-sample,1-gene,2-chrom,3-mutStart,4-mutEnd
            //5-ref,6-alt,7-Amino_Acid_Change,8-effect,9-filter,10-dna_vaf
            //11-length,12-start,13-end
        }
        br.close();
        return geneStart;
    }
    //2、创建一个方法：输入BufferedReader对象，获得每个基因对应的终止位点map
    public static LinkedHashMap<String, Integer> getEnds(String root,String filename) throws IOException {
        FileReader fr = new FileReader(root+filename);
        BufferedReader br = new BufferedReader(fr);
        //删除第一行(各文件信息)
        br.readLine();
        //创建linkedHashMap，记录唯一的基因名-end(Integer)
        LinkedHashMap<String, Integer> getEnd = new LinkedHashMap<>();
        String line = null;
        while ((line = br.readLine()) != null) {
            String[] arrStr = line.split("\\t");
            //提取每一行对应的基因名
            String gene = arrStr[3];
            // System.out.println(gene);
            //提取每一行对应的基因元件终止位点(第2列)
            int end = Integer.parseInt(arrStr[1]);
            //将基因名和start信息存入第1个Map中
            getEnd.put(gene, end);
        }
        br.close();
        return (getEnd);
    }

    //3、创建一个方法：输入BufferedReader对象，获得每个基因对应的突变位置map
    public static LinkedHashMap<String, ArrayList<Integer>> getPositions(String root,String filename) throws IOException {
        FileReader fr = new FileReader(root+filename);
        BufferedReader br = new BufferedReader(fr);
        //删除第一行(各文件信息)
        br.readLine();
        //创建linkedHashMap，记录唯一的基因名-end(Integer)
        String line = null;
        //创建LinkedHashMap，记录唯一的基因名-和多个发生突变的位置
        LinkedHashMap<String, ArrayList<Integer>> mutPositions = new LinkedHashMap<>();
        //为了避免空值调用，先读取一行并将第一个基因名和第一个突变位置存入到map中
        line = br.readLine();
        //第一行产生了数组
        String[] arrStrPre = line.split("\\t");
        //获得第一行对应的基因
        String gene1 = arrStrPre[3];
        //获得第一行对应的突变位置并放入集合中
        ArrayList<Integer> position1 = new ArrayList<>();
        //发生突变的位置（第6行）
        position1.add(Integer.parseInt(arrStrPre[5]));
        //将整个键值对放入map中
        mutPositions.put(gene1, position1);
        while ((line = br.readLine()) != null) {
            String[] arrStr = line.split("\\t");
            //提取每一行对应的基因名
            String gene = arrStr[3];
            // System.out.println(gene);
            //提取每一行对应的position
            int position = Integer.parseInt(arrStr[5]);
            //先获得所有键的集合
            Set<String> keys = mutPositions.keySet();
            //判断当前的map集合的所有键中是否存在读入这一行的基因
            if (keys.contains(gene)) {
                mutPositions.get(gene).add(position);
            } else {
                //若不存在，新建一个集合，存放第一个出现基因的突变位置
                ArrayList<Integer> value = new ArrayList<>();
                value.add(position);
                //并把新基因的键值对存入map中
                mutPositions.put(gene, value);
            }

        }
        br.close();
        return (mutPositions);
    }


    //4、 创建一个方法，统计每个位置发生突变的次数，并将结果放到map中
    //0ms
    public static HashMap<Integer, Double> mutPosTimes(List<Integer> mutPosR) {
        //定义map集合，利用集合进行统计：
        HashMap<Integer, Double> hm = new HashMap<>();
        //遍历list，依次得到每一个投票信息
        //position:发生突变的位置
        for (Integer position : mutPosR) {
            //判断当前景点在map集合中是否存在
            if (hm.containsKey(position)) {
                //存在
                hm.put(position, hm.get(position) + 1);

            } else {
                //不存在
                hm.put(position, 1.0);
            }
        }
        return hm;
    }

    //5、创建一个方法，将map中的value*inc
    //反正是乘以同一个值，键的顺序无所谓，所以用HashMap即可
    //0ms
    public static HashMap<Integer, Double> incMap(HashMap<Integer, Double> mutPosT, double inc) {
        //遍历HashMap，提取其中的value值并乘以inc
        //获取所有的键，将这些键放入一个单列集合中
        Set<Integer> keys = mutPosT.keySet();
        for (Integer key : keys) {
            //利用Map中的键获取每个值
            Double value = mutPosT.get(key) * inc;
            mutPosT.put(key, value);
        }
        return mutPosT;
    }

    //6、创建一个方法，将起始到终止位置的连续集合作为KEY,将-dec作为value，存放到map中
    public static LinkedHashMap<Integer, Double> decMap(List<Integer> range, double dec) {
        //创建一个新的HashMap，存放rang中的每个值作为Key,-dec作为value
        //键需要有序，所以用LinkedHashMap
        LinkedHashMap<Integer, Double> allPosDec = new LinkedHashMap<>();
        //更慢:range.parallelStream.forEach(position ->  allPosDec.put(position, -dec));
        // 也慢：range.forEach(position ->  allPosDec.put(position, -dec));
        for (Integer position : range) {
            allPosDec.put(position, -dec);
        }
        return allPosDec;
    }

    //7、创建一个方法，计算map中value的累加和cum,并计算出累加后数组的最大值，最小值以及二者的差值
    public static double[] getES(LinkedHashMap<Integer, Double> seqIncDec, int start) {
        //将map中的value都取出来放入集合valuesList中
        List<Double> valuesList = new ArrayList<>();
        //先取出键值对entries，针对每个键值对进行迭代(迭代器比增强for更快)
        Set<Map.Entry<Integer, Double>> entries = seqIncDec.entrySet();
        //累加获得MAS
        Iterator<Map.Entry<Integer, Double>> iterator = entries.iterator();
        //第一个值+0，第二个值+第一个值，以此类推
        double temp = 0;
        //double temp = entries.iterator().next().getValue();
        //System.out.println(temp);
        while (iterator.hasNext()) {
            //从第二个value开始
            double value = iterator.next().getValue();
            //将value和第一个累加
            temp = value + temp;
            //并赋值给value
            valuesList.add(temp);
        }
        //遍历MAS（最后一个位置的值应该无限接近于0）
       /* System.out.print("MAS向量："+" ");
       for(int m=0; m<=valuesList.size()-1; m++)
              {
                System.out.print(valuesList.get(m)+" ");    //get(i):返回第i号位置的元素
                 }
        System.out.println();*/
        //计算集合的最大值最小值以及最大值最小值对应的基因组位置
        //  System.out.println("将map中的结果放入的list:"+ valuesList);
        double max = Collections.max(valuesList);
        //System.out.println("最大值："+ max);
        double min = Collections.min(valuesList);
       // System.out.println("最小值："+ min);
        int maxPos = valuesList.indexOf(max) ;
        //System.out.println("最大值对应的基因组位置："+ maxPos);
        int minPos = valuesList.indexOf(min) ;
        //System.out.println("最小值对应的基因组位置："+ minPos);
        //判断：maxPos和minPos的大小
        double[] trueResult = new double[0];
        //如果maxPos > minPos，则热点区域为二者的中间区域，ES=最大值减最小值
        if (maxPos > minPos) {
            //计算最大值和最小值的差值
            double es = max - min;
            //最大值 最大值索引 最小值 最小值索引 es
            trueResult = new double[]{max, maxPos+start, min, minPos+start, es};
            // System.out.println(es);
        } else {

            //判断最大值的位置是否是第一个位置，并且最小值的位置是最后一个位置
            //如果这种情况发生，则ES=-1，并在后期筛选时删除
            if(maxPos==0 & minPos==valuesList.size()-1){
                trueResult = new double[]{max, maxPos+ start, min, minPos+ start, -1};
            } else if (maxPos==0) {
                //若最大值是第一个位置，但最小值不是最后一个位置
                //则热点区域为最小值右侧的热点区域
                //获得最小值右侧的所有MAS子集
                List<Double> minProMAS =valuesList.subList(minPos,valuesList.size()-1);
                // System.out.println(minProMAS.get(0));    //get(i):返回第i号位置的元素
                //计算最小值右侧的最大值
                double maxRight = Collections.max(minProMAS);
                // System.out.println("最小值右侧的最大值："+maxRight);
                //计算最小值右侧的ES值：RightES
                double rightES = maxRight-min;
                int maxRightPos=minProMAS.indexOf(maxRight)+ minPos + start;
                trueResult = new double[]{maxRight, maxRightPos, min, minPos+start, rightES};
            } else if (minPos==valuesList.size()-1) {
               //若最小值的位置是最后一个位置，但最大值不是第一个位置
               //则热点区域为最大值左侧的热点区域
                List<Double> maxPreMAS =valuesList.subList(0, maxPos);
                //计算最大值左侧的最小值
                double minLeft = Collections.min(maxPreMAS);
                double leftES = max-minLeft;
                int minLeftPos=maxPreMAS.indexOf(minLeft) + start;
                trueResult = new double[]{max, maxPos+start, minLeft, minLeftPos, leftES};
            }else{
                //最大值和最小值的位置都不在边缘
                //最大值的左侧一定有一个最小值
                List<Double> maxPreMAS =valuesList.subList(0, maxPos);
                double minLeft = Collections.min(maxPreMAS);
                //System.out.println("最大值左侧的最小值："+ minLeft);
                //计算最大值左侧的ES值：LeftES
                double leftES = max-minLeft;
                //最小值的右侧一个有一个最大值
                List<Double> minProMAS =valuesList.subList(minPos,valuesList.size()-1);
                // System.out.println(minProMAS.get(0));    //get(i):返回第i号位置的元素
                //计算最小值右侧的最大值
                double maxRight = Collections.max(minProMAS);
                // System.out.println("最小值右侧的最大值："+maxRight);
                //计算最小值右侧的ES值：RightES
                double rightES = maxRight-min;
                //比较这两个ES的大小
                if(leftES>=rightES){
                    double es = leftES;
                    int minLeftPos=maxPreMAS.indexOf(minLeft) + start;
                    trueResult = new double[]{max, maxPos+start, minLeft, minLeftPos, es};
                    //System.out.println(es);
                }else {
                    double es = rightES;
                    int maxRightPos=minProMAS.indexOf(maxRight)+ minPos + start;
                    trueResult = new double[]{maxRight, maxRightPos, min, minPos+start, es};
                    //System.out.println(es);
                }


            }

        }

        return trueResult;
        //获取最大值和最小值以及最大值和最小是对应的位置

    }
    //8、创建执行方法，对每个基因实际的突变情况以及随机产生的突变情况进行相同的处理
    public static double[] getResult(List<Integer> mutPos, int length, List<Integer> range, int start) {
        //计算inc(1/发生的所有突变的总和)
        //这样为保持3位
        double inc = 1.0/mutPos.size();
        //System.out.println("inc="+inc);
        //统计每个位置发生突变的次数 0ms
        HashMap<Integer, Double> mutPosT = mutPosTimes(mutPos);
        // System.out.println("每个位置发生突变的次数" + mutPosT);
        //用每个位置的突变次数乘以inc 0ms
        HashMap<Integer, Double> mutPosTInc = incMap(mutPosT, inc);
        //System.out.println("每个位置发生突变的次数*inc=" + mutPosT);
        // Double  sumInc = mutPosTInc.values().stream().reduce((double) 0, Double::sum);

        //总和应该是1，但有无限循环小数，所以和接近1

        // System.out.println("增加量inc的总和："+ sumInc);
        //计算dec(1/基因长度-发生突变的位置数，获得没有发生突变位置的数量)
        double dec = 1.0 / (length - mutPosT.size());
        //System.out.println("dec = " + dec);
        //生成一个有序的map,键为基因起始位置和终止位置的连续集合，
        // 值均为-dec(在方法中赋值的是-dec,这里直接输入dec即可)//几-20几ms
        LinkedHashMap<Integer, Double> seqIncDec = decMap(range, dec);
        // System.out.println("起始位置到终止位置的连续集合:" + seqIncDec);
        /*double sum=0;
        for(int i = 1; i < 8; ++i) {
            if(seqIncDec.containsKey(i))
                sum += seqIncDec.get(i);
        }*/
        //System.out.println("减少量dec的总和："+ sum);

        //将两个map合并，将发生突变位置的-dec代替为inc*突变数的值 0ms
        //减少量的和也接近于1
        seqIncDec.putAll(mutPosTInc);
        //System.out.println("合并后的map:" + seqIncDec);
        //计算合并后map中value的累加和，累加后的最大值，最小值以及最大最小值的差值
        //不稳定 几-几十ms
        double[] es = getES(seqIncDec, start);

        //  System.out.println("es的结果：");
       /* for (int i = 0; i < es.length; i++) {
            if (i == es.length - 1) {
                System.out.println(es[i]);
            } else
                System.out.print(es[i] + " ");
        }*/
        return es;
    }
    // 9、根据基因的起始位置和终止位置的连续集合随机生成Nm个突变位置，将随机生成的数据放到集合中
    //基因的位置没有小数，所以是Integer
    public static ArrayList<Integer> mutPosRandom(List<Integer> range, int mutNum, int times) {
        //生成一个新的集合用于存放随机后的数据
        ArrayList<Integer> mutPos = new ArrayList<>();
        //for循环随机mutNum*1000次，并将随机位置放入集合中
        //seed：随机种子数相同，保证每次随机都跟第一次随机的结果一致，保证代码的可重复性
        Random r = new Random(1);
        for (int i = 0; i < mutNum * times; i++) {
            //产生的是List的随机索引，而不是其中的值
            //不需要确保非重复
            int randomIndex = r.nextInt(range.size());
            //提取其中的值加入到集合中
            mutPos.add(range.get(randomIndex));
        }
        return mutPos;
    }
    //10 创建一个方法：先从大的Nm*times的大集合中每次提取Nm个集合
    // 并对这个集合进行分析得到times个元素的ES集合
    public static List<List<Integer>> TrackSubpackage(ArrayList<Integer> objects, int everySize) {
        //在集合中存储集合
        List<List<Integer>> packageList = new ArrayList<>();
        //packages作为一个临时的集合读取器，每次放满5个后释放
        List<Integer> packages = new ArrayList<>();
        int size = objects.size();
        for (int i = 0; i < size; i++) {
            packages.add(objects.get(i));
            if (packages.size() == everySize || i == objects.size() - 1) {
                List<Integer> isp = new ArrayList<>();
                isp.addAll(packages);
                packageList.add(isp);
                packages.clear();
            }
        }
        return packageList;
    }
    //12、创建一个方法：统计随机生成的es值大于真实值的数量
    public static double getNumber(double trueES, List<Double> esRandoms) {
        double number = 0;
        for (int i = 0; i < esRandoms.size(); i++) {
            if (esRandoms.get(i) >= trueES) {
                number++;
            }
        }
        return number;
    }


}

