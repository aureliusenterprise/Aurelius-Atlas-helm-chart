import requests
import argparse
from urlpath import URL


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--token", "-t", required=True, help="Atlas access token", type=str)
    parser.add_argument("--base-url", "-u", default="https://aureliusdev.westeurope.cloudapp.azure.com/demo/atlas2/", help="Apache Atlas base url", type=URL)
    parser.add_argument("--output", "-o", default="out.zip", help="Output zip file", type=str)
    return parser.parse_args()


def get_entity_types(base_url, base_headers={}):
    url = base_url / "v2/types/typedefs"
    response = requests.get(url.as_uri(), headers=base_headers)
    data = response.json()
    return [entity["name"] for entity in data["entityDefs"] if entity["category"] == "ENTITY"]


def export(entity_types, base_url, output, base_headers={}):
    headers = base_headers.copy()
    body = {"itemsToExport": []}
    for entity in entity_types:
        body["itemsToExport"].append({"typeName": entity, "uniqueAttributes": {"qualifiedName": ".*"}})

    body["options"] = {"matchType": "matches"}
    headers["Content-Type"] = "application/json"
    headers["Cache-Control"] = "no-cache"
    url = base_url / "admin/export"
    
    response = requests.post(url.as_uri(), json=body, headers=headers)
    with open(output, "wb") as handler:
        handler.write(response.content)


def main():
    args = parse_args()
    base_url = args.base_url / "api/atlas"
    headers = { "Authorization": f"Bearer {args.token}" }
    print(headers)
    print("Getting all entity types")
    entity_types = get_entity_types(base_url, headers)
    print("Exporting entities")
    export(entity_types, base_url, args.output, headers)
    print("Done!")


if __name__ == "__main__":
    main()
