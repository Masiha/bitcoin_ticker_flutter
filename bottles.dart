void main() {
  var bottleNumberinFirstRow;
  var bottleNumberinSecondRow;
  for (int i = 99; i > -1; i--) {
    bottleNumberinFirstRow = i;
    bottleNumberinSecondRow = i - 1;
    if (i == 1) {
      bottleNumberinSecondRow = 'no more';
      print(
          '$bottleNumberinFirstRow bottle of beer on the wall, $bottleNumberinFirstRow bottle of beer.\nTake one down and pass it around, $bottleNumberinSecondRow bottles of beer on the wall.\n');
    } else if (i == 0) {
      bottleNumberinFirstRow = 'no more';
      bottleNumberinSecondRow = 99;
    } else {
      print(
          '$bottleNumberinFirstRow bottles of beer on the wall, $bottleNumberinFirstRow bottles of beer.\nTake one down and pass it around, $bottleNumberinSecondRow bottles of beer on the wall.\n');
    }
  }
}
