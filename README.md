# dndbeyond_to_json
This scrapes a dndbeyond fillable pdf and puts it in a JSON format for tableplop, it works with Powershell 5.1.

# Instructions:
1. Using command/powershell: powershell.exe -file dndbeyond_to_tableplop.ps1 [-folder <folder>] [-file <file>]
  1.1. If you're just using one file you can call it without a tag: powershell.exe -file dndbeyond_to_tableplop.ps1 <file>
2. Tada, you now have a json, upload that puppy to tableplop and get to gaming!

# Notable limitations: 
1. This does not *update* a character in tableplop, it completely writes over it! I strongly recommend you load it into a new character and delete/archive the old one once you're sure you have everything.
2. dndbeyond doesn't export the damage or heal amounts for spells, so those have to be input manually after creation (down with the capitalist pigs!)
3. It doesn't import a lot of the flavor stuff (like bonds, flaws, etc), I plan on adding this in the future, just not a high priority
4. A lot of stuff isn't explicitly ordered by ranks, rather it relies on being in the right order, so if you fiddle around with it be warned it might change how it displays on the screen


# General notes:
1. Want something specific? Feel free to hit me up on discord (.joebob.).
2. Want to tip me for making your life easier? Also hit me up on discord, after I confirm you're not crazy I'll happily take free money!
