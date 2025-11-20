import re

variabel = {}

def tanya(prompt):
    return input(prompt)

def tulis(*args):
    print(*args)

def proses_variabel(expr):
    expr = expr.strip()

    # Angka
    if expr.isdigit():
        return int(expr)

    # String
    if expr.startswith('"') and expr.endswith('"'):
        return expr[1:-1]

    # Variabel
    if expr in variabel:
        return variabel[expr]

    return expr


def jalankan_kode(kode):
    baris = kode.split("\n")
    i = 0

    while i < len(baris):
        line = baris[i].strip()

        if not line:
            i += 1
            continue

        # Tulis (output)
        if line.startswith("tulis "):
            konten = line[6:]
            tulis(proses_variabel(konten))

        # Input
        elif line.startswith("tanya "):
            nama = line.split()[1]
            isi = input("Masukkan {}: ".format(nama))
            variabel[nama] = isi

        # Assign
        elif "=" in line and not line.startswith("jika"):
            nama, nilai = line.split("=", 1)
            variabel[nama.strip()] = proses_variabel(nilai)

        # If
        elif line.startswith("jika "):
            kondisi = line[4:].strip().rstrip(":")
            kondisi_eval = eval(kondisi, {}, variabel)

            # Blok
            block = []
            i += 1
            while i < len(baris) and baris[i].startswith("    "):
                block.append(baris[i][4:])
                i += 1
            i -= 1

            if kondisi_eval:
                jalankan_kode("\n".join(block))

        # Loop
        elif line.startswith("ulang "):
            m = re.match(r"ulang dari (.+) sampai (.+):", line)
            awal = proses_variabel(m.group(1))
            akhir = proses_variabel(m.group(2))

            block = []
            i += 1
            while i < len(baris) and baris[i].startswith("    "):
                block.append(baris[i][4:])
                i += 1
            i -= 1

            for x in range(int(awal), int(akhir)+1):
                variabel["i"] = x
                jalankan_kode("\n".join(block))

        i += 1
