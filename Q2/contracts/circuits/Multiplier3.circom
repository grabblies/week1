pragma circom 2.0.0;

// [assignment] Modify the circuit below to perform a multiplication of three signals

template Multiplier2 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal output out;

   // Constraints.  
   out <== a * b;  
}

template Multiply3() {
   
   component mTwo = Multiplier2();
   signal input a;
   signal input b;
   signal input c;
   signal d;
   signal output outOne;

   mTwo.a <== a;
   mTwo.b <== b;
   d <== mTwo.out;
   outOne <== c * d;
}


component main = Multiply3();