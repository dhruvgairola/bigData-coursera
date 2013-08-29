#!/usr/bin/env python
import mincemeat
import glob

text_files = glob.glob("../hw3data/*")

def file_contents(file_name):
    f = open(file_name)
    try:
        return f.read()
    finally:
        f.close()
        
datasource = dict((file_name, file_contents(file_name))
                for file_name in text_files)

def mapfn(k, v):
    for line in v.splitlines():
        chunks = line.split(":::")
        for w in chunks[1].split("::"):
            for w2 in chunks[2].split(" "):
                for w3 in w2.split("-"):
                    yield w, w3

def reducefn(k, vs):
    import stopwords
    import re
    from collections import Counter
    
    cnt = Counter()
    for word in vs:
        if len(word) > 1:
            word = re.sub(r"\.|,", "", word)
            if word not in stopwords.allStopWords:
                cnt[word] += 1
    return cnt

s = mincemeat.Server()
s.datasource = datasource
s.mapfn = mapfn
s.reducefn = reducefn

results = s.run_server(password="changeme")
print(results)