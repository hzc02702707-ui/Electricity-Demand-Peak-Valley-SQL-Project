import json
import csv
from pathlib import Path
from urllib.parse import urlencode
from urllib.request import urlopen

# Replace this placeholder with your own EIA API key before running the script.
API_KEY = "YOUR_EIA_API_KEY_HERE"

base_url = "https://api.eia.gov/v2/electricity/rto/region-data/data/"

params = {
    "api_key": API_KEY,
    "frequency": "hourly",
    "data[0]": "value",
    "facets[respondent][]": "CISO",
    "start": "2024-07-01T00",
    "end": "2024-08-01T00",
    "sort[0][column]": "period",
    "sort[0][direction]": "asc",
    "offset": "0",
    "length": "5000"
}

url = base_url + "?" + urlencode(params)

with urlopen(url) as response:
    payload = json.loads(response.read().decode("utf-8"))

rows = payload["response"]["data"]

print("下载行数:", len(rows))
print("字段名:", list(rows[0].keys()))
print("前3行:")
for row in rows[:3]:
    print(row)

# 固定项目文件夹路径
project_dir = Path(r"C:\pythonpro\learning\SQL_Electricity_Project")

# 保存到项目文件夹里的 data_raw 文件夹
out_path = project_dir / "data_raw" / "eia_caiso_alltypes_2024_07_raw.csv"
out_path.parent.mkdir(parents=True, exist_ok=True)

with open(out_path, "w", newline="", encoding="utf-8-sig") as f:
    writer = csv.DictWriter(f, fieldnames=rows[0].keys())
    writer.writeheader()
    writer.writerows(rows)

print("保存成功:", out_path.resolve())