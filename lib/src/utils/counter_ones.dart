class CounterOnes {
  static int countOnesOnString(String binaryNumber){
    return binaryNumber.split('').where((bit) => bit == '1').length;
  }
}