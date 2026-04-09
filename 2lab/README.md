# Lab 2 - Buffer Overflow

## Task 1 - Find the vulnerability
```bash
nano ~/lab/exploit-1.txt
```

## Task 2 - Crash the server
```bash
./clean-env.sh ./zookd 8080 &
chmod +x ~/lab/exploit-2.py
make check-crash
```

## Task 3 - Shellcode
```bash
make
touch ~/grades.txt
./run-shellcode shellcode.bin
ls ~/grades.txt
```

## Task 4 - Inject shellcode
```bash
CMD
./clean-env.sh ./zookd-exstack 8080 &
touch ~/grades.txt
chmod +x ~/lab/exploit-4.py
make check-exstack
ls ~/grades.txt

GDB
Terminal 1:
./clean-env.sh ./zookd-exstack 8080 &
Terminal 2:
gdb -p $(pgrep zookd-exstack)
set follow-fork-mode child
break process_client
continue
Terminal 3:
curl localhost:8080
Terminal 2:
print &reqpath
info frame
```
