{3. Una empresa de transporte de caudales desea optimizar el servicio que brinda a sus clientes. Para ello,
cuenta con información sobre todos los viajes realizados durante el mes de marzo. De cada viaje se cuenta
con la siguiente información: día del mes (de 1 a 31), monto de dinero transportado y distancia recorrida
por el camión (medida en kilómetros).
a. Realizar un programa que lea y almacene la información de los viajes (a lo sumo 200). La lectura finaliza
cuando se ingresa una distancia recorrida igual a 0 km, que no debe procesarse.
b. Realizar un módulo que reciba el vector generado en a) e informe:
- El monto promedio transportado de los viajes realizados
- La distancia recorrida y el día del mes en que se realizó el viaje que transportó menos dinero.
- La cantidad de viajes realizados cada día del mes.
c. Realizar un módulo que reciba el vector generado en a) y elimine todos los viajes cuya distancia
recorrida sea igual a 100 km.
Nota: para realizar el inciso b, el vector debe recorrerse una única vez.
}


program untitled;
const
	dimF = 5;
type
	viaje = record
		dia: 1..31;
		monto: real;
		distancia_km: integer;
	end;
	vector = array[1..dimF]of viaje;
	vector_contador = array[1..31]of integer; // Solo lo voy a usar para saber la cantidad de vijaes realizados cada dia del mes.

procedure Leer_viaje(var a: viaje);
begin
	writeln('Ingrese el dia del viaje: ');
	readln(a.dia);
	writeln('Ingrese el monto transportado: ');
	readln(a.monto);
	writeln('Ingrese la distancia recorrida: ');
	readln(a.distancia_km);
end;

procedure cargar_vector(var v: vector; var dimL: integer);
var
	a: viaje;
begin
	Leer_viaje(a);
	while(dimL <= dimF)and(a.distancia_km <> 0)do begin
		dimL:= dimL +1;
		v[dimL]:= a;
		Leer_viaje(a);
	end;
end;

procedure inicializar_vc(var vc: vector_contador);
var
	i: integer;
begin
	for i:= 1 to 31 do begin
		vc[i]:= 0;
	end;
end;

procedure calcular_minimo(dia: integer; distancia: integer; var min: integer; var dia_min: integer);
begin
	if(distancia < min)then begin
		min:= distancia;
		dia_min:= dia;
	end;
end;

procedure imprimir_cantidad_viajes(vc: vector_contador);
var
	i: integer;
begin
	for i:= 1 to 31 do begin
		writeln('El dia ',i,' se realizaron ', vc[i],' viajes');
	end;
end;

procedure procesar_vector(v: vector; dimL: integer; var vc: vector_contador);
var
	monto_promedio, suma_montos: real;
	i, dia_minimo, minimo: integer;
begin
	suma_montos:= 0;
	monto_promedio:= 0;
	minimo:= 32767;
	dia_minimo:= 0;
	for i:= 1 to dimL do begin
		suma_montos:= suma_montos + v[i].monto;
		calcular_minimo(v[i].dia, v[i].distancia_km, minimo, dia_minimo); // Inciso B
		vc[v[i].dia]:= vc[v[i].dia] +1; // C
	end;
	monto_promedio:= suma_montos/dimL; // Inciso A - nota: dimL es la cantidad de viajes realizados en total // Por alguna razon me toma dimL + 1
	writeln('El monto promedio transportado de los viajes realizados es: ',monto_promedio:1:2);
	writeln('La distancia recorrida y el dia del mes en que se realizo el viaje que transporto menos dinero son: ',minimo,' km, en el dia ',dia_minimo);
	imprimir_cantidad_viajes(vc);
end;

procedure eliminar(var v: vector; var dimL: integer);
var
	i, j: integer;
begin
	for i:= 1 to dimL do begin
		if(v[i].distancia_km = 100)then begin // Al hacer la comparacion ya obtengo la posicion a eliminar.
			for j:= i to dimL-1 do
				v[i]:= v[i+1];
			dimL:= dimL -1;
		end;
	end;
end;

procedure mostrar_vector(v: vector; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln(v[i].dia);
		writeln(v[i].monto:1:2);
		writeln(v[i].distancia_km);
	end;
end;

var
	v: vector;
	vc: vector_contador;
	dimL: integer;

BEGIN
	dimL:= 0;
	inicializar_vc(vc);
	cargar_vector(v, dimL);
	procesar_vector(v, dimL, vc);
	eliminar(v, dimL);
	mostrar_vector(v, dimL);
END.

