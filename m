From: "Mauro S." <mau.salvi@tin.it>
Subject: Xeno3-x86: system freezes with SEGFAULT
Message-ID: <89a388f9-f30b-59d5-7a6f-e46026793089@tin.it>
Date: Mon, 28 Jun 2021 16:33:13 +0200
MIME-Version: 1.0
Content-Language: it-IT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I'm using Xenomai3 (master branch, commit =

d98c99798836dd3571144203b51ff787d2108f1b) on a X86_64bit Intel Atom =

x5-E8000 with 2GB RAM, using kernel from Xenomai repos, in Cobalt =

coniguration.
Just for completeness, I'm using a Yocto built filesystem (but I think =

it doesn't matter to the issue that I'm going to describe).

Consider the simple test program attached: it creates 120 tasks that =

does nothing than sleep. This test is compiled with the Yocto toolchain =

using the attached makefile. Toolchain have Xenomai installed in.

(By the way, I needed to raise to 2048 the registry slots number in =

kernel configuration: without raising this, I cannot create more than =

110 tasks.)

If I kill this program with TERM signal, sighandler does its work and =

the application exits cleanly.

If I kill this application with SEGV signal (no custom sighandler =

installed), system freezes.

If I build this application with 50 tasks, then SEGV does not cause =

system to freeze.

Bisecting the number of tasks, SIGSEGV freezes starts with a number of =

tasks greater than 85.

I enabled watchdog (and almost all of the debug options) in Xenomai =

section of the kernel configuration, without success.

Are there some system limits? I checked under /proc/xenomai but all =

seems to be OK.

Thanks in advance, regards

-- =

Mauro




-------------- next part --------------
APP =3D test

APP_OBJS =3D main.o

### Default Xenomai installation path
XENO ?=3D $(OECORE_TARGET_SYSROOT)/usr

XENOCONFIG =3D DESTDIR=3D$(OECORE_TARGET_SYSROOT) $(shell PATH=3D$(XENO):$(=
XENO)/bin:$(PATH) which xeno-config 2>/dev/null)

## Sanity check
ifeq ($(XENOCONFIG),)
all:
	@echo ">>> Invoke make like this: \"make XENO=3D/path/to/xeno-config\" <<<"
	@echo
endif

APP_CFLAGS =3D -c -Wall -g -Wconversion -Wno-unused-parameter -Wextra -O3

APP_CFLAGS  :=3D $(shell $(XENOCONFIG) --skin=3Dalchemy --cflags) $(APP_CFL=
AGS)
APP_LDFLAGS :=3D $(shell $(XENOCONFIG) --skin=3Dalchemy --ldflags) $(APP_LD=
FLAGS)

DEPS =3D $(LIBDATA_OBJS:.o=3D.d)

.PHONY : all clean

all : $(APP)

$(APP) : $(APP_OBJS)
	$(CC) $(APP_OBJS) $(APP_LDFLAGS) -o $(APP)

-include $(DEPS)

%.o : %.c
	$(CC) $(APP_CFLAGS) -o $@ $<

%.o : %.cpp
	$(CXX) $(LIB_CFLAGS) -o $@ $<

clean :
	rm -f $(APP) $(APP_OBJS) $(DEPS) *~*

-------------- next part --------------
A non-text attachment was scrubbed...
Name: main.c
Type: text/x-csrc
Size: 1486 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20210628/dc57da98/at=
tachment.c>
