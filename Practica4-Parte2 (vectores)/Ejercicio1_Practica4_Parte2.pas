{1. a. Dado un vector de enteros de a lo sumo 500 valores, realice un módulo que reciba dicho vector y un valor
n y retorne si n se encuentra en el vector o no. // Buscar valor n , lo hago con una funcion True/False
b. Modifique el módulo del inciso a. considerando ahora que el vector se encuentra ordenado de manera
ascendente // Si el vector esta ordenado, debo hacer busqueda dicotomica.
}


program Ejercicio1;
const
	dimF = 5;
type
	vector = array[1..dimF]of integer;

procedure cargar_vector(var v: vector; var dimL: integer);
var
	num:integer;
begin
	writeln('Ingrese un valor (para cargar el vector): ');
	readln(num);
	while(dimL < dimF)and(num <> -1)do begin
		dimL:= dimL + 1;
		v[dimL]:= num;
		writeln('Ingrese un valor (para cargar el vector): ');
		readln(num);
	end;
end;

procedure ordenar(var v: vector; dimL: integer);
var
	i, j, p, item: integer;
begin
	for i:= 1 to dimL-1 do begin
		p:= i; // Guardo en p la posicion i
		for j:= i+1 to dimL do begin // Recorro todo el vector desde i + 1 , en busca del numero mas pequeño
			if v[j] < v[p] then
				p:= j;
		end;
		item:= v[p]; // Numero mas pequeño encontrado
		v[p]:= v[i]; // En la posicion que encontre el valor mas pequeño, pongo el valor de i (voy a poner el valor que quiero cambiar)
		v[i]:= item; // Pongo el valor mas pequeño en la posicion i (en el primer caso, en la posicion 1)
	end;
end;

function buscar_valor(v: vector; dimL: integer; num: integer): boolean; // No esta mal, pero si encuentro el elemento, sigo recorriendo el resto del vector.
var
	esta: boolean;
	i: integer;
begin
	esta:= False;
	for i:= 1 to dimL do begin
		if(v[i] = num)then begin
			esta:= True;
		end;
	end;
	buscar_valor:= esta;
end;
//______________________________________________________________________ Ver en profundidad este modulo
function buscar_valor_ordenado(v: vector; dimL: integer; num: integer): boolean;
var
	esta: boolean;
	pri, ult, medio: integer;
begin
	esta:= False;
	pri:= 1;
	ult:= dimL;
	medio:= (pri + ult) DIV 2;
	while(pri <= ult)and(num <> v[medio])do begin
		if(num < v[medio])then
			ult:= medio - 1
		else
			pri:= medio + 1;
		medio:= (pri + ult) DIV 2;
	end;
	if(pri <= ult)and(num = v[medio])then
		esta:= True;
	buscar_valor_ordenado:= esta;
end;

var
	dimL, valor: integer;
	v: vector;
	
BEGIN
	dimL:= 0;
	cargar_vector(v, dimL); // Lo dispongo, pero lo hago para comprobar el ejercicio.
	writeln('Ingrese un valor: ');
	readln(valor);
	if(buscar_valor(v, dimL, valor))then begin
		writeln('El numero ',valor,' se encuenta en el vector');
	end
	else
		writeln('El numero ',valor,' no se encuenta en el vector');
	ordenar(v, dimL);
	if(buscar_valor_ordenado(v, dimL, valor))then begin
		writeln('El numero ',valor,' se encuenta en el vector');
	end
	else
		writeln('El numero ',valor,' no se encuenta en el vector');
END.

