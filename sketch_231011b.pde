import controlP5.*;
import processing.serial.*;
boolean sobreBoton = false;
boolean sobreBoton2 = false;
boolean sobreBoton3 = false;
boolean sobreBoton4 = false;
boolean sobreBoton5 = false;
boolean sobreBoton6 = false;
boolean sobreBoton7 = false;
boolean sobreBoton8 = false;
boolean sobreBoton9 = false;

boolean cuadroblancovisible = true;
boolean cuadronegrovisible = false;
boolean cuadronegrovisible2 = false; 
boolean cuadronegrovisible3 = false; 
boolean cuadronegrovisible4 = false; 

float[] cuerda;
float[] y111;
float[] y211;
boolean superposicion = false, simulacion=true;
int  intervaloBolas = 120, radioBola, contadorBolasAmarillas = 0;
float fn, n, a, w1, extremoDerechoY, velocidadPropagacion, lambda, densidad = 6, x11 = 1080, amplitud, tension, y11, numero_o, rapidez_onda,n1;


float amplitude = 90;   
float frequency = 4.0;   
float yOffset;           
float[] yValues;         
int numPoints;           
float spacing;           
float t = 0;             
float startX = 335; 

ControlP5 cp5;
PImage imagen;
PFont font1, font2, font3,font4; 
int x = 30, y = 200, x2 = 30, y2 = 500,y3 = 350,w = 200, h = 50;
color blue = color(189,212,255);
color white = color(255);
color black = color (34,37,42);
color buttonColorHome;
color buttonColorSorpresa;
color buttonColorSimulacion;
color hoverColor = color(189,212,255);
int abrir = 1;

Serial arduino;
int[] values;
int scaleFactor = 2; // Ajusta la escala para la representación gráfica
float tension1 = 1, amplitud1= 5;

void setup() {
   arduino = new Serial(this, "COM3", 9600); // Asegúrate de ajustar el puerto COM correcto
  values = new int[width];
  //Fondo
  size(1500, 950);
  //fullScreen();
  background(black);
  
  //Fonts
  font1 = loadFont("YuGothic-Medium-48.vlw");
  font2 = loadFont("CooperBlack-48.vlw");
  font3 = loadFont("CorbelLight-48.vlw");
  font4 = loadFont("Corbel-Bold-48.vlw");
  
  //Wave baby blue
  fill(blue);
  textFont(font2);
  textSize(30);
  text("Wave",90,110);
 
  //Cp5
    // Crea una barra de desplazamiento horizontal para la tensión
    
  cp5 = new ControlP5(this);
  //Segundo
  cp5.addSlider("Tensión(N)")
    .setPosition(700, 700)
    .setWidth(250)
    .setHeight(40)
    .setRange(0, 15)
    .setValue(0);
    cp5.getController("Tensión(N)").setVisible(false);
    cp5.getController("Tensión(N)").setColorForeground(color(129, 138, 245)); 
    cp5.getController("Tensión(N)").setColorBackground(color(111, 156, 230)); 
   
   
      
  // Utiliza un controlador numérico en lugar de un deslizador para los nodos
  //Primero
  cp5.addSlider("Amplitud(M)")
    .setPosition(365, 700)
    .setWidth(250)
    .setHeight(40)
    .setRange(0, 1)
    .setValue(0);
    cp5.getController("Amplitud(M)").setVisible(false);
    cp5.getController("Amplitud(M)").setColorForeground(color(129, 138, 245));
    cp5.getController("Amplitud(M)").setColorBackground(color(111, 156, 230)); 
    
   //Tercero 
  cp5.addSlider("Frecuencia(Hz)")
    .setPosition(1050, 700)
    .setWidth(250)
    .setHeight(40)
    .setRange(0.0001, 0.1)
    .setValue(0);
    cp5.getController("Frecuencia(Hz)").setVisible(false);
    cp5.getController("Frecuencia(Hz)").setColorForeground(color(129, 138, 245));
    cp5.getController("Frecuencia(Hz)").setColorBackground(color(111, 156, 230));
    
  // Utiliza un controlador numérico en lugar de un deslizador para los nodos
  //cuarto
  cp5.addNumberbox("Nodos")
    .setPosition(500, 800)
    .setSize(100, 20)
    .setWidth(250)
    .setHeight(40)
    .setRange(0, 15) // Rango de valores enteros para nodos
    .setValue(0);
     cp5.getController("Nodos").setVisible(false);
     cp5.getController("Nodos").setColorForeground(color(129, 138, 245));
    cp5.getController("Nodos").setColorBackground(color(111, 156, 230));
     
  cp5.addButton("Superposición")
    .setPosition(900, 800)
    .setSize(250, 40);
  cp5.getController("Superposición").addListener(new ControlListener() {
    public void controlEvent(ControlEvent event) {
      superposicion = !superposicion; // Cambia el estado del botón al hacer clic
    }
  }
  );
  cp5.getController("Superposición").setVisible(false);

  // Agrega un listener para el controlador numérico de nodos
  cp5.getController("Nodos").addListener(new ControlListener() {
    public void controlEvent(ControlEvent event) {
      n = int(event.getValue());
    }
  }
  );
  cp5.getController("Nodos").setVisible(false);
  
  // botones 
  buttonColorHome = color(black); 
  buttonColorSorpresa = color(black);
  
  //onda
         
  yOffset = 1000/ 3;  
  numPoints = 700;     
  spacing = (float)900 / numPoints;
  yValues = new float[numPoints];
  cuerda = new float[int(x11)];
  y111 = new float[int(x11)];
  y211 = new float[int(x11)];

}


