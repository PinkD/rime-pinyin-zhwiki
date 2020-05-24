import jieba
from collections import defaultdict


def cut(s: str) -> list:
    return jieba.cut(s)


word_map = defaultdict(list)

if __name__ == '__main__':
    with open("zhwiki_pinyin.sc", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            words = cut(line)
            for word in words:
                word_map[word].append(line)
    with open("result.txt", mode="w", encoding="utf-8") as f:
        for word, lines in word_map.items():
            if len(word) == 1:
                continue
            f.write(f"{len(lines)}:{word}:{lines}\n")

