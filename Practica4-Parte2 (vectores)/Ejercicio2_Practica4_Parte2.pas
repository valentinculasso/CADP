{2. Realice un programa que resuelva los siguientes incisos:
a. Lea nombres de alumnos y los almacene en un vector de a lo sumo 500 elementos. La lectura finaliza
cuando se lee el nombre ‘ZZZ’, que no debe procesarse.
b. Lea un nombre y elimine la primera ocurrencia de dicho nombre en el vector.
c. Lea un nombre y lo inserte en la posición 4 del vector.
d. Lea un nombre y lo agregue al vector.
Nota: Realizar todas las validaciones necesarias.
}


program Ejercicio2;
const
	dimF = 500;
type
	vector = array[1..dimF]of string;

procedure cargar_vector(var v: vector; var dimL: integer);
var
	nombre: string[20];
begin
	writeln('Ingrese un nombre de un alumno: ');
	readln(nombre);
	while(dimL <= dimF)and(nombre <> 'ZZZ')do begin
		dimL:= dimL + 1;
		writeln('Ingrese un nombre de un alumno: ');
		readln(nombre);
	end;
end;

procedure eliminar_nombre(var v: vector; var dimL: integer; var pude: boolean; nombre: string);
var
	i, pos: integer;
	esta: boolean;
begin
	pos:= 0;
	i:= 1;
	esta:= False;
	while(i <= dimL)and(not esta)do begin // Aca lo que hago es recorrer el vector, hasta encontrar la primera ocurrencia.
		if(v[i] = nombre)then begin
			pos:= i;
			esta:= True;
		i:= i + 1;
	end;
	if(pos >= 1)and(pos <= dimL)then begin // Aca elimino el elemento
		for i:= pos to dimL-1 do
				v[i]:= v[i+1];
		pude:= True;
		dimL:= dimL -1;
	end;
end;

procedure insertar(var v: vector; var dimL: integer; var pude: boolean; nombre: string; pos: integer);
var
	i: integer;
begin
	if(dimL+1 < dimF)and(pos >= 1)and(pos <= dimL)then begin
		for i:= dimL downto pos do
			v[i+1]:= v[i];
		pude:= True;
		v[pos]:= nombre;
		dimL:= dimL +1;
	end;
end;

procedure agregar_nombre(var v: vector; var dimL: integer; var pude: boolean; nombre: string);
begin
	if((dimL+1)<dimF)then begin
		pude:= True;
		dimL:= dimL +1;
		v[dimL]:= nombre;
	end;
end;

var
	v: vector;
	dimL, posicion: integer;
	nombre: string;
	ok: boolean;
BEGIN
	dimL:= 0;
	cargar_vector(v, dimL);
	writeln('Ingrese un nombre de un alumno a eliminar: ');
	// Inciso B
	read(nombre);
	ok:= False;
	eliminar_nombre(v, dimL, ok, nombre);
	// Inciso C
	writeln('Ingrese un nombre de un alumno a eliminar: ');
	read(nombre);
	ok:= False;
	posicion:= 4;
	insertar(v, dimL, ok, nombre, posicion);
	// Inciso D
	writeln('Ingrese un nombre de un alumno a eliminar: ');
	read(nombre);
	ok:= False;
	agregar_nombre(v, dimL, ok, nombre);
END.

