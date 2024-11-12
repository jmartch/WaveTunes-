import controlP5.*;
ControlP5 cp5;

float[] cuerda;
float[] y1;
float[] y2;
boolean superposicion = false, simulacion=true;
int n, intervaloBolas = 120, radioBola, contadorBolasAmarillas = 0;
float fn, a, w, extremoDerechoY, velocidadPropagacion, lambda, densidad = 3, x = 1200, amplitud, tension, y, numero_o, rapidez_onda;

void setup() {
  size(1200, 600);
  cuerda = new float[int(x)];
  y1 = new float[int(x)];
  y2 = new float[int(x)];
  //Controles
  controles();
}
void controles() {
  // Crea una barra de desplazamiento horizontal para la tensión
  cp5 = new ControlP5(this);
  cp5.addSlider("Tensión(N)")
    .setPosition(1, 15)
    .setWidth(200)
    .setRange(0, 15)
    .setValue(2.5);
  // Utiliza un controlador numérico en lugar de un deslizador para los nodos
  cp5.addSlider("Amplitud(M)")
    .setPosition(345, 15)
    .setWidth(200)
    .setRange(0, 1)
    .setValue(0.75);
  cp5.addSlider("Frecuencia(Hz)")
    .setPosition(645, 15)
    .setWidth(200)
    .setRange(0.0001, 0.1)
    .setValue(0.1);
  // Utiliza un controlador numérico en lugar de un deslizador para los nodos
  cp5.addNumberbox("Nodos")
    .setPosition(50, 100)
    .setSize(100, 20)
    .setRange(0, 15) // Rango de valores enteros para nodos
    .setValue(1);
  cp5.addButton("Superposición")
    .setPosition(950, 15)
    .setSize(100, 20);
  cp5.getController("Superposición").addListener(new ControlListener() {
    public void controlEvent(ControlEvent event) {
      superposicion = !superposicion; // Cambia el estado del botón al hacer clic
    }
  }
  );

  // Agrega un listener para el controlador numérico de nodos
  cp5.getController("Nodos").addListener(new ControlListener() {
    public void controlEvent(ControlEvent event) {
      n = int(event.getValue());
    }
  }
  );
  if (simulacion) {
    cp5.addButton("Detener/Reanudar Simulación")
      .setPosition(1050, 15)
      .setSize(160, 20);

    cp5.getController("Detener/Reanudar Simulación").addListener(new ControlListener() {
      public void controlEvent(ControlEvent event) {
        simulacion = !simulacion; // Cambiar el estado de la simulación
      }
    }
    );
  }
}
void draw() {
  background(0);
  noStroke();
  actualiza();
  if (simulacion) {
    // Graficar Bolitas y cuerda
    for (int i = 1; i < cuerda.length; i=i+1) {
      if (i+10 % intervaloBolas == 0) {
        fill(255, 255, 0); // Color amarillo para bolas de diferente color
        radioBola = 2; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola amarilla
        contadorBolasAmarillas++;
      } else {
        fill(255, 0, 0); // Color rojo para las otras bolas
        radioBola = 2; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
      }
    }
    if (n ==  1){
    for (int i = 1; i<cuerda.length; i = i+1200){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
  } 
  if (n ==  2){
    for (int i = 1; i<cuerda.length; i = i+600){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  }
  if (n ==  3){
    for (int i = 1; i<cuerda.length; i = i+400){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  4){
    for (int i = 1; i<cuerda.length; i = i+300){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  5){
    for (int i = 1; i<cuerda.length; i = i+240){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  6){
    for (int i = 1; i<cuerda.length; i = i+200){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
   if (n ==  7){
    for (int i = 1; i<cuerda.length; i = i+170){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  8){
    for (int i = 1; i<cuerda.length; i = i+150){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  9){
    for (int i = 1; i<cuerda.length; i = i+133){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  10){
    for (int i = 1; i<cuerda.length; i = i+120){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  11){
    for (int i = 1; i<cuerda.length; i = i+109){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  12){
    for (int i = 1; i<cuerda.length; i = i+100){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  13){
    for (int i = 1; i<cuerda.length; i = i+92){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  14){
    for (int i = 1; i<cuerda.length; i = i+86){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
  if (n ==  15){
    for (int i = 1; i<cuerda.length; i = i+80){ 
      fill(255, 255, 0);
      radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
    }
    ellipse(1191, height / 2 + cuerda[1191], radioBola, radioBola);
  } 
    if (superposicion) {
      fill(0, 0, 255); //H Relleno azul para y1
      text("Onda Incidente (y1): " + y1[1], 20, 150);

      fill(0, 255, 0); // Relleno verde para y2
      text("Onda Reflejante (y2): " + y2[1], 20, 180);

      fill(255, 0, 0); // Relleno verde para y2
      text("Onda cuerda: " +cuerda[1], 20, 210);

      for (int i = 1; i < cuerda.length; i=i+1) {

        fill(0, 0, 255); // Relleno azul
        ellipse(i, height/2 + y1[i], 5, 5); // Dibuja y1 en azul

        fill(0, 255, 0); // Relleno verde
        ellipse(i, height/2 + y2[i], 5, 5); // Dibuja y2 en verde
      }
    }
    // Dibuja el recuadro para mostrar los datos
    fill(255);
    rect(10, 500, 300, 80); // Recuadro para datos

    // Muestra los datos en el recuadro
    fill(0);
    textSize(14);
    text("Velocidad de Propagación: " + velocidadPropagacion, 20, 530);
    text("Frecuencia Angular (w): " + w, 20, 550);
    text("Longitud de Onda (Lambda): " + lambda, 20, 570);
    text("Número de Ondas (k): " + numero_o, 20, 510);
  }
}


void actualiza() {
  tension = cp5.getController("Tensión(N)").getValue();
  amplitud = cp5.getController("Amplitud(M)").getValue();
  if (n==0) {
    float f = cp5.getController("Frecuencia(Hz)").getValue();
    lambda = 2*x;
    numero_o = w*8*frameCount+lambda; // Número de ondas (k)
    w = TWO_PI * f/10; // Frecuencia angular
    //Calculo de las ondas
    for (int i = 1; i < cuerda.length; i=i+1) {

      y1[i] = a * sin(f/10* i - w  *frameCount); // Onda positiva
      y2[i] = a * sin(f/10* i + w * frameCount); // Onda negativa

      cuerda[i] = y1[i] + y2[i]; // Suma aritmética (Superposición)
    }
  } else {

    fn = (n / (2.0 * x)) * velocidadPropagacion;//Freciencia
    lambda = 2 * x / n; // Lambda
    a = amplitud * 100;
    velocidadPropagacion = sqrt(tension / densidad); // Velocidad de propagación
    w = TWO_PI * fn; // Frecuencia angular
    numero_o = TWO_PI / lambda; // Número de ondas (k)

    //Calculo de las ondas
    for (int i = 1; i < cuerda.length; i=i+1) {

      y1[i] = a * sin(numero_o * i - w * 8 *frameCount); // Onda positiva
      y2[i] = a * sin(numero_o * i + w * 8 * frameCount); // Onda negativa

      cuerda[i] = y1[i] + y2[i]; // Suma aritmética (Superposición)
    }
  }
}
