int num = 200;  //表示する世代数
int mod = 2;  //法とする数
int[] state = {1};  //初期状態
int gen = 0;
void setup(){
  size(1000, 500);
  colorMode(HSB, 1);
  background(0, 0, 1);
}
void draw(){
  if (gen < num){
    drawCell(gen);
    updateState();
  }
}
void mouseClicked(){
  gen = 0;
  state = new int[]{1};  //初期状態
  mod = int(random(2, 20));
  println(mod);
  background(0, 0, 1);
}

void drawCell(float y){
  float scalar = width * 0.5 / num; // セルの大きさ
  float x = (width - state.length * scalar) * 0.5; // セルのx座標
  y *= scalar;
  noStroke(); //輪郭線を描かない
  for (int i = 0; i < state.length; i++){
    fill(state[i] * 1.0 / mod, state[i] * 1.0 / mod, 1);
    rect(x, y, scalar, scalar); // 四角形を描画する関数
    x += scalar; // x座標方向にセルをずらす
  }
}

int transition(int a, int b, int c){
  int d;
  if (random(1) < 0.999) {
    d = a + b + c; //99.9%の確率でこのルールを選択
  } else {
    d = a + c; //0.1%の確率
  }
  d %= mod;
  return d;
}

void updateState() {
  int[] BOUNDARY = {0, 0};
  int[] nextState = new int[state .length + 2]; // 次の世代の状態
  state = splice(state, BOUNDARY, 0); // 既存の配列に境界値を加える
  state = splice(state, BOUNDARY, state.length); // 配列の最後に境界値を加える
  for(int i=1; i < state.length -1; i++){
    nextState[i-1] = transition(state[i-1], state[i], state[i+1]); //次世代のセルの状態の計算
  }
  state = nextState; //セルの状態を更新
  gen++; //世代を一つ増やす
}
