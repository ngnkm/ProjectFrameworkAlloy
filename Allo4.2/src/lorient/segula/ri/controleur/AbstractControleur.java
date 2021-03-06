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

/**
 * classe abstraite contenant l'implementation  de methodes
 * necessaires pour l'utilisation d'un controleur
 * @version 1.0 
 * @author NGANKAM FRANCK
 * @see TestControleur
 *
 */
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
		resultat =  null;
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
	public void setCommandes(ConstList<Command> allCommands) {
		// TODO Auto-generated method stub
		commandes = allCommands;
	}
	public void setResultat(String string) {
		// TODO Auto-generated method stub
		resultat = string;
	}


}
