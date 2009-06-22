MIME-Version: 1.0
Message-ID: <OF0304875E.FFEBB455-ON652575DD.0012837B-652575DD.0012EBAC@tcs.com>
From: Vandana Sasidharan <vandana.sasidharan@domain.hid>
Date: Mon, 22 Jun 2009 08:58:11 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 0012EB9E652575DD_="
Subject: [Xenomai-help] Question on uITRON Skin development and porting to
	iMX27/ARM926EJ-S
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

This is a multipart message in MIME format.
--=_alternative 0012EB9E652575DD_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi All,

I am using Xenomai 2.4.7. I am upgrading uITRON skin to be compliant to=20
uITRON specification 4.0 on iMX27/ARM926EJ-S. I have few related=20
questions. Sorry for the lengthy error logs..
1. The specification requires task creation to accept base address of task=20
stack to be allocated. The xnarch_alloc_stack() currently accepts only=20
stack size but not the base address.
Can anyone please suggest a work around for allocating task stack from a=20
base address?

2. I am planning to use iMX27 board from iWave (Rainbow-G3) with=20
ARM926EJ-S and Linux kernel 2.6.19.2 to develop Xenomai application. Is=20
Adeos ported on this platform? I get following error while building kernel=20
with ?adeos-ipipe-2.6.19-arm-1.7-00.patch?.
[root@domain.hid linux-2.6.19.2]# make

CHK include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
CHK include/linux/utsrelease.h
CC arch/arm/kernel/asm-offsets.s
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

CC init/version.o
LD init/built-in.o
LD .tmp_vmlinux1
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
Vandana


ForwardSourceID:NT000047F6=20
ForwardSourceID:NT00007306=20
ForwardSourceID:NT0000731A=20
ForwardSourceID:NT0000731E=20
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



