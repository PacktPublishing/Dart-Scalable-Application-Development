main() {
  isCheckedMode();
  // your code starts here
}

void isCheckedMode() {
    try {
        int n = '';
        throw new Exception("Checked Mode is disabled!");
    } on TypeError {
      print("Checked Mode is enabled!");
    }
}