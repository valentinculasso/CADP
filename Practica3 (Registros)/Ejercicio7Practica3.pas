{
7. Realizar un programa que lea información de centros de investigación de Universidades Nacionales. De cada
centro se lee su nombre abreviado (ej. LIDI, LIFIA, LINTI), la universidad a la que pertenece, la cantidad de
investigadores y la cantidad de becarios que poseen. La información se lee de forma consecutiva por universidad y
la lectura finaliza al leer un centro con 0 investigadores, que no debe procesarse. Informar:
● Cantidad total de centros para cada universidad.
● Universidad con mayor cantidad de investigadores en sus centros.
● Los dos centros con menor cantidad de becarios.  
}
program Ejercicio7Practica3;
type
str20 = string[20];
	centro = record
		nombre: str20;
		universidad: str20;
		cant_investigadores: integer;
		cant_becarios: integer;
	end;

procedure LeerDatos(var a: centro);
begin
	writeln('Ingrese el nombre del centro de investigacion: ');
	readln(a.nombre);
	writeln('Ingrese el nombre de la universidad: ');
	readln(a.universidad);
	writeln('Ingrese la cantidad de investigadores: ');
	readln(a.cant_investigadores);
	writeln('Ingrese la cantidad de becarios: ');
	readln(a.cant_becarios);
end;

procedure inciso_B(uni: str20; cantidad: integer; var uni_max: str20; var max1: integer);
begin
	if(cantidad > max1)then begin
		max1:= cantidad;
		uni_max:= uni;
	end;
end;

procedure inciso_C(nombre_centro: str20; cant_bec: integer; var min1: integer; var min2: integer; var centro_min1: str20; var centro_min2: str20);
begin
	if(cant_bec < min1)then begin
		min2:= min1;
		centro_min2:= centro_min1;
		min1:= cant_bec;
		centro_min1:= nombre_centro;
	end
	else
		if(cant_bec < min2)then begin
			min2:= cant_bec;
			centro_min2:= nombre_centro;
		end;
end;

var
	a: centro;
	universidad_actual, universidad_max, centro_minimo1, centro_minimo2: str20;
	cant_centros, cant_total_investigadores, maximo1, minimo1, minimo2: integer;
BEGIN
	universidad_max:= '';
	centro_minimo1:= '';
	centro_minimo2:= '';
	minimo1:= 999;
	minimo2:= 999;
	maximo1:= -1;
	LeerDatos(a);
	while(a.cant_investigadores <> 0)do begin
		cant_centros:= 0;
		cant_total_investigadores:= 0;
		universidad_actual:= a.universidad;
		while(a.universidad = universidad_actual)do begin
			cant_centros:= cant_centros +1;
			cant_total_investigadores:= cant_total_investigadores + a.cant_investigadores;
			inciso_C(a.nombre, a.cant_becarios, minimo1, minimo2, centro_minimo1, centro_minimo2);
			LeerDatos(a);
		end;
		inciso_B(a.universidad, cant_total_investigadores, universidad_max, maximo1);
		writeln('Inciso A: La cantidad de centros de la universidad es de: ',cant_centros);
	end;
END.

