{5. Realizar un programa que lea y almacene la información de productos de un supermercado. De cada
producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se ingresa
el código -1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular e informar:
a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
c. Código de los dos productos más económicos.
}
program Ejercicio5;
type
	str20 = string[20];
	producto = record
		codigo: integer;
		descripcion: str20;
		stock_actual: integer;
		stock_minimo: integer;
		precio: real;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: producto;
		sig: lista;
	end;
//_____________MODULOS DE CARGA DE DATOS_________________
procedure LeerDatos(var p: producto);
begin
	writeln('Ingrese el codigo del producto: ');
	readln(p.codigo);
	writeln('Ingrese la descripcion del producto: ');
	readln(p.descripcion);
	writeln('Ingrese el stock actual del producto: ');
	readln(p.stock_actual);
	writeln('Ingrese el stock minimo del producto: ');
	readln(p.stock_minimo);
	writeln('Ingrese el precio del producto: ');
	readln(p.precio);
end;

procedure AgregarAdelante(var l: lista; p: producto);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.dato:= p;
	nuevo^.sig:= nil;
	if(l = nil)then
		l:= nuevo
	else begin
		nuevo^.sig:= l;
		l:= nuevo;
	end;	
end;

procedure cargar_lista(var l: lista);
var
	a: producto;
begin
	LeerDatos(a);
	while(a.codigo <> -1)do begin
		AgregarAdelante(l, a);
		LeerDatos(a);
	end;
end;
//_____________FIN MODULOS DE CARGA DE DATOS_____________

function digitos_pares(codigo: integer): integer; // Inciso B
var
	dig, cant_pares: integer;
begin
	cant_pares:= 0;
	while(codigo <> 0)do begin
		dig:= codigo MOD 10; // Tomo el ultimo digito del codigo
		if(dig MOD 2 = 0)then
			cant_pares:= cant_pares + 1; // Si es par, cant_pares +1
		codigo:= codigo DIV 10; // Elimino el ultimo digito
	end;
	digitos_pares:= cant_pares;
end;

procedure calcular_minimos(var minimo1: real; var minimo2: real; var codmin1: integer; var codmin2: integer; codigo: integer; precio: real); // Inciso C
begin
	if(precio < minimo1)then begin
		minimo2:= minimo1;
		codmin2:= codmin1;
		minimo1:= precio;
		codmin1:= codigo
	end
	else
		if(precio < minimo2)then begin
			minimo2:= precio;
			codmin2:= codigo;
		end;
end;

procedure recorrer_lista(L: lista);
var
	cant_productos: integer; // Variable que uso para contar la cantidad de productos con stock actual por debajo de su stock minimo
	cant_total: integer; // Variable que uso para contar la cantidad de productos (todos) ... El porcentaje lo saco haciendo "(cant_productos*100) div cant_total"
	porcentaje: integer; // Inciso A
	minimo1, minimo2: real; // Inciso C
	codmin1, codmin2: integer; // Inciso C
begin
	cant_productos:= 0;
	cant_total:= 0;
	minimo1:= 9999;
	minimo2:= 9999;
	codmin1:= 0;
	codmin2:= 0;
	while(L <> NIL)do begin
		cant_total:= cant_total + 1; // Uso de variable de inciso A
		if(L^.dato.stock_actual < L^.dato.stock_minimo)then begin
			cant_productos:= cant_productos + 1; // Uso de variable de inciso A
		if(digitos_pares(L^.dato.codigo) >= 3)then begin // Inciso B
			writeln('El producto tiene al menos 3 digitos pares y su descripcion es: ', L^.dato.descripcion); // Muestro Inciso B
		end;
		calcular_minimos(minimo1, minimo2, codmin1, codmin2, L^.dato.codigo, L^.dato.precio); // Inciso C
		L:= L^.sig;
	end;
	porcentaje:= (cant_productos*100) div cant_total; // Inciso A
	writeln('El porcentaje de productos con stock actual por debajo de su stock mínimo es de: ', porcentaje); // Muestro Inciso A
	writeln('El codigo de los dos productos más económicos son: ', codmin1,' y ', codmin2); // Muestro Inciso C
end;

var
	l: lista;

BEGIN
	l:= nil;
	cargar_lista(l);
	recorrer_lista(l);
END.

