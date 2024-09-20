#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/nulxn/nolan_2025/main"

curl -o _notebooks/2024-09-15-itunes-y-table.ipynb \
     "$BASE_URL/_notebooks/2024-09-15-itunes-y-table.ipynb"

curl -o navigation/calc.md \
     "$BASE_URL/navigation/calc.md"

curl -o navigation/cookie.md \
     "https://gist.githubusercontent.com/nulxn/6c532de73da755d0efcfd085c5cc8ac9/raw/6656818cc94cf1fb346ccd4d79b8b315480b3a43/cookie.md"

curl -o assets/ka-ching.mp3 \
     "https://github.com/nulxn/nolan_2025/raw/main/images/brown/ka-ching.mp3"

echo "Files downloaded:"
echo "- _notebooks/2024-09-15-itunes-y-table.ipynb"
echo "- navigation/calc.md"
echo "- navigation/cookie.md"
echo "- assets/ka-ching.mp3"
