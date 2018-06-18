"""
Quiz: Password Generator
Write a function called generate_password that selects three random words from the list of words word_list and concatenates them into a single string. 
Your function should not accept any arguments and should reference the global variable word_list to build the password.
"""

import random 
# Use an import statement at the top

word_file = "words.txt"
word_list = []

#fill up the word_list
with open(word_file,'r') as words:
	for line in words:
		# remove white space and make everything lowercase
		word = line.strip().lower()
		# don't include words that are too long or too short
		if 3 < len(word) < 8:
			word_list.append(word)

# Add your function generate_password here
# It should return a string consisting of three random words 
# concatenated together without spaces
def generate_password():
    password = ""
    for _ in range(3):
        index = random.randint(0, len(word_list) - 1)
        password += word_list[index]
    
    return password

# test your function
print(generate_password())



# Author implementation
"""
Quiz Solution: Password Generator
To create random passwords we used import random. The function definition was simply:
"""

def generate_password():
    return random.choice(word_list) + random.choice(word_list) + random.choice(word_list)
Alternatively, you could use the random.sample function and .join method for strings:

def generate_password():
    return ''.join(random.sample(word_list,3))