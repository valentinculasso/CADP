{14. El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en
los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que
participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:
CÓDIGO ROL DEL DESARROLLADOR VALOR/HORA (USD)
1 Analista Funcional 35,20
2 Programador 27,45
3 Administrador de bases de datos 31,03
4 Arquitecto de software 44,28
5 Administrador de redes y seguridad 39,87
Nota: los valores/hora se incluyen a modo de ejemplo
Realizar un programa que procese la información de los desarrolladores que participaron en los 1000
proyectos de software más activos durante el año 2017. De cada participante se conoce su país de
residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en
dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto
-1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:
a) El monto total invertido en desarrolladores con residencia en Argentina.
b) La cantidad total de horas trabajadas por Administradores de bases de datos.
c) El código del proyecto con menor monto invertido.
d) La cantidad de Arquitectos de software de cada proyecto.
}
program Ejercicio14;
const
	dimF = 1000;
type
	str20 = string[20];
	participante = record
		pais: str20;
		codigo: integer; // de 1..1000 no, porque tiene que parar con codigo = -1
		nombre_proyecto: str20;
		rol: 1..5;
		cant_horas: integer;
	end;
	vector = array[1..dimF]of participante;

procedure Leer(var a:participante);
begin
    with a do begin
        writeln('Ingrese el pais de residencia:');
        readln(pais);
        writeln('Ingrese el codigo del proyecto (1..1000):');
        readln(a.codigo);
        if (codigo <> -1) then begin
            writeln('Ingrese el nombre del proyecto:');
            readln(nombre_proyecto);
            writeln('Ingrese el rol en el proyeto:');
            writeln('1: Analisa Funcional: 35,20 V/H'); 
            writeln('2: Programador: 27,45V/H');
            writeln('3: Administrador de bases de datos: 31,03 V/H'); 
            writeln('4: Arquitecto de software: 44,28 V/H');
			writeln('5: Administrador de redes y seguridad: 39,87');
            readln(rol);
            writeln('Horas trabajadas:');
            readln(cant_horas);
        end;
    end;
end;

procedure Leer_Participantes(var v:vector; var dimL:integer);
var
	registro: participante;
	monto_total: real;
	cant_horas_BD: integer;
begin
	monto_total:= 0;
	cant_horas_BD:= 0;
	writeln('Ingrese los datos de un participante: ');
    Leer(registro);
    v[dimL]:= registro;
    while (dimL < dimF) and (v[dimL].codigo <> -1) do
    begin
		if(v[dimL].pais = 'Argentina')then begin // Inciso A
			case v[dimL].rol of
			1: monto_total:= monto_total + v[dimL].cant_horas*35.20;
			2: monto_total:= monto_total + v[dimL].cant_horas*27,45;
			3: monto_total:= monto_total + v[dimL].cant_horas*31,03;
			4: monto_total:= monto_total + v[dimL].cant_horas*44,28;
			5: monto_total:= monto_total + v[dimL].cant_horas*39,87;
		end;
		if(v[dimL].rol = 3)then begin
			cant_horas_BD:= cant_horas_BD + v[dimL].cant_horas;
		end;
		
        writeln('Ingrese los datos de un participante: ');
        Leer(registro);
        v[dimL]:= registro;
        dimL:= dimL +1;
    end;
end;

var
	v: vector; dimL: integer;
BEGIN
	dimL:= 1;
	Leer_Participantes(v, dimL);
END.

