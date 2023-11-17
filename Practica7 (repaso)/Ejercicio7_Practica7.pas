{
7. La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de
Analista Programador Universitario. Para ello se deberá leer la información de cada alumno, a saber:
número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, año de egreso
y las notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran).
* 
1. Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el
alumno con número de alumno -1, el cual no debe procesarse. Las 24 notas correspondientes a
cada alumno deben quedar ordenadas de forma descendente.
* 
2. Una vez leída y almacenada la información del inciso 1, se solicita calcular e informar:
a. El promedio de notas obtenido por cada alumno.
b. La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto
únicamente por dígitos impares.
c. El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido
se recibieron (o sea, que tardaron menos años)
3. Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de
la estructura generada en el inciso 1. El alumno puede no existir
}


program untitled;
const
	dimF = 24;
type
	str20 = string[20];
	RangoNotas = 1..10;
	alumno = record
		nro: integer;
		nombre: str20;
		email: str20;
		ingreso: integer;
		egreso: integer;
		notas: vectorNotas;
	end;
	
	vectorNotas = array[1..dimF]of integer;
	
	lista = ^nodo;
	nodo = record
		dato: alumno;
		sig: lista;
	end;

procedure OrdenarVector(var v: vectorNotas);
var
	i, j, p, item: integer;
begin
	for i:= 1 to dimF do begin // Recorro el vector notas completo
		p:= i;				   // indice p = i
		for j:= i+1 to dimF do begin // recorro el resto del vector (posicion i+1)
			if(v[j] > v[p])then
				p:= j; // En p me queda la posicion del valor mas grande
		end;
		item:= v[p]; // Cargo el valor mas grande en item
		v[p]:= v[i]; // Mando el elemento actual a la posicion del elemento mas grande que encontre (p)
		v[i]:= item; // Cargo en la posicion actual el valor mas grande que encontre
	end; 
end;

procedure LeerDatos(var p: alumno);
var
	i: integer;
begin
	readln(p.nro);
	readln(p.nombre);
	readln(p.email);
	readln(p.ingreso);
	readln(p.egreso);
	// CargarVector(p.notas);
	for i:= 1 to dimF do begin
		readln(p.notas[i]); // p.notas = v[];
	end; 
	OrdenarVector(p.notas);
end;

procedure AgregarAdelante(var L1: lista; p: alumno);
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
	a: alumno;
begin
	L1:= NIL;
	LeerDatos(a);
	while(a.nro <> -1)do begin
		AgregarAdelante(L1, a);
		LeerDatos(a);
	end;
end;
//_________________________________________

procedure sumarNotas(v: vectorNotas; suma: integer);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		suma:= suma + v[i];
	end;
end;

function DescomponerNro(num: integer): boolean;
var
	dig, cant_pares: integer;
	cumple: boolean;
begin
	cumple:= False;
	cant_pares:= 0;
	while(num <> 0)and(cant_pares = 0)do begin
		dig:= num MOD 10;
		if(dig MOD 2 = 0)then
			cant_pares:= cant_pares + 1;
		num:= num DIV 10;
	end;
	if(cant_pares = 0)then
		cumple:= True;
	DescomponerNro:= cumple;
end;

procedure calcularMaximos(tardo: integer; var min1: integer; var min2: integer; var nomMin1: str20; var nomMin2: str20; var mailMin1: str20; var mailMin2: str20; nombre: str20; email: str20);
begin
	if(tardo < min1)then begin
		min2:= min1;
		nomMin2:= nomMin1;
		mailMin2:= mailMin1;
		min1:= tardo;
		nomMin1:= nombre;
		mailMin1:= email;
	end
	else
		if(tardo < min2)then begin
		min2:= tardo;
		nomMin2:= nombre;
		mailMin2:= email;
	end;
end;

procedure RecorrerLista(L1: lista);
var
	promedio: real;
	suma_total, cant_alumnos, tardo, minimo1, minimo2: integer;
	nombreMin1, nombreMin2, emailMin1, emailMin2: str20;
begin
	suma_total:= 0;
	cant_alumnos:= 0;
	minimo1:= 999;
	minimo2:= 999;
	nombreMin1:= '';
	nombreMin2:= '';
	emailMin1:= '';
	emailMin2:= '';
	while(L1 <> NIL)do begin
		sumarNotas(L1^.dato.notas, suma_total);
		promedio:= suma_total div dimF; // Inciso A
		if(L1^.dato.ingreso = 2012)and(DescomponerNro(L1^.dato.nro))then begin // Si ingreso en el año 2012 y tiene unicamente digitos impares ...
			cant_alumnos:= cant_alumnos + 1; // Inciso B
		end;
		tardo:= L1^.dato.egreso - L1^.dato.ingreso;
		calcularMaximos(tardo, minimo1, minimo2, nombreMin1, nombreMin2, emailMin1, emailMin2, L1^.dato.nombre, L1^.dato.email); // Inciso C
		L1:= L1^.sig;
	end;
end;

procedure eliminar(var L1: lista; nro: integer);
var
	ant, actual: lista;
begin
	ant:= L1;
	actual:= L1;
	while(actual <> NIL)and(actual^.dato.nro <> nro)do begin
		ant:= actual;
		actual:= actual^.sig;
	end;
	if(actual <> NIL)then begin
		if(actual = NIL)then
			L1:= L1^.sig
		else
			ant^.sig:= actual^.sig;
		dispose(actual)
	end
	else begin
		writeln('El nro de alumno no existe');
	end;
end;

{Programa principal}
var
	L: lista;
	num: integer;
BEGIN
	CargarLista(L);
	RecorrerLista(L);
	readln(num);
	eliminar(L, num);
END.

