from Jumpscale import j
import json
import sys

if len(sys.argv) > 1:
    if sys.argv[1] == 'supports':
        # sys.argv[2] is the renderer name
        sys.exit(0)

context, book = json.load(sys.stdin)
book_toml=j.data.serializers.toml.dumps(book)
def write(book):
    x=1
    while j.core.tools.exists(f"/tmp/data_{x}.toml"):
        x+=1
    j.core.tools.file_write(f"/tmp/data_{x}.toml",book)
write(book_toml)
j.core.tools.file_write("/tmp/context.json",str(context))
json.dump(book, sys.stdout)

