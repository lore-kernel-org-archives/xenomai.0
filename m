Message-ID: <289790.83729.qm@domain.hid>
Date: Tue, 23 Mar 2010 22:05:16 +0800 (CST)
From: =?utf-8?B?5p2wIHpoYW8=?= <zhjunjie2007@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-589563824-1269353116=:83729"
Subject: [Xenomai-help] dm9000 doesn't work well with the
	adeos-ipipe-2.6.28.10-arm-1.12-06.patch
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

--0-589563824-1269353116=:83729
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,
I have compiled a kernel 2.6.28.10 +=C2=A0 xenomai2.5.1 and successfully bo=
oted on=C2=A0s3c2440 based board with DM9000, but ethernet comunication doe=
sn't work and I see the following messagge; when i remove the Kernel Featur=
es->interrupt pipeline support, the ethernet work well.Can someone help me?
# ping 172.20.36.100
PING 172.20.36.100 (172.20.36.100): 56 data bytes
------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:226 dev_watchdog+0x184/0x270()
NETDEV WATCHDOG: eth0 (): transmit timed out
Modules linked in:
[<c002ec28>] (dump_stack+0x0/0x14) from [<c004acd0>] (warn_slowpath+0x5c/0x=
78)
[<c004ac74>] (warn_slowpath+0x0/0x78) from [<c023f58c>] (dev_watchdog+0x184=
/0x270)
=C2=A0r3:c397b800 r2:c03465e0
=C2=A0r6:00000001 r5:00000001 r4:c397b800
[<c023f408>] (dev_watchdog+0x0/0x270) from [<c0054710>] (run_timer_softirq+=
0x17c/0x1f8)
=C2=A0r7:c023f408 r6:c03a7920 r5:00000100 r4:c0364000
[<c0054594>] (run_timer_softirq+0x0/0x1f8) from [<c004f9f0>] (__do_softirq+=
0x60/0x118)
[<c004f990>] (__do_softirq+0x0/0x118) from [<c004fd1c>] (irq_exit+0x44/0x4c=
)
[<c004fcd8>] (irq_exit+0x0/0x4c) from [<c002a068>] (asm_do_IRQ+0x68/0x80)
[<c002a000>] (asm_do_IRQ+0x0/0x80) from [<c0071d08>] (__ipipe_sync_stage+0x=
1d4/0x288)
Exception stack(0xc0365eb0 to 0xc0365ef8)
5ea0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c0=
3a9ec0 c03a9ec0 c036ec3c c036ec38=20
5ec0: c03a9ec0 000003c0 00000001 c0365ef8 c0365edc c00720dc c0071b44 c03a9e=
c0=20
5ee0: 0000001e c03aa2e0 c03a9ec4 c0365f24 c0365efc c002fbf8=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=20
=C2=A0r6:0000001e r5:c03aa2e0 r4:c036ec3c
[<c0071b34>] (__ipipe_sync_stage+0x0/0x288) from [<c00720dc>] (__ipipe_walk=
_pipeline+0x9c/0xc4)
[<c0072040>] (__ipipe_walk_pipeline+0x0/0xc4) from [<c002fbf8>] (__ipipe_ha=
ndle_irq+0x158/0x1a8)
=C2=A0r7:c03a9ec4 r6:c03aa2e0 r5:0000001e r4:c03a9ec0
[<c002faa0>] (__ipipe_handle_irq+0x0/0x1a8) from [<c002fd68>] (__ipipe_grab=
_irq+0xb0/0xcc)
[<c002fcb8>] (__ipipe_grab_irq+0x0/0xcc) from [<c002ab28>] (__irq_svc+0x28/=
0xa8)
=C2=A0r6:00004000 r5:f4000000 r4:ffffffff
[<c002bb28>] (s3c24xx_default_idle+0x0/0x44) from [<c002bd2c>] (default_idl=
e+0x7c/0x90)
[<c002bcb0>] (default_idle+0x0/0x90) from [<c002bd84>] (cpu_idle+0x44/0x58)
[<c002bd40>] (cpu_idle+0x0/0x58) from [<c02a27f4>] (rest_init+0x54/0x68)
=C2=A0r5:c0385d28 r4:c03ab288
[<c02a27a0>] (rest_init+0x0/0x68) from [<c0008b04>] (start_kernel+0x2b4/0x3=
24)
[<c0008850>] (start_kernel+0x0/0x324) from [<30008034>] (0x30008034)
=C2=A0r6:c0025f08 r5:c03861ec r4:c0007175
---[ end trace da8f6a8a6146042c ]---
=0A=0A=0A      
--0-589563824-1269353116=:83729
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi all,<BR>I have compiled a kernel 2.6.28.10=
 +&nbsp; xenomai2.5.1 and successfully booted on&nbsp;s3c2440 based board w=
