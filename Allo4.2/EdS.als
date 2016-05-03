module Auxiliaires_psm

open Bib_Papers_Test as bib
one sig St1_PORT_2 extends PP{}{component = St1}
one sig St1_PORT_3 extends IP{}{component = St1}
one sig St1_PORT_1 extends PP{}{component = St1}
one sig St2_PORT_2 extends PP{}{component = St2}
one sig St2_PORT_3 extends IP{}{component = St2}
one sig St2_PORT_4 extends PP{}{component = St2}
one sig LAH_0001_PORT_3 extends  SP{}{component = LAH_0001}
one sig LS0001_PORT_2 extends IP{}{component = LS0001}
one sig LS0001_PORT_4 extends SP{}{component = LS0001}
one sig LS0001_PORT_5 extends EP{}{component = LS0001}
one sig LT0001_PORT_2 extends IP{}{component = LT0001}
one sig LT0001_PORT_3 extends SP{}{component = LT0001}
one sig LI0001_PORT_2 extends IP{}{component = LI0001}
one sig LAH_0002_PORT_3 extends  SP{}{component = LAH_0002}
one sig LS0002_PORT_2 extends IP{}{component = LS0002}
one sig LS0002_PORT_4 extends SP{}{component = LS0002}
one sig LS0002_PORT_5 extends EP{}{component = LS0002}
one sig LT0002_PORT_2 extends IP{}{component = LT0002}
one sig LT0002_PORT_3 extends SP{}{component = LT0002}
one sig LI0002_PORT_2 extends IP{}{component = LI0002}
one sig V2VM03_PORT_2 extends PP{}{component = V2VM03}
one sig V2VM03_PORT_3 extends PP{}{component = V2VM03}
one sig V2VM04_PORT_2 extends PP{}{component = V2VM04}
one sig V2VM04_PORT_3 extends PP{}{component = V2VM04}
one sig V2VM05_PORT_2 extends PP{}{component = V2VM05}
one sig V2VM05_PORT_3 extends PP{}{component = V2VM05}
one sig V2VM06_PORT_2 extends PP{}{component = V2VM06}
one sig V2VM06_PORT_3 extends PP{}{component = V2VM06}
one sig V2VM07_PORT_2 extends PP{}{component = V2VM07}
one sig V2VM07_PORT_3 extends PP{}{component = V2VM07}
one sig V2VM08_PORT_2 extends PP{}{component = V2VM08}
one sig V2VM08_PORT_3 extends PP{}{component = V2VM08}
one sig V3VM01_PORT_1 extends PP{}{component = V3VM01}
one sig V3VM01_PORT_2 extends PP{}{component = V3VM01}
one sig V3VM01_PORT_3 extends PP{}{component = V3VM01}
one sig V3VM02_PORT_1 extends PP{}{component = V3VM02}
one sig V3VM02_PORT_2 extends PP{}{component = V3VM02}
one sig V3VM02_PORT_3 extends PP{}{component = V3VM02}
one sig V3VM03_PORT_1 extends PP{}{component = V3VM03}
one sig V3VM03_PORT_2 extends PP{}{component = V3VM03}
one sig V3VM03_PORT_3 extends PP{}{component = V3VM03}
one sig V2VM09_PORT_2 extends PP{}{component = V2VM09}
one sig V2VM09_PORT_3 extends PP{}{component = V2VM09}
one sig Lm1_PORT_2 extends PP{}{component = Lm1}
one sig Lm1_PORT_3 extends PP{}{component = Lm1}
one sig Cl1_PORT_2 extends PP{}{component = Cl1}
one sig Cl1_PORT_3 extends PP{}{component = Cl1}
one sig Cl2_PORT_2 extends PP{}{component = Cl2}
one sig Cl2_PORT_3 extends PP{}{component = Cl2}
one sig Cl3_PORT_2 extends PP{}{component = Cl3}
one sig Cl3_PORT_3 extends PP{}{component = Cl3}
one sig Cl4_PORT_2 extends PP{}{component = Cl4}
one sig Cl4_PORT_3 extends PP{}{component = Cl4}
one sig Cl5_PORT_2 extends PP{}{component = Cl5}
one sig Cl5_PORT_3 extends PP{}{component = Cl5}
one sig H1_PORT_1 extends PP{}{component = H1}
one sig H1_PORT_2 extends PP{}{component = H1}
one sig H2_PORT_1 extends PP{}{component = H2}
one sig H2_PORT_2 extends PP{}{component = H2}
one sig H3_PORT_1 extends PP{}{component = H3}
one sig H3_PORT_2 extends PP{}{component = H3}
one sig LI_1_PORT_3 extends  SP{}{component = LI_1}
one sig LI_2_PORT_3 extends  SP{}{component = LI_2}
one sig TRCH01_PORT_1 extends PP{}{component = TRCH01}
one sig TRCH01_PORT_2 extends PP{}{component = TRCH01}
one sig St1 extends St{}{p1= St1_PORT_1
	 p2 = St1_PORT_2
	 p3 = St1_PORT_3}

