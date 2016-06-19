# Dicar
Dicar - The Handwritten Formula Recognizer

## Usage

---

### classify.m

It's implemented as an matlab function which can do the classification of the hand-written numbers and symbols

For the prediction only

    % x should be a n x 1600 input data vector or matrix
    predict = classify(x);
    % 'predict' is a number or a vector (depends on the input) with values from 1 to 22 except of 21 (which is responsible for type 'frac')
  
For prediction and the probability

    [predict accuracy probability] = classify(x);
    % 'probability' is a n x 21 vector or matrix (depends on the input) with the estimated probability of each type
    % (Notice that column 21 is responsible for type '22' which is 'pi')
    % 'accuracy' here is meaningless, it's returned by the libsvm
