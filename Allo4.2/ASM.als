module Synoptic/AbstractSyntax/ASM

//style



abstract sig Component {
ports: set Port, 
actions: Port set -> set Port
}{this = ports.component 
actions.Port in ports
actions[Port] in ports

}

abstract sig Port {
component: one Component
}{this in component.ports}

abstract sig Connector {
roles: set Role
}{this = roles.connector
}

abstract sig Role{
connector : one Connector,
connected : one Port
}{
this in connector.roles
}


abstract sig Configuration{
components: set Component, 
connectors: set Connector, 
}{
connectors.roles.connected in (components.ports) 
components.ports.~connected in connectors.roles

}

abstract sig Process extends Component{}
abstract sig Instrument extends Component{}


abstract sig PL extends Connector{}
abstract sig IL extends Connector{}
abstract sig EL extends Connector{}
abstract sig SL extends Connector{}

abstract sig PP extends Port{}
abstract sig IP extends Port{}
abstract sig EP  extends Port{}
abstract sig SP  extends Port{}




fact StyleConstraints{
//compatibility role/ port
all r:Role| some p: Port| Attached[r,p] &&  isCompatible[r.connector,p]

// extremities of connector connected to diferent component
all disj r1, r2: Role | (r1.connector= r2.connector ) => (r1.connected.component != r2.connected.component) 

// each connector has at most 2 roles
//all con: Connector | #con.roles=2

// two connector for the same ports
all disj c1,c2: Connector|no (c1.roles.connected  & c2.roles.connected)


// noLooseOfObject
all   con: Connector| all c: Component|
some conf: Configuration|( c in conf.components && con in conf.connectors)

// Component must be connected
all comp: Component|  !(comp.ComponentConnected= none)


// just for experiments
#Configuration=1 
#TRCH>1
}

pred isTyped[e1:univ, e2:univ]{
e1 in e2
}

pred isCompatible[con:Connector, p:Port]{
isTyped[con, PL] => isTyped[p, PP]  
else (isTyped[con, IL] => isTyped[p, IP ]	
else (isTyped[con, EL] => isTyped[p, EP]
else (isTyped[con, SL] => isTyped[p, SP] )))
}

pred Attached [r: Role , p: Port]{
    r->p in connected
}

// Corecteness properties
//funtional
fun ComponentConnected: Component->Component{
{s1,s2: Component|( disj[s1,s2] &&  
! ((s1.ports).(s1.actions).~(connected).RoleConnected.(connected).(s2.actions) =none)  //or  (not((s2.ports).(s2.actions).~(connected).bond.ext.(connected).(s1.actions) = none)) 
)}
}

fun RoleConnected: Role->Role{
{ disj r1,r2: Role| connector[r1] = connector[r2]}
}


pred ExistChemin[source: Component, passage : set Component, destination:Component] {
{(passage in source.^(ComponentConnected)) && (destination in passage.^(ComponentConnected))}
}


pred isTransfertPossible[source: Component, passage : set Component, destination:Component] {
{ExistChemin[source, passage , destination]  && (source in St) && (destination in St) && (passage in HP)}
}


pred isBrassagePossible[source: Component, passage : set Component ] {
{isTransfertPossible[source, passage , source]  }
}


//extra-funtional

pred NotIsolatedComponent[s: Component] {
{ let valves= (V2VM+V3VM+V3V+V2VR) | (some (IsolatedComponentApres[s] & valves)) &&  (some( IsolatedComponentAvant[s] & valves))}
}


fun IsolatedComponentApres[s: Component] : set Component{
{ comp:Component|let cl=Cl| (comp in  s.ComponentConnected)   || ((cl in s.ComponentConnected) && (comp in cl.ComponentConnected))}
}

fun IsolatedComponentAvant[s: Component] : set Component{
{ comp: Component| let cl=Cl | (s in comp.ComponentConnected)  || ((cl in comp.ComponentConnected) && (s in cl.ComponentConnected))}
}


/** element EDS */


 // les elements  process

	//CE
