package tmp;
import java.io.File;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.XMLNode;
import edu.mit.csail.sdg.alloy4compiler.ast.Command;
import edu.mit.csail.sdg.alloy4compiler.ast.Expr;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Solution;
import edu.mit.csail.sdg.alloy4compiler.translator.A4SolutionReader;
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod;


public class EvaluatorExample {

	
		 private static String model = "sig Point {} \n" + "\n" + "run { #Point > 1 } for 3 but 3 Int";
		    private static String outputfilename = "myissue.xml";

		    public static void main(String[] args) throws Exception {
		        A4Reporter rep = new A4Reporter();
		        File tmpAls = CompUtil.flushModelToFile(model, null);
		        {
		        	//creation d'un monde grace a un model issu d'une chaine de caractere et du reporter associ� 
		            Module world = CompUtil.parseEverything_fromString(rep, model);
		            //options
		            A4Options opt = new A4Options();
		             //set des attribut de l'objet opt
		            opt.originalFilename = tmpAls.getAbsolutePath();
		            opt.solver = A4Options.SatSolver.SAT4J;
		            //recuperation de la commande run contenu a l'indice 0 de world.getAllCommands() 
		            Command cmd = world.getAllCommands().get(0);
		            //calcul solution et retour dans sol
		            A4Solution sol = TranslateAlloyToKodkod.execute_commandFromBook(rep, world.getAllReachableSigs(), cmd, opt);
		            //test si la solution est satisfiable
		            assert sol.satisfiable();
		            //ecriture solution dans le fichier de sortie
		            sol.writeXML(outputfilename);

		            // eval with existing A4Solution    
		            Expr e = CompUtil.parseOneExpression_fromString(world, "univ");
		            System.out.println(sol.eval(e));
		            e = CompUtil.parseOneExpression_fromString(world, "Point");
		            System.out.println(sol.eval(e));
		        }
		        // reload everything from files
		        {
		            XMLNode xmlNode = new XMLNode(new File(outputfilename));
		            String alloySourceFilename = xmlNode.iterator().next().getAttribute("filename");
		            Module ansWorld = CompUtil.parseEverything_fromFile(rep, null, alloySourceFilename);
		            A4Solution ans = A4SolutionReader.read(ansWorld.getAllReachableSigs(), xmlNode);
		            
		            Expr e = CompUtil.parseOneExpression_fromString(ansWorld, "univ");
		            System.out.println(ans.eval(e));
		            e = CompUtil.parseOneExpression_fromString(ansWorld, "Point");
		            System.out.println(ans.eval(e));
		        }
		    }


//		    private static String model =
//		    		"sig Point {} \n" +
//		    		"\n" +
//		    		"run { #Point > 1 } for 3 but 3 Int";
		//    
//		    public static void main(String[] args) throws Exception {
//		        A4Reporter rep = new A4Reporter();
//		        File tmpAls = File.createTempFile("alloyEvaluator", ".als");
//		        tmpAls.deleteOnExit();
//		        flushModelToFile(tmpAls);
//		        Module world = CompUtil.parseEverything_fromFile(rep, null, tmpAls.getAbsolutePath());
//		        A4Options opt = new A4Options();
//		        opt.originalFilename = tmpAls.getAbsolutePath();
//		        opt.solver = A4Options.SatSolver.SAT4J;
//		        Command cmd = world.getAllCommands().get(0);
//		        A4Solution sol = TranslateAlloyToKodkod.execute_commandFromBook(rep, world.getAllReachableSigs(), cmd, opt);
//		        assert sol.satisfiable();
//		        
//		        // eval: univ
//		        Expr e = CompUtil.parseOneExpression_fromString(world, "univ");        
//		        System.out.println(sol.eval(e));
//		        
//		        // eval: Point
//		        e = CompUtil.parseOneExpression_fromString(world, "Point");        
//		        System.out.println(sol.eval(e));
//		    }
		//
//		    private static void flushModelToFile(File tmpAls) throws IOException {
//		        BufferedOutputStream bos = null;
//		        try {
//		            bos = new BufferedOutputStream(new FileOutputStream(tmpAls));
//		            bos.write(model.getBytes());
//		            bos.flush();
//		        } finally {
//		            if (bos != null) bos.close();
//		        }
//		    }
		    
	}

