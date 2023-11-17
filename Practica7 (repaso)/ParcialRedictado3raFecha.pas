program RedictadoCADP3raFecha;

type
	RangoDia = 1..30;
	RangoMes = 1..12;
	fecha = record
		dia: RangoDia;
		mes: RangoMes;
	end;
	compra = record
		ID: integer;
		dia_mes: fecha;
		DNI: integer;
		codigo: integer;
	end;
	lista = ^nodo;
	nodo = record
		dato: compra;
		sig: lista;
	end;
// Lista 2
	cliente = record
		DNI: integer;
		cant_compras: integer;
	end;
	lista2 = ^nodo2;
	nodo2 = record
		dato: cliente;
		sig: lista2;
	end;
	vector_contador = array[0..9]of integer;
	
procedure LeerDatos(var c: compra);
begin
	readln(c.ID);
	readln(c.dia_mes.dia);
	readln(c.dia_mes.mes);
	readln(c.DNI);
	readln(c.codigo);
end;

procedure InsertarOrdenado(var L1: lista; c: compra);
var
	ant, actual, nuevo: lista;
begin
	new(nuevo);
	nuevo^.dato:= c;
	nuevo^.sig:= nil;
	ant:= L1;
	actual:= L1;
	while(actual <> NIL)and(actual^.dato.DNI < c.DNI)do begin // c.DNI = nuevo^.dato.DNI
		ant:= actual;
		actual:= actual^.sig;
	end;
	if(ant = actual)then
		L1:= nuevo
	else
		ant^.sig:= nuevo; 
	nuevo^.sig:= actual; 
end;

procedure CargarLista(var L: lista);
var
	a: compra;
begin
	LeerDatos(a);
	while(a.DNI <> 0)do begin
		InsertarOrdenado(L, a);
		LeerDatos(a);
	end;
end;

procedure AgregarAtras(var L2: lista2; var ULT: lista2; dni: integer; compras: integer);
var
	nuevo: lista2;
begin
	new(nuevo);
	nuevo^.dato.DNI:= dni;
	nuevo^.dato.cant_compras:= compras;
	nuevo^.sig:= NIL;
	if(L2 = NIL)then
		L2:= nuevo
	else
		ULT^.sig:= nuevo;
	ULT:= nuevo;
end;

procedure InicializarVC(var v: vector_contador);
var
	i: integer;
begin
	for i:= 0 to 9 do
		v[i]:= 0;
end;


procedure CalcularDigitos(v: vector_contador; id: integer);
var
	i, dig: integer;
begin
	while(id <> 0)do begin
		dig:= id MOD 10;
		v[dig]:= v[dig] + 1;
		id:= id DIV 10;
	end;
	for i:= 0 to 9 do begin // Imprimo Inciso C
		writeln('La cantidad de veces que aparece el digito',i,' en el ID es: ',v[i]);
	end;
end;

procedure CalcularMaxMin(DNIactual: integer; cant_compras: integer; var maximo: integer; var minimo: integer; var DNImax: integer; var DNImin: integer);
begin
	if(cant_compras > maximo)then
		maximo:= cant_compras;
		DNImax:= DNIactual;
	if(cant_compras < minimo)then
		minimo:= cant_compras;
		DNImin:= DNIactual;
end;

procedure RecorrerLista(L1: lista; var L2: lista2);
var
	DNI_actual, cant_compras_septiembre, cant_compras_anual, max, min, DNI_max, DNI_min: integer;
	ULT: lista2;
	vc: vector_contador;
begin
	InicializarVC(vc);
	cant_compras_septiembre:= 0;
	cant_compras_anual:= 0;
	max:= 0;
	min:= 9999;
	DNI_max:= 0;
	DNI_min:= 0;
	while(L1 <> NIL)do begin
		DNI_actual:= L1^.dato.DNI;
		
		while(L1^.dato.DNI = DNI_actual)do begin
			if(L1^.dato.dia_mes.mes = 8)then begin // Si el mes es septiembre
				cant_compras_septiembre:= cant_compras_septiembre + 1; // Inciso A
			end;
			cant_compras_anual:= cant_compras_anual + 1; // Inciso B
			CalcularDigitos(vc, L1^.dato.ID); // Inciso C
			L1:= L1^.sig;
		end;
		AgregarAtras(L2, ULT, DNI_actual, cant_compras_septiembre); // Inciso A completo
		CalcularMaxMin(DNI_actual, cant_compras_anual, max, min, DNI_max, DNI_min); // Inciso B
	end;
end;

{Programa principal}
var
	L1: lista; L2: lista2;
BEGIN
	L1:= NIL;
	L2:= NIL;
	CargarLista(L1);
	RecorrerLista(L1, L2);
END.

