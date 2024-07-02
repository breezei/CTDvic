package com.example.demo.dao;

import com.example.demo.entity.CustomException;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//驱动突变可视化
public class Visual_dao {
    public static Map visual(String uuid,String hg) throws RserveException, REXPMismatchException {
        Map visualMap = new HashMap<String,Object>();
        RConnection rConnection = new RConnection();
        try {
            String Pa = System.getProperty("user.dir").replace("\\", "/");
            String PaOutBean = Pa.endsWith("/bin") ? Pa.substring(0, Pa.length() - 4) : Pa;
            String pathMu = PaOutBean + "/webapps/CTDvic/file/data/uploads/mutations/" + uuid + ".txt";
            System.out.println("Visual_map input path:");
            System.out.println(pathMu);
            String pathRe = PaOutBean + "/webapps/CTDvic/file/data/analysis/results/" + uuid + "/final_result.txt";
            System.out.println(pathRe);
            rConnection.eval("rm(list=ls())\n" +
                    "pathRe <- read.table('" + pathRe + "', header = T,sep=\"\\t\",stringsAsFactors=FALSE,quote = \"\")\n" +
                    "pathMu <- read.table('" + pathMu + "',header = T,sep = \"\\t\",stringsAsFactors = F,quote = \"\")\n" +
                    "visual <- data.frame(matrix(ncol = length(colnames(pathMu)),nrow = 0))\n" +
                    "colnames(visual) <- colnames(pathMu)\n" +
                    "for(i in 1:nrow(pathMu)){\n" +
                    "  for(j in 1:nrow(pathRe)){\n" +
                    "    if(pathMu[i,\"Hugo_Symbol\"] == pathRe[j,\"gene\"] && pathMu[i,\"Start_Position\"]>=pathRe[j,\"minpos\"] && pathMu[i,\"End_Position\"] <= pathRe[j,\"maxpos\"]){\n" +
                    "      visual <- rbind(visual,pathMu[i,]);\n" +
                    "      break;\n" +
                    "    }\n" +
                    "  }\n" +
                    "}\n" +
                    "##因为可视化仅支持单核苷酸而不是区域，以起始位点可视化\n" +
                    "duplicates <- duplicated(visual[, c(\"Hugo_Symbol\", \"Start_Position\")])\n" +
                    "visual <- visual[!duplicates, ]\n" +
                    "geneList <- unique(visual$Hugo_Symbol)\n" +
                    "grouped_gene <- split(visual, visual$Hugo_Symbol)\n");

            String[] geneList = rConnection.eval("geneList").asStrings();
            for (String gene : geneList) {
                Map geneMap = new HashMap<String, Object>();
                geneMap.put("host", "https://proteinpaint.stjude.org");
                geneMap.put("holder", "ORIGIN");
                geneMap.put("parseurl", "true");
                geneMap.put("noheader", "true");
                geneMap.put("nobox", "true");
                geneMap.put("genome", hg);
                geneMap.put("gene", gene);
                List tracks = new ArrayList<Object>();
                Map track = new HashMap<String, Object>();
                track.put("type", "mds3");
                track.put("name", "VARIANT_TYPE");
                List custom_variants = new ArrayList<Object>();
                rConnection.eval(
                        "  for (group_name in names(grouped_gene)) {\n" +
                                "    if (group_name == '" + gene + "') {\n" +
                                "      matching_rows <- rownames(grouped_gene[[group_name]])\n" +
                                "    }\n" +
                                "  }\n");
                String[] matching_rows = rConnection.eval("matching_rows").asStrings();
                for (String row_nam : matching_rows) {
                    Map mutation = new HashMap<String, Object>();
                    mutation.put("chr", rConnection.eval("visual['" + row_nam + "',\"Chromosome\"]").asString());
                    mutation.put("pos", rConnection.eval("visual['" + row_nam + "',\"Start_Position\"]").asInteger());
                    mutation.put("mname", rConnection.eval("visual['" + row_nam + "',\"Reference\"]").asString() + ">" + rConnection.eval("visual['" + row_nam + "',\"Alteration\"]").asString());
                    mutation.put("dt", 1);
                    String mt = rConnection.eval("visual['" + row_nam + "',\"Mutation_type\"]").asString();
                    switch (mt) {
                        case "MISSENSE":
                            mutation.put("class", "M");
                            break;
                        case "EXON":
                            mutation.put("class", "E");
                            break;
                        case "FRAMESHIFT":
                            mutation.put("class", "F");
                            break;
                        case "SILENT":
                            mutation.put("class", "S");
                            break;
                        case "PROTEINDEL":
                            mutation.put("class", "D");
                            break;
                        case "PROTEININS":
                            mutation.put("class", "I");
                            break;
                        case "SPLICE_REGION":
                            mutation.put("class", "P");
                            break;
                        case "SPLICE":
                            mutation.put("class", "L");
                            break;
                        case "INTRON":
                            mutation.put("class", "Intron");
                            break;
                        case "UTR_3":
                            mutation.put("class", "Utr3");
                            break;
                        case "UTR_5":
                            mutation.put("class", "Utr5");
                            break;
                        case "NONCODING":
                            mutation.put("class", "noncoding");
                            break;
                        case "SNV":
                            mutation.put("class", "snv");
                            break;
                        case "MNV":
                            mutation.put("class", "mnv");
                            break;
                        case "insertion":
                            mutation.put("class", "insertion");
                            break;
                        case "Small_deletion":
                            mutation.put("class", "deletion");
                            break;
                        default:
                            mutation.put("class", "X");
                            break;
                    }
                    mutation.put("ref", rConnection.eval("visual['" + row_nam + "',\"Reference\"]").asString());
                    mutation.put("alt", rConnection.eval("visual['" + row_nam + "',\"Alteration\"]").asString());
                    custom_variants.add(mutation);
                }
                track.put("custom_variants", custom_variants);
                tracks.add(track);
                geneMap.put("tracks", tracks);
                visualMap.put(gene, geneMap);
            }
            System.out.println("Visual_map finish...");
            return visualMap;
        }
        catch (REXPMismatchException e) {
            throw new RuntimeException(e);
        } catch (RserveException e) {
            throw new RuntimeException(e);
        }
        finally {
            rConnection.close();
        }
    }
}

