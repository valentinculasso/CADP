{
3. Se dispone de un vector con números enteros, de dimensión física dimF y dimensión lógica dimL.
a) Realizar un módulo que imprima el vector desde la primera posición hasta la última.
b) Realizar un módulo que imprima el vector desde la última posición hasta la primera.
c) Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera posición, y
desde la mitad más uno hacia la última posición.
d) Realizar un módulo que reciba el vector, una posición X y otra posición Y, e imprima el vector desde la
posición X hasta la Y. Asuma que tanto X como Y son menores o igual a la dimensión lógica. Y considere
que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o hacia atrás.
e) Utilizando el módulo implementado en el inciso anterior, vuelva a realizar los incisos a, b y c. 
}


program ejercicio;
const
	dimF = 10;
type
	vector = array [1..dimF] of integer;

procedure inicializar_vector(var a: vector; var dL: integer);
var
	num: integer;
begin
	write('Ingrese un numero: ');
	read(num);
	while((dL < dimF)and(num<>7))do begin //aca a modo de ejemplo pongo la condicion de que num no sea igual a 7, esto lo hago para cargar el vector nomas
		dL:= dL + 1;  	                  //porque el enunciado me dice que lo dispongo, pero yo lo cargo a proposito, para chequear los incisos
		a[dL]:= num;
		write('Ingrese un numero: ');
		read(num);
	end;
end;

procedure Imprimir_PrimeraPos_Ultima(v: vector; dL: integer);
var
	i: integer;
begin
	for i:= 1 to dL do begin
		writeln(v[i]);
	end;
end;

procedure imprimir_ultimaPos_primera(v: vector; dL: integer);
var
	i: integer;
begin
	for i:= dL downto 1 do begin
		writeln(v[i]);
	end;
end;

procedure imprimir_mitad(v: vector; dL: integer);
var
	i: integer;
	dimL_aux: integer;
	
begin
	dimL_aux:= dL DIV 2;
	for i:= dimL_aux downto 1 do begin // Recorro desde dimL/2 hasta la primera posicion
		writeln(v[i]);
	end;
	for i:= dimL_aux+1 to dL do begin // Recorro desde dimL/2 hasta DimL
		writeln(v[i]);
	end;
end;

var
	v: vector;
	dimL: integer;

BEGIN
	dimL:= 0;
	inicializar_vector(v, dimL);
	Imprimir_PrimeraPos_Ultima(v, dimL);
	imprimir_ultimaPos_primera(v, dimL);
	imprimir_mitad(v, dimL);
END.
