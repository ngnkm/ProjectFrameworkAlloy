module Bib_Papers

//style



abstract sig Component {
ports: set Port, 
actions: Port set -> set Port
}{this = ports.component 
actions.Port in ports
actions[Port] in ports
all disj p1, p2: ports| p1!=p2
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
all con: Connector | #con.roles=2

// two connector for the same ports
all disj c1,c2: Connector|no (c1.roles.connected  & c2.roles.connected)


// noLooseOfObject
all   con: Connector| all c: Component|
some conf: Configuration|( c in conf.components && con in conf.connectors)

// Component must be connected
all comp: Component|  (comp.ports.~connected != none)
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




/** element EDS */


 // les elements  process

	//CE
abstract sig CE extends Process{
p1: one PP,
p2: one PP,
p3: one PP
}{
p1+p2+p3 = ports
actions =  (p1->p3)+ (p2->p3)
one ports & p1
one ports & p2
one ports & p3
# ports=3
}
	//E
abstract sig E extends Process{
p1: one PP,
p2: one PP,
p3: one PP,
p4: one PP
}{
p1+p2+p3+p4= ports
actions =  (p1->p2)+ (p3->p4)
one ports & p1
one ports & p2
one ports & p3
one ports & p4
# ports=4
}

//CA

abstract sig CA extends Process{
p1: one PP,
p2: one PP,
p3: one PP,
p4: one PP
}{
p1+p2+p3+p4 = ports
actions =  (p1->p2)+ (p1->p3)+(p1->p4)
one ports & p1
one ports & p2
one ports & p3
one ports & p4
# ports=4 
}
	//V2VM
abstract sig V2VM extends Process{
p1: one PP,
p2: one PP,
ep: one EP
}{
p1+p2+ep= ports
actions =  (p1->p2)+ (p2->p1)
one ports  & p1
one ports  & p2
one ports  & ep
# ports=3
}



	//V2VR
abstract sig V2VR extends Process{
p1: one PP,
p2: one PP,
ep: one EP
}{
p1+p2+ep= ports
actions =  (p1->p2)+ (p2->p1)
one ports  & p1
one ports  & p2
one ports  & ep
# ports=3
}

	//V3VM
abstract sig V3VM extends Process{
p1: one PP,
p2: one PP,
p3: one PP,
ep: one EP
}{
p1+p2+p3+ep = ports
actions = (p1-> p2) + (p1->p3)+ (p2->p1)+ (p3->p1)
#ports=4
one ports &  p1
one ports & p2
one ports & p3
one ports & ep

}


	//V3V
abstract sig V3V extends Process{
p1: one PP,
p2: one PP,
p3: one PP
}{
p1+p2+p3 = ports
actions = (p1-> p2) + (p1->p3)+ (p2->p1)+ (p3->p1)
one ports & p1
one ports & p2
one ports & p3
# ports=3
}
	//HP
abstract sig HP extends Process{
p1: one PP,
p2: one PP
}{
p1+p2 = ports
actions = (p1-> p2) 
one ports & p1
one ports & p2
# ports=2
}


	//Cl
abstract sig Cl extends Process{
p1: one PP,
p2: one PP,
p3: one PP
}{
p1+p2 = ports
actions = (p1-> p2) 
one ports & p1
one ports & p2
# ports=2
}


	//PC
abstract sig PC extends Process{
p1: one PP,
p2: one PP,
ep: one EP
}{
p1+p2+ep = ports
actions = (p1-> p2) 
one ports & p1
one ports & p2
one ports  & ep
# ports=3
}


//TRCH // port 2à 1 suivant le synoptique
abstract sig TRCH extends Process{
p1: one PP,
p2: one PP
}{
p1+p2 = ports
actions = (p2->p1)
one ports & p1
one ports & p2
# ports=2
}

//TRUV // port 2à 1 suivant le synoptique
abstract sig TRUV extends Process{
p1: one PP,
p2: one PP
}{
p1+p2= ports
actions =  (p2->p1)
one ports & p1
one ports & p2
# ports=2
}


//Osm
abstract sig Osm extends Process{
p1: one PP,
p2: one PP,
p3: one PP,
p4: one PP
}{
p1+p2+p3+p4 = ports
actions = (p1-> p2) + (p1->p3)+ (p1->p4)
one ports & p1
one ports & p2
one ports & p3
one ports & p4
# ports=4
}


	//St
abstract sig St extends Process{
p1: one PP,
p2: one PP,
ip: one IP
}{
p1+p2+ip = ports
actions = (p1-> p2) 
one ports & p1
one ports & p2
one ports  & ip
# ports=3
}


	//Int
abstract sig Interface extends Process{
p1: one PP,
p2: one PP
}{
p1+p2 = ports
actions =  (p2->p1)
one ports & p1
one ports & p2
# ports=2
}


	//Lm
abstract sig Lm extends Process{
p1: one PP,
p2: one PP
}{
p1+p2 = ports
actions = (p1-> p2) 
one ports & p1
one ports & p2
# ports=2
}

	//F
abstract sig F extends Process{
p1: one PP,
p2: one PP
}{
p1+p2 = ports
actions = (p1-> p2) 
one ports & p1
one ports & p2
# ports=2
}

 //les instrumentations

	//MontNiv
abstract sig MontNiv extends Instrument{
ip: one IP
}{
ip = ports
one ports  & ip
no actions
# ports=1
}
	//FS
abstract sig FS extends Instrument{
ip: one IP,
ep: one EP,
sp: one SP
}{
ip+ep+sp = ports
one ports  & ip
one ports  & ep
one ports  & sp
//one ports & p4
# ports=3
no actions 
}

	//FAL
abstract sig FAL extends Instrument{
sp: one SP
}{
sp = ports
one ports  & sp
no actions
# ports=1 
}
	//FT
abstract sig FT extends Instrument{
ip: one IP,
sp: one SP
}{
ip+sp = ports
one ports  & ip
one ports  & sp
# ports=2
no actions 
}
	//FI
abstract sig FI extends Instrument{
sp: one SP
}{
sp = ports
one ports  & sp
# ports=1
no actions 
}
	//TI
abstract sig TI extends Instrument{
sp: one SP
}{
sp = ports
one ports  & sp
no actions 
# ports=1
}

	//TC
abstract sig TC extends Instrument{
ep: one EP
}{
ep = ports
one ports  & ep
# ports=2
no actions 
}


	//TT
abstract sig TT extends Instrument{
ip: one IP,
ep: one EP,
sp: one SP
}{
ip+ep+sp = ports
one ports  & ip
one ports  & ep
one ports  & sp
//one ports & p1
# ports=3
no actions 
}

	//FQ
abstract sig FQ extends Instrument{
sp: one SP
}{
sp= ports
one ports  & sp
# ports=1
no actions
}
	//LAH
abstract sig LAH extends Instrument{
sp: one SP
}{
sp= ports
one ports  & sp
# ports=1
no actions
}

	//LS
abstract sig LS extends Instrument{
ip: one IP,
ep: one EP,
sp: one SP
}{
ip+ep+sp = ports
one ports  & ip
one ports  & ep
one ports  & sp
# ports=3
no actions 
}

	//LI
abstract sig LI extends Instrument{
sp: one SP
}{
sp= ports
one ports  & sp
# ports=1
no actions
}

	//LT
abstract sig LT extends Instrument{
sp: one SP,
ip: one IP
}{
sp+ip= ports
one ports  & sp
one ports & ip
# ports=2
no actions 
}

//MesNiv
abstract sig MesNiv extends Component{
ip: one IP
}{
ip = ports
one ports  & ip
no actions
# ports=1
no actions 
}
/*
one sig V2VM01 extends V2VM{}
one sig H1 extends HP{}


one sig Equi_17_1 extends Role{}{connector = Equi_17
	 connected = V2VM01.p2
}
one sig Equi_17_2 extends Role{}{connector = Equi_17
	 connected = H1.p1
}

one sig Equi_17 extends PL{}{Equi_17_1+Equi_17_2 = roles}

one sig EdS extends Configuration{}{components =  V2VM01+H1
	*/

pred show{
/*# St>=1
# V2VM>=1
# Interface>=1*/	
}

//run show for 5

