from random import randrange, shuffle
from sys import argv


def set_up_game(help_me, ordered_roles, give_me_roles,shuffle):
    # if len(argv) < 2 or argv[1] in ['--help', 'help', '-h']:
    #     help_me()
    nPlayers = int(argv[1])
    if nPlayers > len(ordered_roles):
        print("Too many players, mafia doesn't support a game with", nPlayers, "player.")
        help_me()
    roles = give_me_roles(ordered_roles[:nPlayers])
    shuffle(roles)
    admin_key = generate_admin_password()
    print("_" * 20 + "GOD's password" + "_" * 20)
    print(admin_key)
    print("_" * 54)

## Function to generate admin password 
def generate_admin_password():
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789!@#$%^&*()"
    preshared_key = ''
    for i in range(4):
        preshared_key += chars[randrange(0, len(chars))]
    return preshared_key