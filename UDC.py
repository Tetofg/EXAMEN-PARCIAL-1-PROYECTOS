import psycopg2
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
    cursor.execute("INSERT INTO udc(u, d, c) VALUES (%s, %s, %s);", (x, y, z))
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
    cursor.execute("SELECT * from udc;")
    print(tabulate(cursor, headers=["ID", "UNIDAD", "DECENA", "CENTENA"], tablefmt="fancy_grid", numalign ="center"))

print("UNIDADES DECENAS Y CENTENAS \n")
cumple = ""
edad=0
while True:
    try:
        print("Elija una opcion:\n1.Correr el Programa\n2.Mostrar el Historial\n3.Salir")
        b=int(input("Elija:\n"))
        if b>3 or b<=0:
            print("Valor ingresado fuera del rango del menu.\n")
        elif b==1:
            while True:
                try:
                    print("Ingrese el numero entre 1 y 999")
                    a1 = int(input("Numero: \n"))
                    if a1>999 or a1<=0:
                        print("Revise el valor ingresado\n")
                        continue
                    break
                except:
                    print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
                    continue

            c=(a1%1000-a1%100)//100
            d=(a1%100-a1%10)//10
            u=a1%10
            print("Valor de centenas: %d \n" %(c))
            print("Valor de decenas: %d \n" %(d))
            print("Valor de unidades: %d \n"%(u))
            post(u,d,c)
        elif b==2:
            ret()
        elif b==3:
            break

    except Exception as e:
        print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
        print(repr(e))

exit(0)