module Biblioheque

open util/relation as rel


enum Ext {Ext1,Ext2}
enum typedCi {WORD, STRING}

abstract sig SYNOPTIQUE{
system: one String,
subSystem: one String,
shapes: set SHAPE,
bonds:  set BOND,
connected :   EXTREMITY-> lone PORT // port peut etre attaché à plusieurs extremity, par contre une extremity est attaché à un seule port 
}{ //connected.PORT in (bonds.ext1 + bonds.ext2)
	 connected[EXTREMITY] in shapes.ports
    
}


abstract sig SHAPE{
//cis: set  CI,
ports: set PORT,
actions: set PORT-> set PORT
}{ this = ports.shape 
	 //this = cis.shape
	actions.PORT in ports
	actions[PORT] in ports
}
  
/*
abstract sig CI{
nature : one String,
value:one String,
type: one typedCi,
shape : one SHAPE
}{this in shape.cis
}
*/

abstract sig  PORT {
 number: one Int,
 shape: one SHAPE
}{ this in shape.ports
}


abstract sig BOND {
ext1: one EXTREMITY,
ext2: one EXTREMITY,
sens: EXTREMITY-> lone EXTREMITY
} { //this =ext1.bond
	 // this=ext2.bond 
	ext1.ext=Ext1
	ext2.ext=Ext2
//	sens[EXTREMITY] in (ext1+ext2)
//	sens.EXTREMITY in (ext1+ext2)
	irreflexive[sens]
}

abstract sig EXTREMITY{
ext: one Ext,
bond: one BOND
}{ this in (bond.ext1+bond.ext2)}


/** règles générales*/

/** on peut pas avoir une une extremity sans connection */
/*fact strongConnection{
all  extr:EXTREMITY|not (extr.(SYNOPTIQUE.connected)) =none
}

/** on peut pas avoir les deux  extremités d'une meme bonde vers le meme port ou la meme shape */
/*fact correctConnection{
all  b:BOND| ((b.ext1.(SYNOPTIQUE.connected).shape)!=( b.ext2.(SYNOPTIQUE.connected).shape))
}

/** on peut pas avoir les deux  bondes reliant les meme shape *///  28/10/2015
/*fact correctConnection{
some b1,b2:BOND| ((b1.ext1+b1.ext2).(SYNOPTIQUE.connected).shape) != ((b2.ext1+b2.ext2).(SYNOPTIQUE.connected).shape)
}

/** Il y n'existe pas un shape type composant pas capteur qui n'est pas connecté*/  //27/10/2015 problème 
/*fact ShapeConnected{
all s:SHAPE| (s in (HP+V2VM+V3VM+Cl+Lm+St+TRCH) )   => (s in  ((BOND.ext1+BOND.ext2).(SYNOPTIQUE.connected).shape))
}



/** relation de liason entre shape: st1->st2 = st1 est connecté avce une bo=nd avec st2*/
/*fun ShapeShape2 : SHAPE->SHAPE{
{s1,s2: SHAPE| some b: BOND|(b.ext2=(s1.ports.~(SYNOPTIQUE.connected).(b.sens))) and (b.ext1= s2.ports.~(SYNOPTIQUE.connected).(b.sens)) and not (s1.ports.~(SYNOPTIQUE.connected)  = none) and (not (s2.ports.~(SYNOPTIQUE.connected)  = none))}
}



/** relation de liason entre shape: st1->st2 = st1 est connecté avce une bo=nd avec st2*/
/*fun ShapeConnected: SHAPE->SHAPE{
{s1,s2: SHAPE| some b: BOND|( //(s1!=s2) and  
not ((s1.ports).(s1.actions).~(SYNOPTIQUE.connected).(b.sens).(SYNOPTIQUE.connected).(s2.actions) =none) // or  (s2.ports.~(SYNOPTIQUE.connected).(b.sens).(SYNOPTIQUE.connected).(s1.actions)in s1.ports) 
)}
}


pred ExistChemin[source: SHAPE, passage : set SHAPE, destination:SHAPE] {
{(passage in source.^(ShapeConnected)) and (destination in passage.^(ShapeConnected))}
}


pred isTransfertPossible[source: SHAPE, passage : set SHAPE, destination:SHAPE] {
{ExistChemin[source, passage , destination]  and (source in St) and (destination in St) and (passage in HP)}
}

pred isBrassagePossible[source: SHAPE, passage : set SHAPE] {
{isTransfertPossible[source, passage , source]  }
}
*/

// BONDs

abstract sig Monodirectional extends BOND{}{ 
//some sens & (ext1->ext2)  
}

abstract sig Bidirectional extends BOND{}{ 
//some sens & (ext1->ext2)
//some sens & (ext2->ext1)
}


/** element EDS */


 // les elements  process

	//CE
