#!/usr/bin/env python3

import os
import sys
import errno
from fuse import FUSE, FuseOSError, Operations

class SimpleFS(Operations):
    def __init__(self, root):
        self.root = root

    def _full_path(self, partial):
        if partial.startswith("/"):
            partial = partial[1:]
        return os.path.join(self.root, partial)

    def getattr(self, path, fh=None):
        full_path = self._full_path(path)
        st = os.lstat(full_path)
        return dict((key, getattr(st, key)) for key in ('st_atime', 'st_ctime',
                    'st_gid', 'st_mode', 'st_mtime', 'st_nlink', 'st_size', 'st_uid'))

    def readdir(self, path, fh):
        full_path = self._full_path(path)
        dirents = ['.', '..']
        if os.path.isdir(full_path):
            dirents.extend(os.listdir(full_path))
        for r in dirents:
            yield r

    def read(self, path, size, offset, fh):
        with open(self._full_path(path), 'rb') as f:
            f.seek(offset)
            return f.read(size)

    def write(self, path, buf, offset, fh):
        with open(self._full_path(path), 'r+b') as f:
            f.seek(offset)
            f.write(buf)
        return len(buf)

def main(mountpoint, root):
    FUSE(SimpleFS(root), mountpoint, nothreads=True, foreground=False)

if __name__ == '__main__':
    main(sys.argv[2], sys.argv[1])
