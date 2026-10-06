#!/usr/bin/python
import sys
import pysubs2

if len(sys.argv) == 1:
    print(sys.argv[0], 'files')
    exit(1)

keys: list[str] = ["ScriptType", "PlayResX", "PlayResY"]

for ass in sys.argv[1:]:
    sub: pysubs2.SSAFile = pysubs2.load(ass)
    sub.aegisub_project = {}
    sub.info = {i: j for i, j in sub.info.items() if i in keys}
    events: list[pysubs2.SSAEvent] = []
    for line in sub.events:
        if (line.type == "Dialogue") and (line.end - line.start) and line.text:
            events.append(line)
    sub.events = events
    sub.sort()
    sub.save(ass)
