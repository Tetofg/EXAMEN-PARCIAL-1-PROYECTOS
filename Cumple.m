clc; clear all; close all;
pkg load database;
retry= true;
retry1= true;
retry2= true;
retry3= true;
cumple = '';
edad=0;
while retry
  try
    fprintf("\n Elija una opcion \n 1.Correr el programa \n 2.Mostrar Historial \n 3.Salir\n");
    m=(input('Elija:   '));
    if m>3||m==0|m<0
      fprintf("Elija una opcion correcta \n");
    endif
    if m==1
      dt=24;
      mt= 2;
      yt=2022;
      
      while retry1
        try
          fprintf("Ingrese el dia de nacimiento \n");
          dy=input("Dia:   ");
          if dy>31 || dy<=0
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
          fprintf("Ingrese el mes de nacimiento \n");
          mon=input("Mes:   ");
          if mon>12 || dy<=0
            fprintf("\nRevise el valor ingresado\n");
          else
            retry2=false;
          endif
        catch
          fprintf("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n");
        end_try_catch
      endwhile
      
      while retry3
        try
          fprintf("Ingrese el año de nacimiento \n");
          yr=input("Año:   ");
          if yr<=0 || yr>yt
            fprintf("\nRevise el valor ingresado\n");
          else
            retry3=false;
          endif
        catch
          fprintf("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n");
          msg = lasterror.message;
          fprintf(msg);
        end_try_catch
      endwhile
      c= yt-dy;
      
      if mt<mon
        cumple='NO HA CUMPLIDO AÑOS';
        edad= yt-yr;
      elseif mt>mon
        cumple='YA HA CUMPLIDO AÑOS';
        edad= yt-yr;
      elseif mt==mon
        if dt>dy
          cumple='YA HA CUMPLIDO AÑOS';
          edad= yt-yr;
        elseif dt<dy
          cumple='NO HA CUMPLIDO AÑOS';
          edad= yt-yr;
        elseif dt==dy
          cumple='YA HA CUMPLIDO AÑOS';
          edad= yt-yr;
        endif
      endif
      
      fprintf("Esta persona cumple %d este año y %s este año\n ",edad,cumple );
      params= cell(1,5);
      params{1,1}=dy;
      params{1,2}=mon;
      params{1,3}=yr;
      params{1,4}=cumple;
      params{1,5}=edad;
      conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
      'port','5432','user','postgres','password','123fgthg'));
      N=pq_exec_params(conn, "insert into birth(dy, mon, yr, cumple, edad) values($1,$2,$3,$4,$5);",params); %insertar datos en la tabla
      
    endif
    if m==2
      conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
      'port','5432','user','postgres','password','123fgthg'));
      N=pq_exec_params(conn, "Select * from birth;"); %insertar datos en la tabla
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