ith DM9000, but ethernet comunication doesn't work and I see the following =
messagge; when i remove the Kernel Features-&gt;interrupt pipeline support,=
 the ethernet work well.Can someone help me?<BR># ping 172.20.36.100<BR>PIN=
G 172.20.36.100 (172.20.36.100): 56 data bytes<BR>------------[ cut here ]-=
-----------<BR>WARNING: at net/sched/sch_generic.c:226 dev_watchdog+0x184/0=
x270()<BR>NETDEV WATCHDOG: eth0 (): transmit timed out<BR>Modules linked in=
:<BR>[&lt;c002ec28&gt;] (dump_stack+0x0/0x14) from [&lt;c004acd0&gt;] (warn=
_slowpath+0x5c/0x78)<BR>[&lt;c004ac74&gt;] (warn_slowpath+0x0/0x78) from [&=
lt;c023f58c&gt;] (dev_watchdog+0x184/0x270)<BR>&nbsp;r3:c397b800 r2:c03465e=
0<BR>&nbsp;r6:00000001 r5:00000001 r4:c397b800<BR>[&lt;c023f408&gt;]
 (dev_watchdog+0x0/0x270) from [&lt;c0054710&gt;] (run_timer_softirq+0x17c/=
0x1f8)<BR>&nbsp;r7:c023f408 r6:c03a7920 r5:00000100 r4:c0364000<BR>[&lt;c00=
54594&gt;] (run_timer_softirq+0x0/0x1f8) from [&lt;c004f9f0&gt;] (__do_soft=
irq+0x60/0x118)<BR>[&lt;c004f990&gt;] (__do_softirq+0x0/0x118) from [&lt;c0=
04fd1c&gt;] (irq_exit+0x44/0x4c)<BR>[&lt;c004fcd8&gt;] (irq_exit+0x0/0x4c) =
from [&lt;c002a068&gt;] (asm_do_IRQ+0x68/0x80)<BR>[&lt;c002a000&gt;] (asm_d=
o_IRQ+0x0/0x80) from [&lt;c0071d08&gt;] (__ipipe_sync_stage+0x1d4/0x288)<BR=
>Exception stack(0xc0365eb0 to 0xc0365ef8)<BR>5ea0:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c03a9ec0 c03a9ec0 c036ec3c c036e=
c38 <BR>5ec0: c03a9ec0 000003c0 00000001 c0365ef8 c0365edc c00720dc c0071b4=
4 c03a9ec0 <BR>5ee0: 0000001e c03aa2e0 c03a9ec4 c0365f24 c0365efc
 c002fbf8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;r6:0000001e r5:c03aa2e=
0 r4:c036ec3c<BR>[&lt;c0071b34&gt;] (__ipipe_sync_stage+0x0/0x288) from [&l=
t;c00720dc&gt;] (__ipipe_walk_pipeline+0x9c/0xc4)<BR>[&lt;c0072040&gt;] (__=
ipipe_walk_pipeline+0x0/0xc4) from [&lt;c002fbf8&gt;] (__ipipe_handle_irq+0=
x158/0x1a8)<BR>&nbsp;r7:c03a9ec4 r6:c03aa2e0 r5:0000001e r4:c03a9ec0<BR>[&l=
t;c002faa0&gt;] (__ipipe_handle_irq+0x0/0x1a8) from [&lt;c002fd68&gt;] (__i=
pipe_grab_irq+0xb0/0xcc)<BR>[&lt;c002fcb8&gt;] (__ipipe_grab_irq+0x0/0xcc) =
from [&lt;c002ab28&gt;] (__irq_svc+0x28/0xa8)<BR>&nbsp;r6:00004000 r5:f4000=
000 r4:ffffffff<BR>[&lt;c002bb28&gt;] (s3c24xx_default_idle+0x0/0x44) from =
[&lt;c002bd2c&gt;] (default_idle+0x7c/0x90)<BR>[&lt;c002bcb0&gt;] (default_=
idle+0x0/0x90) from [&lt;c002bd84&gt;] (cpu_idle+0x44/0x58)<BR>[&lt;c002bd4=
0&gt;] (cpu_idle+0x0/0x58) from [&lt;c02a27f4&gt;]
 (rest_init+0x54/0x68)<BR>&nbsp;r5:c0385d28 r4:c03ab288<BR>[&lt;c02a27a0&gt=
;] (rest_init+0x0/0x68) from [&lt;c0008b04&gt;] (start_kernel+0x2b4/0x324)<=
BR>[&lt;c0008850&gt;] (start_kernel+0x0/0x324) from [&lt;30008034&gt;] (0x3=
0008034)<BR>&nbsp;r6:c0025f08 r5:c03861ec r4:c0007175<BR>---[ end trace da8=
f6a8a6146042c ]---<BR></td></tr></table><br>=0A=0A=0A=0A      &nbsp;
--0-589563824-1269353116=:83729--


