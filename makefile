EXEC_NAME=TCL-Drone #output filename

SDK_DIR=/home/alvin/Documents/Code/parrot/out/arsdk-native/staging/usr
IDIR=./
CC=gcc
CFLAGS=-I $(IDIR) -I $(SDK_DIR)/include

OBJDIR=obj
LDIR = $(SDK_DIR)/lib

EXTERNAL_LIB=-lncurses -lavutil -lavcodec -lavformat

LIBS=-L$(SDK_DIR)/lib -larcommands -larcontroller -lardiscovery -larnetwork -larnetworkal -larsal -larstream -larstream2 -larmavlink -ljson -larmedia -larutils -lcurl -lardatatransfer -lcrypto -lssl $(EXTERNAL_LIB)

_DEPS = DecoderManager.h ihm.h BebopDroneDecodeStream.h 
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = DecoderManager.o ihm.o BebopDroneDecodeStream.o
OBJ = $(patsubst %,$(OBJDIR)/%,$(_OBJ))

$(OBJDIR)/%.o: %.c $(DEPS)
	@ [ -d $(OBJDIR) ] || mkdir $(OBJDIR)
	@ $(CC) -c -o $@ $< $(CFLAGS)

$(EXEC_NAME): $(OBJ)
	gcc -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	@ rm -f $(OBJDIR)/*.o *~ core $(INCDIR)/*~
	@ rm -rf $(OBJDIR)
	@ rm -r $(EXEC_NAME)

run:
	LD_LIBRARY_PATH=$(LDIR) ./$(EXEC_NAME)