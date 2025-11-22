libnifraylib: src/libnifraylib.c
	mkdir -p priv/ && \
	gcc -I/usr/lib64/erlang/usr/include \
	    -lraylib \
	    -shared \
	    -o priv/libnifraylib.so \
	    -fPIC src/libnifraylib.c
