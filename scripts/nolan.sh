#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/nulxn/nolan_2025/main"

wget -O _notebooks/2024-09-15-itunes-y-table.ipynb \
    "$BASE_URL/_notebooks/2024-09-15-itunes-y-table.ipynb"

wget -O navigation/calc.md \
    "$BASE_URL/navigation/calc.md"

echo "Files downloaded:"
echo "- _notebooks/2024-09-15-itunes-y-table.ipynb"
echo "- navigation/calc.md"
