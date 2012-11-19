float frequencyOfDisease = 0.01;

float accuracyOfTest = 0.95;

float totalPositiveProbability = (accuracyOfTest*frequencyOfDisease) + (1-accuracyOfTest)*(1-frequencyOfDisease);

float probabilityOfDisesaeGivenPositiveTest = (accuracyOfTest*frequencyOfDisease)/totalPositiveProbability;
float probabilityOfHealthGivenPositiveTest = ((1-accuracyOfTest)*(1-frequencyOfDisease))/totalPositiveProbability;

float totalNegativeProbability = (accuracyOfTest * (1- frequencyOfDisease)) + (1-accuracyOfTest)*(frequencyOfDisease);


float probabilityOfDiseaseGivenNegativeTest = ((1-accuracyOfTest)*frequencyOfDisease)/totalNegativeProbability;
float probabilityOfHealthGivenNegativeTest = (accuracyOfTest*(1-frequencyOfDisease))/totalNegativeProbability;

println("probabilityOfDisesaeGivenPositiveTest: " + probabilityOfDisesaeGivenPositiveTest);
println("probabilityOfHealthGivenPositiveTest: " + probabilityOfHealthGivenPositiveTest);
println(probabilityOfHealthGivenPositiveTest + probabilityOfDisesaeGivenPositiveTest);

println("probabilityOfDiseaseGivenNegativeTest: " + probabilityOfDiseaseGivenNegativeTest);
println("probabilityOfHealthGivenNegativeTest: " + probabilityOfHealthGivenNegativeTest);
println(probabilityOfDiseaseGivenNegativeTest + probabilityOfHealthGivenNegativeTest);