one sig St2 extends St{}{p1 = St2_PORT_2
	 p2 = St2_PORT_4
	 p3 = St2_PORT_3}
one sig LAH_0001 extends LAH{}{p1 = LAH_0001_PORT_3}
one sig LS0001 extends LS{}{p1 = LS0001_PORT_2
	 p3 = LS0001_PORT_4
	 p2 = LS0001_PORT_5}
one sig LT0001 extends LT{}{p2 = LT0001_PORT_2
	 p1 = LT0001_PORT_3}
one sig LI0001 extends LI{}{p1 = LI0001_PORT_2}
one sig LI_1 extends MesNiv{}{p1 = LI_1_PORT_3
	}
one sig LAH_0002 extends LAH{}{p1 = LAH_0002_PORT_3}
one sig LS0002 extends LS{}{p1 = LS0002_PORT_2
	 p3= LS0002_PORT_4
	 p2 = LS0002_PORT_5}
one sig LT0002 extends LT{}{p2 = LT0002_PORT_2
	 p1 = LT0002_PORT_3}
one sig LI0002 extends LI{}{p1 = LI0002_PORT_2}
one sig V2VM03 extends V2VM{}{p1 = V2VM03_PORT_2
	 p2 = V2VM03_PORT_3}
one sig V2VM04 extends V2VM{}{p1 = V2VM04_PORT_2
	 p2 = V2VM04_PORT_3}
one sig V2VM05 extends V2VM{}{p1 = V2VM05_PORT_2
	 p2 = V2VM05_PORT_3}
one sig V2VM06 extends V2VM{}{p1 = V2VM06_PORT_2
	 p2 = V2VM06_PORT_3}
one sig V2VM07 extends V2VM{}{p1 = V2VM07_PORT_2
	 p2 = V2VM07_PORT_3}
one sig V2VM08 extends V2VM{}{p1 = V2VM08_PORT_2
	 p2= V2VM08_PORT_3}
one sig V3VM01 extends V3VM{}{p1 = V3VM01_PORT_1
	 p2 = V3VM01_PORT_2
	 p3 = V3VM01_PORT_3
	}
one sig V3VM02 extends V3VM{}{p1 = V3VM02_PORT_1
	 p2 = V3VM02_PORT_2
	 p3 = V3VM02_PORT_3
	}
one sig V3VM03 extends V3VM{}{p1 = V3VM03_PORT_1
	 p2 = V3VM03_PORT_2
	 p3 = V3VM03_PORT_3
	}
one sig V2VM09 extends V2VM{}{p1 = V2VM09_PORT_2
	 p2= V2VM09_PORT_3}
one sig Lm1 extends Lm{}{p1 = Lm1_PORT_2
	 p2 = Lm1_PORT_3}
one sig Cl1 extends Cl{}{p1 = Cl1_PORT_2
	 p2 = Cl1_PORT_3}
one sig Cl2 extends Cl{}{p1 = Cl2_PORT_2
	 p2 = Cl2_PORT_3}
one sig Cl3 extends Cl{}{p1 = Cl3_PORT_2
	 p2 = Cl3_PORT_3}
one sig Cl4 extends Cl{}{p1 = Cl4_PORT_2
	 p2 = Cl4_PORT_3}
one sig Cl5 extends Cl{}{p1 = Cl5_PORT_2
	 p2 = Cl5_PORT_3}
