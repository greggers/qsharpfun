import Microsoft.Quantum.Diagnostics.*;
import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Math.*;

operation Main() : (Int) {
    // Basic Qubit example.
    BasicQubit();

    // Random number generation.
    let max = 100;
    Message($"Sampling a random number between 0 and {max}: ");
    return GenerateRandomNumberInRange(max);
}

/// Generates a random number between 0 and `max`.
operation GenerateRandomNumberInRange(max : Int) : Int {
    // Determine the number of bits needed to represent `max` and store it
    // in the `nBits` variable. Then generate `nBits` random bits which will
    // represent the generated random number.
    mutable bits = [];
    let nBits = BitSizeI(max);
    for idxBit in 1..nBits {
        bits += [GenerateRandomBit()];
    }
    let sample = ResultArrayAsInt(bits);

    // Return random number if it is within the requested range.
    // Generate it again if it is outside the range.
    return sample > max ? GenerateRandomNumberInRange(max) | sample;
}

operation GenerateRandomBit() : Result {
    // Allocate a qubit.
    use q = Qubit();

    // Set the qubit into superposition of 0 and 1 using a Hadamard operation
    H(q);

    // At this point the qubit `q` has 50% chance of being measured in the
    // |0〉 state and 50% chance of being measured in the |1〉 state.
    // Measure the qubit value using the `M` operation, and store the
    // measurement value in the `result` variable.
    let result = M(q);

    // Reset qubit to the |0〉 state.
    // Qubits must be in the |0〉 state by the time they are released.
    Reset(q);

    // Return the result of the measurement.
    return result;
}

operation BasicQubit() : (Result, Result) 
{
    // Allocate two qubits, q1 and q2, in the 0 state.
    use (q1, q2) = (Qubit(), Qubit());

    // Put q1 into an even superposition.
    H(q1);

    // Entangle q1 and q2, making q2 depend on q1.
    CNOT(q1, q2);

    // Show the entangled state of the qubits.
    DumpMachine();

    // Measure q1 and q2 and store the results in m1 and m2.
    let (m1, m2) = (M(q1), M(q2));

    // Reset q1 and q2 to the 0 state.
    Reset(q1);
    Reset(q2);

    // Return the measurement results.
    return (m1, m2);
}