MIME-Version: 1.0
References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
 <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
 <73a5c9f6-5014-5113-1ddd-2fcf974273bb@siemens.com>
 <CAOuPNLjuB53ovnEBijNSqrgsKYcSGjLM-L=J4mfbRogwo_5kVA@mail.gmail.com>
 <CAOuPNLh2C8b1KC5D6+Lws_1UA0o0Sp_BaPb3mUTyebUPq_EduA@mail.gmail.com>
 <CAOuPNLiCfmUrDMWyX=N37hVJTBDEqwOtoOr1srf-55ks1qms+w@mail.gmail.com>
 <513744ad-f8fe-d54e-0618-fad492ed5bff@siemens.com>
 <5f46f00c-f09b-7439-93cf-4ff2a0343974@siemens.com>
 <6da8a3e2-7a76-afb2-c46c-7c173a8e444c@siemens.com>
 <CAOuPNLhYPGrP5s0y6e9HFUVrg2aDochOxF_fMkbjTmYnEvPOQQ@mail.gmail.com>
 <CAOuPNLjXN531P13WddSAQ-ZmnNOF_EQ4R+3eZ09VtG5zNvUH0g@mail.gmail.com>
 <aaa3a49e-ae7f-1696-199b-4ade86bd503f@siemens.com>
 <CAOuPNLi-p3A9LvkbpAVDapjN-dKgD8hJ3RJwJV+P=FvK2Pa7SA@mail.gmail.com>
 <8e8bd751-89b5-7006-a791-ae464838f5ed@siemens.com>
