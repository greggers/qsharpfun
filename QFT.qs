import Microsoft.Quantum.Diagnostics.*;
import Microsoft.Quantum.Math.*;
import Microsoft.Quantum.Arrays.*;

operation Main() : Result[] {

    mutable resultArray = [Zero, size = 3];

    use qs = Qubit[3];

    //QFT:
    //first qubit:
    H(qs[0]);
    Controlled R1([qs[1]], (PI()/2.0, qs[0]));
    Controlled R1([qs[2]], (PI()/4.0, qs[0]));

    //second qubit:
    H(qs[1]);
    Controlled R1([qs[2]], (PI()/2.0, qs[1]));

    //third qubit:
    H(qs[2]);

    SWAP(qs[2], qs[0]);

    Message("Before measurement: ");
    DumpMachine();

    for i in IndexRange(qs) {
        resultArray w/= i <- M(qs[i]);
    }

    Message("After measurement: ");
    DumpMachine();

    ResetAll(qs);
    Message("Post-QFT measurement results [qubit0, qubit1, qubit2]: ");
    return resultArray;

}