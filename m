Message-ID: <11361891.1003501257322627993.JavaMail.defaultUser@domain.hid>
Date: Wed, 4 Nov 2009 09:17:07 +0100 (CET)
From: "cagnulein@domain.hid" <cagnulein@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_121964_26936857.1257322627993"
Subject: Re: [Xenomai-core] BUG: scheduling while atomic
Reply-To: "cagnulein@domain.hid" <cagnulein@domain.hid>
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_121964_26936857.1257322627993
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I've tried with your patch and asking to do latency test with 1000ns but the result is still the same :(
Do you have any other ideas? I'm very lost in space :(
Thanks
Roberto

 root@domain.hid:~# latency -p1000
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
[  156.780000] BUG: scheduling while atomic: sampling-1478/0x00000001/1480
[  156.790000] [<c002bef0>] (dump_stack+0x0/0x14) from [<c02ceb18>] (schedule+0x
60/0x7f0)
[  156.800000] [<c02ceab8>] (schedule+0x0/0x7f0) from [<c00882b4>] (xnshadow_har
den+0xd4/0x240)
[  156.810000] [<c00881e0>] (xnshadow_harden+0x0/0x240) from [<c0088a40>] (xnsha
dow_wait_barrier+0x104/0x11c)
[  156.820000]  r8:00000018 r7:00000000 r6:c33a4000 r5:c33a5fb0 r4:c4801410
[  156.820000] [<c008893c>] (xnshadow_wait_barrier+0x0/0x11c) from [<c0088a6c>]
(xnshadow_sys_barrier+0x14/0x18)
[  156.830000]  r5:c33a5fb0 r4:00000001
[  156.840000] [<c0088a58>] (xnshadow_sys_barrier+0x0/0x18) from [<c008882c>] (l
osyscall_event+0xcc/0x1dc)
[  156.850000] [<c0088760>] (losyscall_event+0x0/0x1dc) from [<c0073288>] (__ipi
pe_dispatch_event+0xd0/0x1c8)
[  156.860000] [<c00731b8>] (__ipipe_dispatch_event+0x0/0x1c8) from [<c002d1b8>]
 (__ipipe_syscall_root+0x80/0x130)
[  156.870000] [<c002d138>] (__ipipe_syscall_root+0x0/0x130) from [<c0027294>] (
vector_swi+0x74/0xb4)
[  156.880000]  r6:40032c94 r5:bef14c6c r4:00100000
[  156.880000] I-pipe: Detected illicit call from domain 'Xenomai'
[  156.880000]         into a service reserved for domain 'Linux' and below.
[  156.880000] [<c002bef0>] (dump_stack+0x0/0x14) from [<c00726fc>] (ipipe_check
_context+0xbc/0xdc)
[  156.880000] [<c0072640>] (ipipe_check_context+0x0/0xdc) from [<c02cf23c>] (sc
hedule+0x784/0x7f0)
[  156.880000]  r4:c3c79c40
[  156.880000] [<c02ceab8>] (schedule+0x0/0x7f0) from [<c00882b4>] (xnshadow_har
den+0xd4/0x240)
[  156.880000] [<c00881e0>] (xnshadow_harden+0x0/0x240) from [<c0088a40>] (xnsha
dow_wait_barrier+0x104/0x11c)
[  156.880000]  r8:00000018 r7:00000000 r6:c33a4000 r5:c33a5fb0 r4:c4801410
[  156.880000] [<c008893c>] (xnshadow_wait_barrier+0x0/0x11c) from [<c0088a6c>]
(xnshadow_sys_barrier+0x14/0x18)
[  156.880000]  r5:c33a5fb0 r4:00000001
[  156.880000] [<c0088a58>] (xnshadow_sys_barrier+0x0/0x18) from [<c008882c>] (l
osyscall_event+0xcc/0x1dc)
[  156.880000] [<c0088760>] (losyscall_event+0x0/0x1dc) from [<c0073288>] (__ipi
pe_dispatch_event+0xd0/0x1c8)
[  156.880000] [<c00731b8>] (__ipipe_dispatch_event+0x0/0x1c8) from [<c002d1b8>]
 (__ipipe_syscall_root+0x80/0x130)