abstract sig CE extends SHAPE{}{
//some cis & CiPTAH 
//some cis &  CiPTIH
 //some cis & CiPTIL 
//some cis & CiPTAL
//some cis & CiEmax 
some ports & PortNum1
some ports & PortNum2
some ports & PortNum3
some actions & (PortNum1-> PortNum3)
some actions &   (PortNum2->PortNum3) 
}
	//E
abstract sig E extends SHAPE{}{
//no cis 
some ports   & PortNum1
some ports   & PortNum2
some ports   & PortNum3
some ports   & PortNum4
some actions & (PortNum1-> PortNum2)
some actions &   (PortNum3->PortNum4) 
}
	//CA
abstract sig CA extends SHAPE{}{
//some cis & CiRepere
//some cis & CiNom 
some ports & PortNum1
some ports & PortNum2
some ports & PortNum3
some ports & PortNum4
some actions & (PortNum1-> PortNum2)
some actions &   (PortNum1->PortNum3) 
some actions &   (PortNum1->PortNum4) 
}
	//V2VM
abstract sig V2VM extends SHAPE{}{
//no cis 
some ports   & PortNum1
some ports   & PortNum2
some ports   & PortNum3
some actions & (PortNum1-> PortNum2)
some actions &   (PortNum2->PortNum1) 
}



	//V2VR
abstract sig V2VR extends SHAPE{}{
//no cis 
some ports   & PortNum1
some ports   & PortNum2
some ports   & PortNum3
some actions & (PortNum1-> PortNum2)
some actions &   (PortNum2->PortNum1) 
}

	//V3VM
abstract sig V3VM extends SHAPE{}{
//no cis
some ports &  PortNum1
some ports & PortNum2
some ports & PortNum3
some actions & (PortNum1-> PortNum2) 
some actions & (PortNum1->PortNum3)
some actions & (PortNum2->PortNum1)
some actions & (PortNum3->PortNum1)
}


	//V3V
abstract sig V3V extends SHAPE{}{
//no cis
some ports &  PortNum1
some ports & PortNum2
some ports & PortNum3
some actions & (PortNum1-> PortNum2) 
some actions & (PortNum1->PortNum3)
some actions & (PortNum2->PortNum1)
some actions & (PortNum3->PortNum1)
}
	//HP
abstract sig HP extends SHAPE{}{
//some cis &  CiPPAH 
//some cis & CiPPIH 
//some cis & CiPPIL 
//some cis & CiPPAL 
//some cis & CiEmax 
//some cis &  CiEmin
some ports & PortNum1
some ports & PortNum2
some actions & (PortNum1-> PortNum2) 
}


	//Cl
abstract sig Cl extends SHAPE{}{
//no cis
some ports & PortNum1
some ports & PortNum2
some actions & (PortNum1-> PortNum2) 
}


	//PC
abstract sig PC extends SHAPE{}{
//no cis
some ports & PortNum1
some ports & PortNum2
some actions & (PortNum1-> PortNum2) 
}
	//TRCH
abstract sig TRCH extends SHAPE{}{
//no cis
some ports & PortNum1
some ports & PortNum2
some actions & (PortNum1-> PortNum2) 
}

	//St
abstract sig St extends SHAPE{}{
//some cis & CiFluide 
//some cis & CiCapacite
some ports & PortNum1
some ports & PortNum2
some ports & PortNum3
some actions & (PortNum1-> PortNum2) 

}


	//Int
abstract sig Interface extends SHAPE{}{
//some cis & CiFluide 
some ports & PortNum1
some ports & PortNum2
some actions & (PortNum1-> PortNum2) 
}


	//Lm
abstract sig Lm extends SHAPE{}{
//some cis & Cipression
some ports & PortNum1
some ports & PortNum2
some actions & (PortNum1-> PortNum2) 
}

	//F
abstract sig F extends SHAPE{}{
//some cis & CiPointDeFiltrage
some ports & PortNum1
some ports & PortNum2
some actions & (PortNum1-> PortNum2) 
}

 // les elements non process
