From: =?iso-8859-1?Q?Peter_K=FCnnemann_ITB?= <itb.pkue@domain.hid>
Date: Wed, 14 Jul 2010 18:17:14 +0200
Message-ID: <4c3de30f.cf7d0e0a.6141.4e93@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: de
Subject: [Xenomai-help] arch 'powerpc' make: error 'struct ipipe_sysinfo'
	has no member named 'cpufreq'
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

Hi all

I am about to get a xenomai kernel 2.6.34 to be run on a lite5200 =
platform (IceCube?).
The patches from=20

"http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.34-po=
werpc-2.10-03.patch"

did apply without any problem. The make however resulted in the failure =
reported below.

...
  CC      kernel/time/tick-sched.o
  LD      kernel/time/built-in.o
  CC      kernel/xenomai/arch/generic/hal.o
In file included from =
/opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h:32,
                 from kernel/xenomai/arch/generic/hal.c:47:
include/asm-generic/xenomai/hal.h: In function 'rthal_get_cpufreq':
include/asm-generic/xenomai/hal.h:176: error: 'struct ipipe_sysinfo' has =
no member named 'cpufreq'
include/asm-generic/xenomai/hal.h: In function 'rthal_get_timerfreq':
include/asm-generic/xenomai/hal.h:183: error: 'struct ipipe_sysinfo' has =
no member named 'archdep'
In file included from kernel/xenomai/arch/generic/hal.c:47:
/opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h: In function 'rthal_get_active_mm':
/opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h:109: error: 'ipipe_active_mm' undeclared
(first use in this function)
/opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h:109: error: (Each undeclared identifier is
reported only once
/opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h:109: error: for each function it appears in.)
kernel/xenomai/arch/generic/hal.c: In function 'rthal_add_proc_leaf':
kernel/xenomai/arch/generic/hal.c:740: error: 'struct proc_dir_entry' =
has no member named 'owner'
kernel/xenomai/arch/generic/hal.c: In function 'rthal_proc_register':
kernel/xenomai/arch/generic/hal.c:755: error: 'struct proc_dir_entry' =
has no member named 'owner'

I'ld really like to get the 2.34 kernel running because I managed to =
make it running without Xenomai already, whereas 2.6.24 did not
made it because of other problems with the board settings

Any help would be very much appreciated

  mit freundlichen Gr=FC=DFen,
  sincerely yours
  sinc=E8res salutations

Peter Kuennemann



