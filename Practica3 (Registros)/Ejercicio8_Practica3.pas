{
8. La Comisión Provincial por la Memoria desea analizar la información de los proyectos presentados en el programa
Jóvenes y Memoria durante la convocatoria 2020. Cada proyecto posee un código único, un título, el docente
coordinador (DNI, nombre y apellido, email), la cantidad de alumnos que participan del proyecto, el nombre de la
escuela y la localidad a la que pertenecen. Cada escuela puede presentar más de un proyecto. La información se
ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela. Realizar un programa que
lea la información de los proyectos hasta que se ingrese el proyecto con código -1 (que no debe procesarse), e
informe:
● Cantidad total de escuelas que participan en la convocatoria 2018 y cantidad de escuelas por cada localidad.
● Nombres de las dos escuelas con mayor cantidad de alumnos participantes.
● Título de los proyectos de la localidad de Daireaux cuyo código posee igual cantidad de dígitos pares e impares.  
}

program Ejercicio8Practica3;
type
	str20 = string[20];
	
	docente = record
		DNI: integer;
		nombre_completo: str20;
		email: str20;
	end;

	proyecto = record
		codigo: integer;
		titulo: str20;
		docente: docente;
		cant_alumnos: integer;
		nombre_escuela: str20;
		localidad: str20;
	end;

procedure LeerDatos(var a: proyecto; var b: docente);
begin
	writeln('Ingrese el codigo del proyecto: ');
	readln(a.codigo);
	writeln('Ingrese el titulo del proyecto: ');
	readln(a.titulo);
	// Docente
	writeln('Ingrese el DNI del docente: ');
	readln(a.docente.DNI);
	writeln('Ingrese el nombre completo del docente: ');
	readln(a.docente.nombre_completo);
	writeln('Ingrese el email del docente: ');
	readln(a.docente.email);
	// Termina docente
	writeln('Ingrese la cantidad de alumnos: ');
	readln(a.cant_alumnos);
	writeln('Ingrese el nombre de la escuela: ');
	readln(a.nombre_escuela);
	writeln('Ingrese la localidad: ');
	readln(a.localidad);
end;

function cant_digitos(cod: integer):boolean;
var
	cant_pares, cant_impares, dig: integer;
begin
	cant_pares:= 0;
	cant_impares:= 0;
	while(cod <> 0)do begin
		dig:= cod MOD 10; // tomo el ultimo digito
		if(dig MOD 2 = 0)then
			cant_pares:= cant_pares +1
		else
			cant_impares:= cant_impares +1;
		cod:= cod DIV 10; // le saco el ultimo digito
	end;
	if(cant_pares = cant_impares)then
		cant_digitos:= True
	else
		cant_digitos:= False;
end;

procedure calcular_dos_escuelas_con_mas_alumnos(cant_alumnos: integer; nombre_esc: str20; var nombre_max1: str20; var nombre_max2: str20; var max1: integer; var max2: integer);
begin
	if(cant_alumnos > max1)then begin
		max2:= max1;
		nombre_max2:= nombre_max1;
		max1:= cant_alumnos;
		nombre_max1:= nombre_esc;
	end
	else
		if(cant_alumnos > max2)then begin
			max2:= cant_alumnos;
			nombre_max2:= nombre_esc;
		end;
end;

var
	a: proyecto; b: docente;
	localidad_actual, escuela_actual, nombre_maximo1, nombre_maximo2: str20;
	cant_escuelas, cant_escuelas_localidad, cant_max1, cant_max2: integer;
	
	
BEGIN
	nombre_maximo1:= '';
	nombre_maximo2:= '';
	cant_max1:= -1;
	cant_max2:= -1;
	cant_escuelas:= 0; // Aca inicializo la cant de escuelas totales (Inciso A)
	LeerDatos(a, b);
	while(a.codigo <> -1)do begin
		localidad_actual:= a.localidad;
		cant_escuelas:= cant_escuelas +1; // Aca sumo la cantidad de escuelas totales (Inciso A)
		cant_escuelas_localidad:= 0; // Aca inicializo la cant de escuelas por localidad, entonces, si la localidad cambia se vuelve a inicializar en 0 (Inciso A)
		while(localidad_actual = a.localidad)do begin
			cant_escuelas_localidad:= cant_escuelas_localidad +1; // aca sumo la cantidad de escuelas por localidad (Inciso A)
			escuela_actual:= a.nombre_escuela;
			calcular_dos_escuelas_con_mas_alumnos(a.cant_alumnos, a.nombre_escuela, nombre_maximo1, nombre_maximo2, cant_max1, cant_max2); // Inciso B
			while(escuela_actual = a.nombre_escuela)do begin
				if(a.localidad = 'Daireaux')then // Inciso C
					if(cant_digitos(a.codigo))then
						writeln('El proyecto de titulo ',a.titulo,'s en la escuela ',a.nombre_escuela,' de la localidad de Daireaux tiene codigo con misma cantidad de digitos pares que impares.'); // Termina inciso C
				LeerDatos(a, b); // El LeerDatos se tiene que poner aca, porque yo puedo seguir ingresando proyectos de la misma escuela.
			end;
		end;
		writeln('La cantidad de escuelas en la localidad es de ', cant_escuelas_localidad);
	end;
	writeln('La Cantidad total de escuelas que participan en la convocatoria es de , ',cant_escuelas);
	writeln('Los nombres de las escuelas con mayor cantidad de alumnos participantes son ',nombre_maximo1,' y ',nombre_maximo2);
END.

