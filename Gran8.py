from turtle import pd
import psycopg2
import random 
from tabulate import tabulate
def  post(x,y,z):
    try:
        conexion = psycopg2.connect(
            host = "localhost",
            port = "5432",
            user = "postgres",
            password = "123fgthg",
            dbname = "EP1"
            )
    except:
        print("Sin Conexion Exitosa\n")
            
    cursor = conexion.cursor()
    cursor.execute("INSERT INTO dados(pdado,sdado,status) VALUES (%s, %s, %s);", (x, y, z))
    conexion.commit()
    cursor.close()
    conexion.close()

def ret():
    try:
        conexion = psycopg2.connect(
            host = "localhost",
            port = "5432",
            user = "postgres",
            password = "123fgthg",
            dbname = "EP1"
            )
    except:
        print("Sin Conexion Exitosa\n")
    
    cursor = conexion.cursor()
    cursor.execute("SELECT * from dados;")
    print(tabulate(cursor, headers=["ID", "DADO 1", "DADO 2", "STATUS"], tablefmt="fancy_grid", numalign ="center"))


print("JUEGO GRAN 8 \n")
status=""
while True:
    try:
        print("Elija una opcion:\n1.Correr el Programa\n2.Mostrar el Historial\n3.Salir")
        b=int(input("Elija:\n"))
        if b>3 or b<=0:
            print("Valor ingresado fuera del rango del menu.\n")
        elif b==1:
            while True:
                try:
                    print("Iniciando Juego \n")
                    pdado=random.randint(1,6)
                    print("Dado #1: %d"%(pdado))
                    sdado=random.randint(1,6)
                    print("Dado #2: %d"%(sdado))
                    s=pdado+sdado
                    if s== 8:
                        status="GANASTE"
                        print(status)
                        print("\n")
                        post(pdado, sdado, status)
                        break
                    if s== 7:
                        status="Perdiste"
                        print(status)
                        print("\n")
                        post(pdado, sdado, status)
                        break
                    else:
                        status="Continuas"
                        post(pdado, sdado, status)
                        rr=input("Quieres continuar? (y/n)")
                        if rr == 'N' or rr == 'n':
                            break
                except Exception as e:
                    print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
                    print(repr(e))
            break
        elif b==2:
            ret()
        elif b==3:
            break

    except Exception as e:
        print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
        print(repr(e))

exit(0)