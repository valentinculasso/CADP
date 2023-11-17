{6. La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales lanzadas
al espacio en la última década. De cada sonda se conoce su nombre, duración estimada de la misión
(cantidad de meses que permanecerá activa), el costo de construcción, el costo de mantenimiento mensual y
rango del espectro electromagnético sobre el que realizará estudios. Dicho rango se divide en 7 categorías:
1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma
Realizar un programa que lea y almacene la información de todas las sondas espaciales. La lectura finaliza al
ingresar la sonda llamada “GAIA”, que debe procesarse.
Una vez finalizada la lectura, informar:
a. El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
b. La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
c. La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
d. El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sondas.
Nota: para resolver los incisos a), b), c) y d), la lista debe recorrerse la menor cantidad de veces posible
}


program Ejercicio6;
type
	str20 = string[20];
	sonda = record
		nombre: str20;
		duracion_estimada: integer; // duracion en meses
		costo_construccion: real;
		costo_mantenimiento: real; // mensual
		rango: 1..7;
	end;
	
	vector_contador = array[1..7]of integer;
	
	lista = ^nodo;
	nodo = record
		dato: sonda;
		sig: lista;
	end;
//_____________________________

procedure LeerDatos(var s: sonda);
begin
	writeln('Ingrese el nombre de la sonda: ');
	readln(s.nombre);
	writeln('Ingrese la duracion estimada (en meses) de la mision: ');
	readln(s.duracion_estimada);
	writeln('Ingrese el costo de construccion de la sonda: ');
	readln(s.costo_construccion);
	writeln('Ingrese el costo de mantenimiento de la sonda: ');
	readln(s.costo_mantenimiento);
	writeln('Ingrese el rango del espectro electromagnético sobre el que realizará estudios: ');
	readln(s.rango);
end;

procedure AgregarAdelante(var l: lista; s: sonda);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.dato:= s;
	nuevo^.sig:= nil;
	if(l = nil)then
		l:= nuevo
	else begin
		nuevo^.sig:= l;
		l:= nuevo;
	end;	
end;


procedure CargarLista(var L: lista);
var
	s: sonda;
begin
	LeerDatos(s);
	repeat
		AgregarAdelante(L, s);
		LeerDatos(s);
	until(s.nombre = 'GAIA');
end;
//____________FIN CARGA DE DATOS________________
procedure inicializarVector(var v: vector_contador);
var
	i: integer;
begin
	for i:=1 to 7 do begin
		v[i]:= 0;
	end;
end;

procedure calcular_maximo(costo_constr: real; costo_manten: real; nombre: str20 ; var maximo1: real; var nombre_max1: str20);
var
	costo_total: real;
begin
	costo_total:= costo_constr + costo_manten;
	if(costo_total > maximo1)then begin
		maximo1:= costo_total;
		nombre_max1:= nombre;
	end;
end;

procedure ImprimirVectorContador(v: vector_contador);
var
	i: integer;
begin
	for i:= 1 to 7 do begin
		writeln(v[i]);
	end;
end;

procedure RecorrerLista(L: lista; var duracion_promedio: real; var costo_promedio: real);
var
	v: vector_contador;
	maximo1: real; nombre_max1: str20;
	suma_total_duraciones: integer; cant_sondas: integer;
	suma_total_costo: real; 
begin
	inicializarVector(v);
	maximo1:= -1; // Inciso A 
	nombre_max1:= ''; // Inciso A 
	
	cant_sondas:= 0;
	suma_total_duraciones:= 0;
	suma_total_costo:= 0;
	
	
	while(L <> NIL)do begin
		cant_sondas:= cant_sondas + 1; // Variable para insicos C y D
		calcular_maximo(L^.dato.costo_construccion, L^.dato.costo_mantenimiento, L^.dato.nombre, maximo1, nombre_max1); // Inciso A
		v[L^.dato.rango]:= v[L^.dato.rango] + 1; // Inciso B ... 
		
		suma_total_duraciones:= suma_total_duraciones + L^.dato.duracion_estimada; // Inciso C
		suma_total_costo:= suma_total_costo + L^.dato.costo_construccion; // Inciso D
		
		L:= L^.sig;
	end;
	writeln('El nombre de la sonda mas costosa es ', nombre_max1); // Inciso A
	writeln('La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético son: ');
	ImprimirVectorContador(v);
	duracion_promedio:= suma_total_duraciones div cant_sondas; // Inciso C
	costo_promedio:= suma_total_costo / cant_sondas; // Inciso D
end;

procedure RecorrerLista2(L: lista; duracion_promedio: real; costo_promedio: real);
var
	cant_sondas_incisoC: integer;
begin
	cant_sondas_incisoC:= 0;
	while (L <> nil)do begin
		if(L^.dato.duracion_estimada > duracion_promedio)then begin
			cant_sondas_incisoC:= cant_sondas_incisoC + 1;
		end;
		if(L^.dato.costo_construccion > costo_promedio)then begin
			writeln('El nombre de la sonda cuyo costo de construcción supera el costo promedio entre todas las sondas es ', L^.dato.nombre); // Inciso D
		end;
		L:= L^.sig;
	end;
	writeln('La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas es: ', cant_sondas_incisoC);
end;

var
	L: lista;
	duracion_prom, costo_prom: real;
	

BEGIN
	L:= NIL;
	duracion_prom:= 0;
	costo_prom:= 0;
	CargarLista(L);
	RecorrerLista(L, duracion_prom, costo_prom); // Primer recorrido resuelvo incisos A y B, y obtengo las variables necesarias para resolver los incisos C y D en el proximo recorrido
	RecorrerLista2(L, duracion_prom, costo_prom); // Segundo recorrido resuelvo incisos C y D
END.















