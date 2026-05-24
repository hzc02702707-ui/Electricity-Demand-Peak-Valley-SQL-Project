import csv
from pathlib import Path

# 这里改成你桌面 sequel 文件夹的真实路径
project_dir = Path.cwd()

raw_path = project_dir / "data_raw" / "eia_caiso_alltypes_2024_07_raw.csv"
clean_path = project_dir / "data_clean" / "eia_caiso_alltypes_2024_07_clean.csv"

clean_path.parent.mkdir(parents=True, exist_ok=True)

with open(raw_path, "r", encoding="utf-8-sig", newline="") as infile:
    reader = csv.DictReader(infile)

    clean_rows = []
    for row in reader:
        clean_rows.append({
            "period": row["period"],
            "respondent": row["respondent"],
            "respondent_name": row["respondent-name"],
            "data_type": row["type"],
            "type_name": row["type-name"],
            "value": row["value"],
            "value_units": row["value-units"]
        })

with open(clean_path, "w", encoding="utf-8-sig", newline="") as outfile:
    fieldnames = [
        "period",
        "respondent",
        "respondent_name",
        "data_type",
        "type_name",
        "value",
        "value_units"
    ]

    writer = csv.DictWriter(outfile, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(clean_rows)

print("清洗完成:", clean_path.resolve())
print("行数:", len(clean_rows))