one sig H1 extends HP{}{p1 = H1_PORT_1
	 p2 = H1_PORT_2
	}
one sig H2 extends HP{}{p1 = H2_PORT_1
	 p2 = H2_PORT_2}
one sig H3 extends HP{}{p1 = H3_PORT_1
	 p2 = H3_PORT_2
	 }
one sig LI_2 extends MesNiv{}{p1 = LI_2_PORT_3}
one sig TRCH01 extends TRCH{}{p1 = TRCH01_PORT_1
	 p2 = TRCH01_PORT_2}
one sig Equi_1 extends PL{}{Equi_1_1+Equi_1_2+Equi_1_3 = roles}

one sig Equi_3 extends PL{}{Equi_3_1+Equi_3_2 = roles}
one sig Equi_4 extends PL{}{Equi_4_1+Equi_4_2 = roles}
one sig Equi_5 extends PL{}{Equi_5_1+Equi_5_2 = roles}
one sig Equi_6 extends PL{}{Equi_6_1+Equi_6_2 = roles}
one sig Equi_7 extends PL{}{Equi_7_1+Equi_7_2 = roles}
one sig Equi_8 extends PL{}{Equi_8_1+Equi_8_2+Equi_8_3 = roles}
one sig Equi_9 extends PL{}{Equi_9_1+Equi_9_2+Equi_9_3+Equi_9_4 = roles}
one sig Equi_10 extends PL{}{Equi_10_1+Equi_10_2 = roles}
one sig Equi_11 extends PL{}{Equi_11_1+Equi_11_2 = roles}
one sig Equi_12 extends PL{}{Equi_12_1+Equi_12_2+Equi_12_3 = roles}
one sig Equi_13 extends PL{}{Equi_13_1+Equi_13_2+Equi_13_3+Equi_13_4 = roles}
one sig Equi_14 extends PL{}{Equi_14_1+Equi_14_2+Equi_14_3+Equi_14_4 = roles}
one sig Equi_15 extends PL{}{Equi_15_1+Equi_15_2+Equi_15_3+Equi_15_4 = roles}
one sig Equi_16 extends PL{}{Equi_16_1+Equi_16_2+Equi_16_3 = roles}
one sig Equi_17 extends PL{}{Equi_17_1+Equi_17_2 = roles}
one sig Equi_18 extends PL{}{Equi_18_1+Equi_18_2+Equi_18_3 = roles}
one sig EdS extends Configuration{}{components = St1+St2+LAH_0001+LS0001+LT0001+LI0001+LI_1+LAH_0002+LS0002+LT0002+LI0002+V2VM03+V2VM04+V2VM05+V2VM06+V2VM07+V2VM08+V3VM01+V3VM02+V3VM03+V2VM09+Lm1+Cl1+Cl2+Cl3+Cl4+Cl5+H1+H2+H3+LI_2+TRCH01
	 connectors = Equi_1+Equi_3+Equi_4+Equi_5+Equi_6+Equi_7+Equi_8+Equi_9+Equi_10+Equi_11+Equi_12+Equi_13+Equi_14+Equi_15+Equi_16+Equi_17+Equi_18}
one sig Equi_1_1 extends Role{}{connector = Equi_1
	 connected = V2VM09.p1}
one sig Equi_1_2 extends Role{}{connector = Equi_1
	 connected = TRCH01.p1}
one sig Equi_1_3 extends Role{}{connector = Equi_1
	 connected = Cl4.p2}

one sig Equi_3_1 extends Role{}{connector = Equi_3
	 connected = H3.p2}
one sig Equi_3_2 extends Role{}{connector = Equi_3
	 connected = Cl1.p1}
one sig Equi_4_1 extends Role{}{connector = Equi_4
	 connected = Lm1.p1}
one sig Equi_4_2 extends Role{}{connector = Equi_4
	 connected = V2VM09.p2}
one sig Equi_5_1 extends Role{}{connector = Equi_5
	 connected = Cl3.p2}
one sig Equi_5_2 extends Role{}{connector = Equi_5
	 connected = V3VM01.p1}
one sig Equi_6_1 extends Role{}{connector = Equi_6
	 connected = Cl5.p2}
