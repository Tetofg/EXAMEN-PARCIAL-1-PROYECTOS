import psycopg2
from tabulate import tabulate
def  post(x,y,z,w,q):
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
    cursor.execute("INSERT INTO birth(dy, mon, yr, cumple, edad) VALUES (%s, %s, %s, %s, %s);", (x, y, z, w, q))
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
    cursor.execute("SELECT * from birth;")
    print(tabulate(cursor, headers=["ID", "DIA", "MES", "AÑO", "¿YA CUMPLIO AÑOS?", "EDAD"], tablefmt="fancy_grid", numalign ="center"))

print("CUMPLEAÑOS \n")
cumple = ""
edad=0
while True:
    try:
        print("Elija una opcion:\n1.Correr el Programa\n2.Mostrar el Historial\n3.Salir")
        b=int(input("Elija:\n"))
        if b>3 or b<=0:
            print("Valor ingresado fuera del rango del menu.\n")
        elif b==1:
            dt=24
            mt=2
            yt=2022
            while True:
                try:
                    print("Ingrese el dia de nacimiento")
                    dy = int(input("Dia: \n"))
                    if dy>31 or dy<=0:
                        print("Revise el valor ingresado\n")
                        continue
                    break
                except:
                    print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
                    continue
            while True:
                try:
                    print("Ingrese el mes de nacimiento (numero)\n")
                    mon = int(input("Mes: \n"))
                    if mon>12 or mon<=0:
                        print("Revise el valor ingresado\n")
                        continue
                    break
                except:
                    print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
                    continue
            while True:
                try:
                    print("Ingrese el año de nacimiento\n")
                    yr = int(input("Año: \n"))
                    if yr<=0 or yr>yt:
                        print("Revise el valor ingresado\n")
                        continue
                    break
                except:
                    print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
                    continue
            if mt<mon:
                cumple="NO HA CUMPLIDO AÑOS"
                edad = yt-yr
            elif mt>mon:
                cumple="YA HA CUMPLIDO AÑOS"
                edad = yt-yr
            elif mt==mon:
                if dt>dy:
                    cumple="YA HA CUMPLIDO AÑOS"
                    edad = yt-yr
                elif dt<dy:
                    cumple="NO HA CUMPLIDO AÑOS"
                    edad = yt-yr
                elif dy==dy:
                    cumple="HOY CUMPLE AÑOS"
                    edad = yt-yr
            print("Esta persona cumple %d este año y %s este año\n "%(edad,cumple))
            post(dy, mon, yr,cumple, edad)
            
                
                
        elif b==2:
            ret()
        elif b==3:
            break

    except Exception as e:
        print("\n A ingresado un valor o Caracter no valido por favor, ingrese una opcion correcta:\n")
        print(repr(e))

exit(0)