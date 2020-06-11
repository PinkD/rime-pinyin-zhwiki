# zhwi dictionary for rime

## Install

```bash
git clone https://github.com/PinkD/rime-pinyin-zhwiki
cd rime-pinyin-zhwiki
make && make install
# or you can use `make VERSION=20200601` to build specified version instead of the latest
```

> NOTE: you need to modify install dir in Makefile depending on your os release

### Arch Linux

use [aur](https://aur.archlinux.org/packages/rime-pinyin-zhwiki/)

## Usage

add `zhwiki_pinyin` into your dictionary table in rime config file


create a custom config named like `luna_pinyin.custom.yaml` under `.config/fcitx/rime` (may be different for fcitx5):
```yaml
patch:
  translator/dictionary: luna_pinyin.extended
```

create `luna_pinyin.extended.dict.yaml` to define dictionary:
```yaml
---
name: luna_pinyin.extended
version: 'v0.1-20200524'
sort: by_weight
use_preset_vocabulary: true
import_tables:
  - 'luna_pinyin'
  - 'zhwiki_pinyin'
...
```

> NOTE: double_pinyin also uses luna_pinyin as dictionary

redeploy RIME and enjoy

> Tested for luna_pinyin by me and double_pinyin by haruue

### remove words by word frequency manually

```bash
# make raw
make zhwiki_pinyin.raw

# convert tc to sc because jieba doesn't support tc
opencc -c /usr/share/opencc/t2s.json -i zhwiki_pinyin.raw -o zhwiki_pinyin.sc

# count word frequency(requires jieba)
python word_frequency.py

# sort by count
sort -rn result.txt > result0.txt
sort -rn result.txt | awk -F ':' '{print $1":"$2}' > result1.txt

# use grep to exclude words you want to
grep -v "xxx" zhwiki_pinyin.sc > zhwiki_pinyin.txt

# convert sc back to tc
opencc -c /usr/share/opencc/s2t.json -i zhwiki_pinyin.txt -o zhwiki_pinyin.raw

# clean
rm -f *.txt

# make
make
```

## Thanks

This project is inspired by [felixonmars/fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki)

## Change list

- latest
  - add word_frequency.py for excluding useless words manually
- 0.2: 
  - remove manually convert tc to sc with opencc because RIME will do that automatically
  - limit word len from 2 to 8
- 0.1: first release

