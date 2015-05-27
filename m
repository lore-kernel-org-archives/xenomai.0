From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Date: Wed, 27 May 2015 14:19:19 +0000
Message-ID: <C9F8415089354E4FB76F4548B3515AF48CD48B3E@edb1.wapice.localdomain>
References: <C9F8415089354E4FB76F4548B3515AF48CD382E9@edb0.wapice.localdomain>
In-Reply-To: <C9F8415089354E4FB76F4548B3515AF48CD382E9@edb0.wapice.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [RFC] [PATCH] Backport for chained interrupt handling
 fix - Linux 3.1.10 PowerPC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Actually this patch seems to crash the kernel from time to time if
lots of QE interrupts are handled (e.g. high Ethernet traffic).

Sometimes we get a kernel oops (same every time) and sometimes
the system seems to freeze somehow partially (user tasks
stop responding). The kernel oops is attached below.

We discovered that the latency problem is fixed and system is
stable (at least no crashes after a couple of days of continuous
test) if the patch is stripped of the changes to the file:
"arch/powerpc/kernel/ipipe.c". Therefore the only change is basically that
calls to the masking of the QE interrupt are removed
(ipipe_pre_cascade_noeoi).

That is actually what was suggested by Michael Pustylnik before:
http://www.xenomai.org/pipermail/xenomai/2012-April/025670.html
However, Philippe commented it would not work because there is a risk that
interrupts are re-enabled before "the handler" is invoked (which handler
actually?).

I have tried to understand where this actually can happen but I haven't
recognized the situation (and the system seems to be running fine).
To me it seems that the cascaded call to the __ipipe_handle_irq()
will always acknowledge (or actually mask since it is a level interrupt)
the demuxed IRQ in QE before  there are any calls to operations that
might re-enable interrupts (like syncing pipeline). If the demuxed IRQ is
masked before interrupts are re-enabled, do we have any problem?
According to QE datasheet, the interrupt request should stop if the interru=
pt
in the QE is masked.

If I understood correctly, the cascaded interrupt path (from QE) is like th=
is:

1. Exception 0x501 occurs
2. __ipipe_grab_irq() <-- interrupt num 33 (QE low prio)
3. __ipipe_handle_irq() <-- handle the multiplex IRQ 33
4. qe_ic_cascade_low_ipic() <-- acknowledge handler of the multiplex IRQ
5. __ipipe_handle_irq() <-- handle the demuxed IRQ
6. __ipipe_ack_level_irq() <-- mask/ack the demuxed IRQ in QE
7. __ipipe_dispatch_wired() <-- demuxed IRQ is wired

Even if the demuxed IRQ would not be handled as wired, it would be
acked/masked before a call to __ipipe_walk_pipeline().

I know this is an old Ipipe/Linux version (adeos-ipipe-3.1.10-powerpc-2.13-=
07.patch)
but I'm very interested in this issue.

Philippe, could you elaborate where exactly the problem might occur?

BR,
Jouko Haapaluoma
Wapice Ltd
Tampere, Finland



*****************************

Oops: Kernel access of bad area, sig: 11 [#1]
MPC8309 UNIC2CORE
Modules linked in: flx_frs rtl2_prot rtvlan rtnetproxy rt_loopback rtpacket=
 rtudp rt_ucc_geth rtipv4 rtnet
NIP: 00000000 LR: c0060df0 CTR: 00000000
REGS: cb4b1ba0 TRAP: 0400   Not tainted  (3.1.10-ipipe-HAL_8_1_5)
MSR: 20001032 <ME,IR,DR>  CR: 24044082  XER: 00000000
TASK =3D cbdceba0[1290] 'USMCoreTask' THREAD: cb4b0000
GPR00: c0060df0 cb4b1c50 cbdceba0 00000021 00000000 00000002 00000000 00000=
000
GPR08: 00000000 c050f240 00000000 c04d38c4 24044082 10021240 c050ee20 00009=
032
GPR16: ffffffff fffeffff cb4b1f50 00000000 00010000 c050ee20 00000010 c000e=
47c
GPR24: 00000025 c04d3888 c04f0000 c050ee20 c050a6e0 c050ee24 00000001 00000=
021
NIP [00000000]   (null)
LR [c0060df0] __ipipe_sync_stage+0x154/0x1f8
Call Trace:
[cb4b1c50] [c0060df0] __ipipe_sync_stage+0x154/0x1f8 (unreliable)
[cb4b1c90] [c000e810] __ipipe_handle_irq+0x124/0x178
[cb4b1cd0] [c000e8e0] __ipipe_grab_irq+0x3c/0x70
[cb4b1cf0] [c00107c4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at ipipe_unstall_pipeline_head+0x38/0x88
    LR =3D xnpod_suspend_thread+0x23c/0x298
[cb4b1db0] [c04d38c0] 0xc04d38c0 (unreliable)
[cb4b1de0] [c006f588] xnshadow_relax+0x7c/0x160
[cb4b1e80] [c00715b4] hisyscall_event+0x1d0/0x35c
[cb4b1ec0] [c00615a8] __ipipe_dispatch_event+0xac/0x1ec
[cb4b1f20] [c000ea5c] __ipipe_syscall_root+0x5c/0x140
[cb4b1f40] [c000fe60] DoSyscall+0x20/0x5c
--- Exception: c01 at 0x4849f7b4
    LR =3D 0x4826b9d0
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
---[ end trace e0653a9ce6b5e1c6 ]---

