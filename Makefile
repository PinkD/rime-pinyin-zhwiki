FILENAME=zhwiki-latest-all-titles-in-ns0
YAML_HEADER='\n---\nname: zhwiki_pinyin\nversion: "2020.05.23"\n...\n\n\n'

all: build

build: zhwiki_pinyin.dict.yaml

clean:
	rm -f zhwiki_pinyin.raw
	rm -f zhwiki_pinyin.dict.yaml
	rm -f $(FILENAME).1 $(FILENAME).2 $(FILENAME).3 $(FILENAME).4
	rm -f $(FILENAME).split
	rm -f $(FILENAME).out
	rm -f $(FILENAME)
	rm -f $(FILENAME).gz

download: $(FILENAME).gz

$(FILENAME).gz:
	wget https://dumps.wikimedia.org/zhwiki/latest/$(FILENAME).gz

$(FILENAME): $(FILENAME).gz
	gzip -k -d $(FILENAME).gz

$(FILENAME).out: $(FILENAME)
	grep -P $$'^[\u4e00-\u9fa5]{2,8}$$' $(FILENAME) > $(FILENAME).out

$(FILENAME).split: $(FILENAME).out
	split -n l/4 $(FILENAME).out
	touch $(FILENAME).split

$(FILENAME).1: $(FILENAME).split
	opencc -c /usr/share/opencc/t2s.json -i xaa -o $(FILENAME).1
	rm -f xaa

$(FILENAME).2: $(FILENAME).split
	opencc -c /usr/share/opencc/t2s.json -i xab -o $(FILENAME).2
	rm -f xab

$(FILENAME).3: $(FILENAME).split
	opencc -c /usr/share/opencc/t2s.json -i xac -o $(FILENAME).3
	rm -f xac

$(FILENAME).4: $(FILENAME).split
	opencc -c /usr/share/opencc/t2s.json -i xad -o $(FILENAME).4
	rm -f xad
	
zhwiki_pinyin.raw: | $(FILENAME).1 $(FILENAME).2 $(FILENAME).3 $(FILENAME).4
	cat $(FILENAME).1 $(FILENAME).2 $(FILENAME).3 $(FILENAME).4 > zhwiki_pinyin.raw

zhwiki_pinyin.dict.yaml: | zhwiki_pinyin.raw
	printf $(YAML_HEADER) > zhwiki_pinyin.dict.yaml
	cat zhwiki_pinyin.raw >> zhwiki_pinyin.dict.yaml

install: zhwiki_pinyin.dict.yaml
	install -Dm644 zhwiki_pinyin.dict.yaml -t $(DESTDIR)/usr/share/rime-data/

uninstall:
	rm -f $(DESTDIR)/usr/share/rime-data/zhwiki_pinyin.dict.yaml 

.PHONY: all build clean install uninstall

