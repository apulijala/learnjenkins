import json

file = "repos.txt"
repomatch = "abacus"

with open(file) as fp:
    result = json.load(fp)
    for item in result:
        repo_name = item["name"]
        print(repo_name)

        
    