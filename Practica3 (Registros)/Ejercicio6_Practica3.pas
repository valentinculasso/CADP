{
 6. Una empresa importadora de microprocesadores desea implementar un sistema de software para analizar la
información de los productos que mantiene actualmente en stock. Para ello, se conoce la siguiente información de
los microprocesadores: marca (Intel, AMD, NVidia, etc), línea (Xeon, Core i7, Opteron, Atom, Centrino, etc.),
cantidad de cores o núcleos de procesamiento (1, 2, 4, 8), velocidad del reloj (medida en Ghz) y tamaño en
nanómetros (nm) de los transistores (14, 22, 32, 45, etc.). La información de los microprocesadores se lee de
forma consecutiva por marca de procesador y la lectura finaliza al ingresar un procesador con 0 cores (que no
debe procesarse). Se pide implementar un programa que lea información de los microprocesadores de la empresa
importadora e informe:
● Marca y línea de todos los procesadores de más de 2 cores con transistores de a lo sumo 22 nm.
● Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm.
● Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de
al menos 2 Ghz.

La informacion se ingresa consecutiva y ordenada por procesador, por ende hay que usar corte de control.
}
program Ejercicio6Practica3;

type
str20 = string[20];
microprocesador = record
	marca: str20;
	linea: str20;
	nucleos: integer;
	velocidad_reloj: real;
	tamano_nm: integer;
end;

procedure LeerDatos(var a: microprocesador);
begin
	writeln('Ingrese la marca del microprocesador: ');
	readln(a.marca);
	writeln('Ingrese la linea del microprocesador: ');
	readln(a.linea);
	writeln('Ingrese la cantidad de nucleos del microprocesador: ');
	readln(a.nucleos);
	writeln('Ingrese la velocidad de reloj del microprocesador: ');
	readln(a.velocidad_reloj);
	writeln('Ingrese el tamaño en nanometros del microprocesador: ');
	readln(a.tamano_nm);
end;

procedure inciso_A(a: microprocesador);
begin
	if(a.nucleos > 2)and(a.tamano_nm >= 22)then begin
		writeln('El procesador de marca ',a.marca,'y linea ',a.linea,' tiene mas de 2 nucleos y transistores de a lo sumo 22nm');
	end;
end;

procedure inciso_B(cant: integer; marca: str20; var max1: integer; var max2: integer; var marca_max1: str20; var marca_max2: str20);
begin
	if(cant > max1)then begin
		max2:= max1;
		marca_max2:= marca_max1;
		marca_max1:= marca;
		max1:= cant;
	end
	else 
		if(cant > max2)then
			max2:= cant;
			marca_max2:= marca;
end;
	
var
	a: microprocesador;
	marca_actual, marca_max1, marca_max2: str20;
	cantidad, cantidad2, maximo1, maximo2: integer;

BEGIN
	maximo1:= -1;
	maximo2:= -1;
	marca_max1:= '';
	marca_max2:= '';
	cantidad2:= 0; // Esta es la cantidad que uso para el inciso C
	LeerDatos(a);
	while(a.nucleos <> 0)do begin
		cantidad:= 0; // Esta es la cantidad que uso para el inciso B
		marca_actual:= a.marca;
		while (a.marca = marca_actual) do begin
			inciso_A(a);
			if(a.tamano_nm = 14)then begin
				cantidad:= cantidad + 1
			end;
			if(a.marca = 'intel')or(a.marca = 'AMD')then begin
				if(a.nucleos > 1)and(a.velocidad_reloj >= 2)then begin
					cantidad2:= cantidad2 + 1;
				end;
			end;
			LeerDatos(a);
		end;
		inciso_B(cantidad, a.marca, maximo1, maximo2, marca_max1, marca_max2);
	end;
	writeln('Inciso B: Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm son: ',marca_max1,' y ',marca_max2);
	writeln('Inciso C: La cantidad de procesadores Intel o AMD con mas de 1 nucleo y con velocidad de reloj de al menos 2Ghz es: ',cantidad2);
END.