--=_alternative 0012EB9E652575DD_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<br><font size=3D2 face=3D"sans-serif"><br>
</font><font size=3D3 face=3D"Times New Roman">Hi All,</font><font size=3D3=
><br>
</font><font size=3D3 face=3D"Times New Roman"><br>
I am using Xenomai 2.4.7. I am upgrading uITRON skin to be compliant to
uITRON specification 4.0 on iMX27/ARM926EJ-S. I have few related questions.
Sorry for the lengthy error logs..</font>
<br><font size=3D3 face=3D"Times New Roman">1. The specification requires t=
ask
creation to accept base address of task stack to be allocated. The xnarch_a=
lloc_stack()
currently accepts only stack size but not the base address.</font>
<br><font size=3D3 face=3D"Times New Roman">Can anyone please suggest a work
around for allocating task stack from a base address?</font><font size=3D3>=
<br>
</font><font size=3D3 face=3D"Times New Roman"><br>
2. I am planning to use iMX27 board from iWave (Rainbow-G3) with ARM926EJ-S
and Linux kernel 2.6.19.2 to develop Xenomai application. Is Adeos ported
on this platform? I get following error while building kernel with &#8220;a=
deos-ipipe-2.6.19-arm-1.7-00.patch&#8221;.</font>
<br><font size=3D3 face=3D"Courier New">[root@domain.hid linux-2.6.19.2]# ma=
ke</font>
<br><font size=3D3 face=3D"Courier New"><br>
CHK include/linux/version.h<br>
make[1]: `include/asm-arm/mach-types.h' is up to date.<br>
CHK include/linux/utsrelease.h<br>
CC arch/arm/kernel/asm-offsets.s<br>
In file included from include/linux/sched.h:57,<br>
from arch/arm/kernel/asm-offsets.c:13:<br>
include/linux/ipipe.h:30:23: error: asm/ipipe.h: No such file or directory<=
br>
In file included from include/linux/sched.h:57,<br>
from arch/arm/kernel/asm-offsets.c:13:<br>
include/linux/ipipe.h:141: warning: 'struct ipipe_domain' declared inside
parameter list<br>
include/linux/ipipe.h:141: warning: its scope is only this definition or
declaration, which is probably not what you want<br>
include/linux/ipipe.h:149: error: 'IPIPE_NR_XIRQS' undeclared here (not
in a function)<br>
include/linux/ipipe.h:164: error: 'IPIPE_NR_EVENTS' undeclared here (not
in a function)<br>
include/linux/ipipe.h: In function 'ipipe_init_notify':<br>
include/linux/ipipe.h:438: error: 'IPIPE_EVENT_INIT' undeclared (first
use in this function)<br>
include/linux/ipipe.h:438: error: (Each undeclared identifier is reported
only once<br>
include/linux/ipipe.h:438: error: for each function it appears in.)<br>
include/linux/ipipe.h: In function 'ipipe_cleanup_notify':<br>
include/linux/ipipe.h:444: error: 'IPIPE_EVENT_CLEANUP' undeclared (first
use in this function)<br>
...<br>
Bla bla bla..<br>
...<br>
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1<br>
make: *** [prepare0] Error 2</font>
<br><font size=3D3 face=3D"Times New Roman">I got rid of the errors by chan=
ging
include path of ipipe.h to /asm-arm/ipipe.h. Similarly I got rid of subsequ=
ent
errors by changing paths of other header files as above. Now I get following
linker errors:</font>
<br><font size=3D3 face=3D"Courier New"><br>
CC init/version.o<br>
LD init/built-in.o<br>
LD .tmp_vmlinux1<br>
arch/arm/kernel/built-in.o: In function `__ipipe_init_platform':<br>
arch/arm/kernel/ipipe.c:123: undefined reference to `__ipipe_mach_ticks_per=
_jiffy'<br>
arch/arm/kernel/built-in.o: In function `ipipe_get_sysinfo':<br>
arch/arm/kernel/ipipe.c:133: undefined reference to `__ipipe_mach_ticks_per=
_jiffy'<br>
arch/arm/kernel/ipipe.c:133: undefined reference to `__ipipe_mach_timerint'=
<br>
arch/arm/kernel/built-in.o: In function `__ipipe_set_decr':<br>
arch/arm/kernel/ipipe.c:141: undefined reference to `__ipipe_mach_get_tsc'<=
br>
arch/arm/kernel/ipipe.c:142: undefined reference to `__ipipe_mach_set_dec'<=
br>
arch/arm/kernel/built-in.o: In function `__ipipe_grab_irq':<br>
arch/arm/kernel/ipipe.c:482: undefined reference to `__ipipe_mach_get_tsc'<=
br>
...<br>
Bla bla bla..<br>
...<br>
arch/arm/xenomai/built-in.o: In function `rthal_timer_request':<br>
arch/arm/xenomai/hal.c:128: undefined reference to `__ipipe_mach_ticks_per_=
jiffy'<br>
arch/arm/xenomai/hal.c:128: undefined reference to `__ipipe_mach_timerstole=
n'<br>
arch/arm/xenomai/hal.c:128: undefined reference to `__ipipe_mach_timerint'<=
br>
make: *** [.tmp_vmlinux1] Error 1</font>
<br><font size=3D3 face=3D"Times New Roman">Is my approach correct? I tried
building with all patches &#8220;adeos-ipipe-2.6.19-arm-1.x-yy.patch&#8221;=
 but no
success. Does that mean I have to port Adeos on to this platform?</font>
<br><font size=3D3 face=3D"Times New Roman">I also tried to get different L=
inux
kernel version ported to iMX27, such as 2.6.20, but I don&#8217;t have any =
option
here other than 2.6.19 :(</font>
<br><font size=3D3 face=3D"Times New Roman">Please advice if there is any a=
lternative.</font>
<br>
<br>
<br><font size=3D3 face=3D"Times New Roman">Thanks<br>
Vandana</font>
<br><font size=3D3><br>
</font><font size=3D3 color=3Dwhite><br>
ForwardSourceID:NT000047F6 <br>
ForwardSourceID:NT00007306 </font><font size=3D1 color=3Dwhite><br>
ForwardSourceID:NT0000731A </font>
<br><font size=3D1 color=3Dwhite face=3D"sans-serif">ForwardSourceID:NT0000=
731E
&nbsp; &nbsp;</font><pre>=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=
=3D=3D
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


</pre>
--=_alternative 0012EB9E652575DD_=--


