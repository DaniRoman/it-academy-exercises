# nivel1
# Exercici 1
# Calculadora de l'índex de massa corporal

# Escriu una funció que calculi l'IMC ingressat per l'usuari/ària, és a dir,
# qui ho executi haurà d'ingressar aquestes dades. Pots obtenir més informació del seu càlcul en:


def imc_cal(weight: int, height: int) -> float:
    height_in_meters: int = height / 100
    imc: int = weight / (height_in_meters**2)
    imc: float = float(imc)
    return round(imc, 2)


def imc_result(imc: float) -> str:
    result: str = ""
    if imc < 18.5:
        result = "Underweight"
    elif imc >= 18.5 and imc < 24.9:
        result = "Normal"
    elif imc >= 25 and imc < 29.9:
        result = "Above normal weight"
    elif imc > 30.0:
        result = "Obess"
    return result


def exe1_main() -> str:
    switch: bool = False

    while not switch:
        try:
            weight_input: str = input("enter your weight: ")
            weight: float = float(weight_input.replace(",", "."))

            switch = True
        except ValueError:
            print("Invalid input. Please enter a valid number (e.g., 70,5).")

    switch = False

    while not switch:
        try:
            height_input: str = input("enter your height in cm: ")
            height: float = float(height_input.replace(",", "."))

            switch = True
        except ValueError:
            print("Invalid Input please enter a valid integer.")

    
    imc = imc_cal(weight, height)
    result = imc_result(imc)
    print(f"Your BMI is {imc} ({result}).")


exe1_main()

# # Exercici 2
# # Convertidor de temperatures.

# # Existeixen diverses unitats de temperatura utilitzades en diferents contextos i regions. Les més comunes són Celsius (°C), Fahrenheit (°F) i Kelvin (K).
# # També existeixen altres unitats com Rankine (°Ra) i Réaumur (°Re). Selecciona almenys 2 conversors,
# # de tal manera que en introduir una temperatura retorni, com a mínim, dues conversions.


def temp_conversor(temp: int, choise: str) -> float:
    result: str = 0
    if choise == "1":
        fa: float = (temp * 9 / 5) + 32
        result = fa
    if choise == "2":
        ke: float = temp + 273.15
        result = ke
    return result


def exe2_main() -> str:
    switch: bool = False
    str_result: str = ""
    result: str = ""
    temp: float = 0
#Implementar que cuandno ponga float sea con punto y no con coma
    while not switch:
        try:
            celsius: float = float(input("Enter the temperature in degrees Celsius: "))
            switch = True
        except ValueError:
            print("Invalid Input please enter a valid integer.")

    switch = False

    print("""What type of conversion do you want to change to?
            Press 1 for Fahrenheit
            Press 2 for Kelvin""")
    while not switch:
        choise: str = input("Enter your choise: ")
        if choise == "1" or choise == "2":
            switch = True
        else:
            print("Invalid Input please enter 1  or 2.")

    if choise == "1":
        str_result = "Fahrenheit"
    elif choise == "2":
        str_result = "Kelvin"

    temp = temp_conversor(celsius, choise)
    result = f"{celsius} of degrees celsius equals to {temp} {str_result} of degrees"

    return result


str_conversion: str = exe2_main()
print(str_conversion)

# Exercici 3
# Comptador de paraules d'un text.
# Escriu una funció que donat un text, mostri les vegades que apareix cada paraula.

text: str = """Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Nullam sagittis egestas magna sed volutpat ultrices. tortor Aliquam Vivamus erat volutpat.
    In dictum, velit id pulvinar luctus, purus urna scelerisque turpis,
    et bibendum tortor nunc turpis quis Vivamus magna. Sed in pretium tortor.
    """


def text_count(text: str) -> int:
    result: int = 0
    new_list: list = []
    new_dic: dict = {}
    to_remove: str = ",."

    new_list = text.split()

    for word in new_list:
        formated_word = word.strip(to_remove)
        if formated_word not in new_dic:
            new_dic[formated_word] = 0
        new_dic[formated_word] += 1
    print(new_dic.items())

text_count(text)

# Exercici 4
# Diccionari invers.

# Resulta que el client té una enquesta molt antiga que s'emmagatzema en un diccionari i els resultats els necessita al revés, és a dir,
# intercanviats les claus i els valors. Els valors i claus en el diccionari original són únics; si aquest no és el cas,
# la funció hauria d'imprimir un missatge d'advertiment.


wrong_dict: dict = {"a": 2, "b": 2, "c": 5}
correct_dict: dict = {"a": 1, "b": 2, "c": 3}

def check_duplicates(dict_to_check: dict) -> bool:
    return len(dict_to_check.values()) != len(set(dict_to_check.values()))


def dict_trasnform(input_dict: dict) -> dict:
    reversed_dict: dict = {}
    if check_duplicates(input_dict):
        print("ADVISE: There are duplicates in the dict")
    else:
        reversed_dict: dict = {key: value for value, key in correct_dict.items()}
    return reversed_dict


result = dict_trasnform(correct_dict)
print(result)