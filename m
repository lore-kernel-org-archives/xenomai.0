Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Mon, 03 Feb 2020 17:52:08 +0100
Subject: Kernel crash when userland does not close file descriptor before exit
Message-ID: <2a72-5e384f80-67-7b6ca980@231441792>
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
To: =?utf-8?q?Fran=C3=A7ois_Legal_via_Xenomai?= <xenomai@xenomai.org>

Hello,

using xenomai 3.0.9 on linux-4.4.189, I'm experiencing a kernel crash i=
f a userland application that opens a custom driver terminates without =
closing the fd.
However, when the application calls close before terminating, no proble=
m happens.I'm not quite sure how to debug this, and if this is really l=
inked to my driver.

This is the back trace of the crash :
[   60.324708] Unable to handle kernel NULL pointer dereference at virt=
ual address 000001e4
[   60.332757] pgd =3D c0004000
[   60.335417] [000001e4] *pgd=3D00000000
[   60.338975] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[   60.344366] CPU: 1 PID: 790 Comm: integration-dma Not tainted 4.4.18=
9 #158
[   60.351219] Hardware name: Xilinx Zynq Platform
[   60.355729] I-pipe domain: Linux
[   60.358941] task: df5c7800 ti: df764000 task.ti: df764000
[   60.364341] PC is at xnsynch=5Ftry=5Facquire+0x1c/0x80
[   60.369098] LR is at 0x0
[   60.371615] pc : [<c0097170>]    lr : [<00000000>]    psr: 40000093
[   60.371615] sp : df765dd4  ip : 00000000  fp : c059143c
[   60.383090] r10: de47be2c  r9 : 00000000  r8 : 00000000
[   60.388282] r7 : c0585f70  r6 : c058e5c0  r5 : c0585f70  r4 : 000000=
00
[   60.394793] r3 : de47be50  r2 : df764000  r1 : 00000001  r0 : de47be=
2c
[   60.401306] Flags: nZcv  IRQs off  FIQs on  Mode SVC=5F32  ISA ARM  =
Segment none
[   60.408518] Control: 18c5387d  Table: 1e29404a  DAC: 00000051
[   60.414235] Process integration-dma (pid: 790, stack limit =3D 0xdf7=
64220)
[   60.420920] Stack: (0xdf765dd4 to 0xdf766000)
[   60.425260] 5dc0:                                              c00a4=
738 df765e34 c00ccaa0
[   60.433438] 5de0: df765dfc 00000001 00000001 de255e00 de47be10 c058e=
5c0 c058e5c0 de255e00
[   60.441596] 5e00: de255e00 de47be2c c0596a4c c00a4860 00000000 00000=
001 df764000 c0355d04
[   60.449756] 5e20: b6fd43a8 c007efe4 c04f0e36 00000001 df765e2c de255=
e00 de47be58 c058e5c0
[   60.457915] 5e40: c058e5c0 de255e00 c059143c 60000013 c0596a4c c00a2=
388 c00a2368 c0587110
[   60.466073] 5e60: c0585f70 c00a5344 00000001 00000000 00000000 00000=
000 de793128 c0585f70
[   60.474233] 5e80: de280a40 de79300c de79300c de793000 00000001 de793=
118 c0596a4c c00a53bc
[   60.482392] 5ea0: de280a48 00000000 c00a5354 c009c624 00000001 de793=
000 c05f8728 de79300c
[   60.490551] 5ec0: de793578 c00b00dc 00000000 c05f8728 00000000 de793=
578 de793000 00000001
[   60.498710] 5ee0: de793118 c00afc30 de79310c de793000 de1fd500 00000=
005 00000000 00000000
[   60.506870] 5f00: 00000000 00000000 00000000 c00b15d8 00000025 dfbdc=
dd0 de1fd500 00000005
[   60.515029] 5f20: 60000013 60000013 df764000 00000000 00000000 c008a=
064 de1fd500 00000000
[   60.523188] 5f40: 00000001 de1fd500 de1fd53c c0022ec0 00000000 df5c7=
800 df5c7b70 c00270e0
[   60.531348] 5f60: 00000000 c002fa90 00000100 00000100 df5a98c0 df597=
ec4 000000f8 c000fa68
[   60.539507] 5f80: df764000 00000000 00000000 c0027908 00000001 00000=
001 b6eae764 c0027998
[   60.547667] 5fa0: ffffffff c000f7c0 00000001 00000001 00000001 b6eb1=
0ac 00000001 ffffffff
[   60.555825] 5fc0: 00000001 00000001 b6eae764 000000f8 b6eb10ac 00000=
000 b6fdb000 00000000
[   60.563983] 5fe0: 00000000 beb90cd0 b6d9d220 b6e0f030 60000010 00000=
001 00000000 00000000
[   60.572165] [<c0097170>] (xnsynch=5Ftry=5Facquire) from [<c00a4738>]=
 (rtdm=5Fmutex=5Ftimedlock+0x78/0x184)