void draw() {
  
  //Cuadrado blanco 
  if (cuadroblancovisible){
  fill(255);
  noStroke();
  rect(300,40,1170,855,30);
  
  //Cuadro abajo
  fill(55,58,63);
  rect(50, 700, 205, 200, 30);
  
  //texto
  textFont(font3);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Welcome to ", 450, 105);
  
  textFont(font4);
  textSize(40);
  textAlign(CENTER,CENTER);
  text("Wavetunes",650,105);
  
  //Aqui va la onda 
  fill(55,58,63);
  rect(330, 180, 910, 300, 30);
 
  
  //BotonInstrucciones
  fill(242,246,249);
  noStroke();
  rect(430, 600,250,200,30);
  fill(black);
  textFont(font3);
  textSize(24);
  textAlign(CENTER,CENTER);
  text("Instrucciones",550,650);
  
 imagen = loadImage("instrucciones.png");
 imagen.resize(150,150);
 image (imagen,475,660);
  
  
  //Al momento de presionar
  if (mouseX > 430 && mouseX < 680 && mouseY > 600 && mouseY < 800 && mousePressed == true){
    
    cuadroblancovisible = false;
    cuadronegrovisible2 = true;
    
  
  }
 
    
   
  //BotonOpciones
  fill(242,246,249);
  noStroke();
  rect(1000, 600,250,200,30);
  fill(black);
  textFont(font3);
  textSize(24);
  textAlign(CENTER,CENTER);
  text("Definiciones",1120,650);
  //Al momento de presionar
  if (mouseX > 1000 && mouseX < 1600 && mouseY > 600 && mouseY < 800 && mousePressed == true){
    
    cuadroblancovisible = false;
    cuadronegrovisible = true;
    
  }
    imagen = loadImage("info.png");
    imagen.resize(200,100);
    image (imagen,1020,670); 
  
  // onda
  for (int i = 0; i < numPoints; i++) {
    float x = startX + t + i; 
    yValues[i] = yOffset + sin(TWO_PI * frequency * x / 900 + t) * amplitude;
  }
  
  strokeWeight(4);
  noFill();
  stroke(blue);
  beginShape();
  for (int i = 0; i < numPoints; i++) {
    vertex(startX + i * spacing, yValues[i]);
  }
  endShape();
  
  t += 0.05; 
  
  }
  
  //BotonHome 
  fill(buttonColorHome);
  noStroke();
  rect(x, y, w, h, 10);
  fill(white);
  textFont(font1);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Home", x + w / 2, y + h / 2);

  //Brilla  
  if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    buttonColorHome = hoverColor; 
  } else {
    buttonColorHome = color(black); 
  }
  
  //Al momento de presionar
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed == true){
    cuadroblancovisible = true;
    cuadronegrovisible = false;
    cuadronegrovisible2 = false;
    cuadronegrovisible3 = false;
    cuadronegrovisible4 = false;
     cp5.getController("Tensión(N)").setVisible(false);
    cp5.getController("Amplitud(M)").setVisible(false);
    cp5.getController("Frecuencia(Hz)").setVisible(false);
    cp5.getController("Nodos").setVisible(false);
    cp5.getController("Superposición").setVisible(false);
  }
  
  //Simulacion
  fill(buttonColorSimulacion);
  noStroke();
  rect(x, y3, w, h, 10);
  fill(white);
  textFont(font1);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Simulacion", x + 5 + w / 2, y3 + h / 2);
  

  //Brilla  
  if(mouseX > x && mouseX < x + w && mouseY >y3 && mouseY < y3 + h) {
     buttonColorSimulacion = hoverColor; 
  } else {
    buttonColorSimulacion = color(black); 
  }
  
  //Al momento de presionar
  if (mouseX > x && mouseX < x+w && mouseY > y3 && mouseY < y3+h && mousePressed == true){
    cuadroblancovisible = false;
    cuadronegrovisible3 = true;
  }
  
    
  //Sorpresa
  fill(buttonColorSorpresa);
  noStroke();
  rect(x, y2, w, h, 10);
  fill(white);
  textFont(font1);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Sorpresa", x + w / 2, y2 + h / 2);

  //Brilla  
  if(mouseX > x2 && mouseX < x2 + w && mouseY >y2 && mouseY < y2 + h) {
     buttonColorSorpresa = hoverColor; 
  } else {
    buttonColorSorpresa = color(black); 
  }
  
  //Al momento de presionar
  if (mouseX > x2 && mouseX < x2+w && mouseY > y2 && mouseY < y2+h && mousePressed == true){
    
    cuadroblancovisible = false;
    cuadronegrovisible4 = true;
    
  }
  
   //imagen 
  imagen = loadImage("medusa2.PNG");
  imagen.resize(500,500);
  image (imagen,-40,637);
  
   
  if (cuadronegrovisible){
  fill(255);
  noStroke();
  rect(300,40,1170,855,30);
  cp5.getController("Tensión(N)").setVisible(false);
    cp5.getController("Amplitud(M)").setVisible(false);
    cp5.getController("Frecuencia(Hz)").setVisible(false);
    cp5.getController("Nodos").setVisible(false);
    cp5.getController("Superposición").setVisible(false);
    
 
    
  //Definiciones 
  
  fill (black);
  textFont(font4);
  textSize(60);
  textAlign(CENTER,CENTER);
  text("Definiciones",520,155);
  
  textFont(font3);
  textSize(24);
  text("¡Explora y despeja tus dudas con nuestras definiciones clave!",600,205);
  
  fill (black);
  textFont(font1);
  textSize(21);
  
   
  
  if (mouseX > 600 && mouseX < 800 && mouseY > 400 && mouseY < 480) {
    sobreBoton = true;
  } else {
    sobreBoton = false;
  }
  
   
  if (mouseX > 600 && mouseX < 800 && mouseY > 500 && mouseY < 580) {
    sobreBoton2 = true;
  } else {
    sobreBoton2 = false;
  }
  
  if (mouseX > 350 && mouseX < 550 && mouseY > 300 && mouseY < 380) {
    sobreBoton3 = true;
  } else {
    sobreBoton3 = false;
  }
  
  if (mouseX > 350 && mouseX < 550 && mouseY > 400 && mouseY < 480) {
    sobreBoton4 = true;
  } else {
    sobreBoton4 = false;
  }
  
  
  if (mouseX > 350 && mouseX < 550 && mouseY > 500 && mouseY < 580) {
    sobreBoton5 = true;
  } else {
    sobreBoton5 = false;
  }
  
   if (mouseX > 350 && mouseX < 550 && mouseY > 600 && mouseY < 680) {
    sobreBoton6 = true;
  } else {
    sobreBoton6 = false;
  }
  
   if (mouseX > 350 && mouseX < 550 && mouseY > 700 && mouseY < 780) {
    sobreBoton7 = true;
  } else {
    sobreBoton7 = false;
  }
  
   if (mouseX > 600 && mouseX < 800 && mouseY > 700 && mouseY < 780) {
    sobreBoton8 = true;
  } else {
    sobreBoton8 = false;
  }
  
   if (mouseX > 600 && mouseX < 800 && mouseY > 600 && mouseY < 680) {
    sobreBoton9 = true;
  } else {
    sobreBoton9 = false;
  }
  
  //onda
  fill(blue);
  rect(600, 400, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Onda", 695, 450);
 
    fill(blue); 
    rect(900,100,500,700,10);
    
 if (sobreBoton) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text("Una onda es una perturbación que se propaga", 1150, 200);
    text("a través de un medio o espacio,", 1150, 250);
    text("transfiriendo energía sin mover material.",1150,300);
 }
 
 //onda estacionaria 
  fill(blue);
  rect(600, 500, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Onda estacionaria", 695, 550);
  imagen = loadImage("Mantarraya.png");
  imagen.resize(400,400);
  image (imagen,1050,440);  
 
    
 if (sobreBoton2) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text("Una onda estacionaria es el resultado de las", 1150, 200);
    text("interferencias de dos ondas idénticas que se", 1150, 250);
    text("desplazan en direcciones opuestas, dando lugar",1150,300);
    text(" a patrones fijos de crestas y valles.",1150,350);
 }
  
 //Lambda
  fill(blue);
  rect(350, 300, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Lambda(λ)", 440, 350);
  
  if (sobreBoton3) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text(" La longitud de onda (λ) es la distancia entre ", 1150, 200);
    text("dos puntos equivalentes en una onda, como ", 1150, 250);
    text("dos crestas sucesivas. Se mide en metros (m).",1150,300);
 }
 
 //Amplitud
  fill(blue);
  rect(350, 400, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Amplitud", 440, 450);
  
  if (sobreBoton4) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text("La amplitud es la magnitud máxima de la perturbación", 1150, 200);
    text("en una onda, representando la altura desde la ", 1150, 250);
    text("posición de equilibrio hasta el punto más alto o bajo.",1150,300);
    text("Se mide en metros (m).",1150,350);
 } 
  
  //Longitud
  fill(blue);
  rect(350, 500, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Longitud", 440, 550);
  
  if (sobreBoton5) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text("En el contexto de una onda, la longitud se refiere", 1150, 200);
    text("a la distancia física que recorre la onda. ", 1150, 250);
    text("Se mide en metros (m).",1150,300);
 } 
 
  //Densidad lineal
  fill(blue);
  rect(350, 600, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Densidad lineal", 440, 650);
  
  if (sobreBoton6) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text("La densidad lineal es la masa por unidad de ", 1150, 200);
    text("un elemento de onda. ", 1150, 250);
    text("Se mide en kilogramos por metro (kg/m).",1150,300);
 } 
  
  //Tensión
  fill(blue);
  rect(350, 700, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Tensión", 440, 750);
  
  if (sobreBoton7) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text("La tensión es la fuerza de estiramiento que actúa en ", 1150, 200);
    text("una cuerda o medio de propagación de la onda.", 1150, 250);
    text("Se mide en newtons (N).",1150,300);
 } 
  
  //Velocidad de propagación
  fill(blue);
  rect(600, 700, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Velocidad de", 695, 740);
  text("propagación",695,770);
  
  if (sobreBoton8) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text(" La velocidad de propagación es la rapidez con la ", 1150, 200);
    text("que una onda se desplaza a través de un medio.", 1150, 250);
      text("Se mide en newtons (N).",1150,300);
 } 

  //Frecuencia  
  fill(blue);
  rect(600, 600, 200, 80 ,10);
  fill(black);
  textAlign(CENTER);
  text("Frecuencia", 695, 650);
  
  if (sobreBoton9) {
    fill(0); 
    textSize(20);
    textAlign(CENTER);
    text("La frecuencia es el número de ciclos u oscilaciones", 1150, 200);
    text(" completas de una onda que ocurren en un segundo.", 1150, 250);
    text("Se mide en hercios (Hz).",1150,300);
    
   
 } 
  
  }
  
  if (cuadronegrovisible2){
  fill(255);
  noStroke();
  rect(300,40,1170,855,30);
  cp5.getController("Tensión(N)").setVisible(false);
    cp5.getController("Amplitud(M)").setVisible(false);
    cp5.getController("Frecuencia(Hz)").setVisible(false);
    cp5.getController("Nodos").setVisible(false);
    cp5.getController("Superposición").setVisible(false);
    
    
  //Instrucciones 
  fill (black);
  textFont(font4);
  textSize(50);
  textAlign(CENTER,CENTER);
  text("Instrucciones",520,105);
  
  textFont(font1);
  textSize(20);
  text("Para utilizar la simulación, siga estos pasos:",600,200);
  text("1. Haga clic en el botón simulación para iniciar la onda.",600,250);
  text("2. Mueve los sliders para obtener los valores deseados para la tensión, la amplitud, la frecuencia y el número de nodos.",900,300);
  text("3.Observa la onda.",200,350);
  
  imagen = loadImage("Medusa con ojos.png");
  imagen.resize(700,700);
  image (imagen,800,237);
  
  
  }
  
  if ( cuadronegrovisible3) {
  fill(255);
  noStroke();
  rect(300,40,1170,855,30);
  
 
   
    
    cp5.getController("Tensión(N)").setVisible(true);
    cp5.getController("Amplitud(M)").setVisible(true);
    cp5.getController("Frecuencia(Hz)").setVisible(true);
    cp5.getController("Nodos").setVisible(true);
    cp5.getController("Superposición").setVisible(true);
  // simulacion de la onda 
  
  Controller t= cp5.getController("Tensión(N)");
     tension = t.getValue();
     Controller A = cp5.getController("Amplitud(M)");
     amplitud = A.getValue();
     Controller f1 = cp5.getController("Frecuencia(Hz)");
     fn = f1.getValue();
     Controller M = cp5.getController("Nodos");
     n= M.getValue();
     
     
     
  if (n==0) {
    float fn = 0.001;
    lambda = 2*x11;
    numero_o = w1*8*frameCount+lambda; // Número de ondas (k)
    w1 = TWO_PI * fn/10; // Frecuencia angular
    //Calculo de las ondas
    for (int i = 1; i < cuerda.length; i=i+1) {

      y111[i] = a * sin(fn/10* i - w1  *frameCount); // Onda positiva
      y211[i] = a * sin(fn/10* i + w1 * frameCount); // Onda negativa

      cuerda[i] = y111[i] + y211[i]; // Suma aritmética (Superposición)
    }
  } else {
    velocidadPropagacion = sqrt(tension / densidad); // Velocidad de propagación
    fn = (n / (2.0 * x11)) * velocidadPropagacion;//Freciencia
    lambda = 2 * x11 / n; // Lambda
    a = amplitud * 100;
    
    w1 = TWO_PI * fn; // Frecuencia angular
    numero_o = TWO_PI / lambda; // Número de ondas (k)

    //Calculo de las ondas
    for (int i = 1; i < cuerda.length; i=i+1) {

      y111[i] = a * sin(numero_o * i - w1 * 8 *frameCount); // Onda positiva
      y211[i] = a * sin(numero_o * i + w1 * 8 * frameCount); // Onda negativa

      cuerda[i] = y111[i] + y211[i]; // Suma aritmética (Superposición)
    }
  }
    for (int i = 1; i < cuerda.length; i=i+1) {
      
        fill(189,212,255); // Color rojo para las otras bolas
        radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(350+i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
      
    }

  
    // Muestra los datos en el recuadro
    fill(0);
    textFont(font4);
    textSize(20);
    text("Vel de Prop: " + velocidadPropagacion, 1300, 145);
    text("Frecuencia(w): " + w1, 1300, 175);
    text("Lambda: " + lambda, 1300, 205);
    text("Número Ondas(k):" + numero_o, 1300, 235);
    
  if (superposicion) {
      for (int i = 1; i < cuerda.length; i=i+1) {

        fill(0, 0, 255); // Relleno azul
        ellipse(350+i, height/2 + y111[i], 5, 5); // Dibuja y1 en azul

        fill(0, 255, 0); // Relleno verde
        ellipse(350+i, height/2 + y211[i], 5, 5); // Dibuja y2 en verde
      }
    }
    
  fill (94, 139, 198 );
  textFont(font2);
  textSize(60);
  textAlign(CENTER,CENTER);
  text("Simulacion",520,155);
    
   fill(black); 
  textFont(font4);  
  textSize(20);
  text("Tensión(N)",800, 690);
  fill(black);
  textSize(20);
  
  textFont(font4);  
  textSize(20);
  text("Amplitud(M)",460, 690);
  fill(black);
  textSize(20);
  
  textFont(font4);  
  textSize(20);
  text("Frecuencia(Hz)",1150, 690);
  fill(black);
  textSize(20);
  
  textFont(font4);  
  textSize(20);
  text("Frecuencia2(Hz)",600, 790);
  fill(black);
  textSize(20);
  
  
  }
  if(cuadronegrovisible4) {
    fill(255);
  noStroke();
  rect(300,40,1170,855,30);
  cp5.getController("Tensión(N)").setVisible(false);
    cp5.getController("Amplitud(M)").setVisible(false);
    cp5.getController("Frecuencia(Hz)").setVisible(false);
    cp5.getController("Nodos").setVisible(true);
    cp5.getController("Superposición").setVisible(false);
  //Instrucciones 
  fill (black);
  textFont(font4);
  textSize(50);
  textAlign(CENTER,CENTER);
  text("SORPRESA",520,105);
  
    for (int i = 0; i < values.length - 1; i++) {
    values[i] = values[i + 1];
  }
  while (arduino.available() > 0) {
    String data = arduino.readStringUntil('\n');
    if (data != null) {
      data = data.trim();
      int sensorValue = int(data);
   
      values[values.length - 1] = sensorValue * scaleFactor;
      stroke(0);
      line(width - 1, height / 2, width, height / 2);
      noFill();
      beginShape();
      for (int i = 0; i < values.length; i++) {
        vertex(i, height / 2 - values[i]);
      }
      endShape();
    }
  }
   for (int i = 1; i< values.length; i++){
     float fn1=values[i];
  velocidadPropagacion = sqrt(tension1 / densidad); // Velocidad de propagación
    fn = (fn1 / (2.0 * x11)) * velocidadPropagacion;//Freciencia
    lambda = 2 * x11 / n; // Lambda
    a = amplitud1 * 100;
    
    w1 = TWO_PI * fn; // Frecuencia angular
    numero_o = TWO_PI / lambda; // Número de ondas (k)

    //Calculo de las ondas
    for (int i1 = 1; i1 < cuerda.length; i1=i1+1) {

      y111[i] = a * sin(numero_o * i - w1 * 8 *frameCount/5); // Onda positiva
      y211[i] = a * sin(numero_o * i + w1 * 8 * frameCount/5); // Onda negativa

      cuerda[i] = y111[i] + y211[i]; // Suma aritmética (Superposición)
    }
  
    for (int i2 = 1; i < cuerda.length; i2=i2+1) {
      
        fill(0, 0, 255); // Color rojo para las otras bolas
        radioBola = 3; // Aumentar el tamaño de las bolas
        ellipse(350+i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
      
    }
} 
  
  }
}
