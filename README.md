# Dicar
Dicar - The Handwritten Formula Recognizer

## Usage

---

### classify.m

It's implemented as an matlab function which can do the classification of the hand-written numbers and symbols

For the prediction only

    % x should be a n x 1600 input data vector or matrix
    predict = classify(x);
    % 'predict' is a number or a vector (depends on the input) with values from 1 to 22 except of 16 (which is responsible for type 'frac')
  
For prediction and the probability

    [predict probability] = classify(x);
    % 'probability' is a number or a vector (depends on the input) with the estimated probability of the prediction
