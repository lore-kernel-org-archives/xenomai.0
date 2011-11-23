From: Erik Sommer <erik.sommer@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 23 Nov 2011 10:38:49 +0100
Message-Id: <1322041129.15019.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] can't link math.h in a userspace programm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I'm programming a userspace Xenomai-Programm für a Xilinx PowerPC
(additional Information without FPU). I include the math.h because I
have to use arcustangens and arcuscosinus. When compiling the programm
it seems so like the linker can't do his job for math.h.

minimal example:

"
#include <stdbool.h>// boolescher Datentyp
#include <native/task.h>
#include <native/timer.h>
#include <rtdm/rtdm.h>
#include <sys/mman.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <math.h>

void user_task(void *cookie){
...
Vektor.y_w=0.5*atan(Vektor.y/reg->l_O);
...
}
"

the Makefile:

"
# Name der zu erstellenden Programmdatei
PROG=pu10_Las_Vek

# Liste der C-Dateien im Verzeichnis
C_DAT=$(wildcard *.c)


# Variablen für die Benutzung des ELDK-Compilers
ARCH=powerpc

#Xenomai Installations Pfad
DESTDIR=../usersupport/root
#DESTDIR=/mnt/albatros_projekte/PU10/pu10_sw/PU10_Xenomai/xenomai_build/root
XENO := $(DESTDIR)/usr/xenomai

XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config
2>/dev/null)

CC=$(shell $(XENOCONFIG) --cc)

CFLAGS=$(shell export DESTDIR="$(DESTDIR)"; $(XENOCONFIG) --skin native
--cflags) $(MY_CFLAGS)

LDFLAGS=$(shell export DESTDIR="$(DESTDIR)"; $(XENOCONFIG) --skin native
--ldflags) $(MY_LDFLAGS) -lnative -lrtdm

#Xenomai Library Pfad in binary hinzufügen
LPATH=/usr/xenomai/lib
#LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)
LDFLAGS+=-Xlinker -rpath -Xlinker $(LPATH) 

$(PROG):: 
	$(CC) -Wall $(CFLAGS) $(LDFLAGS) -L/usr/lib -I/usr/include
$(C_DAT) ../defines.h ../regbank.h -o $(PROG)	

clean::
	$(RM) $(PROG) *.o
"

I hope for some hints.

Erik 




