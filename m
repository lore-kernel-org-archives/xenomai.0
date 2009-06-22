MIME-Version: 1.0
Message-ID: <OF023F5611.C8ADBADC-ON652575DD.000E4E0F-652575DD.000F87A0@domain.hid>
From: Ravikiran Saralaya <ravikiran.saralaya@domain.hid>
Date: Mon, 22 Jun 2009 08:20:08 +0530
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Xenomai-core] Question on uITRON Skin development and porting to
	iMX27/ARM926EJ-S
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, gilles.chanteperdrix@xenomai.org, xenomai@xenomai.org

Dear Philippe, Gilles,

First of all apologies for mailing you directly as our company mail rules=20
don't allow e-mailing to mail lists.

I am using Xenomai 2.4.7 and upgrading uITRON skin to be compliant to=20
uITRON specification 4.0 on iMX27/ARM926EJ-S. I have few related=20
questions. Sorry for the lengthy error logs..

1.      The uITRON specification requires task creation to accept base=20
address of task stack to be allocated. The xnarch_alloc_stack() currently=20
accepts only stack size but not the base address.

Can anyone please suggest a work around for allocating task stack from a=20
base address?

2.      I am planning to use iMX27 board from iWave (Rainbow-G3) with=20
ARM926EJ-S and Linux kernel 2.6.19.2 to develop Xenomai application. Is=20
Adeos ported on this platform? I get following error while building kernel=20
with ?adeos-ipipe-2.6.19-arm-1.7-00.patch?.

[root@domain.hid linux-2.6.19.2]# make
  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/utsrelease.h
  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/sched.h:57,
                 from arch/arm/kernel/asm-offsets.c:13:
include/linux/ipipe.h:30:23: error: asm/ipipe.h: No such file or directory
In file included from include/linux/sched.h:57,
                 from arch/arm/kernel/asm-offsets.c:13:
include/linux/ipipe.h:141: warning: 'struct ipipe_domain' declared inside=20
parameter list
include/linux/ipipe.h:141: warning: its scope is only this definition or=20
declaration, which is probably not what you want
include/linux/ipipe.h:149: error: 'IPIPE_NR_XIRQS' undeclared here (not in=20
a function)
include/linux/ipipe.h:164: error: 'IPIPE_NR_EVENTS' undeclared here (not=20
in a function)
include/linux/ipipe.h: In function 'ipipe_init_notify':
include/linux/ipipe.h:438: error: 'IPIPE_EVENT_INIT' undeclared (first use=20
in this function)
include/linux/ipipe.h:438: error: (Each undeclared identifier is reported=20
only once
include/linux/ipipe.h:438: error: for each function it appears in.)
include/linux/ipipe.h: In function 'ipipe_cleanup_notify':
include/linux/ipipe.h:444: error: 'IPIPE_EVENT_CLEANUP' undeclared (first=20
use in this function)
...
Bla bla bla..
...
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

I got rid of the errors by changing include path of ipipe.h to=20
/asm-arm/ipipe.h. Similarly I got rid of subsequent errors by changing=20
paths of other header files as above. Now I get following linker errors:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/kernel/built-in.o: In function `__ipipe_init_platform':
arch/arm/kernel/ipipe.c:123: undefined reference to=20
`__ipipe_mach_ticks_per_jiffy'
arch/arm/kernel/built-in.o: In function `ipipe_get_sysinfo':
arch/arm/kernel/ipipe.c:133: undefined reference to=20
`__ipipe_mach_ticks_per_jiffy'
arch/arm/kernel/ipipe.c:133: undefined reference to=20
`__ipipe_mach_timerint'
arch/arm/kernel/built-in.o: In function `__ipipe_set_decr':
arch/arm/kernel/ipipe.c:141: undefined reference to `__ipipe_mach_get_tsc'
arch/arm/kernel/ipipe.c:142: undefined reference to `__ipipe_mach_set_dec'
arch/arm/kernel/built-in.o: In function `__ipipe_grab_irq':
arch/arm/kernel/ipipe.c:482: undefined reference to `__ipipe_mach_get_tsc'
...
Bla bla bla..
...
arch/arm/xenomai/built-in.o: In function `rthal_timer_request':
arch/arm/xenomai/hal.c:128: undefined reference to=20
`__ipipe_mach_ticks_per_jiffy'
arch/arm/xenomai/hal.c:128: undefined reference to=20
`__ipipe_mach_timerstolen'
arch/arm/xenomai/hal.c:128: undefined reference to `__ipipe_mach_timerint'
make: *** [.tmp_vmlinux1] Error 1


Is my approach correct? I tried building with all patches=20
?adeos-ipipe-2.6.19-arm-1.x-yy.patch? but no success. Does that mean I=20
have to port Adeos on to this platform?

I also tried to get different Linux kernel version ported to iMX27, such=20
as 2.6.20, but I don?t have any option here other than 2.6.19 :(

Please advice if there is any alternative.

Thanks
Ravikiran


=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D
Notice: The information contained in this e-mail
message and/or attachments to it may contain=20
confidential or privileged information. If you are=20
not the intended recipient, any dissemination, use,=20
review, distribution, printing or copying of the=20
information contained in this e-mail message=20
and/or attachments to it are strictly prohibited. If=20
you have received this communication in error,=20
please notify us by reply e-mail or telephone and=20
immediately and permanently delete the message=20
and any attachments. Thank you




