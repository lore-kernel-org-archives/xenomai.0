Content-Type: text/plain; charset="utf-8"
In-Reply-To: <f9e58b19-4429-738e-6577-fd6b6d1723a0@siemens.com>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Date: Mon, 02 Dec 2019 10:49:57 +0100
MIME-Version: 1.0
Message-ID: <241a-5de4de80-13-6709f900@16316438>
Subject: =?utf-8?q?Re=3A?= Weird crash integrating new RTNET driver
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Le Vendredi, Novembre 29, 2019 17:45 CET, Jan Kiszka <jan.kiszka@siemen=
s.com> a =C3=A9crit: 
 
> On 29.11.19 17:19, Fran=C3=A7ois Legal wrote:
> > Le Vendredi, Novembre 29, 2019 17:05 CET, Jan Kiszka <jan.kiszka@si=
emens.com> a =C3=A9crit:
> >   
> >> On 29.11.19 16:05, Fran=C3=A7ois Legal wrote:
> >>> Le Vendredi, Novembre 29, 2019 15:45 CET, Jan Kiszka <jan.kiszka@=
siemens.com> a =C3=A9crit:
> >>>    
> >>>> On 29.11.19 15:38, Fran=C3=A7ois Legal via Xenomai wrote:
> >>>>> Le Jeudi, Novembre 28, 2019 09:27 CET, Fran=C3=A7ois Legal via =
Xenomai <xenomai@xenomai.org> a =C3=A9crit:
> >>>>>     
> >>>>>> Hello,
> >>>>>>
> >>>>>> I'm having a weird kernel crash at porting an existing custom =
network driver to RTNET.
> >>>>>> After the second unicast packet is received by the NIC (at the=
 second interrupt to be more precise), the kernel crashes while signali=
ng the pending threads on the rtdev event (rtdev->stack=5Fevent) during=
 the call to rt=5Fmark=5Fstack=5Fmgr.
