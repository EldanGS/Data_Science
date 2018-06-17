"""
You can try out this example by creating your own camelot.txt and example.py files with the text above.

Each time we called read on the file with an integer argument, it read up to that number of characters, outputted them, and kept the 'window' at that position for the next call to read. This makes moving around in the open file a little tricky, as there aren't many landmarks to navigate by.

Reading Line by Line
\ns in blocks of text are newline characters. The newline character marks the end of a line, and tells a program (such as a text editor) to go down to the next line. However, looking at the stream of characters in the file, \n is just another character.

Fortunately, Python knows that these are special characters and you can ask it to read one line at a time. Let's try it!
"""

"""
Use the relevant part of the Python documentation to find a method that reads the next line of a file. 
Put the name of the method in the box.
"""

# ans => readline()



"""
Quiz: Flying Circus Cast List
You're going to create a list of the actors who appeared in the television programme Monty Python's Flying Circus.

Write a function called create_cast_list that takes a filename as input and returns a list of actors' names. 
It will be run on the file flying_circus_cast.txt (this information was collected from imdb.com). Each line of that file consists of an actor's name, a comma, and then some (messy) information about roles they played in the programme. You'll need to extract only the name and add it to a list. 
You might use the .split() method to process each line.
"""

def create_cast_list(filename):
    cast_list = []
    with open("flying_circus_cast.txt", "r") as file:
        for line in file:
            name = line.split(',')
            cast_list.append(name[0])

    return cast_list

cast_list = create_cast_list('flying_circus_cast.txt')
for actor in cast_list:
    print(actor)
