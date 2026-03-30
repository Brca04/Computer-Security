# 1. laboratorijska vjezba iz kolegija Sigurnost računalnih sustava
# Bruno Cavor, 0036557489

import json
import base64
from Crypto.Protocol.KDF import PBKDF2
from Crypto.Hash import SHA512
from Crypto.Random import get_random_bytes
from Crypto.Cipher import AES

strg = "db.json" # Datoteka u koju je pohranjena baza podataka
script = False

def save(v): # Spremanje baze podataka
    with open(strg, "w") as f:
        json.dump(v, f, indent=4)

def load(): # Citanje baze podataka
    try:
        with open(strg) as f:
            return json.load(f)
    except:
        return None

def encrypt_db(db, master):
    salt = get_random_bytes(16)
    key = PBKDF2(master, salt, 32, count=1000000, hmac_hash_module=SHA512) # Derivacija kljuca uz pomoc PBKDF2 algoritma i SHA512 hash funkcijom
    cipher = AES.new(key, AES.MODE_GCM) 
    ct, tag = cipher.encrypt_and_digest(json.dumps(db).encode()) # Enkripcija baze podataka AES-om i dobivanje tag-a za autentifikaciju

    return {
        "salt": base64.b64encode(salt).decode(),
        "nonce": base64.b64encode(cipher.nonce).decode(),
        "tag": base64.b64encode(tag).decode(),
        "ct": base64.b64encode(ct).decode()
    }

def decrypt_db(tmp, master):
    try:
        salt = base64.b64decode(tmp["salt"].encode())
        nonce = base64.b64decode(tmp["nonce"].encode())
        tag = base64.b64decode(tmp["tag"].encode())
        ct = base64.b64decode(tmp["ct"].encode())

        key = PBKDF2(master, salt, 32, count=1000000, hmac_hash_module=SHA512) # Derivacija kljuca uz pomoc PBKDF2 algoritma i SHA512 hash funkcijom
        cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
        pt = cipher.decrypt_and_verify(ct, tag) # Dekripcija baze podataka AES-om i provjera integriteta pomocu tag-a

        return json.loads(pt.decode())
    except:
        return None
    
def text_checker(text):
    if (len(text) > 255):
            print("Master password too long. Must be shorter than 255 characters.")
            return False
    
    for c in text:
        if ord(c) < 33 or ord(c) > 127:
            print("Invalid character in input. Only ASCII characters allowed.")
            return False

    return True

print("Commands: init, put, get, exit\n")

while True:
    cmd = input("$ ./tajnik ").strip().split() # Unos naredbi kroz naredbeni redak

    if not cmd:
        continue

    if cmd[0] == "script":
        script = not script
        continue
    
    if script:
        print(f" {' '.join(cmd)}")

    if cmd[0] == "exit": # Naredba za gasenje sustava
        break

    if cmd[0] == "init": # Naredba za inicijalizaciju sustava
        
        if len(cmd) != 2:
            print("Usage: init <master>")
            continue

        if not text_checker(cmd[1]):
            continue

        tmp = encrypt_db({}, cmd[1])
        save(tmp)
        print("Password manager initialized.")

    elif cmd[0] == "put": # Naredba za dodavanje/izmjenu zaporki spremljenih na adresi 

        if len(cmd) != 4:
            print("Usage: put <master> <site> <password>")
            continue

        if not text_checker(cmd[1]) or not text_checker(cmd[2]) or not text_checker(cmd[3]):
            continue

        tmp = load()
        if not tmp:
            print("tmp not initialized.")
            continue

        db = decrypt_db(tmp, cmd[1])

        if db is None:
            print("Master password incorrect or integrity check failed.")
            continue

        db[cmd[2]] = cmd[3]
        save(encrypt_db(db, cmd[1]))
        print(f"Stored password for {cmd[2]}.")

    elif cmd[0] == "get": # Naredba za dohvacanje zaporke spremljene na adresi

        if len(cmd) != 3:
            print("Usage: get <master> <site>")
            continue

        if not text_checker(cmd[1]) or not text_checker(cmd[2]):
            continue

        tmp = load()
        if not tmp:
            print("tmp not initialized.")
            continue

        db = decrypt_db(tmp, cmd[1])
        if db is None:
            print("Master password incorrect or integrity check failed.")
            continue

        if cmd[2] in db:
            print(f"Password for {cmd[2]} is: {db[cmd[2]]}.")
        else:
            print("No password stored.")

    else: # Nepoznata naredba
        print("Unknown command.")