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
      a1="0";
      retry1=true;
      while retry1
        try
          fprintf("Ingrese un numero entre 1y 999 \n");
          a1=input("Numero:   ","s");
          if a1>999 || a1<=0
            fprintf("\nRevise el valor ingresado\n");
          else
            retry1=false;
          endif
        catch
          fprintf("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n");
        end_try_catch
      endwhile
      
      c=a1(1);
      d=a1(2);
      u=a1(3);
      fprintf("Valor de centenas: %s \n", c)
      fprintf("Valor de decenas: %s \n" , d)
      fprintf("Valor de unidades: %s \n", u)
      params= cell(1,3);
      uu=str2double(u);
      dd=str2double(d);
      cc=str2double(c);
      params{1,1}= uu;
      params{1,2}= dd;
      params{1,3}= cc;
      conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
      'port','5432','user','postgres','password','123fgthg'));
      N=pq_exec_params(conn, "insert into udc(u, d, c) values($1,$2,$3);",params); %insertar datos en la tabla
      
    endif
    if m==2
      conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
      'port','5432','user','postgres','password','123fgthg'));
      N=pq_exec_params(conn, "Select * from udc;"); %insertar datos en la tabla
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