import re

variabel = {}

def proses_nilai(expr):
    expr = expr.strip()

    # String
    if expr.startswith('"') and expr.endswith('"'):
        return expr[1:-1]

    # Angka
    if re.match(r"^-?\d+$", expr):
        return int(expr)

    # List
    if expr.startswith("[") and expr.endswith("]"):
        return [proses_nilai(x) for x in expr[1:-1].split(",")]

    # Map
    if expr.startswith("{") and expr.endswith("}"):
        hasil = {}
        for item in expr[1:-1].split(","):
            k, v = item.split(":")
            hasil[k.strip()] = proses_nilai(v.strip())
        return hasil

    return variabel.get(expr, expr)


def akses(expr):
    if "[" in expr and expr.endswith("]"):
        nama = expr[:expr.index("[")]
        idx = int(expr[expr.index("[")+1:-1])
        return variabel[nama][idx]

    if "." in expr:
        nama, key = expr.split(".", 1)
        return variabel[nama][key]

    return variabel.get(expr, expr)


def jalankan_kode(kode):
    for line in kode.split("\n"):
        line = line.strip()
        if not line: continue

        if line.startswith("tulis "):
            val = line[6:].strip()
            print(akses(val))
            continue

        if line.startswith("tanya "):
            nama = line.split()[1]
            variabel[nama] = input("Masukkan {}: ".format(nama))
            continue

        if "=" in line:
            k, v = line.split("=", 1)
            variabel[k.strip()] = proses_nilai(v)
            continue
