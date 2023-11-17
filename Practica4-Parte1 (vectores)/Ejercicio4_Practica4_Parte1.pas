{4. Se dispone de un vector con 100 números enteros. Implementar los siguientes módulos:
a) posicion: dado un número X y el vector de números, retorna la posición del número X en dicho vector,
o el valor -1 en caso de no encontrarse.
b) intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números, y retorna el mismo vector
donde se intercambiaron los valores de las posiciones x e y.
c) sumaVector: retorna la suma de todos los elementos del vector.
d) promedio: devuelve el valor promedio de los elementos del vector.
e) elementoMaximo: retorna la posición del mayor elemento del vector
f) elementoMinimo: retorna la posicion del menor elemento del vector}


program Ejercicio4Practica4Parte1;
const
	dimF = 10;
type
	vector = array[1..dimF]of integer;

procedure cargar_vector(var a: vector); // Lo cargo a modo de prueba
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		write('Ingrese un valor: ');
		read(a[i]);
	end;
end;


procedure posicion(v: vector; var pos: integer);
var
	i, X: integer;
	esta: boolean;
begin
	write('Ingrese el valor de X: ');
	read(X);
	i:= 1;
	esta:= False;
	while((i < dimF)and(esta = False))do begin
		if(v[i]=X)then begin
			esta:= True;
			pos:= i;
		end
		else
			i:= i + 1;
		if((i = dimF)and(v[i] = X))then begin
			pos:= i;
		end;
		if((i = dimF)and(v[i] <> X))then begin
			pos:= -1;
		end;
	end;
end;

procedure intercambio(var v: vector; x: integer; y: integer);
var
	num_aux1, num_aux2: integer;
begin
	num_aux1:= v[x];
	num_aux2:= v[y];
	v[x]:= num_aux2;
	v[y]:= num_aux1;
end;

procedure imprimir_vector_nuevo(v: vector);
var
	i: integer;
begin
	for i:= 1 to dimf do begin
		writeln(v[i]);
	end;
end;

procedure sumaVector(v: vector; var suma_vec: integer);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		suma_vec:= suma_vec + v[i];
	end;
end;

procedure promedio(v: vector; suma_vec: integer; var prom: real);
begin	
	prom:= suma_vec div dimF;
end;

procedure elemento_maximo(v: vector; var max: integer ;var pos_max: integer);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		if(v[i]>max)then begin
			max:= v[i];
			pos_max:= i;
		end;
	end;
end;

// _____________________________________ PROGRAMA PRINCIPAL _________________________________________ //

var
	v: vector;
	pos, x, y, suma_vector, posicion_max, maximo: integer;
	prom: real;
	
BEGIN
	suma_vector:= 0;
	prom:= 0;
	maximo:= 0;
	posicion_max:= 0;
	cargar_vector(v); //Lo dispongo
	posicion(v, pos); // A
	writeln('La posicion del numero X en el vector es: ',pos);
	write('Ingrese el valor X: ');
	read(x);
	write('Ingrese el valor Y: ');
	read(y);
	intercambio(v,x,y); // B
	imprimir_vector_nuevo(v); // B "solo muestro el vector, para chequear que evidentemente se hayan cambiado los valores"
	sumaVector(v, suma_vector); // C
	writeln('La suma de los elementos del vector es: ',suma_vector);
	promedio(v, suma_vector, prom); // D
	writeln('El promedio de los elementos del vector es: ',prom:1:2);
	elemento_maximo(v, maximo,posicion_max); // E
	writeln('El elemento maximo del vector esta en la posicion: ',posicion_max);
END.