abstract sig CE extends Process{
p1: lone PP,
p2: lone PP,
p3: lone PP
}{
p1+p2+p3 = ports
actions =  (p1->p3)+ (p2->p3)
lone ports & p1
lone ports & p2
lone ports & p3
}
	//E
abstract sig E extends Process{
p1: lone PP,
p2: lone PP,
p3: lone PP,
p4: lone PP
}{
p1+p2+p3+p4= ports
actions =  (p1->p2)+ (p3->p4)
lone ports & p1
lone ports & p2
lone ports & p3
lone ports & p4
}

//CA

abstract sig CA extends Process{
p1: lone PP,
p2: lone PP,
p3: lone PP,
p4: lone PP
}{
p1+p2+p3+p4 = ports
actions =  (p1->p2)+ (p1->p3)+(p1->p4)
lone ports & p1
lone ports & p2
lone ports & p3
lone ports & p4

}
	//V2VM
abstract sig V2VM extends Process{
p1: lone PP,
p2: lone PP,
p3: lone EP
}{
p1+p2+p3= ports
actions =  (p1->p2)+ (p2->p1)
lone ports  & p1
lone ports  & p2
lone ports  & p3
}



	//V2VR
abstract sig V2VR extends Process{
p1: lone PP,
p2: lone PP,
p3: lone EP
}{
p1+p2+p3= ports
actions =  (p1->p2)+ (p2->p1)
lone ports  & p1
lone ports  & p2
lone ports  & p3

}

	//V3VM
abstract sig V3VM extends Process{
p1: lone PP,
p2: lone PP,
p3: lone PP,
p4: lone EP
}{
p1+p2+p3+p4 = ports
actions = (p1-> p2) + (p1->p3)+ (p2->p1)+ (p3->p1)

lone ports &  p1
lone ports & p2
lone ports & p3
lone ports & p4

}


	//V3V
abstract sig V3V extends Process{
p1: lone PP,
p2: lone PP,
p3: lone PP
}{
p1+p2+p3 = ports
actions = (p1-> p2) + (p1->p3)+ (p2->p1)+ (p3->p1)
lone ports & p1
lone ports & p2
lone ports & p3

}
	//HP
abstract sig HP extends Process{
p1: lone PP,
p2: lone PP
}{
p1+p2 = ports
actions = (p1-> p2) 
lone ports & p1
lone ports & p2

}


	//Cl
abstract sig Cl extends Process{
p1: lone PP,
p2: lone PP,
p3: lone PP
}{
p1+p2 = ports
actions = (p1-> p2) 
lone ports & p1
lone ports & p2

}


	//PC
abstract sig PC extends Process{
p1: lone PP,
p2: lone PP,
p3: lone EP
}{
p1+p2+p3 = ports
actions = (p1-> p2) 
lone ports & p1
lone ports & p2
lone ports  & p3

}


//TRCH // port 2à 1 suivant le synoptique
abstract sig TRCH extends Process{
p1: lone PP,
p2: lone PP
}{
p1+p2 = ports
actions = (p1->p2)
lone ports & p1
lone ports & p2

}

//TRUV // port 2à 1 suivant le synoptique
abstract sig TRUV extends Process{
p1: lone PP,
p2: lone PP
}{
p1+p2= ports
actions =  (p2->p1)
lone ports & p1
lone ports & p2

}


//Osm
abstract sig Osm extends Process{
p1: lone PP,
p2: lone PP,
p3: lone PP,
p4: lone PP
}{
p1+p2+p3+p4 = ports
actions = (p1-> p2) + (p1->p3)+ (p1->p4)
lone ports & p1
lone ports & p2
lone ports & p3
lone ports & p4

}


	//St
abstract sig St extends Process{
p1: lone PP,
p2: lone PP,
p3: lone IP
}{
p1+p2+p3 = ports
actions = (p1-> p2) 
lone ports & p1
lone ports & p2
lone ports  & p3

}


	//Int
abstract sig Interface extends Process{
p1: lone PP,
p2: lone PP
}{
p1+p2 = ports
actions =  (p2->p1)
lone ports & p1
lone ports & p2

}


	//Lm
