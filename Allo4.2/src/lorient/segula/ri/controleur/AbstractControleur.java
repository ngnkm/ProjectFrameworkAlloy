package lorient.segula.ri.controleur;


import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.ConstList;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4compiler.ast.Command;
import edu.mit.csail.sdg.alloy4compiler.ast.Expr;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Solution;
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod;


public abstract class AbstractControleur {
	
	private Module world ;
	private A4Reporter rep;
	private A4Options options;
	private A4Solution sol;
	private ConstList<Command> commandes;
	private String resultat;
	
	AbstractControleur(String File) throws Err{
		rep = new A4Reporter();
		world = CompUtil.parseEverything_fromFile(rep, null,File);
		options = new A4Options();
		options.solver = A4Options.SatSolver.SAT4J;
		options.skolemDepth = 0;		
	}
	
	public void LectureCommande(){
		commandes = world.getAllCommands();
	}
	
	public Command ExtractCommande(){
		
		return commandes.get(0);
	}
	public boolean EvaluationChecking(String formulaTocheck){
	 	A4Solution sol= null;
    	 try {
			sol = TranslateAlloyToKodkod.execute_command(rep, world.getAllReachableSigs(), ExtractCommande(), options);
			if(!(sol.satisfiable()))return false;
			System.out.println("Results Checking:");
			Expr e1 = CompUtil.parseOneExpression_fromString(world, formulaTocheck);
			resultat = sol.eval(e1).toString();
			return true;
		} catch (Err e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    		return false;
    }
    
	public String[] CounterExample(){
    
    	String parseResultat = resultat.substring(1, resultat.length()-1);	
    	return  parseResultat.split(",");
    }
    
    
    
	public Module getWorld() {
		return world;
	}

	public A4Reporter getRep() {
		return rep;
	}

	public A4Options getOptions() {
		return options;
	}

	public A4Solution getSol() {
		return sol;
	}

	public ConstList<Command> getCommandes() {
		return commandes;
	}

	public String getResultat() {
		return resultat;
	}

	public void affichage() {
		for (int i=0 ; i< CounterExample().length; i++)
			System.out.println(CounterExample()[i].replaceAll(" ", ""));
	}
	
	
	
	
	

}
