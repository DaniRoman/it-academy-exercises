# # NIVEL 2
# # Exercici 1
# # Diccionari invers amb duplicats
# # Continuant amb l'exercici 4 del nivell 1: al client es va oblidar
# # de comentar un detall i resulta que els valors en el diccionari original poden
# # duplicar-se i més, per la qual cosa les claus intercanviades poden tenir duplicats.
# # En aquest cas, en l'exercici anterior imprimies un missatge d'advertiment,
# # ara, els valors del diccionari resultant hauran d'emmagatzemar-se com una llista.
# # Tingues en compte que si és un valor únic no ha de ser una llista.


# def find_repeats(dict_to_check: dict) -> dict:
#     new_dict: dict = {}

#     for key, value in dict_to_check.items():
#         if value not in new_dict:
#             new_dict[value] = [key]
#         else:
#             new_dict[value].append(key)

#     return new_dict


# def dict_to_list(dict_to_check: dict) -> list:
#     new_list: list = []

#     for key, value in dict_to_check.items():
#         if len(value) > 1:
#             new_list.append(key)
#     return new_list


# def main_ex1():
#     correct_dict: dict = {"a": 1, "b": 2, "c": 3, "c": 5}
#     wrong_dict: dict = {"a": 1, "b": 2, "c": 3, "d": 3}
#     main_dict: dict = {}
#     main_list: list = []

#     main_dict = find_repeats(wrong_dict)
#     main_list = dict_to_list(main_dict)

#     print(main_list)


# main_ex1()


# Exercici 2
# Conversió de tipus de dades

# El client rep una llista de dades i necessita generar dues llistes,
# la primera on estaran tots els elements que es van poder convertir en flotants i l'altra on estan els elements que no es van poder convertir.
# Exemple de la llista que rep el client: [ '1.3', 'one' , '1e10' , 'seven', '3-1/2', ('2',1,1.4,'not-a-number'), [1,2,'3','3.4']]


def list_generator(con_list: list) -> tuple[list, list]:
    """Function that generates a lists"""
    float_list: list = []
    non_float_list: list = []

    for element in con_list:
        try:
            if isinstance(element, (tuple, list)):
                for e in element:
                    try:
                        con_e = float(e)
                        float_list.append(con_e)
                    except ValueError:
                        non_float_list.append(e)
            else:
                con_elem = float(element)
                float_list.append(con_elem)
        except ValueError:
            non_float_list.append(element)
    return float_list, non_float_list


def main_ex2():
    """Function that ejececutes ex2."""
    conversion = [
        "1.3",
        "one",
        "1e10",
        "seven",
        "3-1/2",
        ("2", 1, 1.4, "not-a-number"),
        [1, 2, "3", "3.4"],
    ]
    float_list, non_float_list = list_generator(conversion)

    print(f"""
          Float list: {float_list}
          Non float list: {non_float_list} 
          """)


main_ex2()