abstract sig Lm extends Process{
p1: lone PP,
p2: lone PP
}{
p1+p2 = ports
actions = (p1-> p2) 
lone ports & p1
lone ports & p2

}

	//F
abstract sig F extends Process{
p1: lone PP,
p2: lone PP
}{
p1+p2 = ports
actions = (p1-> p2) 
lone ports & p1
lone ports & p2

}

 //les instrumentations

	//MontNiv
abstract sig MontNiv extends Instrument{
p1: lone IP
}{
p1 = ports
lone ports  & p1
no actions

}
	//FS
abstract sig FS extends Instrument{
p1: lone IP,
p2: lone EP,
p3: lone SP
}{
p1+p2+p3 = ports
lone ports  & p1
lone ports  & p2
lone ports  & p3
//lone ports & p4

no actions 
}

	//FAL
abstract sig FAL extends Instrument{
p1: lone SP
}{
p1= ports
lone ports  & p1
no actions

}
	//FT
abstract sig FT extends Instrument{
p1: lone IP,
p2: lone SP
}{
p1+p2 = ports
lone ports  & p1
lone ports  & p2

no actions 
}
	//FI
abstract sig FI extends Instrument{
p1: lone SP
}{
p1 = ports
lone ports  & p1

no actions 
}
	//TI
abstract sig TI extends Instrument{
p1: lone SP
}{
p1= ports
lone ports  & p1
no actions 

}

	//TC
abstract sig TC extends Instrument{
p1: lone EP
}{
p1= ports
lone ports  & p1

no actions 
}


	//TT
abstract sig TT extends Instrument{
p1: lone IP,
p2: lone EP,
p3: lone SP
}{
p1+p2+p3 = ports
lone ports  & p1
lone ports  & p2
lone ports  & p3
//lone ports & p1

no actions 
}

	//FQ
abstract sig FQ extends Instrument{
p1: lone SP
}{
p1= ports
lone ports  & p1

no actions
}
	//LAH
abstract sig LAH extends Instrument{
p1: lone SP
}{
p1= ports
lone ports  & p1

no actions
}

	//LS
abstract sig LS extends Instrument{
p1: lone IP,
p2: lone EP,
p3: lone SP
}{
p1+p2+p3= ports
lone ports  & p1
lone ports  & p2
lone ports  & p3

no actions 
}

	//LI
abstract sig LI extends Instrument{
p1: lone IP
}{
p1= ports
lone ports  & p1

no actions
}

	//LT
abstract sig LT extends Instrument{
p1: lone SP,
p2: lone IP
}{
p1+p2= ports
lone ports  & p1
lone ports & p2

no actions 
}

//MesNiv
abstract sig MesNiv extends  Instrument{
p1: lone SP
}{
p1= ports
lone ports  & p1
no actions

}
/*
one sig V2VM01 extends V2VM{}{p1= V2VM01_p1
	                    p2= V2VM01_p2
}
one sig H1 extends HP{}{p2= H1_p1
}

one sig V2VM01_p1 extends PP{}{component= V2VM01}
one sig V2VM01_p2 extends PP{}{component= V2VM01}
one sig H1_p1 extends PP{}{component= H1}

one sig Equi_17_1 extends Role{}{connector = Equi_17
	 connected =V2VM01.p2
}
one sig Equi_17_2 extends Role{}{connector = Equi_17
	 connected = H1.p2
}

one sig Equi_17 extends PL{}{Equi_17_1+Equi_17_2 = roles}

one sig EdS extends Configuration{}{components =  V2VM01+H1
connectors=Equi_17}
*/



assert corecteness_Analysis {
all s: TRCH+St+HP | NotIsolatedComponent[s]

/*some St1:St , St2: St| isTransfertPossible[St1, HP,St2] 
 isTransfertPossible[St1, HP,St2] 
	[St1, HP] 
 isBrassagePossible[St2, HP] */
}

//pred show{}
//
//run show for 10

check corecteness_Analysis for 10