one sig Equi_6_2 extends Role{}{connector = Equi_6
	 connected = Lm1.p2}
one sig Equi_7_1 extends Role{}{connector = Equi_7
	 connected = H1.p2}
one sig Equi_7_2 extends Role{}{connector = Equi_7
	 connected = Cl3.p1}
one sig Equi_8_1 extends Role{}{connector = Equi_8
	 connected = V2VM07.p2}
one sig Equi_8_2 extends Role{}{connector = Equi_8
	 connected = V2VM08.p2}
one sig Equi_8_3 extends Role{}{connector = Equi_8
	 connected = H3.p1}
one sig Equi_9_1 extends Role{}{connector = Equi_9
	 connected = V3VM03.p2}
one sig Equi_9_2 extends Role{}{connector = Equi_9
	 connected = Cl5.p1}
one sig Equi_9_3 extends Role{}{connector = Equi_9
	 connected = V3VM02.p2}
one sig Equi_9_4 extends Role{}{connector = Equi_9
	 connected = V3VM01.p2}
one sig Equi_10_1 extends Role{}{connector = Equi_10
	 connected = H2.p2}
one sig Equi_10_2 extends Role{}{connector = Equi_10
	 connected = Cl2.p1}
one sig Equi_11_1 extends Role{}{connector = Equi_11
	 connected = Cl2.p2}
one sig Equi_11_2 extends Role{}{connector = Equi_11
	 connected = V3VM02.p1}
one sig Equi_12_1 extends Role{}{connector = Equi_12
	 connected = H1.p1}
one sig Equi_12_2 extends Role{}{connector = Equi_12
	 connected = V2VM04.p2}
one sig Equi_12_3 extends Role{}{connector = Equi_12
	 connected = V2VM03.p2}
one sig Equi_13_1 extends Role{}{connector = Equi_13
	 connected = V3VM02.p3}
one sig Equi_13_2 extends Role{}{connector = Equi_13
	 connected = V3VM01.p3}
one sig Equi_13_3 extends Role{}{connector = Equi_13
	 connected = V3VM03.p3}
one sig Equi_13_4 extends Role{}{connector = Equi_13
	 connected = Cl4.p1}
one sig Equi_14_1 extends Role{}{connector = Equi_14
	 connected = St2.p2}
one sig Equi_14_2 extends Role{}{connector = Equi_14
	 connected = V2VM04.p1}
one sig Equi_14_3 extends Role{}{connector = Equi_14
	 connected = V2VM06.p1}
one sig Equi_14_4 extends Role{}{connector = Equi_14
	 connected = V2VM08.p1}
one sig Equi_15_1 extends Role{}{connector = Equi_15
	 connected = St1.p2}
one sig Equi_15_2 extends Role{}{connector = Equi_15
	 connected = V2VM03.p1}
one sig Equi_15_3 extends Role{}{connector = Equi_15
	 connected = V2VM05.p1}
one sig Equi_15_4 extends Role{}{connector = Equi_15
	 connected = V2VM07.p1}
one sig Equi_16_1 extends Role{}{connector = Equi_16
	 connected = V2VM06.p2}
one sig Equi_16_2 extends Role{}{connector = Equi_16
	 connected = V2VM05.p2}
one sig Equi_16_3 extends Role{}{connector = Equi_16
	 connected = H2.p1}
one sig Equi_17_1 extends Role{}{connector = Equi_17
	 connected = Cl1.p2}
one sig Equi_17_2 extends Role{}{connector = Equi_17
	 connected = V3VM03.p1}
one sig Equi_18_1 extends Role{}{connector = Equi_18
	 connected = St2.p1}
one sig Equi_18_2 extends Role{}{connector = Equi_18
	 connected = St1.p1}
one sig Equi_18_3 extends Role{}{connector = Equi_18
	 connected = TRCH01.p2}


assert corecteness_Analysis {
  IsolatedComponent 
/*
isTransfertPossible[St2, HP,St1] 
 isTransfertPossible[St1, HP,St2] 
 isBrassagePossible[St1, HP] 
 isBrassagePossible[St2, HP] */
}

//pred show{}

//run show for 1

check corecteness_Analysis for 1
