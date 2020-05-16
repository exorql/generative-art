int num = 250; //行と列の長さ
int mod = 4; // 法とする数
int[][] state = new int[num][num]; //セルの状態を表す行列
void setup(){
  size(500, 500);
  colorMode(HSB, 360, 1, 1);
  initialize();
}
void draw(){
  drawCell();
  updateState();
}

void drawCell() {
  float scalar = (float) height / num; // セルのサイズ
  float y = 0; // セルのy座標
  float x;
  for (int i=0; i < num; i++){
    x = 0;  // セルのx座標
    for (int j = 0; j < num; j++){
      noStroke();
      fill(state[i][j] * 1.0 / mod, state[i][j] * 1.0 / mod, 1); //セルの色
      rect(x, y, scalar, scalar);
      x += scalar;
    }
    y += scalar;
  }
}

void initialize() {
  for (int i=0; i < num; i++){
    for (int j=0; j < num; j++){
      if (i == num / 2 && j == num /2){
        state[i][j] = 1; // 真ん中の成分のみ１
      } else {
        state[i][j] = 0;
      }
    }
  }
}

void updateState() {
  int[][] nextState = new int[num][num]; // 次世代の状態
  for (int i=0; i < num ; i++) {
    for (int j=0; j < num;  j++) {
      nextState[i][j] = traonsition(i, j); //　遷移
    }
  }
  state = nextState; //　更新
}

int traonsition(int i, int j){
  int nextC;
   nextC = state[(i - 1 + num) % num][j] // 上のセル 
     + state[i][(j - 1 + num) % num] // 左のセル
     + state[i][j] // 中央のセル
     + state[i][(j + 1) % num] // 右のセル
     + state[(i + 1) % num][j]; // 下のセル
   nextC %= mod;
   return nextC;
}

void mouseClicked(){
  initialize();
  mod = int(random(2, 20));
  println(mod);
  background(0, 0, 1);
}
