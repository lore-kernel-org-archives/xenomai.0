Message-ID: <32783.83.147.84.149.1130828326.squirrel@domain.hid>
Date: Tue, 1 Nov 2005 07:58:46 +0100 (CET)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Xenomai & ATI
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

Hi XenoPeople:

The point is:

real time Linux with OpenGL support enabled  - in hardware - using DRI or
external driver.

I'm doing some Xenomai compatibility test on varios hardware using the
official 2.0 Xenomai relase. Everythings works fine BUT with some glitch on
ATI videocard. If the kernel is compiled without DRI support and X (x.org)
use the default generic "radeon" driver all the sistems are stable BUT:

- in a machine (Dual PIII 450MHz) with ATI 9250-256Mbyte, with kernel
2.6.13.4 pathched with the Xenomai shipped -ipipe, if I include DRI support
in the kernel, the machine become unstable (e.g. hang);

- in a laptop with M10 ATI chipset (ASUS Z8100D), the R300 is not supported
in the kernel, so I'm using proprietary video driver from ATI. Same problem
of above with X.

Both machine are perfectly working and stable with Xenomai 2.0 and kernel
2.6.13.4 leaving standard radeon X driver and DRI support disabled: NO
OpenGL support in hardware :(

I'm sending this sequest for help because the Asus laptop is perfectly
working and stable with kernel 2.6.10, Adeos-ipipe patch -r9, and RTAI 3.2
stable (May 2005) with OpenGL support active (using proprietary ATI driver)
and RTAI applications:

testsuite/kern/latency/run:
...
RTH|    lat min|    lat avg|    lat max|   overruns|  freq.cntr
RTD|      -3357|        207|      13008|          0|      10000
RTD|      -3357|        205|      13008|          0|      10000
... :)

I suspect some incompatibility with ATI videocard, because on a machine with
Pentium IV and i845 chipset everything works OK, both Xenomai (with SMI
workaround enabled) and RTAI, with and without DRI OpenGL support in the
kernel.
Someone has done some test on systems with ATI videocard ?

And with nVidia ?

                      Simone Mannori