In-Reply-To: <8e8bd751-89b5-7006-a791-ae464838f5ed@siemens.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 27 Jun 2018 19:42:05 +0530
Message-ID: <CAOuPNLh6ShYRG3E1Q+uad4phS3+QEtogzzu6RQpLz=N4qVQX1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Kernel oops during rtnet loopback usage on x86_64
	(e1000e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

> With nosmap, that particular issue should no longer occur (at least as
> long as we can ask the kernel for this relaxation), so I suspect the
> other effect you see now is something else.

Just for the information, that issue occurred even on Beagle bone, and
there is no smap on arm.
However, it works on virtual box. how ?

This is the back trace seen on ARM Beagle bone:
{{{
[  970.717610] Unhandled fault: page domain fault (0x01b) at 0xbe926678
[  970.724030] pgd = da830000
[  970.726755] [be926678] *pgd=9cda7831, *pte=9a61634f, *ppte=9a61683f
[  970.733107] Internal error: : 1b [#1] PREEMPT SMP ARM
[  970.738188] Modules linked in: rt_loopback rtpacket rtudp rtipv4 rtnet
[  970.744831] CPU: 0 PID: 564 Comm: rtnet-client Not tainted 4.9.51-scel-beagle
bone #6
[  970.752611] Hardware name: Generic AM33XX (Flattened Device Tree)
[  970.758733] I-pipe domain: Linux
[  970.761979] task: dce0d740 task.stack: dce08000
[  970.766567] PC is at rt_udp_getfrag+0x48/0x118 [rtudp]
[  970.771796] LR is at rt_ip_build_xmit+0x230/0x2f4 [rtipv4]
[  970.777313] pc : [<bf026be0>]    lr : [<bf019688>]    psr: 20060013
[  970.777313] sp : dce09cf0  ip : bf026bb0  fp : dce09d14
[  970.788846] r10: dcb35824  r9 : 00000400  r8 : c12050a0
[  970.794099] r7 : dcd9e364  r6 : 0000000a  r5 : dce09db4  r4 : 00000000
[  970.800659] r3 : be926678  r2 : 00000000  r1 : be926678  r0 : 00000000
[  970.807221] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  970.814392] Control: 10c5387d  Table: 9a830019  DAC: 00000051
[  970.820168] Process rtnet-client (pid: 564, stack limit = 0xdce08220)
[  970.826642] Stack: (0xdce09cf0 to 0xdce0a000)
[  970.831025] 9ce0:                                     dce09d14 dce09d00 dcc0b
600 dcd9e2c0
[  970.839249] 9d00: 00000040 dcd9e364 dce09d6c dce09d18 bf019688 bf026ba4 c1205
0a0 00000000
[  970.847470] 9d20: dce09d6c dce09d30 bf017d4c bf01c13c 0000000a dce09db4 bf026
b98 0000000f
[  970.855692] 9d40: 00000000 c120418c dce09e64 00000002 dce09d98 dcb35800 dce09
dd4 00000000
[  970.863912] 9d60: dce09ebc dce09d70 bf027098 bf019464 dce09e64 00000000 00000
000 0000e015
[  970.872133] 9d80: 0100007f c1199b50 c12050a0 00000000 c0173fd0 dce09dd4 be926
6cc 00000010
[  970.880354] 9da0: be926678 00000001 00000000 00000000 00000000 e015a816 00000
a00 0100007f
[  970.888576] 9dc0: 0100007f dcb35800 be926678 00000001 00000000 be926714 00000
002 c0179034
[  970.896798] 9de0: c12095fc 00000002 c1200000 c010332c c0103340 c015ef90 c0103
32c ffffffff
[  970.905020] 9e00: c1209f90 00000002 c1200000 c0112abc c0112ad0 c015ef90 dce09
e4c dce09e28
[  970.913240] 9e20: 00000000 00000000 00000000 dce08000 c01ab530 c015f2d4 00000
000 00000000
[  970.921461] 9e40: 00000003 00000001 c020cdec c027ea78 c1199b50 e0150002 01000
07f 00000000
[  970.929682] 9e60: 00000000 0100007f 00000000 00000000 00000000 00000000 00000
000 00000000
[  970.937904] 9e80: 00000000 00000000 dcc0b600 00040933 dce09ebc dcb35800 c119a
cf0 40060013
[  970.946124] 9ea0: 00000000 00000003 dce09efc c11989b0 dce09ef4 dce09ec0 c027f
6f0 bf026cbc
[  970.954346] 9ec0: 00000052 dce0d740 00000000 00000003 00000000 00000051 00000
001 e0580008
[  970.962568] 9ee0: c0285920 c11989b0 dce09f34 dce09ef8 c02859b0 c027f65c e0580
008 be9266cc
[  970.970789] 9f00: 00000010 be926678 00000001 00000000 00000000 00000000 dce09
fb0 dce09fb0
[  970.979010] 9f20: 00000052 c12050a0 dce09f6c dce09f38 c029351c c028592c 00000
000 dce09f48
[  970.987231] 9f40: c02d1f68 df9429b0 df9419b0 c12050a0 20060013 c13f7600 c13f7
600 c11989b0
[  970.995452] 9f60: dce09fac dce09f70 c020d5a0 c029340c c11989b0 c119acf0 c13f7
600 dce09fb0
[  971.003675] 9f80: c02d8de4 00022080 00000000 be926680 000f0042 c0109288 dce08
000 00000002
[  971.011896] 9fa0: 00000000 dce09fb0 c01091d4 c020d4a8 10000054 00000003 be926
680 00000000
[  971.020119] 9fc0: 00022080 00000000 be926680 000f0042 00000003 00000002 00001
5e0 00000000
[  971.028340] 9fe0: b6f482d0 be926650 00000000 b6f2f044 00060030 10000054 00000
000 00000000
[  971.036617] [<bf026be0>] (rt_udp_getfrag [rtudp]) from [<bf019688>] (rt_ip_bu
ild_xmit+0x230/0x2f4 [rtipv4])
[  971.046445] [<bf019688>] (rt_ip_build_xmit [rtipv4]) from [<bf027098>] (rt_ud
p_sendmsg+0x3e8/0x45c [rtudp])
[  971.056256] [<bf027098>] (rt_udp_sendmsg [rtudp]) from [<c027f6f0>] (rtdm_fd_
sendmsg+0xa0/0x248)
[  971.065095] [<c027f6f0>] (rtdm_fd_sendmsg) from [<c02859b0>] (CoBaLt_sendmsg+
0x90/0x98)
[  971.073156] [<c02859b0>] (CoBaLt_sendmsg) from [<c029351c>] (ipipe_syscall_ho
ok+0x11c/0x400)
[  971.081647] [<c029351c>] (ipipe_syscall_hook) from [<c020d5a0>] (__ipipe_noti
fy_syscall+0x104/0x1d4)
[  971.090841] [<c020d5a0>] (__ipipe_notify_syscall) from [<c01091d4>] (pipeline
_syscall+0x8/0x24)
[  971.099591] Code: da00000a e5953014 e1a02000 e0831184 (e7930184)
[  971.105740] ---[ end trace 0e2d3ec12e870a84 ]---
}}}

I will try to debug this issue if my time permits.

Thanks,
Pintu
On Wed, Jun 27, 2018 at 4:44 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 2018-06-27 12:56, Pintu Kumar wrote:
> > Dear Jan,
> >
> >> What means "now"? Did it work before? What was the setup then?
> > rtnet loopback test is working (even with older kernel) on my Virtual
> > Box with Ubuntu 32-bit.
> >
> > But it never worked for me on x86_64 machine.
> > So, at first I wonder what is the minimum criteria to make rtnet work
> > on any system.
> > I am sure it would have definitely worked in the past. No?
>
> It surely worked, but it wasn't looked after consistently in the (even
> not so) recent past since then.
>
> >
> >> Either you drill deeper, systematically, and report your
> >> findings for discussions and suggestions on the list
> > Yes sure, I am ready to do that.
> > Once I know the little bit of history and current problems with rtnet,
> > I can definitely start contributing.
> > At first I assumed that there might be some fix already available.
> > So, instead of reinventing the wheel, I thought to first check out.
>
> The main recent problem was (and still is) related to SMAP (supervisor
> mode access prevention) which started to bite RTnet due to its sloppy
> way of taken data from user space or pushing it back there (not using
> proper copy-to/from services). The problem in the UDP code you ran into
> is related to the code still doing direct access (checksum generation
> over userspace data, rather than over the kernel copy).
>
> With nosmap, that particular issue should no longer occur (at least as
> long as we can ask the kernel for this relaxation), so I suspect the
> other effect you see now is something else.
>
> Jan
>
> >
> > I am really sorry for troubling you!
> > I will try to look into this issue and see if I can find something.
> >
> > Thank you!
> > Pintu
> >
> > On Wed, Jun 27, 2018 at 3:50 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 2018-06-26 13:08, Pintu Kumar wrote:
> >>> Dear Jan,
> >>>
> >>> Till now I haven't had any success for running my rtnet demo test
> >>> either or x86 or arm.
> >>> I even upgraded to xenomai-next (both kernel and user space) but still no luck.
> >>>
> >>> Now even the "loopback" test is not working on xenomai-next.
> >>
> >> What means "now"? Did it work before? What was the setup then?
> >>
> >>>
> >>> Can you confirm, if any of the below rtnet test works for you with
> >>> Kernel 4.9 and xenomai-next.
> >>> - xenomai-3-next/testsuite/smokey/net_udp
> >>> - url = https://git.code.sf.net/p/rtnet/code  => examples/generic/
> >>> - Or a simple UDP client/server program, compiled with xenomai posix skin
> >>>
> >>> I already tried with "nosmap" but there are no response coming (I am
> >>> getting no prints on console, but client is terminated).
> >>> If there is any work around to make rtnet works, please let me know.
> >>>
> >>
> >> I'm afraid there is currently a lack of bandwidth here to dive into the
> >> details. Either you drill deeper, systematically, and report your
> >> findings for discussions and suggestions on the list, or you need to be
> >> patient until someone finds the time to reproduce and resolve the issue(s).
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >> Corporate Competence Center Embedded Linux
>
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

