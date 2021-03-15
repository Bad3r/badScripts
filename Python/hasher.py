from pathlib import Path
import sys
import os
import hashlib
import argparse

# prefix components:
space =  '    '
branch = '│   '
# pointers:
tee =    '├── '
last =   '└── '

  
    
    

def tree(dir_path: Path, prefix: str=''):
    """A recursive generator, given a directory Path object
    will yield a visual tree structure line by line
    with each line prefixed by the same characters
    """
    BUF_SIZE = 65536  # read stuff in 64kb chunks
    contents = list(dir_path.iterdir())
    # contents each get pointers that are ├── with a final └── :
    pointers = [tee] * (len(contents) - 1) + [last]
    for pointer, path in zip(pointers, contents):
        
        if path.is_dir(): # extend the prefix and recurse:
            extension = branch if pointer == tee else space 
            # i.e. space because last, └── , above so no more |
            yield prefix + pointer + path.name
            yield from tree(path, prefix=prefix+extension)
        else:
            md5 = hashlib.md5()
            sha1 = hashlib.sha1()
            try:
                with open(f"{path}", 'rb') as f:
                    while True:
                        data = f.read(BUF_SIZE)
                        if not data:
                            break
                        md5.update(data)
                        sha1.update(data)
                        
                        yield f"MD5={md5.hexdigest()} |\
                            SHA1={sha1.hexdigest()} |\
                                {prefix}{pointer}{path.name}"
            except FileNotFoundError:
                pass
            except PermissionError:
                pass

def main():
    parser = argparse.ArgumentParser(description=
                                     'Hash all files in a given directory \
                                      recursively and print it in tree \
                                      structure')

    for line in tree(Path("/bin")):
        print(line)
    

main()
