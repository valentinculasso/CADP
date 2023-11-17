{
Una empresa de fabricacion y venta de repuestos para automoviles DISPONE de informacion sobre el stock de repuestos para la venta.
Para cada repuesto conoce su codigo de repuesto (entre 100 y 3400), la cantidad disponible en stock, el precio por unidad y el año de fabricacion.
Ademas, la empresa DISPONE tambien de la informacion de todas las ventas realizadas en el año.
De cada venta se conoce el codigo de repuesto vendido y la cantidad vendida. Pueden aparecer muchas ventas de un mismo repuesto. La informacion de las ventas
no posee ningun orden particular.

Realizar un programa que actualice la informacion del stock de la empresa, procesando la informacion de las ventas realizadas en el año, e informe:
a) Para cada repuesto, la cantidad total que se vendio durante todo el año
b) Los dos codigos de repuesto que generaron mayor ingreso de dinero (precio por unidad multiplicado por la cantidad total vendida)
c) Los codigos de los repuestos fabricados en años multiplos de 5 que quedaron con stock menor o igual a cero luego de actualizar la informacion del stock.
}


program untitled;
const
	dimF = 3400;
type
// Lista 1
	repuesto = record
		codigo_repuesto: 100..dimF;
		cant_stock: integer;
		precio_unidad: real;
		anio_fabricacion: integer;
	end;
	
	lista1 = ^nodo1;
	nodo1 = record
		dato: repuesto;
		sig: lista1;
	end;
//
// Lista 2
	venta = record
		codigo_rep: 100..dimF;
		cant_vendida: integer;
	end;
	
	lista2 = ^nodo2;
	nodo2 = record
		dato: venta;
		sig: lista2;
	end;
//
	vector_contadorA = array[100..dimF]of integer; // Este vector va a acumular en sus posiciones la cantidad que se vendio por eso es integer
	vector_contadorB = array[100..dimF]of real; // Este vector va a acumular en sus posiciones los ingresos de dinero, por eso es real
// ____________________________________________________

procedure inicializar_vectorA(v: vector_contadorA);
var
	i: integer;
begin
	for i:= 0 to dimF do begin
		v[i]:= 0;
	end;
end;

procedure inicializar_vectorB(v: vector_contadorB);
var
	i: integer;
begin
	for i:= 0 to dimF do begin
		v[i]:= 0;
	end;
end;

procedure recorrer_lista_repuestos(var L1: lista1; var precio: real; codigo_repuestoAct: integer; cantidad_vendida: integer);
var
	encontre: boolean;
begin
	encontre:= false;
	while(L1 <> NIL)and(not encontre)do begin
		if(L1^.dato.codigo_repuesto = codigo_repuestoAct)then begin
			precio:= L1^.dato.precio_unidad; // Cargo en la variable el precio del repuesto (Para inciso B)
			L1^.dato.cant_stock:= L1^.dato.cant_stock - cantidad_vendida; // Actualizo el stock --->> En esto consiste el ejercicio, en actualizar el stock (tambien lo uso en Inciso C)
			encontre:= true; // Si lo encuentro -> True y dejo de recorrer al pedo la lista
		end;
		L1:= L1^.sig;
	end;
end;

procedure ImprimirIncisoA(v: vector_contadorA);
var
	i: integer;
begin
	for i:= 100 to dimF do begin
		writeln('Del repuesto ',i,' se vendieron ', v[i],' unidades');
	end;
end;

procedure calcular_maximos(v: vector_contadorB; var max1: real; var max2: real; cod_max1: integer; cod_max2: integer);
var
	i: integer;
begin
	for i:= 100 to dimF do begin
		if(v[i] > max1)then begin
			max2:= max1;
			cod_max2:= cod_max1;
			max1:= v[i];
			cod_max1:= i;
		end
		else begin
			if(v[i] > max2)then begin
				max2:= v[i];
				cod_max2:= i;
			end;
		end;
	end;
end;

procedure recorrer_lista_repuestos_con_stock_modificado(L1: lista1);
begin
	while(L1 <> NIL)do begin
		if(L1^.dato.anio_fabricacion MOD 5 = 0)and(L1^.dato.cant_stock <= 0)then begin
			writeln('Codigo de repuesto fabricado en año multiplo de 5 que quedo con stock menor o igual a cero luego de actualizar la informacion del stock: ', L1^.dato.codigo_repuesto);
		end;
		L1:= L1^.sig;
	end;
end;

procedure recorrer_lista_ventas(L2: lista2; L1: lista1);
var
	vcA: vector_contadorA;
	vcB: vector_contadorB;
	precio, max1, max2: real;
	cod_max1, cod_max2: integer;
begin
	inicializar_vectorA(vcA);
	inicializar_vectorB(vcB);
	max1:= 0;
	max2:= 0;
	cod_max1:= 0;
	cod_max2:= 0;
	while(L2 <> NIL)do begin
		precio:= 0;
		vcA[L2^.dato.codigo_rep]:= vcA[L2^.dato.codigo_rep] + L2^.dato.cant_vendida; // Inciso A
		recorrer_lista_repuestos(L1, precio, L2^.dato.codigo_rep, L2^.dato.cant_vendida);
		vcB[L2^.dato.codigo_rep]:= vcB[L2^.dato.codigo_rep] + (precio * L2^.dato.cant_vendida); // Actualizo en el vector los ingresos de cada venta por repuesto

		L2:= L2^.sig; // Paso al siguiente
	end;
	ImprimirIncisoA(vcA); // Muestro en pantalla Inciso A
	calcular_maximos(vcB, max1, max2, cod_max1, cod_max2); // Inciso B
	writeln('Los dos codigos de repuesto que generaron mayor ingreso de dinero son: ', cod_max1,' y ', cod_max2,' respectivamente');
	recorrer_lista_repuestos_con_stock_modificado(L1); // Inciso C
end;
	
var
	L1: lista1; // repuesto
	L2: lista2; // ventas
	
BEGIN
	cargar_lista1(L1);	 // Dispongo
	cargar_lista2(L2); // Dispongo
	recorrer_lista_ventas(L2, L1);
END.

