
#Vowel & Consonant Counter
def count_vowels_consonants(text):
    """
    Count vowels and consonants in a string.
    """
    vowels = "aeiouAEIOU"
    v = 0
    c = 0

    for ch in text:
        if ch.isalpha():
            if ch in vowels:
                v += 1
            else:
                c += 1

    return v, c


print(count_vowels_consonants("hello"))