{8. Realizar un programa que lea y almacene la información de 400 alumnos ingresantes a la Facultad de
Informática de la UNLP en el año 2020. De cada alumno se lee: nro de inscripción, DNI, apellido, nombre y
año de nacimiento. Una vez leída y almacenada toda la información, calcular e informar:
a) El porcentaje de alumnos con DNI compuesto sólo por dígitos pares.
b) Apellido y nombre de los dos alumnos de mayor edad.
* 
9. Modificar la solución del punto anterior considerando que el programa lea y almacene la información de a
lo sumo 400 alumnos. La lectura finaliza cuando se ingresa el DNI -1 (que no debe procesarse).}


program Ejercicio9Practica4Parte1;
const
	dimF = 3;
	anio_actual = 2023;
type
	alumno = record
		nro_inscripcion: integer;
		DNI: integer;
		nombre_apellido: string[20];
		anio_nacimiento: integer;
	end;

	vector = array[1..dimF]of alumno;

procedure LeerDatos(var a: alumno);
begin
	writeln('Ingrese el nombre y apellido del alumno: ');
	readln(a.nombre_apellido);
	write('Ingrese el numero de inscripcion del alumno: ');
	read(a.nro_inscripcion);
	write('Ingrese el DNI del alumno: ');
	read(a.DNI);
	write('Ingrese el anio de nacimiento del alumno: ');
	readln(a.anio_nacimiento);
end;

procedure digitos_pares(a: alumno; var cant_pares: integer); // La forma mas sencilla de ver si todos los digitos son pares, es ver si hay impares, si hay al menos 1 ya lo descarto al DNI
var
	dig: integer;
	impar, par:integer;
	
begin
    impar:=0;
    par:= 0;
    while (a.DNI <> 0) do begin // PASCAL SOLO TOMA DNI DESDE -32767 HASTA 32767 ... Si le pongo mi DNI por ejemplo: 41896019, no lo toma o solo toma los primeros digitos
        dig:= a.DNI MOD 10; // Si me exedo del limite, basicamente me toma digitos basura, numeros random.
        if((dig MOD 2)= 0) then
			par:= par +1
        else
			impar:= impar +1;
        a.DNI := a.DNI DIV 10;
    end;
    if (impar>=1)then begin
		cant_pares:= 0;
    end
	else 
		cant_pares:= cant_pares + 1;
end;

procedure calcular_maximos(a: alumno; var nombre_max1: string; var nombre_max2: string; var max1: integer; var max2: integer);
var
	edad: integer;
begin
	edad:= anio_actual - a.anio_nacimiento;
	if(edad > max1)then begin
		max2:= max1;
		nombre_max2:= nombre_max1;
		max1:= edad;
		nombre_max1:= a.nombre_apellido;
	end
	else
		if(edad > max2)then begin
			max2:= edad;
			nombre_max2:= a.nombre_apellido;
		end;
end;

procedure cargar_vector(var v: vector; var cantidad_pares: integer; var max1: integer; var max2: integer; var nombre_max1: string; var nombre_max2: string; var dimL: integer);
var
	a: alumno;
	
begin
	LeerDatos(a);
	while(dimL <= dimF)and(a.DNI <> -1)do begin
		dimL:= dimL +1;
		digitos_pares(a, cantidad_pares);
		calcular_maximos(a, nombre_max1, nombre_max2, max1, max2);
		v[dimL]:= a;
		LeerDatos(a);
	end;
end;

var 
	v: vector;
	maximo1, maximo2, cant_pares, dimL: integer;
	nombre_max1, nombre_max2: string[20];
	promedio: real;
	
BEGIN
	dimL:= 0;
	cant_pares:= 0;
	promedio:= 0;
	maximo1:= -1;
	maximo2:= -1;
	nombre_max1:= '';
	nombre_max2:= '';
	cargar_vector(v, cant_pares, maximo1, maximo2, nombre_max1, nombre_max2, dimL);
	promedio:= cant_pares/dimF;
    writeln('A) EL promedio de los alumnos con los digitos del dni completamente pares son : ', promedio:1:2);
    WriteLn('B) Los dos alumnos con mayor edad son: ',nombre_max1);
END.
