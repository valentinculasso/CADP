{5. Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100
camiones. De cada camión se tiene: patente, año de fabricación y capacidad (peso máximo en
toneladas que puede transportar).
Realizar un programa que lea y almacene la información de los viajes realizados por la empresa. De
cada viaje se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros
recorrida, ciudad de destino, año en que se realizó el viaje y DNI del chofer. La lectura finaliza cuando
se lee el código de viaje -1.
Una vez leída y almacenada la información, se pide:
1. Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que
menos kilómetros recorridos posee.
2. Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5
toneladas y que posean una antigüedad mayor a 5 años al momento de realizar el viaje (año en
que se realizó el viaje).
3. Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
Nota: Los códigos de viaje no se repiten.
}


program untitled;

const
	MaxCamion = 100;

type
	RangoCamion = 1..MaxCamion;
	tViaje = record
		codigo: integer;
		codigo_camion: RangoCamion;
		ciudad: string;
		distancia: real;
		anio: integer;
		DNI_chofer: integer;
	end;
	
	camion = record
		patente: string;
		fabricacion: integer;
		capacidad: real;
	
	lista : ^nodo;
	nodo : record
		dato: tViaje;
		sig: lista;
	end;
	
	vector_camiones = array[RangoCamion]of camion;
	
procedure CargarVector(var v: vector_camiones);
var
	i: integer;
	a: camion;
begin
	for i:=1 to maxCamion do begin
		LeerCamion(a); // Se dispone
		v[i]:= a;
	end;
end;

procedure AgregarAdelante(var L: lista; a: tViajes);
var
	nue: lista;
begin
	new(nue); // Generas espacio
	nue^.dato:= a;	// Cargas el dato
	nue^.sig:= L; // Generas el enlace
	L:= nue; //
end;


procedure CargarLista(var L: lista);
var
	a: tViajes;
begin
	LeerViajes(a); // Se dispone
	while(L^.dato.codigo <> -1)do begin
		AgregarAdelante(L, a);
		LeerViajes(a); // Se dispone
	end;
end;

procedure CalcularMaxMin(distancia: real; patente: string; var maxKM: real; var minKM: real; var maxPatente: string; var minPatente: string);
begin
	if(distancia > maxKM)then begin
		maxKM:= distancia;
		maxPatente:= patente;
	end;
	if(distacia < minKM)then begin
		minKM:= distancia;
		minPatente:= patente;
	end;
end;

function DigitosImpares(DNI: integer): boolean;
var
	cumple: boolean;
	dig, cant_pares: integer;
begin
	cumple:= True;
	cant_pares:= 0;
	while(DNI <> 0)and(cant_pares = 0)do begin
		dig:= DNI MOD 10; // tomo el ultimo digito
		if(dig MOD 2 = 0)then
			cant_pares:= cant_pares +1;
			cumple:= False;
		DNI:= DNI DIV 10; // elimino el ultimo digito
	end;
	DigitosImpares:= cumple;
end;

procedure RecorrerLista(L: lista; v: vector_camiones);
var
	maxPatente, minPatente: string;
	maxKM, minKM: real;
	cant_viajes, antiguedad: integer;
	
begin
	maxKM:= 0;
	minKM:= 9999;
	maxPatente:= '';
	minPatente:= '';
	cant_viajes:= 0;
	while(L <> NIL)do begin
		CalcularMaxMin(L^.dato.distancia, v[L^.dato.codigo_camion].patente, maxKM, minKM, maxPatente, minPatente); // Inciso A
		antiguedad:= L^.dato.anio - v[L^.dato.codigo_camion].fabricacion; // año que se realizo el viaje - año fabricacion = antiguedad ... 2023 - 2015 = 8
		if(v[L^.dato.codigo_camion].capacidad > 30,5)and(antiguedad > 5)then begin
			cant_viajes:= cant_viajes + 1; // Inciso B
		end;
		if(DigitosImpares(L^.dato.DNI_chofer)then begin
			writeln(L^.dato.codigo); // Inciso C
		end;
		L:= L^.sig;
	end;
	writeln(); // Inciso A
	writeln(cant_viajes); // Inciso B
end;


var
	L: lista;
	V: vector_camiones;

BEGIN
	CargarVector(V);
	CargarLista(L);
	RecorrerLista(L, V);
END.


