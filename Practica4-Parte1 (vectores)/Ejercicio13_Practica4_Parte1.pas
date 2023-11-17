{13. El Grupo Intergubernamental de Expertos sobre el Cambio Climático de la ONU (IPCC) realiza todos los
años mediciones de temperatura en 100 puntos diferentes del planeta y, para cada uno de estos lugares,
obtiene un promedio anual. Este relevamiento se viene realizando desde hace 50 años, y con todos los
datos recolectados, el IPCC se encuentra en condiciones de realizar análisis estadísticos. Realizar un
programa que lea y almacene los datos correspondientes a las mediciones de los últimos 50 años (la
información se ingresa ordenada por año). Una vez finalizada la carga de la información, obtener:
a) El año con mayor temperatura promedio a nivel mundial.
b) El año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años.   
}


program Ejercicio13;
type
	vector_puntos = array[1..dimF1]of real;;

//______________________________________________________________________
procedure Inicializar_Vector_Contador(var vc: vector_puntos);
var
	i: integer;
begin
	for i:= 1 to 100 do begin
		vc[i]:= 0;
	end;
end;
//______________________________________________________________________
procedure cargar_vector(var vc: vector_puntos);
var
	i, j: integer;
	temperatura: real;
begin
	for i:= 1 to 50 do begin
		for j:= 1 to 100 do begin // Tomo la temperatura de los 100 puntos y los sumo en cada punto del vector contador, entonces cada año sumo la temperatura en cada punto
			read(temperatura);
			vc[j]:= vc[j] + temperatura;
			maximo_incisoB();
		end:
	end;
	for i:= 1 to 100 do begin // 1..100
		vc:= vc[i]/50 // Promedio por año de cada punto
		maximos_incisoA(); // Chequeo si es el año con mayor temp promedio a nivel mundial "Inciso A"
	end:
end;
//______________________________________________________________________

var
	vp: vector_puntos;
	va: vector_anios;
BEGIN
	Inicializar_Vector_Contador(vp);
	cargar_vector(va);
END.


