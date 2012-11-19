
void setup() {
  // Create a new SpamFilter Object
  SpamFilter filter = new SpamFilter();

  // Train spam with a file of spam e-mails
  filter.trainSpam("spam.txt");
  // Train spam with a file of regular e-mails
  filter.trainGood("good.txt");
  // We are finished adding words so finalize the results
  filter.finalizeTraining();


  for (int i = 1; i < 4; i++) {
    // Read in a text file
    String stuff = join(loadStrings("messages/mail" + i + ".txt"), '\n');

    // Ask the filter to analyze it
    boolean spam = filter.analyze(stuff);

    // Print results
    println(i);
    if (spam) println("I do believe this message is spam!");
    else println("I do believe this is a genuine message!");
  }
  noLoop();
}

void draw() {
}

