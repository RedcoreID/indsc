#!/usr/bin/env python
from engine import jalankan_kode
import sys

if len(sys.argv) < 2:
    print("Gunakan: indsc file.isc")
    sys.exit()

with open(sys.argv[1]) as f:
    jalankan_kode(f.read())
