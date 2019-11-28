Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Thu, 28 Nov 2019 09:27:16 +0100
Subject: Weird crash integrating new RTNET driver
Message-ID: <241a-5ddf8500-7-6709f900@16316240>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm having a weird kernel crash at porting an existing custom network d=
river to RTNET.
After the second unicast packet is received by the NIC (at the second i=
nterrupt to be more precise), the kernel crashes while signaling the pe=
nding threads on the rtdev event (rtdev->stack=5Fevent) during the call=
 to rt=5Fmark=5Fstack=5Fmgr.
I dug as deep as I could, and found out that xnsynch=5Fflush does not s=
eem to detect that there is only one pending thread on the event, and t=
hus tries to write to a poisonned list pointer.

See the crash dump below.
My configuration is linux 4.4.189 running on ARM Cortex A9 hardware, wi=
th xenomai 3.0.9.

[   40.673006] Unable to handle kernel NULL pointer dereference at virt=
ual address 00000104
[   40.681009] pgd =3D 40004000
[   40.683698] [00000104] *pgd=3D00000000
[   40.687261] Internal error: Oops: 817 [#1] PREEMPT SMP ARM
[   40.692732] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.189 #14
[   40.698801] Hardware name: Xilinx Zynq Platform
[   40.703314] I-pipe domain: Xenomai
[   40.706702] task: 416a4328 ti: 416a0000 task.ti: 416a0000
[   40.712097] PC is at xnsynch=5Fflush+0xb0/0x174
[   40.716429] LR is at xnthread=5Fresume+0x100/0x2a8
[   40.721026] pc : [<400970a8>]    lr : [<40098118>]    psr: 20000193
[   40.721026] sp : 416a1e00  ip : 00000200  fp : 00000098
[   40.732480] r10: 416a54b8  r9 : 416a2578  r8 : 00000100
[   40.737689] r7 : 00000200  r6 : 00000000  r5 : 00000000  r4 : 417608=
58
[   40.744198] r3 : 41760620  r2 : 00000100  r1 : 00000002  r0 : 417606=
20
[   40.750711] Flags: nzCv  IRQs off  FIQs on  Mode SVC=5F32  ISA ARM  =
Segment none
[   40.757914] Control: 18c5387d  Table: 1993804a  DAC: 00000051
[   40.763642] Process swapper/0 (pid: 0, stack limit =3D 0x416a0220)
[   40.769631] Stack: (0x416a1e00 to 0x416a2000)
[   40.773977] 1e00: 00000003 41760848 5f557410 00000001 41760848 41699=
fb0 41699fb0 416a2578
[   40.782136] 1e20: 416a54b8 5f5d4400 00000001 400a2dc4 5fbd2280 5f5d4=
560 61fa0000 750cd714
[   40.790294] 1e40: 00000009 00000003 416a554c 403ef728 00000000 416a2=
578 41698278 00000000
[   40.798454] 1e60: 416a20c0 5fbd2280 00000037 416a2578 416a54b8 ffff0=
f00 5f5d4588 416a2578
[   40.806613] 1e80: 41733340 40090524 00000037 41744b80 281977d5 00000=
003 416a2578 5fbd2db0
[   40.814772] 1ea0: 00000000 4169b280 5fbd2154 41722c40 00000000 5fbcf=
e18 5fbcfe14 5fbd2150
[   40.822931] 1ec0: 41699fb0 416a2578 5fbd108c 41699fb0 1e537000 5fbcf=
e10 41733340 40088ab0
[   40.831090] 1ee0: 416a9254 00000037 416a1f40 5fbcfe10 416a1f40 00000=
037 416a1f40 f8f00100
[   40.839250] 1f00: f8f01100 416982c4 404e37c8 4000934c 416c25c0 416a2=
700 f8f0010c 400095c8
[   40.847408] 1f20: 40088758 40088784 60000013 ffffffff 416a1f74 416a2=
3c0 416a2578 400139d4
[   40.855567] 1f40: 00000000 5fbcfe10 00000000 00000000 41698e10 416a2=
498 416a2450 416dcc00
[   40.863727] 1f60: 416a23c0 416a2578 416982c4 404e37c8 1e537000 416a1=
f90 40088758 40088784
[   40.871886] 1f80: 60000013 ffffffff 00000051 416a2450 416a0000 40059=
cf8 416a1fa4 416dca57
[   40.880045] 1fa0: 4066aa38 416dcc00 4066aa38 4062fc98 ffffffff fffff=
fff 00000000 4062f680
[   40.888204] 1fc0: 00000000 5fffce40 00000000 4066aa38 00000000 416dc=
e94 416a2440 4066aa34
[   40.896364] 1fe0: 416a536c 0000406a 413fc090 00000000 00000000 00008=
07c 00000000 00000000
[   40.904541] [<400970a8>] (xnsynch=5Fflush) from [<400a2dc4>] (rtdm=5F=
event=5Fsignal+0x70/0x144)
[   40.912689] [<400a2dc4>] (rtdm=5Fevent=5Fsignal) from [<403ef728>] (=
rt=5Fmacip=5Finterrupt=5Frx+0x20c/0x248)
[   40.921627] [<403ef728>] (rt=5Fmacip=5Finterrupt=5Frx) from [<400905=
24>] (xnintr=5Firq=5Fhandler+0xc8/0x378)
[   40.930574] [<40090524>] (xnintr=5Firq=5Fhandler) from [<40088ab0>] =
(dispatch=5Firq=5Fhead+0x9c/0x15c)
[   40.939162] [<40088ab0>] (dispatch=5Firq=5Fhead) from [<4000934c>] (=
=5F=5Fipipe=5Fgrab=5Firq+0x64/0x7c)
[   40.947490] [<4000934c>] (=5F=5Fipipe=5Fgrab=5Firq) from [<400095c8>=
] (gic=5Fhandle=5Firq+0x48/0x8c)
[   40.955556] Exception stack(0x416a1f20 to 0x416a1f68)
[   40.960596] 1f20: 40088758 40088784 60000013 ffffffff 416a1f74 416a2=
3c0 416a2578 400139d4
[   40.968755] 1f40: 00000000 5fbcfe10 00000000 00000000 41698e10 416a2=
498 416a2450 416dcc00
[   40.976909] 1f60: 416a23c0 416a2578
[   40.980387] [<400095c8>] (gic=5Fhandle=5Firq) from [<400139d4>] (=5F=
=5Firq=5Fsvc+0x54/0x80)
[   40.987845] Exception stack(0x416a1f40 to 0x416a1f88)
[   40.992886] 1f40: 00000000 5fbcfe10 00000000 00000000 41698e10 416a2=
498 416a2450 416dcc00
[   41.001044] 1f60: 416a23c0 416a2578 416982c4 404e37c8 1e537000 416a1=
f90 40088758 40088784
[   41.009199] 1f80: 60000013 ffffffff
[   41.012679] [<400139d4>] (=5F=5Firq=5Fsvc) from [<40088784>] (ipipe=5F=
unstall=5Froot+0x3c/0x50)
[   41.020495] [<40088784>] (ipipe=5Funstall=5Froot) from [<40059cf8>] =
(cpu=5Fstartup=5Fentry+0x144/0x1c8)
[   41.029174] [<40059cf8>] (cpu=5Fstartup=5Fentry) from [<4062fc98>] (=
start=5Fkernel+0x3c8/0x3d4)
[   41.037327] Code: e3a06000 e593c06c e1a00003 e3a01002 (e582c004)
[   41.043401] ---[ end trace a517e81af11fe3d4 ]---
[   41.048000] Kernel panic - not syncing: Attempted to kill the idle t=
ask!
[   42.227682] SMP: failed to stop secondary CPUs
[   42.232040] ---[ end Kernel panic - not syncing: Attempted to kill t=
he idle task!

Thanks in advance

Fran=C3=A7ois


