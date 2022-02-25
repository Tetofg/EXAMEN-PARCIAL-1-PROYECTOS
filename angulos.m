clc; clear all; close all;
pkg load database;
retry= true;
retry1= true;
retry2= true;
retry3= true;
while retry
  try
    fprintf("\n Elija una opcion \n 1.Correr el programa \n 2.Mostrar Historial \n 3.Salir\n");
    m=(input('Elija:   '));
    if m>3||m==0|m<0
      fprintf("Elija una opcion correcta \n");
    endif
    if m==1
      while retry1
        try
          fprintf("Ingrese el primer angulo \n");
          a1=input("Angulo 1:   ");
          if a1>=180 || a1<=0
            fprintf("\nRevise el valor ingresado\n");
          else
            retry1=false;
          endif
        catch
          fprintf("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n");
        end_try_catch
      endwhile
      
      while retry2
        try
          fprintf("Ingrese el segundo angulo \n");
          a2=input("Angulo 2:   ");
          if a2>180 || a2<=0 || a1+a2>1180
            fprintf("\nRevise el valor ingresado\n");
          else
            retry2=false;
          endif
        catch
          fprintf("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n");
        end_try_catch
      endwhile
      a3=180-a1-a2;
      fprintf("El Tercer Angulo es: %d \n ", a3);
      params= cell(1,3);
      params{1,1}=a1;
      params{1,2}=a2;
      params{1,3}=a3;
      conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
      'port','5432','user','postgres','password','123fgthg'));
      N=pq_exec_params(conn, "insert into angle(a1, a2, a3) values($1,$2,$3);",params); %insertar datos en la tabla
      
    endif
    if m==2
      conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
      'port','5432','user','postgres','password','123fgthg'));
      N=pq_exec_params(conn, "Select * from angle;"); %insertar datos en la tabla
      disp(N)
      retry=false;
    endif
    
    if m==3
      retry=false;
    endif
  catch
    fprintf("A ingresado un valor erroneo vuelva a intentarlo %d \n");
    msg = lasterror.message;
    fprintf(msg);
  end_try_catch
endwhile