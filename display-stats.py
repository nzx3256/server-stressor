#!/usr/bin/python3

from os import system
import sys

def prompt() -> int:
    while True:
        print("Enter which table to view:\n\t1) cpu\n\t2) vm\n\t3) ramfs\n\t4) hdd\n\t5) aio\n-1) exit\n")
        inp = input("-> ")
        try:
            inp = int(inp)
        except ValueError:
            print("not a number. try again\n")
            continue
        if inp >= 1 and inp <= 5 or inp == -1:
            break
        else:
            print("not an option. try again\n")
    return inp

def main() -> int:
    inp = 0
    while inp != -1:
        inp = prompt()
        filename = ""
        if inp == 1:
            filename = "cputab"
        elif inp == 2:
            filename = "vmtab"
        elif inp == 3:
            filename = "ramfstab"
        elif inp == 4:
            filename = "hddtab"
        elif inp == 5:
            filename = "aiotab"
        else:
            break
        if filename != "":
            system("less "+filename)
            print(filename+" opened\n")
    return 0

if __name__ == "__main__":
    sys.exit(main())
