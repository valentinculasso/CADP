{5. Realizar un programa que lea información de autos que están a la venta en una concesionaria. De cada auto se lee:
marca, modelo y precio. La lectura finaliza cuando se ingresa la marca “ZZZ” que no debe procesarse. La
información se ingresa ordenada por marca. Se pide calcular e informar:
a. El precio promedio por marca.
b. Marca y modelo del auto más caro.

Cuando me dice que estan ordenados, tengo que usar corte de control
}

program Ejercicio5Practica3;
type
str20 = string[20];
	auto = record
		marca: str20;
		modelo: str20;
		precio: real;
	end;

procedure LeerDatos(var a: auto);
begin
	writeln('Ingrese la marca del auto: ');
	readln(a.marca);
	writeln('Ingrese el modelo del auto: ');
	readln(a.modelo);
	writeln('Ingrese el precio del auto: ');
	readln(a.precio);
end;

procedure calcular_maximo(precio: real; marca: str20; modelo: str20; var max_precio: real; var max_marca: str20; var max_modelo: str20);
begin
	if(precio > max_precio)then begin
		max_precio:= precio;
		max_marca:= marca;
		max_modelo:= modelo;
	end;
end;

var
	a: auto;
	max_marca, max_modelo, marca_actual: str20;
	max_precio, promedio_marca, suma_marca: real;
	cant: integer;
BEGIN
	max_precio:= -1;
	max_marca:= '';
	max_modelo:= '';
	LeerDatos(a);
	while(a.marca <> 'ZZZ')do begin
		marca_actual:= a.marca;
		promedio_marca:= 0;
		suma_marca:= 0;
		cant:= 0;
		while (a.marca = marca_actual) do begin
			cant:= cant + 1;
			suma_marca:= suma_marca + a.precio;
			calcular_maximo(a.precio, a.marca, a.modelo, max_precio, max_marca, max_modelo);
			LeerDatos(a);
		
		end;
		promedio_marca:= suma_marca / cant;
		writeln('');
		writeln('El precio promedio por marca es: ',promedio_marca:1:2);
		writeln('La marca y modelo del auto mas caro es: ',max_marca, '  ', max_modelo);
		writeln('');
	end;
END.