[  156.880000] [<c002d138>] (__ipipe_syscall_root+0x0/0x130) from [<c0027294>] (
vector_swi+0x74/0xb4)
[  156.880000]  r6:40032c94 r5:bef14c6c r4:00100000
[  156.880000] Xenomai: fatal: bug at kernel/xenomai/nucleus/shadow.c:1128 (!irq
s_disabled_hw())
[  156.880000]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[  156.880000]    0  0       -1      0        00400088  ROOT
[  156.880000]    0  1479     0      0        00300380  display-1478
[  156.880000] >  0  1480    99      0        00300180  sampling-1478
[  156.880000] Master time base: clock=2610156463
[  156.880000]
[  156.880000] [<c002b648>] (show_stack+0x0/0x48) from [<c00883c4>] (xnshadow_ha
rden+0x1e4/0x240)
[  156.880000] [<c00881e0>] (xnshadow_harden+0x0/0x240) from [<c0088a40>] (xnsha
dow_wait_barrier+0x104/0x11c)
[  156.880000]  r8:00000018 r7:00000000 r6:c33a4000 r5:c33a5fb0 r4:c4801410
[  156.880000] [<c008893c>] (xnshadow_wait_barrier+0x0/0x11c) from [<c0088a6c>]
(xnshadow_sys_barrier+0x14/0x18)
[  156.880000]  r5:c33a5fb0 r4:00000001
[  156.880000] [<c0088a58>] (xnshadow_sys_barrier+0x0/0x18) from [<c008882c>] (l
osyscall_event+0xcc/0x1dc)
[  156.880000] [<c0088760>] (losyscall_event+0x0/0x1dc) from [<c0073288>] (__ipi
pe_dispatch_event+0xd0/0x1c8)
[  156.880000] [<c00731b8>] (__ipipe_dispatch_event+0x0/0x1c8) from [<c002d1b8>]
 (__ipipe_syscall_root+0x80/0x130)
