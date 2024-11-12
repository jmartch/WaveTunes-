import controlP5.*;
ControlP5 cp5;

float[] cuerda;
float[] y1;
float[] y2;
boolean superposicion = false, simulacion=true;
int n, intervaloBolas = 120, radioBola, contadorBolasAmarillas = 0;
float f=3, a, w, x = 1000, k, t,m=20,lambda, v,T=10 ;

void setup() {
  size(1200, 600);
  cuerda = new float[int(x)];
  y1 = new float[int(x)];
  y2 = new float[int(x)];
  //Controles
 
}

void draw() {
  background(0);
  noStroke();
  double d = m / x; 
  double v = sqrt((float) (T / d));
double k = TWO_PI / lambda; // numero de onda = 2PI / Longitud de onda
        double w = TWO_PI * f; // frecuencia angular = 2PI * f
  if (simulacion) {
    // Graficar Bolitas y cuerda
    for (int i = 1; i < cuerda.length; i=i+10) {
      if (i+10 % intervaloBolas == 0) {
        fill(255, 255, 0); // Color amarillo para bolas de diferente color
        radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola amarilla
        contadorBolasAmarillas++;
      } else {
        fill(255, 0, 0); // Color rojo para las otras bolas
        radioBola = 10; // Aumentar el tamaño de las bolas
        ellipse(i, height / 2 + cuerda[i], radioBola, radioBola); // Dibuja una bola roja
      }
    }
    
    // Dibuja el recuadro para mostrar los datos
    fill(255);
    rect(10, 500, 300, 80); // Recuadro para datos

    // Muestra los datos en el recuadro
    fill(0);
    textSize(14);
    text("Velocidad de Propagación: " + 2, 20, 530);
    text("Frecuencia Angular (w): " + w, 20, 550);
    text("Longitud de Onda (Lambda): " + lambda, 20, 570);
    text("Número de Ondas (k): " + 5, 20, 510);
  }
}
