FILENAME=zhwiki-latest-all-titles-in-ns0
YAML_HEADER='\n---\nname: zhwiki_pinyin\nversion: "2020.05.23"\n...\n\n\n'
INSTALL_DIR=/usr/share/rime-data

all: build

build: zhwiki_pinyin.dict.yaml

clean:
	rm -f zhwiki_pinyin.raw
	rm -f zhwiki_pinyin.dict.yaml
	rm -f $(FILENAME)
	rm -f $(FILENAME).gz

download: $(FILENAME).gz

$(FILENAME).gz:
	wget https://dumps.wikimedia.org/zhwiki/latest/$(FILENAME).gz

$(FILENAME): $(FILENAME).gz
	gzip -k -d $(FILENAME).gz

zhwiki_pinyin.raw: $(FILENAME)
	grep -P $$'^[\u4e00-\u9fa5]{2,8}$$' $(FILENAME) > zhwiki_pinyin.raw

zhwiki_pinyin.dict.yaml: | zhwiki_pinyin.raw
	printf $(YAML_HEADER) > zhwiki_pinyin.dict.yaml
	cat zhwiki_pinyin.raw >> zhwiki_pinyin.dict.yaml

install: zhwiki_pinyin.dict.yaml
	install -Dm644 zhwiki_pinyin.dict.yaml -t $(DESTDIR)/$(INSTALL_DIR)

uninstall:
	rm -f $(DESTDIR)/$(INSTALL_DIR)/zhwiki_pinyin.dict.yaml 

.PHONY: all build clean install uninstall

