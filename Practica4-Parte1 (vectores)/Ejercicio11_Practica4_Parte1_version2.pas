{11. El colectivo de fotógrafos ArgenPics desea conocer los gustos de sus seguidores en las redes sociales. Para
ello, para cada una de las 200 fotos publicadas en su página de Facebook, cuenta con la siguiente
información: título de la foto, el autor de la foto, cantidad de Me gusta, cantidad de clics y cantidad de
comentarios de usuarios. Realizar un programa que lea y almacene esta información. Una vez finalizada la
lectura, el programa debe procesar los datos e informar:
a) Título de la foto más vista (la que posee mayor cantidad de clics).
b) Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo “Art Vandelay”.
c) Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página.
}


Program Ejercicio11;
const
	dimF = 2;

Type
	str20 = string[20];
	
	foto = record
		titulo: str20;
		autor: str20;
		cantidad_megusta: integer;
		cantidad_clics: integer;
		cantidad_comentarios: integer;
	end;
	
	vector = array[1..dimF]of foto;

// Carga de datos ______________________________________________________
procedure LeerDatos(var a: foto);
begin
	writeln('Ingrese el titulo de la foto: ');
	readln(a.titulo);
	writeln('Ingrese el autor de la foto: ');
	readln(a.autor);
	writeln('Ingrese la cantidad de me gusta: ');
	readln(a.cantidad_megusta);
	writeln('Ingrese la cantidad de clics: ');
	readln(a.cantidad_clics);
	writeln('Ingrese la cantidad de comentarios: ');
	readln(a.cantidad_comentarios);
end;

procedure cargar_procesar_vector(var v: vector; var cantidad_total_megusta: integer; var max: integer; var nombre_max: str20);
var
	a: foto;
	i: integer;
begin
	cantidad_total_megusta:= 0;
	for i:= 1 to dimF do begin
		LeerDatos(a);
		v[i]:= a;
		if(a.autor = 'Art Vandelay')then begin // Inciso B
			cantidad_total_megusta:= cantidad_total_megusta + a.cantidad_megusta;
		end;
		if(v[i].cantidad_clics > max)then begin // Inciso A
			max:= v[i].cantidad_clics;
			nombre_max:= v[i].titulo;
		end;
		writeln('La cantidad de comentarios recibidos de la foto ',a.titulo,' es de: ',a.cantidad_comentarios); // Inciso C, no se si es lo que me pide, no se entiende bien.
																												// Yo a cada foto le muestro en pantalla la cantidad de comentarios.
	end;
end;	
// Carga de datos ______________________________________________________


Var
	v: vector;
	maximo, cant_total_megusta: integer;
	nombre_maximo: str20;
	
Begin
	cant_total_megusta:= 0;
	maximo:= -1;
	nombre_maximo:= '';
	cargar_procesar_vector(v, cant_total_megusta, maximo, nombre_maximo);
	writeln('El titulo de la foto mas vista es: ', nombre_maximo);
	writeln('La cantidad total de me gusta de las fotos cuyo autor es el fotografo Art Vandelay es de: ', cant_total_megusta)
end.

