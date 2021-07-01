LUA_DIR = -I/usr/local/openresty/luajit/include/luajit-2.1
OBJS := src/cluacov/deepactivelines.o src/cluacov/hook.o
C_SO_NAME := src/cluacov/deepactivelines.so src/cluacov/hook.so
CFLAGS := -O2 -fPIC -DLJ_GC64
LDFLAGS := -shared

INSTALL_DIR = /usr/local/lib/lua/5.1/cluacov
INSTALL ?= install

.PHONY: default
default: build

build: ${C_SO_NAME}

${OBJS} : %.o : %.c
	$(CC) $(CFLAGS) $(LUA_DIR) -c $< -o $@

${C_SO_NAME} : ${OBJS}
	$(CC) $(LDFLAGS) $(OBJS) -o $@

install:
	$(INSTALL) $(C_SO_NAME) $(INSTALL_DIR)/

clean:
	rm -f src/cluacov/*.o rm  src/cluacov/*.so
