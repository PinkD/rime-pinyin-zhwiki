# zhwi dictionary for rime

## Install

```bash
git clone https://github.com/PinkD/rime-pinyin-zhwiki
cd rime-pinyin-zhwiki
make -j4 && make install
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

## Thanks

This project is inspired by [felixonmars/fcitx5-pinyin-zhwiki](https://github.com/felixonmars/fcitx5-pinyin-zhwiki)

