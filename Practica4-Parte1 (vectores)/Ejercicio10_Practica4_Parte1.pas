{10. Realizar un programa que lea y almacene el salario de los empleados de una empresa de turismo (a lo
sumo 300 empleados). La carga finaliza cuando se lea el salario 0 (que no debe procesarse) o cuando se
completa el vector. Una vez finalizada la carga de datos se pide:
a) Realizar un módulo que incremente el salario de cada empleado en un 15%. Para ello, implementar un
módulo que reciba como parámetro un valor real X, el vector de valores reales y su dimensión lógica y
retorne el mismo vector en el cual cada elemento fue multiplicado por el valor X.
b) Realizar un módulo que muestre en pantalla el sueldo promedio de los empleados de la empresa  
}


program Ejercicio10Practica4Parte1;
const
dimF = 300;

type

vector = array[1..dimF]of real;

procedure incrementar_salario(var X: real; var v: vector; dimL: integer); // Lo voy a incrementar en un 15%
begin
		v[dimL]:= X + (X*0.15);
end;


procedure CargarVector(var v: vector; var dimL: integer);
var
	salario: real;
begin
	read(salario);
	while(dimL <= dimF)and(salario <> 0)do begin
		dimL:= dimL +1;
		incrementar_salario(salario, v, dimL);
		read(salario);
	end;
end;
//_______________________ Modulo para mostrar y chequear que se hacen bien los incrementos __________________________
procedure mostrar_vector(v: vector; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln(v[i]:1:2);
	end;
end;
//_______________________ FIN Modulo para mostrar y chequear que se hacen bien los incrementos __________________________
procedure calcular_promedio(v: vector; dimL: integer; var promedio: real);
var
	suma_vector: real;
	i: integer;
begin
	suma_vector:= 0;
	for i:= 1 to dimL do begin
		suma_vector:= suma_vector + v[i];
	end;
	promedio:= suma_vector/dimL;
end;

var
	v: vector;
	dimL: integer;
	promedio: real;
	
BEGIN
	dimL:= 0;
	promedio:= 0;
	CargarVector(v, dimL);
	mostrar_vector(v, dimL);
	calcular_promedio(v, dimL, promedio);
	write('El promedio del salario de los empleados es: ',promedio:1:2);
END.