/*
	//MontNiv
abstract sig MontNiv extends SHAPE{}{
no cis 
//some ports   & PortNum1
//some ports   & PortNum2
//some ports   & PortNum3
no actions
}
	//FS
abstract sig FS extends SHAPE{}{
//some cis & CiPC 
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
//some ports & PortNum4
no actions 
}

	//FAL
abstract sig FAL extends SHAPE{}{
//some cis & CiPC 
//some ports & PortNum1
//some ports & PortNum2
no actions 
}
	//FT
abstract sig FT extends SHAPE{}{
//some cis & CiPDAH 
//some cis &  CiPDIH
 //some cis & CiPDIL 
//some cis & CiPDAL
//some cis & CiEmax 
//some cis &  CiEmin
//some cis & CiPointDeMesure
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
//some ports & PortNum4
no actions 
}
	//FI
abstract sig FI extends SHAPE{}{
//some cis & CiPDAH 
//some cis &  CiPDIH
 //some cis & CiPDIL 
//some cis & CiPDAL
//some cis & CiEmax 
//some cis &  CiEmin
//some cis & CiPointDeMesure
some ports & PortNum1
some ports & PortNum2
no actions 
}
	//TI
abstract sig TI extends SHAPE{}{
//some cis & CiPTAH 
//some cis &  CiPTIH
 //some cis & CiPTIL 
//some cis & CiPTAL
//some cis & CiEmax 
//some cis &  CiEmin
//some cis & CiPointDeMesure
//some ports & PortNum1
no actions 
}

	//TC
abstract sig TC extends SHAPE{}{
no cis
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
//some ports & PortNum4
no actions 
}


	//TT
abstract sig TT extends SHAPE{}{
//some cis & CiPTAH 
//some cis &  CiPTIH
 //some cis & CiPTIL 
//some cis & CiPTAL
//some cis & CiEmax 
//some cis &  CiEmin
//some cis & CiPointDeMesure
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
//some ports & PortNum4
no actions 
}

	//FQ
abstract sig FQ extends SHAPE{}{
//some cis & CiPointDeMesure
//some ports & PortNum1
//some ports & PortNum2
no actions
}	//LAH
abstract sig LAH extends SHAPE{}{
//some cis & CiSt
some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
no actions 
}

	//LS
abstract sig LS extends SHAPE{}{
//some cis & CiSt
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
//some ports & PortNum4
//some ports & PortNum5
no actions 
}

	//LI
abstract sig LI extends SHAPE{}{
no cis 
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
no actions 
}

	//LT
abstract sig LT extends SHAPE{}{
//some cis &  CiPLAH 
//some cis & CiPLIH 
//some cis & CiPLIL
//some cis & CiPLAL
//some cis & CiEmax 
//some cis &  CiEmin
//some cis & CiSt
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
no actions 
}

	//MesNiv
abstract sig MesNiv extends SHAPE{}{
//some cis &  CiPLAH 
//some cis & CiPLIH 
//some cis & CiPLIL
//some cis & CiPLAL
//some cis & CiEmax 
//some cis &  CiEmin
//some cis & CiSt
//some ports & PortNum1
//some ports & PortNum2
//some ports & PortNum3
no actions 
}

 // les Cis
abstract sig  CiPPAH extends CI{}{ type=WORD}
abstract sig  CiPPIH extends CI{}{ type=WORD}
abstract sig  CiPPIL extends CI{}{ type=WORD}
abstract sig  CiPPAL extends CI{}{ type=WORD}
abstract sig  CiEmax extends CI{}{ type=WORD}
abstract sig  CiEmin extends CI{}{ type=WORD}

abstract sig  CiFluide extends CI{}{ type=STRING}
abstract sig  CiCapacite extends CI{}{ type=WORD}

abstract sig Cipression extends CI{}{ type=WORD}
abstract sig CiSt extends CI{}{ type=STRING}


abstract sig CiPLAH extends CI{}{ type=WORD}
abstract sig CiPLIH extends CI{}{ type=WORD}
abstract sig CiPLIL extends CI{}{ type=WORD}
abstract sig CiPLAL extends CI{}{ type=WORD}
   

abstract sig CiPointDeFiltrage extends CI{}{ type=STRING}

abstract sig CiRepere extends CI{}{ type=STRING}

abstract sig CiNom extends CI{}{ type=STRING}


abstract sig CiPointDeMesure extends CI{}{ type=STRING}

abstract sig CiPTAH extends CI{}{ type=WORD}
abstract sig CiPTIH extends CI{}{ type=WORD}
abstract sig CiPTIL extends CI{}{ type=WORD}
abstract sig CiPTAL extends CI{}{ type=WORD}

abstract sig CiPDAH extends CI{}{ type=WORD}
abstract sig CiPDIH extends CI{}{ type=WORD}
abstract sig CiPDIL extends CI{}{ type=WORD}
abstract sig CiPDAL extends CI{}{ type=WORD}

abstract sig CiPC extends CI{}{ type=STRING}

*/
	//les ports
abstract sig  PortNum1 extends PORT{}{ number=1}
abstract sig PortNum2  extends PORT{}{ number =2}
abstract sig PortNum3 extends PORT{}{ number =3}
abstract sig PortNum4 extends PORT{}{ number =4}
abstract sig PortNum5 extends PORT{}{ number =5}

	//les extremités
abstract sig EXTR1 extends EXTREMITY{}{ext=Ext1}
abstract sig EXTR2 extends EXTREMITY {}{ext=Ext2}
