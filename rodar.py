"""Roda um arquivo .sql na base de exemplo (SQLite em memória).

Uso: python rodar.py exercicios.sql
"""
import sqlite3
import sys
from pathlib import Path

AQUI = Path(__file__).parent

conexao = sqlite3.connect(":memory:")
conexao.executescript((AQUI / "base" / "vendas.sql").read_text(encoding="utf-8"))

arquivo = sys.argv[1] if len(sys.argv) > 1 else "gabarito.sql"
comandos = [c.strip() for c in Path(arquivo).read_text(encoding="utf-8").split(";")]

for comando in comandos:
    linhas_sql = [l for l in comando.splitlines() if l.strip() and not l.strip().startswith("--")]
    if not linhas_sql:
        continue
    print("\n→", " ".join(l.strip() for l in linhas_sql)[:100])
    cursor = conexao.execute(comando)
    if cursor.description:
        print(" | ".join(c[0] for c in cursor.description))
        for linha in cursor.fetchall():
            print(" | ".join(str(v) for v in linha))
