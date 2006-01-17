From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 17 Jan 2006 08:32:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601170832.07348.niklaus.giger@domain.hid>
Subject: [Xenomai-core] libvxworks not built
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

I am at revision 464 of the xenomai trunk and wanted to build UVM for vxworks.
The following libraries built fine:
libuvm.a
libpsos.a
libuitron.a
libvrtx.a
libnucleus.a
but the library I am most intrested in is missing? 
Does anybody has any clue?

The XENO-parts of my .config are:
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_SYS_HEAPSZ=128
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
CONFIG_XENO_OPT_WATCHDOG=y
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
# CONFIG_XENO_HW_FPU is not set
CONFIG_XENO_HW_PERIODIC_TIMER=y
CONFIG_XENO_HW_TIMER_LATENCY=0
CONFIG_XENO_HW_SCHED_LATENCY=0
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
CONFIG_XENO_OPT_NATIVE_INTR=y
# CONFIG_XENO_SKIN_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_SKIN_UVM=y
# CONFIG_XENO_DRIVERS_16550A is not set
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set
       

The I configured xenomai like this
 /mnt/data.ng/hcu/kernel/xenomai/configure --prefix=/usr --enable-uvm 
--build=powerpc --host=powerpc-405-linux-gnu CFLAGS=-g 
PATH=/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/mnt/data.ng/hcu/tools/gcc-3.4.4-glibc-2.3.5/powerpc-405-linux-gnu/bin   
and let it build with
DESTDIR=/mnt/data.ng/hcu/rootfs -k install 
PATH=/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/mnt/data.ng/hcu/tools/gcc-3.4.4-glibc-2.3.5/powerpc-405-linux-gnu/bin 
install 

Best regards

-- 
Niklaus Giger