[   60.581090] [<c00a4738>] (rtdm=5Fmutex=5Ftimedlock) from [<c00a4860>=
] (rtdm=5Fmutex=5Flock+0x1c/0x24)
[   60.589602] [<c00a4860>] (rtdm=5Fmutex=5Flock) from [<c0355d04>] (rt=
=5Fsv=5Foffload=5Fclose+0x20/0x108)
[   60.598102] [<c0355d04>] (rt=5Fsv=5Foffload=5Fclose) from [<c00a2388=
>] (=5F=5Frtdm=5Fdev=5Fclose+0x20/0x3c)
[   60.606607] [<c00a2388>] (=5F=5Frtdm=5Fdev=5Fclose) from [<c00a5344>=
] (=5F=5Fput=5Ffd+0x1e0/0x1f0)
[   60.614330] [<c00a5344>] (=5F=5Fput=5Ffd) from [<c00a53bc>] (destroy=
=5Ffd+0x68/0x78)
[   60.621350] [<c00a53bc>] (destroy=5Ffd) from [<c009c624>] (xntree=5F=
cleanup+0x30/0x3c)
[   60.628915] [<c009c624>] (xntree=5Fcleanup) from [<c00b00dc>] (cobal=
t=5Fprocess=5Fdetach+0xb0/0x19c)
[   60.637506] [<c00b00dc>] (cobalt=5Fprocess=5Fdetach) from [<c00afc30=
>] (remove=5Fprocess+0x98/0xec)
[   60.646013] [<c00afc30>] (remove=5Fprocess) from [<c00b15d8>] (ipipe=
=5Fkevent=5Fhook+0x590/0x600)
[   60.654354] [<c00b15d8>] (ipipe=5Fkevent=5Fhook) from [<c008a064>] (=
=5F=5Fipipe=5Fnotify=5Fkevent+0x58/0x78)
[   60.663123] [<c008a064>] (=5F=5Fipipe=5Fnotify=5Fkevent) from [<c002=
2ec0>] (mmput+0x40/0xd4)
[   60.670837] [<c0022ec0>] (mmput) from [<c00270e0>] (do=5Fexit+0x264/=
0xa24)
[   60.677509] [<c00270e0>] (do=5Fexit) from [<c0027908>] (do=5Fgroup=5F=
exit+0x3c/0xbc)
[   60.684723] [<c0027908>] (do=5Fgroup=5Fexit) from [<c0027998>] (=5F=5F=
wake=5Fup=5Fparent+0x0/0x18)
[   60.692621] Code: e590301c e3c2203f e592e214 f57ff05b (e59e21e4)
[   60.698682] ---[ end trace 44c6f5a339c60d1e ]---
[   60.703277] Fixing recursive fault but reboot is needed!

Thanks.

Fran=C3=A7ois