> >>>>>> I dug as deep as I could, and found out that xnsynch=5Fflush d=
oes not seem to detect that there is only one pending thread on the eve=
nt, and thus tries to write to a poisonned list pointer.
> >>>>>>
> >>>>>> See the crash dump below.
> >>>>>> My configuration is linux 4.4.189 running on ARM Cortex A9 har=
dware, with xenomai 3.0.9.
> >>>>>>
> >>>>>> [   40.673006] Unable to handle kernel NULL pointer dereferenc=
e at virtual address 00000104
> >>>>>> [   40.681009] pgd =3D 40004000
> >>>>>> [   40.683698] [00000104] *pgd=3D00000000
> >>>>>> [   40.687261] Internal error: Oops: 817 [#1] PREEMPT SMP ARM
> >>>>>> [   40.692732] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.1=
89 #14
> >>>>>> [   40.698801] Hardware name: Xilinx Zynq Platform
> >>>>>> [   40.703314] I-pipe domain: Xenomai
> >>>>>> [   40.706702] task: 416a4328 ti: 416a0000 task.ti: 416a0000
> >>>>>> [   40.712097] PC is at xnsynch=5Fflush+0xb0/0x174
> >>>>>> [   40.716429] LR is at xnthread=5Fresume+0x100/0x2a8
> >>>>>> [   40.721026] pc : [<400970a8>]    lr : [<40098118>]    psr: =
20000193
> >>>>>> [   40.721026] sp : 416a1e00  ip : 00000200  fp : 00000098
> >>>>>> [   40.732480] r10: 416a54b8  r9 : 416a2578  r8 : 00000100
> >>>>>> [   40.737689] r7 : 00000200  r6 : 00000000  r5 : 00000000  r4=
 : 41760858
> >>>>>> [   40.744198] r3 : 41760620  r2 : 00000100  r1 : 00000002  r0=
 : 41760620
> >>>>>> [   40.750711] Flags: nzCv  IRQs off  FIQs on  Mode SVC=5F32  =
ISA ARM  Segment none
> >>>>>> [   40.757914] Control: 18c5387d  Table: 1993804a  DAC: 000000=
51
> >>>>>> [   40.763642] Process swapper/0 (pid: 0, stack limit =3D 0x41=
6a0220)
> >>>>>> [   40.769631] Stack: (0x416a1e00 to 0x416a2000)
> >>>>>> [   40.773977] 1e00: 00000003 41760848 5f557410 00000001 41760=
848 41699fb0 41699fb0 416a2578
> >>>>>> [   40.782136] 1e20: 416a54b8 5f5d4400 00000001 400a2dc4 5fbd2=
280 5f5d4560 61fa0000 750cd714
> >>>>>> [   40.790294] 1e40: 00000009 00000003 416a554c 403ef728 00000=
000 416a2578 41698278 00000000
> >>>>>> [   40.798454] 1e60: 416a20c0 5fbd2280 00000037 416a2578 416a5=
4b8 ffff0f00 5f5d4588 416a2578
> >>>>>> [   40.806613] 1e80: 41733340 40090524 00000037 41744b80 28197=
7d5 00000003 416a2578 5fbd2db0
> >>>>>> [   40.814772] 1ea0: 00000000 4169b280 5fbd2154 41722c40 00000=
000 5fbcfe18 5fbcfe14 5fbd2150
> >>>>>> [   40.822931] 1ec0: 41699fb0 416a2578 5fbd108c 41699fb0 1e537=
000 5fbcfe10 41733340 40088ab0
> >>>>>> [   40.831090] 1ee0: 416a9254 00000037 416a1f40 5fbcfe10 416a1=
f40 00000037 416a1f40 f8f00100
> >>>>>> [   40.839250] 1f00: f8f01100 416982c4 404e37c8 4000934c 416c2=
5c0 416a2700 f8f0010c 400095c8
> >>>>>> [   40.847408] 1f20: 40088758 40088784 60000013 ffffffff 416a1=
f74 416a23c0 416a2578 400139d4
> >>>>>> [   40.855567] 1f40: 00000000 5fbcfe10 00000000 00000000 41698=
e10 416a2498 416a2450 416dcc00
> >>>>>> [   40.863727] 1f60: 416a23c0 416a2578 416982c4 404e37c8 1e537=
000 416a1f90 40088758 40088784
> >>>>>> [   40.871886] 1f80: 60000013 ffffffff 00000051 416a2450 416a0=
000 40059cf8 416a1fa4 416dca57
> >>>>>> [   40.880045] 1fa0: 4066aa38 416dcc00 4066aa38 4062fc98 fffff=
fff ffffffff 00000000 4062f680
> >>>>>> [   40.888204] 1fc0: 00000000 5fffce40 00000000 4066aa38 00000=
000 416dce94 416a2440 4066aa34
> >>>>>> [   40.896364] 1fe0: 416a536c 0000406a 413fc090 00000000 00000=
000 0000807c 00000000 00000000
> >>>>>> [   40.904541] [<400970a8>] (xnsynch=5Fflush) from [<400a2dc4>=
] (rtdm=5Fevent=5Fsignal+0x70/0x144)
> >>>>>> [   40.912689] [<400a2dc4>] (rtdm=5Fevent=5Fsignal) from [<403=
ef728>] (rt=5Fmacip=5Finterrupt=5Frx+0x20c/0x248)
> >>>>>> [   40.921627] [<403ef728>] (rt=5Fmacip=5Finterrupt=5Frx) from=
 [<40090524>] (xnintr=5Firq=5Fhandler+0xc8/0x378)
> >>>>>> [   40.930574] [<40090524>] (xnintr=5Firq=5Fhandler) from [<40=
088ab0>] (dispatch=5Firq=5Fhead+0x9c/0x15c)
> >>>>>> [   40.939162] [<40088ab0>] (dispatch=5Firq=5Fhead) from [<400=
0934c>] (=5F=5Fipipe=5Fgrab=5Firq+0x64/0x7c)
> >>>>>> [   40.947490] [<4000934c>] (=5F=5Fipipe=5Fgrab=5Firq) from [<=
400095c8>] (gic=5Fhandle=5Firq+0x48/0x8c)
> >>>>>> [   40.955556] Exception stack(0x416a1f20 to 0x416a1f68)
> >>>>>> [   40.960596] 1f20: 40088758 40088784 60000013 ffffffff 416a1=
f74 416a23c0 416a2578 400139d4
> >>>>>> [   40.968755] 1f40: 00000000 5fbcfe10 00000000 00000000 41698=
e10 416a2498 416a2450 416dcc00
> >>>>>> [   40.976909] 1f60: 416a23c0 416a2578
> >>>>>> [   40.980387] [<400095c8>] (gic=5Fhandle=5Firq) from [<400139=
d4>] (=5F=5Firq=5Fsvc+0x54/0x80)
> >>>>>> [   40.987845] Exception stack(0x416a1f40 to 0x416a1f88)
> >>>>>> [   40.992886] 1f40: 00000000 5fbcfe10 00000000 00000000 41698=
e10 416a2498 416a2450 416dcc00
> >>>>>> [   41.001044] 1f60: 416a23c0 416a2578 416982c4 404e37c8 1e537=
000 416a1f90 40088758 40088784
> >>>>>> [   41.009199] 1f80: 60000013 ffffffff
> >>>>>> [   41.012679] [<400139d4>] (=5F=5Firq=5Fsvc) from [<40088784>=
] (ipipe=5Funstall=5Froot+0x3c/0x50)
> >>>>>> [   41.020495] [<40088784>] (ipipe=5Funstall=5Froot) from [<40=
059cf8>] (cpu=5Fstartup=5Fentry+0x144/0x1c8)
> >>>>>> [   41.029174] [<40059cf8>] (cpu=5Fstartup=5Fentry) from [<406=
2fc98>] (start=5Fkernel+0x3c8/0x3d4)
> >>>>>> [   41.037327] Code: e3a06000 e593c06c e1a00003 e3a01002 (e582=
c004)
> >>>>>> [   41.043401] ---[ end trace a517e81af11fe3d4 ]---
> >>>>>> [   41.048000] Kernel panic - not syncing: Attempted to kill t=
he idle task!
> >>>>>> [   42.227682] SMP: failed to stop secondary CPUs
> >>>>>> [   42.232040] ---[ end Kernel panic - not syncing: Attempted =
to kill the idle task!
> >>>>>>
> >>>>>> Thanks in advance
> >>>>>>
> >>>>>> Fran=C3=A7ois
> >>>>>>
> >>>>>>
> >>>>>     
> >>>>> Hello again.
> >>>>>
> >>>>> I ended up finding the CONFIG=5FDEBUG=5FLIST kernel hacking fla=
g and activated it.
> >>>>> It turns out (thus I have no idea why) that the rt=5Fstak=5Fmgr=
=5Ftask () is adding the same thread multiple times to the list (I put =
a break in the list=5Fadd debug function and I got the following backtr=
ace :
> >>>>>
> >>>>>     =5F=5Flist=5Fadd(): lib/list=5Fdebug.c, line 34
> >>>>> list=5Fadd(): include/linux/list.h, line 63
> >>>>> xnsynch=5Fsleep=5Fon(): kernel/xenomai/synch.c, line 186
> >>>>> rtdm=5Fevent=5Ftimedwait(): kernel/xenomai/rtdm/drvlib.c, line =
898
> >>>>> rtdm=5Fevent=5Fwait(): kernel/xenomai/rtdm/drvlib.c, line 828
> >>>>> rt=5Fstack=5Fmgr=5Ftask(): .../xenomai/net/stack/stack=5Fmgr.c,=
 line 204
> >>>>> ...
> >>>>>
> >>>>> I'll try to understand what's going on here, but any help would=
 be appreciated.
> >>>>
> >>>> Where is the second case?
> >>>>
> >>>> A threads adds itself here, so it would be hard to do this twice=
.
> >>>>
> >>>> The RTnet Ethernet driver is self-made?
> >>>>
> >>>> Jan
> >>>>
> >>>> -- 
> >>>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >>>> Corporate Competence Center Embedded Linux
> >>>    
> >>>    
> >>> Actually, the right question would be (if I understand your point=
 correctly) where is the first one !
> >>> How I understand it is that list=5Fadd is called to add an elemen=
t in the list that's already present in that list. And that makes sense=
 regarding the end result with the kernel crash while signaling the pen=
ding threads, as one thread is present in multiple elements of the list=
, when the first gets poisonned by list=5Fdel, so does the other I gues=
s.
> >>>
> >>> About the driver, yes, this is self made. Ported from a non RT wo=
rking one, following the MACB driver as guide.
> >>>
> >>> By checking out what could happen, I tried to add some xenomai de=
bug features.
> >>> It turns out that the RTNET thread seems to go to secondary mode =
due to kernel exception 8 :
> >>>
> >>> [  249.010022] [Xenomai] switching rtnet-stack to secondary mode =
after exception #8 in kernel-space at 0x403e9d5c (pid 637)
> >>> [  249.041650] ------------[ cut here ]------------
> >>> [  249.046289] WARNING: CPU: 1 PID: 637 at kernel/xenomai/rtdm/dr=
vlib.c:871 rtdm=5Fevent=5Ftimedwait+0x58/0x234()
> >>> [  249.055910] CPU: 1 PID: 637 Comm: rtnet-stack Not tainted 4.4.=
189 #11
> >>> [  249.062307] Hardware name: Xilinx Zynq Platform
> >>> [  249.066820] I-pipe domain: Linux
> >>> [  249.070064] [<40015b98>] (unwind=5Fbacktrace) from [<40012fd0>=
] (show=5Fstack+0x10/0x14)
> >>> [  249.077777] [<40012fd0>] (show=5Fstack) from [<402b1300>] (dum=
p=5Fstack+0x104/0x120)
> >>> [  249.085156] [<402b1300>] (dump=5Fstack) from [<400258b8>] (war=
n=5Fslowpath=5Fcommon+0x80/0xb0)
> >>> [  249.093219] [<400258b8>] (warn=5Fslowpath=5Fcommon) from [<400=
259b0>] (warn=5Fslowpath=5Fnull+0x1c/0x24)
> >>> [  249.101985] [<400259b0>] (warn=5Fslowpath=5Fnull) from [<400a4=
9ac>] (rtdm=5Fevent=5Ftimedwait+0x58/0x234)
> >>> [  249.110838] [<400a49ac>] (rtdm=5Fevent=5Ftimedwait) from [<400=
a4ba4>] (rtdm=5Fevent=5Fwait+0x1c/0x24)
> >>> [  249.119351] [<400a4ba4>] (rtdm=5Fevent=5Fwait) from [<403e51d8=
>] (rt=5Fstack=5Fmgr=5Ftask+0x34/0x84)
> >>> [  249.127592] [<403e51d8>] (rt=5Fstack=5Fmgr=5Ftask) from [<4009=
a500>] (kthread=5Ftrampoline+0x68/0xa4)
> >>> [  249.136095] [<4009a500>] (kthread=5Ftrampoline) from [<4003ece=
0>] (kthread+0xe4/0xf8)
> >>> [  249.143735] [<4003ece0>] (kthread) from [<4000f910>] (ret=5Ffr=
om=5Ffork+0x18/0x28)
> >>> [  249.150974] ---[ end trace 058d955f442fbf46 ]---
> >>>
> >>> What is kernel exception 8 ?
> >>
> >> This is likely the exception that recent kernels also throw when y=
ou
> >> "only" have a warning. And that warning is
> >>
> >> XENO=5FASSERT(COBALT, timeout < 0 || !xnsched=5Funblockable=5Fp())=

> >>
> >> You need to filter out what happens first.
> >>
> >> What is at 0x403e9d5c?
> >>
> >> Jan
> >>
> >> -- 
> >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >> Corporate Competence Center Embedded Linux
> > 
> > So I think I found out what happened. It seems it was an alignment =
problem while reading the IP header.
> > I had to skb=5Freserve 2 bytes et voil=C3=A0 !
> > 
> > I saw there was something like this in the MACB driver but I did no=
t really understood what this was about. Now I know. RTNET expect IP he=
ader to be on a 4 bytes alignment.
> 
> Yeah, the code was once written on x86... If you can identify the 
> unaligned access(es), fixing them properly would likely be better tha=
n 
> having to carry this in the drivers.
> 
> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
 
I took a look, and I believe, this "may" be caused by the iphdr struct =
taking saddr and daddr as 32 bits integers. However, this comes from ma=
inline linux (it is not redefined in xenomai), plus the ARM architectur=
e can manage unaligned word accesses to memory. So I'm not quite sure n=
ow what was causing that data abort exception in the first place !


