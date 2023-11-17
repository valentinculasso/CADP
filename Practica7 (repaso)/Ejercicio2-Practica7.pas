{
1. Una productora nacional realiza un casting de personas para la selección de actores extras de una nueva
película, para ello se debe leer y almacenar la información de las personas que desean participar de
dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de género de actuación
que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura finaliza cuando llega
una persona con DNI 33555444, la cual debe procesarse.
Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
b. Informar los dos códigos de género más elegidos.
c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho módulo en el programa principal.
}


program Ejercicio1Practica7;
const
	dimF = 5; //Subrango de codigo de genero
type
	str20 = string[20];
	persona = record
		DNI: integer;
		nombre: str20;
		edad: integer;
		codigo: 1..5;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: persona;
		sig: lista;
	end;
	
	vector_contador = array[1..dimF]of integer;

procedure LeerDatos(var p: persona);
begin
	readln(p.DNI);
	readln(p.nombre);
	readln(p.edad);
	readln(p.codigo);
end;

procedure AgregarAdelante(var L1: lista; p: persona);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.dato:= p;
	nuevo^.sig:= L1;
	L1:= nuevo;
end;

procedure CargarLista(var L1: lista);
var
	a: persona;
begin
	L1:= NIL;
	LeerDatos(a);
	repeat 
		AgregarAdelante(L1, a); // No requiere orden
		LeerDatos(a);
	until (a.DNI = 3355); // geany toma valor hasta 32767
	
end;
//_______________________________
procedure InicializarVC(var v: vector_contador);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		v[i]:= 0;
	end;
end;

function DescomponerDNI(dni: integer): boolean;
var
	cant_pares, cant_impares, dig: integer;
	cumple: boolean;
begin
	cumple:= False;
	cant_pares:= 0;
	cant_impares:= 0;
	while(dni <> 0)do begin
		dig:= dni MOD 10; // Tomo el ultimo digito
		if(dig MOD 2 = 0)then
			cant_pares:= cant_pares + 1
		else
			cant_impares:= cant_impares + 1;
		dni:= dni DIV 10; // Elimino el ultimo digito
	end;
	if(cant_pares > cant_impares)then
		cumple:= True;
		
	DescomponerDNI:= cumple;
end;
	
procedure CalcularMaximos(v: vector_contador; var codmax1: integer; var codmax2: integer);
var
	max1, max2, i: integer;
begin
	max1:= 0;
	max2:= 0;
	for i:= 1 to dimF do begin
		if(v[i] > max1)then begin
			max2:= max1;
			codmax2:= codmax1;
			max1:= v[i];
			codmax1:= i;
		end
		else begin
			if(v[i] > max2)then
				max2:= v[i];
				codmax2:= i;
		end;
	end;
end;

procedure RecorrerLista(L1: lista);
var
	vc: vector_contador;
	cant_personas, codmax1, codmax2: integer;

begin
	InicializarVC(vc);
	cant_personas:= 0;
	codmax1:= 0;
	codmax2:= 0;
	while(L1 <> NIL)do begin
		if(DescomponerDNI(L1^.dato.DNI))then
			cant_personas:= cant_personas + 1; // Inciso A
		vc[L1^.dato.codigo]:= vc[L1^.dato.codigo] + 1; // Inciso B
		L1:= L1^.sig;
	end;
	CalcularMaximos(vc, codmax1, codmax2); // Inciso B
	writeln(cant_personas); // Inciso A
	writeln(codmax1, codmax2); // Inciso B
end;

procedure eliminar(var L1: lista; dni: integer);
var
	actual, ant: lista;
begin
	ant:= L1;
	actual:= L1;
	while (actual <> NIL)and(actual^.dato.DNI <> dni)do begin // Recorro buscando el dni
		ant:= actual;
		actual:= actual^.sig;
	end;
	if(actual <> NIL)then begin // Si llegue a NIL no esta (no existe)
		if(actual = L1)then // Si es el primer elemento de la lista
			L1:= L1^.sig
		else
			ant^.sig:= actual^.sig; // El siguiente nodo del anterior, "apunta" al siguiente del actual
		dispose(actual); // Elimino actual
	end
	else begin
		writeln('El DNI no se encuentra en la lista');
	end;
end;

{Programa principal}
var
	L: lista;
	DNI: integer;
	
BEGIN
	CargarLista(L);
	RecorrerLista(L);
	readln(DNI);
	eliminar(L, DNI);
END.

{
* Ejercicio 2 - Inciso A
 	monto_total:= L^.dato.montoBasico + v[L^.dato.codigo]; // v[L^.dato.codigo] = monto adicional
	writeln(L^.dato.DNI , L^.dato.nombre , monto_total);

}

