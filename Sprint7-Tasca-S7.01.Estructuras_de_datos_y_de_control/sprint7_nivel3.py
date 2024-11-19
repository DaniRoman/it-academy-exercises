# Exercici 1
# Comptador i endreçador de paraules d'un text.

# El client va quedar content amb el comptador de paraules, però ara vol llegir arxius TXT
# i que calculi la freqüència de cada paraula ordenades
# dins de les entrades habituals del diccionari segons la lletra amb la qual comencen,
# és a dir, les claus han d'anar de la A a la Z i dins de la A hem d'anar de la A la Z.
# Per exemple, per a l'arxiu "tu_me_quieres_blanca.txt" la sortida esperada seria:


def clean_data(path: str) -> list:
    formated_words: list = []
    to_remove: str = ",.:;'!¡()"
    with open(path, "r") as fil_e:
        data = fil_e.read()
        new_list = data.split()
        for e in new_list:
            word_f = e.strip(to_remove)
            word = word_f.lower()
            if word:
                formated_words.append(word)
    return formated_words

def dict_gen(data: list) -> dict:
    new_dict: dict = {}
    for element in data:
        first_chart = element[0]
        if first_chart not in new_dict:
            new_dict[first_chart] = {}
        if element not in new_dict[first_chart]:
            new_dict[first_chart][element] = 1
        else:
            new_dict[first_chart][element] +=1
                
    print(new_dict)
      

data = clean_data("./tu_me_quieres_blanca.txt")
dict_gen(data)