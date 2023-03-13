parfor k = 1:30
    % 1
    platemo('algorithm', @CEP, 'problem', @ackley, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 2
    platemo('algorithm', @CEP, 'problem', @camel3, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 3
    platemo('algorithm', @CEP, 'problem', @holder, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 4
    platemo('algorithm', @CEP, 'problem', @rosenbrock, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 5
    platemo('algorithm', @CEP, 'problem', @schwefel222, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 6
    platemo('algorithm', @CEP, 'problem', @schwefel226, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 7
    platemo('algorithm', @CEP, 'problem', @sphere, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 8
    platemo('algorithm', @CEP, 'problem', @michal, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 9
    platemo('algorithm', @CEP, 'problem', @noisyQuartic, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 10
    platemo('algorithm', @CEP, 'problem', @step, 'N', 100, 'maxFE', 300000, 'save', inf)

    % 11
    platemo('algorithm', @FEP, 'problem', @ackley, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 12
    platemo('algorithm', @FEP, 'problem', @camel3, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 13
    platemo('algorithm', @FEP, 'problem', @holder, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 14
    platemo('algorithm', @FEP, 'problem', @rosenbrock, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 15
    platemo('algorithm', @FEP, 'problem', @schwefel222, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 16
    platemo('algorithm', @FEP, 'problem', @schwefel226, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 17
    platemo('algorithm', @FEP, 'problem', @sphere, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 18
    platemo('algorithm', @FEP, 'problem', @michal, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 19
    platemo('algorithm', @FEP, 'problem', @noisyQuartic, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 20
    platemo('algorithm', @FEP, 'problem', @step, 'N', 100, 'maxFE', 300000, 'save', inf)

    % 21
    platemo('algorithm', @IFEP, 'problem', @ackley, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 22
    platemo('algorithm', @IFEP, 'problem', @camel3, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 23
    platemo('algorithm', @IFEP, 'problem', @holder, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 24
    platemo('algorithm', @IFEP, 'problem', @rosenbrock, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 25
    platemo('algorithm', @IFEP, 'problem', @schwefel222, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 26
    platemo('algorithm', @IFEP, 'problem', @schwefel226, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 27
    platemo('algorithm', @IFEP, 'problem', @sphere, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 28
    platemo('algorithm', @IFEP, 'problem', @michal, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 29
    platemo('algorithm', @IFEP, 'problem', @noisyQuartic, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 30
    platemo('algorithm', @IFEP, 'problem', @step, 'N', 100, 'maxFE', 300000, 'save', inf)

    % 31
    platemo('algorithm', @AFEP, 'problem', @ackley, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 32
    platemo('algorithm', @AFEP, 'problem', @camel3, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 33
    platemo('algorithm', @AFEP, 'problem', @holder, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 34
    platemo('algorithm', @AFEP, 'problem', @rosenbrock, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 35
    platemo('algorithm', @AFEP, 'problem', @schwefel222, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 36
    platemo('algorithm', @AFEP, 'problem', @schwefel226, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 37
    platemo('algorithm', @AFEP, 'problem', @sphere, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 38
    platemo('algorithm', @AFEP, 'problem', @michal, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 39
    platemo('algorithm', @AFEP, 'problem', @noisyQuartic, 'N', 100, 'maxFE', 300000, 'save', inf)
    % 40
    platemo('algorithm', @AFEP, 'problem', @step, 'N', 100, 'maxFE', 300000, 'save', inf)
end