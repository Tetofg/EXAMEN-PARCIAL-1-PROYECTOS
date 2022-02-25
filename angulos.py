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
    cursor.execute("INSERT INTO angle(a1,a2,a3) VALUES (%s, %s, %s);", (x, y, z))
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
    cursor.execute("SELECT * from angle;")
    print(tabulate(cursor, headers=["ID", "ANGULO 1", "ANGULO 2", "ANGULO 3 "], tablefmt="fancy_grid", numalign ="center"))

print("ANGULOS INTERNOS DEL TRIANGULO")
while True:
    try:
        print("Elija una opcion:\n1.Correr el Programa\n2.Mostrar el Historial\n3.Salir")
        b=int(input("Elija:\n"))
        if b>3 or b<=0:
            print("Valor ingresado fuera del rango del menu.\n")
        elif b==1:
            while True:
                try:
                    print("Ingrese el primer angulo")
                    a1 = int(input("ANGULO 1: \n"))
                    if a1>=180 or a1<=0:
                        print("Revise el valor ingresado\n")
                        continue
                    break
                except:
                    print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
                    continue

            while True:
                try:
                    print("Ingrese el segundo angulo")
                    a2 = int(input("ANGULO 2: \n"))
                    if a2>=180 or a2<=0:
                        print("Revise el valor ingresado\n")
                        continue
                    break
                except:
                    print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
                    continue

            a3=180-a1-a2
            print("El Tercer Angulo es: %d"%(a3))
            post(a1,a2,a3)
        elif b==2:
            ret()
        elif b==3:
            break

    except Exception as e:
        print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
        print(repr(e))

exit(0)