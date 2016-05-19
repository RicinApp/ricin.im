#!/bin/sh
##
# COPYRIGHT (c) 2016 SkyzohKey <skyzohkey@protonmail.com>
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##

if [ -z "$1" ]; then
  echo -e "usage: $0 <output_file.min.css>"
  echo -e "ie. $0 static/styles/file.min.css"
  exit 1
fi;

FILE=$1
DIR=$(dirname $1)

# Remove old minified file.
rm -f $1

# Merge files into one.
cat ${DIR}/*.css > $1
echo -e "Wow, files got merged into $1 so much faster!"

# Minify css.
cat $1 \
  | tr '\r\n' ' ' \
  | perl -pe 's:/\*.*?\*/::g' \
  | sed \
    -e 's/\s\+/ /g' \
    -e 's/\([#\.:]\)\s\?/\1/g' \
    -e 's/\s\?\([;{}]\)\s\?/\1/g' \
    -e 's/\s\?\([,!+~>]\)\s\?/\1/g' \
    -e 's/;}/}/g' \
    -e 's/0\(\.[0-9]\)/\1/g' \
    -e 's/\(background\|outline\|border\(-left\|-right\|-top\|-bottom\)\?\):none\b/\1:0/g' \
    -e 's/}[^{]\+{}/}/g' \
  > $1

echo -e "Yay! $1 was created with much fucking success!"
exit 0
