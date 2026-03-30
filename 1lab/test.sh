#!/bin/bash

# Pretpostavke:
# - instaliran Python 3.6 ili noviji
# - 1lab.py se nalazi u istom direktoriju kao test.sh
# - pycryptodome je instaliran (pip install pycryptodome)

# Upute za pokretanje:
# 1. Instaliran Python 3.6 ili noviji.
# 2. Instalirano i aktivirano virtualno okruženje (ako se koristi).
# 3. Instalirati pycryptodome ako već nije instaliran: pip install pycryptodome
# 4. Prije pokretanja skripte izvršiti: chmod +x test.sh
# 5. Pokretanje skripte: ./test.sh

PYTHON_FILE="1lab.py"

if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: python3 is not installed."
    exit 1
fi

if [ ! -f "$PYTHON_FILE" ]; then
    echo "Error: $PYTHON_FILE not found."
    exit 1
fi

echo "===== TEST 1: init prazne baze ====="
{
echo "script"
echo "init Master"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 2: spremanje i dohvat jedne zaporke ====="
{
echo "script"
echo "init Master"
echo "put Master gmail pass123"
echo "get Master gmail"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 3: zamjena postojeće zaporke ====="
{
echo "script"
echo "init Master"
echo "put Master gmail pass123"
echo "get Master gmail"
echo "put Master gmail pass456"
echo "get Master gmail"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 4: više različitih adresa ====="
{
echo "script"
echo "init Master"
echo "put Master gmail pass123"
echo "put Master fer.hr tajnaFER"
echo "put Master github.com ghSecret"
echo "get Master gmail"
echo "get Master fer.hr"
echo "get Master github.com"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 5: pogrešna master zaporka ====="
{
echo "script"
echo "init Master"
echo "put Master gmail pass123"
echo "get KriviMaster gmail"
echo "put KriviMaster fer.hr nekaZaporka"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 6: dohvat nepostojeće adrese ====="
{
echo "script"
echo "init Master"
echo "put Master gmail pass123"
echo "get Master yahoo"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 7: posebni ASCII znakovi u adresi i zaporci ====="
{
echo "script"
echo "init Master"
echo "put Master abc-XYZ_123.site P@ss!#\$%^&*()_+-=[]{}|;:,.<>/?"
echo "get Master abc-XYZ_123.site"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 8: neispravni ulazi ====="
LONG_ADDR=$(python3 - <<'PY'
print("P"*256 + ".com")
PY
)
LONG_PASS=$(python3 - <<'PY'
print("P"*256)
PY
)
{
echo "script"
echo "init ${LONG_PASS}"
echo "init Master"
echo "put Master $LONG_ADDR pass123"
echo "get Master $LONG_ADDR"
echo "put Master gmail č"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 9: podaci ostaju spremljeni između pokretanja ====="
{
echo "script"
echo "init Master"
echo "put Master gmail pass123"
echo "put Master fer.hr tajnaFER"
echo "exit"
} | python3 "$PYTHON_FILE"

{
echo "script"
echo "get Master gmail"
echo "get Master fer.hr"
echo "exit"
} | python3 "$PYTHON_FILE"

echo
echo "===== TEST 10: ponovni init briše/staru bazu resetira ====="
{
echo "script"
echo "init Master"
echo "put Master gmail pass123"
echo "exit"
} | python3 "$PYTHON_FILE"

{
echo "script"
echo "init NoviMaster"
echo "get Master gmail"
echo "get NoviMaster gmail"
echo "exit"
} | python3 "$PYTHON_FILE"
