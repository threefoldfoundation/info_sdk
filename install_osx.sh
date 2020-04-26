#!/bin/bash
set -ex
cd $TMPDIR
rm -f *tfwiki
wget https://github.com/threebotserver/publishingtools/releases/download/v1.0/tfwiki
cp tfwiki /usr/local/bin
