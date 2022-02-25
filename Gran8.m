clc; clear all; close all;
pkg load database;
retry= true;
retry2= true;


while retry
  try
    fprintf("\n Elija una opcion \n 1.Correr el programa \n 2.Mostrar Historial \n 3.Salir\n");
    m=(input('Elija:   '));
    if m>3||m==0|m<0
      fprintf("Elija una opcion correcta \n");
    endif
    if m==1
      while retry2
        try
          fprintf("Iniciando Juego \n");
          pdado=round(6*rand());
          fprintf("Dado #1: %d \n",pdado);
          sdado=round(6*rand());
          fprintf("Dado #2: %d \n",sdado);
          s=pdado+sdado;
          if s==8
            status="GANASTE";
            fprintf("%s \n", status);
            fprintf("\n");
            params= cell(1,3);
            params{1,1}=pdado;
            params{1,2}=sdado;
            params{1,3}=status;
            conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
            'port','5432','user','postgres','password','123fgthg'));
            N=pq_exec_params(conn, "insert into dados(pdado, sdado, status) values($1,$2,$3);",params); %insertar datos en la tabla
            retry2=false;
          endif
          if s==7
            status="Perdiste";
            fprintf("%s \n", status);
            fprintf("\n");
            params= cell(1,3);
            params{1,1}=pdado;
            params{1,2}=sdado;
            params{1,3}=status;
            conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
            'port','5432','user','postgres','password','123fgthg'));
            N=pq_exec_params(conn, "insert into dados(pdado, sdado, status) values($1,$2,$3);",params); %insertar datos en la tabla
            retry2=false;
          else
            status="Continuas";
            fprintf("%s \n", status);
            fprintf("\n");
            params= cell(1,3);
            params{1,1}=pdado;
            params{1,2}=sdado;
            params{1,3}=status;
            conn = pq_connect(setdbopts('dbname','EP1','host','localhost',
            'port','5432','user','postgres','password','123fgthg'));
            N=pq_exec_params(conn, "insert into dados(pdado, sdado, status) values($1,$2,$3);",params); %insertar datos en la tabla
            rr=input("Quieres continuar? (1=SI/0=NO)");
            if rr == 0 || rr == 0
              retry2=false;
            elseif rr == 1 || rr == 1
              fprintf("CONTINUAMOS \n");
             endif
            endif
          retry=false;
        catch
          fprintf("A ingresado un valor erroneo vuelva a intentarlo %d \n");
          msg = lasterror.message;
          fprintf(msg);
        end_try_catch
      endwhile

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