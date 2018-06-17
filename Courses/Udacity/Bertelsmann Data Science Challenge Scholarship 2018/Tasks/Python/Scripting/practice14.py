"""
Handling Input Errors
The party_planner function below takes as input a number of party people and cookies and figures out how many cookies each person gets at the party, assuming equitable distribution of cookies. 
Then, it returns that number along with how many cookies will be left over.

Right now, calling the function with an input of 0 cookies will cause an error, because it creates a ZeroDivisionError exception. 
Edit the party_planner function to handle this invalid input. If it runs into this exception, it should print a warning message to the user and request they input a different number of people.

After you've edited the function, try running the file again and make sure it does what you intended. Try it with several different input values, including 0 and other values for the number of people.

Using this workspace
In some pages of our classroom, we'll provide you a workspace like the one below that will provide you a programming environment with a Terminal and code editor, so you can do all your work right here. 
Here are a few tips orienting you to this kind of workspace.

On the top panel is a code editor where you can edit your Python file. Scroll up and down in this panel to see all the code. You can also expand or shrink this panel by clicking and dragging its bottom border.

On the bottom panel, you can execute this Python file by clicking on New Terminal and entering python handling_errors.py on the command line.
"""

def party_planner(cookies, people):
    leftovers = None
    num_each = None
    try:
        num_each = cookies // people
        leftovers = cookies % people
    except ZeroDivisionError as fail:
        print("ZeroDivisionError occurred: {}".format(fail))

    return(num_each, leftovers)

# The main code block is below; do not edit this
lets_party = 'y'
while lets_party == 'y':

    cookies = int(input("How many cookies are you baking? "))
    people = int(input("How many people are attending? "))

    cookies_each, leftovers = party_planner(cookies, people)

    if cookies_each:  # if cookies_each is not None
        message = "\nLet's party! We'll have {} people attending, they'll each get to eat {} cookies, and we'll have {} left over."
        print(message.format(people, cookies_each, leftovers))

    lets_party = input("\nWould you like to party more? (y or n) ")