class Karnaugh {
  int literalNumber = 0;
  List<List<int>> matrix = List.generate(1, (_) => List.filled(1, 0), growable: true);
  int rowLength = 0;
  int columnLength = 0;

  Karnaugh(String litNumber, List<int?> valueList){
    literalNumber = int.parse(litNumber);
    formatListToMatrix(valueList);
  }

  void formatListToMatrix(List<int?> valueList){

    switch(literalNumber){
      case 2:
        rowLength = 2;
        columnLength = 2;
      break;
      case 3:
        rowLength = 2;
        columnLength = 4;
      break;
      case 4:
        rowLength = 4;
        columnLength = 4;
      break;
      case 5:
        rowLength = 4;
        columnLength = 8;
      break;
      case 6:
        rowLength = 4;
        columnLength = 4;
      break;
    }
     matrix = List.generate(rowLength, (_) => List.filled(columnLength, 0));

     initializeMatrixFromList(valueList);

    buildKarnaugh();
  }

  void buildKarnaugh() {
    switch(literalNumber){
      case 3:
        rotateColumn(matrix, 2, 3);
      break;
      case 4:
      case 6:
        rotateColumn(matrix, 2, 3);
        rotateRow(matrix, 2, 3);
      break;
      case 5:
        rotateColumn(matrix, 2, 3);
        rotateColumn(matrix, 4, 7);
        rotateColumn(matrix, 4, 5);
        rotateColumn(matrix, 4, 6);
        rotateRow(matrix, 2, 3);
      break;
    }
  }

  void initializeMatrixFromList(List<int?> valueList){
    int iterator = 0;
    for(int i = 0; i < rowLength; i++){
      for(int j = 0; j < columnLength; j++){
        matrix[i][j] = valueList[iterator]!;
        iterator++;
      }
    }
  }

  void rotateRow(List<List<int>> matrix, int row1, int row2) {

    for(int i = 0; i < matrix[0].length; i++){
      int temp = matrix[row1][i];
      matrix[row1][i] = matrix[row2][i];
      matrix[row2][i] = temp;
    }
  }

  void rotateColumn(List<List<int>> matrix, int column1, int column2){
    
    for (int i = 0; i < matrix.length; i++) {
      int temp = matrix[i][column1];
      matrix[i][column1] = matrix[i][column2];
      matrix[i][column2] = temp;
    }
  }
}