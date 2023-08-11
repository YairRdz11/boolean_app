class BinaryConvert {
  static String decimalToBinary(int decimal, int length) {
    if (decimal == 0) {
      return _completeLength("0", length);
    }

    String binary = '';

    while (decimal > 0) {
      int remainder = decimal % 2;
      binary = remainder.toString() + binary; 
      decimal = decimal ~/ 2;
    }

    return _completeLength(binary, length);
  }

  static String _completeLength(String binary, int length){
    String binaryComplete = binary;

    int rest = length - binaryComplete.length;
    if(rest == 0) {
      return binaryComplete;
    }
    
    while(binaryComplete.length < length){
      binaryComplete = "0$binaryComplete";
    }

    return binaryComplete;
  }
}