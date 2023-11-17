{4. Una cátedra dispone de información de sus alumnos (a lo sumo 1000). De cada alumno se conoce nro de
alumno, apellido y nombre y cantidad de asistencias a clase. Dicha información se encuentra ordenada por
nro de alumno de manera ascendente. Se pide:
a. Un módulo que retorne la posición del alumno con un nro de alumno recibido por parámetro. El
alumno seguro existe.
b. Un módulo que reciba un alumno y lo inserte en el vector. // Si no me da la posicion, lo agrego, no lo inserto. Porque no sabria en que posicion insertarlo.
c. Un módulo que reciba la posición de un alumno dentro del vector y lo elimine.
d. Un módulo que reciba un nro de alumno y elimine dicho alumno del vector
e. Un módulo que elimine del vector todos los alumnos con cantidad de asistencias en 0.
Nota: Realizar el programa principal que invoque los módulos desarrollados en los incisos previos con datos
leídos de teclado.
}


program untitled;
const
	dimF = 5;
type
	str20 = string[20];
	alumno = record
		nro: integer;
		nombre_completo: str20;
		asistencias: integer;
	end;
	
	vector = array[1..dimF]of alumno;

procedure Leer_alumno(var a: alumno);
begin
	writeln('Ingrese el nro de alumno: ');
	readln(a.nro);
//	writeln('Ingrese el nombre completo: ');
//	readln(a.nombre_completo);
//	writeln('Ingrese la cantidad de asistencias: ');
//	readln(a.asistencias);
end;

procedure cargar_vector(var v: vector; var dimL: integer);
var
	a: alumno;
begin
	Leer_alumno(a);
	while(dimL <= dimF)and(a.nro <> 0)do begin
		dimL:= dimL +1;
		v[dimL]:= a;
		Leer_alumno(a);
	end;
end;

function buscar_alumno(v: vector; dimL: integer; num: integer): integer; // No esta mal, pero si encuentro el elemento, sigo recorriendo el resto del vector.
var
	pri, ult, medio, pos: integer;
begin
	pos:= 0;
	pri:= 1;
	ult:= dimL;
	medio:= (pri + ult) div 2;
	while(pri <= ult)and(num <> v[medio].nro)do begin
		if(num < v[medio].nro)then begin
			ult:= medio - 1;
		end
		else
			pri:= medio + 1;
		medio:= (pri + ult) div 2; // Actualizo el medio
	end;
	if(pri<=ult)and(num = v[medio].nro)then
		pos:= medio;
	buscar_alumno:= pos;
end;

procedure agregar_alumno(var v: vector; var dimL: integer; var pude: boolean; a: alumno);
begin
	pude:= False;
	if((dimL +1)< dimF)then
		pude:= True;
		dimL:= dimL +1;
		v[dimL]:= a;
end;

procedure mostrar_vector(v: vector; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln(v[i].nro);
	end;
end;

var
	v: vector;
	dimL, numero, posicion: integer;
	a: alumno;
	ok: boolean;
	
BEGIN
	dimL:= 0;
	cargar_vector(v, dimL); // Lo dispongo
	writeln('Ingrese el numero que desea buscar');
	read(numero);
	posicion:= buscar_alumno(v, dimL, numero); // Tengo que hacer busqueda dicotomica ya que el vector que dispongo se encuentra ordenado
	writeln('El numero buscado se encuentra en la posicion: ', posicion); // Inciso A
	Leer_alumno(a);
	ok:= False;
	agregar_alumno(v, dimL, ok, a);
	if(ok)then
		writeln('El alumno ha sido agregado') // Inciso B
	else
		writeln('El alumno no ha podido agregarse'); // Inciso B
	mostrar_vector(v, dimL);
	
	// El resto de los incisos se implementan los modulos hechos en el ejercicio 2. Eliminar, etc.
END.

