{6. Dado que en la solución anterior se recorre dos veces el vector (una para calcular el elemento máximo y
otra para el mínimo), implementar un único módulo que recorra una única vez el vector y devuelva ambas
posiciones.}



program untitled;
const
	dimF = 100;
type
	vector = array[1..dimF]of integer;
	
	
	
procedure inicializar_vector(var a: vector; var dL: integer);
var
	num: integer;
begin
	write('Ingrese un numero: ');
	read(num);
	while((dL < dimF)and(num<>0))do begin
		dL:= dL + 1;
		a[dL]:= num;
		write('Ingrese un numero: ');
		read(num);
	end;
end;

procedure maximo_minimo(v: vector; var max: integer ;var pos_max: integer; dimL: integer; var min: integer ;var pos_min: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		if(v[i]>max)then begin
			max:= v[i];
			pos_max:= i;
		end;
		if(v[i]<min)then begin
			min:= v[i];
			pos_min:= i;
		end;
	end;
end;


procedure intercambio(var v: vector; max: integer; min: integer);
var
	num_aux1, num_aux2: integer;
begin
	num_aux1:= v[max];
	num_aux2:= v[min];
	v[max]:= num_aux2;
	v[min]:= num_aux1;
end;

procedure imprimir_vector_cambiado(v: vector; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln(v[i]);
	end;
end;

var 
	v: vector;
	dimL, max, posicion_max, min, posicion_min: integer;

BEGIN
	dimL:= 0;
	max:= -1;
	min:= 999;
	posicion_max:= 0;
	posicion_min:= 0;
	inicializar_vector(v, dimL);
	maximo_minimo(v, max, posicion_max, dimL, min, posicion_min);
	writeln('posicion maxima: ',posicion_max);
	writeln('posicion minima: ',posicion_min);
	intercambio(v, posicion_max, posicion_min);
	write('El vector cambiado quedaria: ');
	imprimir_vector_cambiado(v, dimL);
END.
