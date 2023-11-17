{12. En astrofísica, una galaxia se identifica por su nombre, su tipo (1. elíptica; 2. espiral; 3. lenticular; 4.
irregular), su masa (medida en kg) y la distancia en pársecs (pc) medida desde la Tierra. La Unión
Astronómica Internacional cuenta con datos correspondientes a las 53 galaxias que componen el Grupo
Local. Realizar un programa que lea y almacene estos datos y, una vez finalizada la carga, informe:
a) La cantidad de galaxias de cada tipo.
b) La masa total acumulada de las 3 galaxias principales (la Vía Láctea, Andrómeda y Triángulo) y el
porcentaje que esto representa respecto a la masa de todas las galaxias.
c) La cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc.
d) El nombre de las dos galaxias con mayor masa y el de las dos galaxias con menor masa.
}
program Ejercicio12;

const
	dimF = 2;
type

	str20 = string[20];
	galaxia = record
		nombre: str20;
		tipo: 1..4;   //tipo: vector_tipo; Aca yo pensaba que tenia que poner el vector, pero no... Por lo que vi ponen el rango nomas.
		masa: real;
		distancia_pc: integer; // pc = pársecs
	end;
	
	vector_tipo = array[1..4]of integer; // Este va a ser mi vector contador
	
	vector_galaxias = array[1..dimF]of galaxia; 
//______________________________________________________________________
procedure Inicializar_VectorTipo(var v: vector_tipo); // Inicializo el vector contador
var
	i: integer;
begin
	for i:= 1 to 4 do begin
		v[i]:= 0;
	end;
end;
//______________________________________________________________________ Leo el registro
procedure LeerDatos(var a: galaxia);
begin
	writeln('Ingrese el nombre de la galaxia: ');
	readln(a.nombre);
	writeln('Ingrese el tipo de galaxia: ');
	readln(a.tipo);
	writeln('Ingrese la masa de la galaxia: ');
	readln(a.masa);
	writeln('Ingrese la distancia en pc de la galaxia: ');
	readln(a.distancia_pc);
end;
//______________________________________________________________________ Cargo el vector
procedure cargar_vector(var v: vector_galaxias);
var
	i: integer;
	a: galaxia;
begin
	for i:= 1 to dimF do begin
		LeerDatos(a);
		v[i]:= a;
	end;
end;
//______________________________________________________________________
procedure Imprimir_vector_contador(v: vector_tipo);
var
	i: integer;
begin
	for i:= 1 to 4 do begin
		writeln(v[i]);
	end; 
end;
//______________________________________________________________________
procedure calcular_maximos(masa: real; nombre: str20; var max1: real; var max2: real; var nom_max1: str20; var nom_max2: str20; var min1: real; var min2: real; var nom_min1: str20; var nom_min2: str20);
begin
	if(masa > max1)then begin
		max2:= max1;
		nom_max2:= nom_max1;
		max1:= masa;
		nom_max1:= nombre;
	end
	else
		if(masa > max2)then begin
			max2:= masa;
			nom_max2:= nombre;
		end;
	if(masa < min1)then begin
		min2:= min1;
		nom_min2:= nom_min1;
		min1:= masa;
		nom_min1:= nombre;
	end
	else
		if(masa < min2)then begin
			min2:= masa;
			nom_min2:= nombre;
		end;
end;
//______________________________________________________________________
procedure procesar_vector(v: vector_galaxias; v_cont: vector_tipo);
var
	i, tipo_galaxia, cantidad_galaxias_C: integer;
	masa_total_acumulada, masa_todas_galaxias, porcentaje, maximo1, maximo2, minimo1, minimo2: real;
	nombre_maximo1, nombre_maximo2, nombre_minimo1, nombre_minimo2: str20;
begin
	masa_total_acumulada:= 0; // Inciso B
	masa_todas_galaxias:= 0; // Inciso B
	cantidad_galaxias_C:= 0; // Inciso C
	
	maximo1:= 0; // Inciso D
	maximo2:= 0;
	minimo1:= 99999;
	minimo2:= 99999;
	nombre_maximo1:= '';
	nombre_maximo2:= '';
	nombre_minimo1:= '';
	nombre_minimo2:= '';
	
	for i:= 1 to dimF do begin
		masa_todas_galaxias:= masa_todas_galaxias + v[i].masa; //Inciso B -> Calculo la masa de todas las galaxias
		tipo_galaxia:= v[i].tipo; // tipo_galaxia = 1..4 // Inciso A
		v_cont[tipo_galaxia]:= v_cont[tipo_galaxia] + 1;
		if(v[i].nombre = 'La via lactea')or(v[i].nombre = 'Andromeda')or(v[i].nombre = 'Triangulo')then begin // Inciso B
			masa_total_acumulada:= masa_total_acumulada + v[i].masa;
		end;
		if(v[i].tipo <> 4)and(v[i].distancia_pc < 1000)then begin // Inciso C
			cantidad_galaxias_C:= cantidad_galaxias_C + 1;
		end;
		calcular_maximos(v[i].masa, v[i].nombre, maximo1, maximo2, nombre_maximo1, nombre_maximo2, minimo1, minimo2, nombre_minimo1, nombre_minimo2);
	end;
	porcentaje:= (masa_total_acumulada*100)/masa_todas_galaxias; // Inciso B
	writeln('La cantidad de galaxias de cada tipo son: ');
	Imprimir_vector_contador(v_cont);
	writeln('La masa total de las 3 galaxias principales es de ',masa_total_acumulada:1:2,' y el porcentaje que representa respecto a las demas galaxias es de ', porcentaje:1:2); // B
	writeln('La cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc es de ', cantidad_galaxias_C); // C
	writeln('Los nombres de las dos galaxias con mayor masa son ',nombre_maximo1,' y ',nombre_maximo2,' y los nombres de las dos galaxias con menor masa son ',nombre_minimo1,' y ',nombre_minimo2);
end;
//______________________________________________________________________
var
	v: vector_galaxias;
	vt: vector_tipo;
BEGIN
	Inicializar_VectorTipo(vt);
	cargar_vector(v);
	procesar_vector(v, vt);
END.

