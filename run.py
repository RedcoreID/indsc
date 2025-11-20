#!/usr/bin/env python3
from engine import jalankan_kode
import sys, os

def main():
    if len(sys.argv) < 2:
        print("Gunakan: indsc file.isc")
        exit()

    path = sys.argv[1]
    if not os.path.exists(path):
        print("File tidak ditemukan:", path)
        exit()

    with open(path, "r", encoding="utf-8") as f:
        kode = f.read()

    jalankan_kode(kode)

if __name__ == "__main__":
    main()