[  156.880000] [<c002d138>] (__ipipe_syscall_root+0x0/0x130) from [<c0027294>] (
vector_swi+0x74/0xb4)
[  156.880000]  r6:40032c94 r5:bef14c6c r4:00100000 
------=_Part_121964_26936857.1257322627993
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've tried with your patch and asking to do latency test with 1000ns but th=
e result is still the same :(<br>Do you have any other ideas? I'm very lost=
 in space :(<br>Thanks<br>Roberto<br><br>&nbsp;root@domain.hid:~# latency -p1000<=
br>=3D=3D Sampling period: 1000 us<br>=3D=3D Test mode: periodic user-mode =
task<br>=3D=3D All results in microseconds<br>[&nbsp; 156.780000] BUG: sche=
duling while atomic: sampling-1478/0x00000001/1480<br>[&nbsp; 156.790000] [=
&lt;c002bef0&gt;] (dump_stack+0x0/0x14) from [&lt;c02ceb18&gt;] (schedule+0=
x<br>60/0x7f0)<br>[&nbsp; 156.800000] [&lt;c02ceab8&gt;] (schedule+0x0/0x7f=
0) from [&lt;c00882b4&gt;] (xnshadow_har<br>den+0xd4/0x240)<br>[&nbsp; 156.=
810000] [&lt;c00881e0&gt;] (xnshadow_harden+0x0/0x240) from [&lt;c0088a40&g=
t;] (xnsha<br>dow_wait_barrier+0x104/0x11c)<br>[&nbsp; 156.820000]&nbsp; r8=
:00000018 r7:00000000 r6:c33a4000 r5:c33a5fb0 r4:c4801410<br>[&nbsp; 156.82=
0000] [&lt;c008893c&gt;] (xnshadow_wait_barrier+0x0/0x11c) from [&lt;c0088a=
6c&gt;]<br>(xnshadow_sys_barrier+0x14/0x18)<br>[&nbsp; 156.830000]&nbsp; r5=
:c33a5fb0 r4:00000001<br>[&nbsp; 156.840000] [&lt;c0088a58&gt;] (xnshadow_s=
ys_barrier+0x0/0x18) from [&lt;c008882c&gt;] (l<br>osyscall_event+0xcc/0x1d=
c)<br>[&nbsp; 156.850000] [&lt;c0088760&gt;] (losyscall_event+0x0/0x1dc) fr=
om [&lt;c0073288&gt;] (__ipi<br>pe_dispatch_event+0xd0/0x1c8)<br>[&nbsp; 15=
6.860000] [&lt;c00731b8&gt;] (__ipipe_dispatch_event+0x0/0x1c8) from [&lt;c=
002d1b8&gt;]<br>&nbsp;(__ipipe_syscall_root+0x80/0x130)<br>[&nbsp; 156.8700=
00] [&lt;c002d138&gt;] (__ipipe_syscall_root+0x0/0x130) from [&lt;c0027294&=
gt;] (<br>vector_swi+0x74/0xb4)<br>[&nbsp; 156.880000]&nbsp; r6:40032c94 r5=
:bef14c6c r4:00100000<br>[&nbsp; 156.880000] I-pipe: Detected illicit call =
from domain 'Xenomai'<br>[&nbsp; 156.880000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; into a service reserved for domain 'Linux' and below.<br>=
[&nbsp; 156.880000] [&lt;c002bef0&gt;] (dump_stack+0x0/0x14) from [&lt;c007=
26fc&gt;] (ipipe_check<br>_context+0xbc/0xdc)<br>[&nbsp; 156.880000] [&lt;c=
0072640&gt;] (ipipe_check_context+0x0/0xdc) from [&lt;c02cf23c&gt;] (sc<br>=
hedule+0x784/0x7f0)<br>[&nbsp; 156.880000]&nbsp; r4:c3c79c40<br>[&nbsp; 156=
.880000] [&lt;c02ceab8&gt;] (schedule+0x0/0x7f0) from [&lt;c00882b4&gt;] (x=
nshadow_har<br>den+0xd4/0x240)<br>[&nbsp; 156.880000] [&lt;c00881e0&gt;] (x=
nshadow_harden+0x0/0x240) from [&lt;c0088a40&gt;] (xnsha<br>dow_wait_barrie=
r+0x104/0x11c)<br>[&nbsp; 156.880000]&nbsp; r8:00000018 r7:00000000 r6:c33a=
4000 r5:c33a5fb0 r4:c4801410<br>[&nbsp; 156.880000] [&lt;c008893c&gt;] (xns=
hadow_wait_barrier+0x0/0x11c) from [&lt;c0088a6c&gt;]<br>(xnshadow_sys_barr=
ier+0x14/0x18)<br>[&nbsp; 156.880000]&nbsp; r5:c33a5fb0 r4:00000001<br>[&nb=
sp; 156.880000] [&lt;c0088a58&gt;] (xnshadow_sys_barrier+0x0/0x18) from [&l=
t;c008882c&gt;] (l<br>osyscall_event+0xcc/0x1dc)<br>[&nbsp; 156.880000] [&l=
t;c0088760&gt;] (losyscall_event+0x0/0x1dc) from [&lt;c0073288&gt;] (__ipi<=
br>pe_dispatch_event+0xd0/0x1c8)<br>[&nbsp; 156.880000] [&lt;c00731b8&gt;] =
(__ipipe_dispatch_event+0x0/0x1c8) from [&lt;c002d1b8&gt;]<br>&nbsp;(__ipip=
e_syscall_root+0x80/0x130)<br>[&nbsp; 156.880000] [&lt;c002d138&gt;] (__ipi=
pe_syscall_root+0x0/0x130) from [&lt;c0027294&gt;] (<br>vector_swi+0x74/0xb=
4)<br>[&nbsp; 156.880000]&nbsp; r6:40032c94 r5:bef14c6c r4:00100000<br>[&nb=
sp; 156.880000] Xenomai: fatal: bug at kernel/xenomai/nucleus/shadow.c:1128=
 (!irq<br>s_disabled_hw())<br>[&nbsp; 156.880000]&nbsp; CPU&nbsp; PID&nbsp;=
&nbsp;&nbsp; PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIMEOUT&nbsp; STAT&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; NAME<br>[&nbsp; 156.880000]&nbsp;&nbsp;&nbsp; 0&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400088&nbsp; ROOT<br>[&nbsp; 156.=
880000]&nbsp;&nbsp;&nbsp; 0&nbsp; 1479&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00300380&nb=
sp; display-1478<br>[&nbsp; 156.880000] &gt;&nbsp; 0&nbsp; 1480&nbsp;&nbsp;=
&nbsp; 99&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 00300180&nbsp; sampling-1478<br>[&nbsp; 156.880000] Master time ba=
se: clock=3D2610156463<br>[&nbsp; 156.880000]<br>[&nbsp; 156.880000] [&lt;c=
002b648&gt;] (show_stack+0x0/0x48) from [&lt;c00883c4&gt;] (xnshadow_ha<br>=
rden+0x1e4/0x240)<br>[&nbsp; 156.880000] [&lt;c00881e0&gt;] (xnshadow_harde=
n+0x0/0x240) from [&lt;c0088a40&gt;] (xnsha<br>dow_wait_barrier+0x104/0x11c=
)<br>[&nbsp; 156.880000]&nbsp; r8:00000018 r7:00000000 r6:c33a4000 r5:c33a5=
fb0 r4:c4801410<br>[&nbsp; 156.880000] [&lt;c008893c&gt;] (xnshadow_wait_ba=
rrier+0x0/0x11c) from [&lt;c0088a6c&gt;]<br>(xnshadow_sys_barrier+0x14/0x18=
)<br>[&nbsp; 156.880000]&nbsp; r5:c33a5fb0 r4:00000001<br>[&nbsp; 156.88000=
0] [&lt;c0088a58&gt;] (xnshadow_sys_barrier+0x0/0x18) from [&lt;c008882c&gt=
;] (l<br>osyscall_event+0xcc/0x1dc)<br>[&nbsp; 156.880000] [&lt;c0088760&gt=
;] (losyscall_event+0x0/0x1dc) from [&lt;c0073288&gt;] (__ipi<br>pe_dispatc=
h_event+0xd0/0x1c8)<br>[&nbsp; 156.880000] [&lt;c00731b8&gt;] (__ipipe_disp=
atch_event+0x0/0x1c8) from [&lt;c002d1b8&gt;]<br>&nbsp;(__ipipe_syscall_roo=
t+0x80/0x130)<br>[&nbsp; 156.880000] [&lt;c002d138&gt;] (__ipipe_syscall_ro=
ot+0x0/0x130) from [&lt;c0027294&gt;] (<br>vector_swi+0x74/0xb4)<br>[&nbsp;=
 156.880000]&nbsp; r6:40032c94 r5:bef14c6c r4:00100000
------=_Part_121964_26936857.1257322627993--


