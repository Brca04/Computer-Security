# Lab 2 - Buffer Overflow

## Task 1 - Find the vulnerability
```bash
nano ~/lab/exploit-1.txt
```

## Task 2 - Crash the server
```bash
./clean-env.sh ./zookd 8080 &
./exploit-2.py localhost 8080
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
./clean-env.sh ./zookd-exstack 8080 &
touch ~/grades.txt
./exploit-4.py localhost 8080
ls ~/grades.txt
make check-exstack
```
