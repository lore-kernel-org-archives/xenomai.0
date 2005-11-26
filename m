From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 26 Nov 2005 22:26:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200511262226.24260.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Problems linking latency
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

I try to compile Xenomai on my Powerbook for an embedded PPC405. The
kernel boots okay with the xenomai kernel.

But when I try to compile the xenomai (trunk) I get the following error:

=BB/mnt/data.ng/hcu/kernel/build-xeno-hcu3/src/testsuite/latency=AB
/bin/sh ../../../libtool --mode=3Dlink --tag=3DCC powerpc-405-linux-gnu-gcc=
     -o=20
latency  latency-latency.o ../../skins/native/libnative.la -lpthread -lm

*** Warning: Linking the executable latency against the loadable module
*** libnative.so is not portable!

The Xenomai part of my kernel/.config looks like this
CONFIG_XENOMAI=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_STATS=3Dy
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_WATCHDOG is not set
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
# CONFIG_XENO_HW_FPU is not set
CONFIG_XENO_HW_PERIODIC_TIMER=3Dy
CONFIG_XENO_HW_TIMER_LATENCY=3D0
CONFIG_XENO_HW_SCHED_LATENCY=3D0
CONFIG_XENO_SKIN_NATIVE=3Dm
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D4096
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
CONFIG_XENO_OPT_NATIVE_INTR=3Dy
# CONFIG_XENO_SKIN_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
CONFIG_XENO_SKIN_VXWORKS=3Dy
# CONFIG_XENO_SKIN_RTAI is not set
# CONFIG_XENO_SKIN_RTDM is not set
CONFIG_XENO_SKIN_UVM=3Dy

What is wrong?

I was also surprised that I could not configure xenomai with=20
CROSS_COMPILE=3Dpowerpc-405-linux-gnu- but had do specify
CC=3Dpowerpc-405-linux-gnu-gcc to be able to use the same compiler, with wh=
ich I=20
built my kernel.=20

Best regards for any hints.

=2D-=20
Niklaus Giger

