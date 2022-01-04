MIME-Version: 1.0
References: <CA+K1mPGZ3iwY=FKu8ds-6w+JHxFOOurwGvf-1Je1LKqkFemSLw@mail.gmail.com>
 <fa40c032-5580-806f-bcf7-53d323507b7d@siemens.com>
 <CA+K1mPEW1b6fYuzgYTc78477K0p5EbEc8J3rOmE_wd9-Xzyu3Q@mail.gmail.com>
 <5d3652f8-cd5c-b78b-2db2-705b9cabfa96@siemens.com>
In-Reply-To: <5d3652f8-cd5c-b78b-2db2-705b9cabfa96@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 3 Jan 2022 23:44:05 -0800
Message-ID: <CA+K1mPH+XZjasuz1y9zSknidoyu0Cp_GuBpQWOLotDv6LTUJkQ@mail.gmail.com>
Subject: Re: x86 kernel Oops in Xeno-3.1/3.2
Content-Type: text/plain; charset="UTF-8"
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
Cc: Xenomai List <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On Mon, Jan 3, 2022 at 11:05 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 03.01.22 22:12, C Smith wrote:
> > On Sun, Jan 2, 2022 at 11:38 PM Jan Kiszka <jan.kiszka@siemens.com> wro=
te:
> >>
> >> On 03.01.22 08:29, C Smith wrote:
> >>> I have been getting kernel Oopses with x86 Xenomai 3.1 (and 3.2.1).
> >>> In numerous tests, I can't keep a computer running for more than a da=
y
> >>> before the computer hard-locks (no kbd/mouse/ping). Frequently the
> >>> kernel Oopses within 4-6 hours. I have tried 2 identical motherboards=
,
> >>> changed RAM, and tried another manufacturer's motherboard on a 3rd
> >>> computer.
> >>>
> >>> * Can someone supply me with a known successful x68 kernel 4.19.89
> >>> config so I can compare and try those settings? I will attach my
> >>> kernel config to this email, in hopes someone can see something wrong
> >>> with them.
> >>>
> >>> Specs:  Intel i5-4590 CPU, Advantech motherboard with Q87 intel
> >>> chipset, 8G RAM, Moxa 4-port PCI card w/ 16750 UARTs, 2 motherboard
> >>> 16550 UARTS (in ISA memory range), Peak PCI CAN card, Xenomai 3.1
> >>> (also xeno 3.2.1), Distro: RHEL8, with xenomai ipipe-patched 4.19.89
> >>> kernel from kernel.org source.
> >>>
> >>> Sometimes onscreen (in a text terminal) I get this Oops:
> >>>
> >>> kernel tried to execute NX-protected page - exploit attempt? (uid: 10=
00)
> >>> BUG: unable to handle kernel paging request at ...
> >>> PGD ... P4D ... PUD .. PHD ...
> >>> Oops: 0011 [#1] SMP PTI
> >>> CPU: 1 P1D: 3539 Comm: gui Tainted: G OE 4.19.89xeno3.1-i64x3832 #2
> >>> Hardware name: To be filled by O.E.M. To be filled by O.E.M./SHARKBAY=
,
> >>> BIOS 4.6.5 08/29/2017
> >>> I-pipe domain: Linux
> >>> RIP: ... : ...
> >>> Code: Bad RIP value.
> >>>
> >>> Which means the Instruction Pointer is in a Data area. That is bad,
> >>> and I think it is caused by Cobalt code not restoring the
> >>> stack/registers correctly during a context switch.
> >>> Other times I get :
> >>>
> >>> Kernel Panic - not syncing: stack-protector: Kernel stack is corrupte=
d
> >>> in: __xnsched_run.part.63 h -
> >>> CPU: 1 PID: 2409 Comm: appnrtB Tainted: G OE 4.19.89Nen03.1-i64x8632 =
#2
> >>> Hardware name: To be filled by 0.E.M. To be filled by OEM, BIOS 4.6.5=
 04/23/2021
> >>> I-pipe domain: Linux
> >>> Call Trace:
> >>> <IRQ>
> >>> dump_stack+8x95/8xna
> >>> panic+8xe=C2=A7l8x246
> >>> ? ___xnsched_run.part.63+8x5c4/8x4d0
> >>> __stack_chhk_fail+8x19x8x28
> >>> ___xnsched_run.part.63+8x=C2=A7c4/Bx=C2=A7d8
> >>> ? release_ioapic_irq+8x3f/8x58
> >>> ? __ipipe_end_fasteoi_irq+BNZZ/8x38
> >>> xnintr;edge_vec_handler+BXBIA/8x558
> >>> __ipipe_do_sync_pipeline+8xS/ana
> >>> dispatch_irq_head+8xe6/Bx118
> >>> __ipipe_dispatch_irq+ax1bc/Bx1e8
> >>> __ipipe_handle_irq+8x198/x208
> >>> ? common_interrupt+8xf/Bx2c
> >>> </IRQ>
> >>>
> >>> The accompanying stack trace seems to implicate an ipipe interrupt
> >>> handler as causing the problem. I'm using xeno_16550A.ko interrupts o=
n
> >>> an isolated interrupt level (IRQ 18).
> >>>
> >>> Interestingly, the Cobalt scheduler and my RT userspace app are still
> >>> running after this, even though the Linux kernel is halted. I proved
> >>> this on an oscilloscope: I can see serial packets going into and out
> >>> of the serial ports at the expected periodic time base.
> >>>
> >>> (Note that the text of these kernel faults above is reconstructed wit=
h
> >>> OCR so some addresses are not complete. The computer is hard-locked i=
n
> >>> a text terminal when these happen. I can supply the full JPG pictures
> >>> or re-type addresses if you like.)
> >>>
> >>> The application scenario which causes the above problems:  The primar=
y
> >>> app, =E2=80=9Capprt2=E2=80=9D, is a 32-bit userspace app (compiled -m=
32) running on
> >>> CPU core 1 (by fixed affinity), on 64 bit Xenomai 3.1 with ipipe patc=
h
> >>> applied for x86 kernel 4.19.89. It has shared memory via mmap() with
> >>> an RTDM module (=E2=80=9Cmodrt1=E2=80=9D) but nothing is happening in=
 =E2=80=9Cmodrt1=E2=80=9D at
> >>> present, no interrupts etc. There are also two non-RT userspace linux
> >>> apps which have attached to the same shared memory via mmap() but
> >>> those are doing nothing much during these tests. I have attached
> >>> several (1-6) RS232 serial devices and one CAN device all
> >>> communicating with =E2=80=9Capprt2=E2=80=9D.
> >>>
> >>> The system does not fault (for 48+ hours) when no peripheral
> >>> connections are present (Serial/CAN). The faults happen with Serial
> >>> traffic, whether the CAN device is attached or not. The CAN device
> >>> alone with no Serial does not cause the fault (tested for 48+ hours),
> >>> and the fault has also happened when the motherboard serial ports wer=
e
> >>> used, so the PCI Moxa code is not implicated.
> >>>
> >>> Note that in order to get 32-bit userspace support to fully work I ha=
d
> >>> to manually patch the 16550A.c serial driver with the 32 bit
> >>> =E2=80=9Ccompatibility=E2=80=9D patch from the xenomai mailing list. =
That works OK and
> >>> my apps can communicate fine for hours. The serial packets in my
> >>> applications have CRC checks so we know if data ever gets corrupted.
> >>>
> >>> Note that my apps have been running OK 32-bit on Xenomai v2.6 for two
> >>> years. Also I ran my apps compiled as 64 bit on Xenomai v3.0.12 and
> >>> did not get any faults in a test lasting 21+ hours (serial driver
> >>> only, no CAN).
> >>>
> >>> Since I imagine Xenomai developers prefer to debug on recent builds, =
I
> >>> also tested this on Xenomai 3.2.1 and I recompiled my apps 64 bit.  I
> >>> still get kernel Oopses with Xeno 3.2.1 :
> >>>
> >>> kernel tried to execute NX-protected page - exploit attempt? (uid: 10=
00)
> >>> BUG: unable to handle kernel paging request at ...
> >>> PGD ... P4D ... PUD ... PMD ...
> >>> Oops: 0011 [#1] SMP PTI
> >>> CPU: 1 P1D: 3539 Comm: appnrtA Tainted: G OE 4.19.89xeno3.1-i64x3832 =
#2
> >>> Hardware name: To be filled by O.E.M. To be filled by O.E.M./SHARKBAY=
,
> >>> BIOS 4.6.5 08/29/2017
> >>> I-pipe domain: Linux
> >>> RIP: =E2=80=A6 : ...
> >>> Code: Bad RIP value.
> >>> =E2=80=A6
> >>>
> >>> * Is there some way to instrument the Cobalt kernel to debug this ? I=
t
> >>> seems impossible to get any debug data from /proc/xenomai because the
> >>> Linux kernel is Oopsed.
> >>>
> >>> A debugging problem:  occasionally with my apps compiled 64 bit on
> >>> Xeno 3.1 or 3.2 the tests run 24+ hours OK (but would fault
> >>> eventually, or in another test). So I get 'false positives' and it
> >>> takes weeks to make progress.  It is easiest to generate a kernel Oop=
s
> >>> rapidly on Xeno 3.1 with my apps compiled 32 bit. So to expedite the
> >>> testing process may I propose to keep compiling 32 bit and we
> >>> instrument Xeno-3.1 (k4.19.89), and ultimately port the fix to
> >>> xeno-3.2 (k4.19.89)?
> >>>
> >>> Thanks.  -C Smith
> >>
> >> The issue is only with 4.19-ipipe kernels?
> >
> > Yes all of the oopses were on 4.19.89 ipipe kernels (x86).
> >
> >> Are you able to test also
> >> with 5.4-ipipe or 5.10/15-dovetail?
> >
> > Yes I can test with both of those. I'll do that shortly.
> >
> >> Can you also spend an extra UART for a kernel console so that crash
> >> dumps may have a better chance to be reported?
> >
> > I can spare a serial port for a terminal, but I believe I have
> > complete crash dumps I can show
> > you already in photos, so as to show you what has been happening
> > historically in my tests this month.
>
> The major drawback of screen-reported crashes is that you only have what
> is on the frozen screen, nothing from the past before that. Plus, you
> can't search in that.

Agreed, just showing you history. I have my kernel outputting to a
serial terminal now - I like it!
Here is kernel dump output from today. There was no serial activity
during this so maybe the serial driver is absolved? I was running
'switchtest -2s 200' during this:

[  427.925103] apprt2: External pulse period: 0 ns, frame divisor: 0
[ 1926.021851] kernel tried to execute NX-protected page - exploit
attempt? (uid: 1000)
[ 1926.029897] BUG: unable to handle kernel paging request at ffff95b8d4439=
d40
[ 1926.037164] PGD 35801067 P4D 35801067 PUD 2099a4063 PMD 20eede063
PTE 8000000154439063
[ 1926.045405] Oops: 0011 [#1] SMP PTI
[ 1926.049218] CPU: 2 PID: 2323 Comm: appnrt1 Tainted: G           OE
   4.19.89xeno3.1-i64x8632 #2
[ 1926.058430] Hardware name: To be filled by O.E.M. To be filled by
O.E.M./SHARKBAY, BIOS 4.6.5 08/29/2017
[ 1926.068268] I-pipe domain: Linux
[ 1926.071861] RIP: 0010:0xffff95b8d4439d40
[ 1926.076156] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <80> 00 02 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[ 1926.095348] RSP: 95b03ea0:000000000001a220 EFLAGS: 00003046
[ 1926.101356] RAX: ffff95b8e2bd8000 RBX: ffffffffa10b6040 RCX: 00000000000=
00000
[ 1926.108937] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff95b8e2a=
2f1c0
[ 1926.116529] RBP: ffff95b995b15210 R08: 0000000000031980 R09: 00000000000=
009dc
[ 1926.124127] R10: 00000000000009dc R11: 0000000000000000 R12: ffff95b995b=
03e80
[ 1926.131733] R13: ffff95b995b03e80 R14: 000000000002c720 R15: 00000000000=
00046
[ 1926.139341] FS:  0000000000000000(0000) GS:ffff95b995b00000(0063)
knlGS:00000000f6c2e740
[ 1926.147918] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[ 1926.154160] CR2: ffff95b8d4439d40 CR3: 0000000162a22006 CR4: 00000000001=
606a0
[ 1926.161801] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1926.169450] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1926.177095] Call Trace:
[ 1926.180054] Modules linked in: modrt1(OE) devlink xt_CHECKSUM
ipt_MASQUERADE xt_conntrack nft_compat nf_nat_tftp nft_objref
nf_conntrack_tftp nft_counter tun bridge stp llc rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv6
nft_reject nft_ct nf_tables_set nft_chain_nat_ipv6 nf_nat_ipv6
nft_chain_route_ipv6 nft_chain_nat_ipv4 nf_nat_ipv4 nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c
nft_chain_route_ipv4 ip_set nf_tables nfnetlink xeno_rtipc snd_pcm_oss
snd_mixer_oss sunrpc snd_hda_codec_hdmi snd_hda_intel snd_hda_codec
snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm intel_rapl
snd_timer intel_powerclamp snd coretemp crc32_pclmul xeno_can_peak_pci
joydev mei_wdt xeno_can_sja1000
[ 1926.253264]  mei_me intel_cstate rt_igb soundcore xeno_can(E)
rt_e1000e intel_uncore iTCO_wdt intel_rapl_perf iTCO_vendor_support
rtnet mei video lpc_ich radeon drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops ttm crc32c_intel drm serio_raw igb e1000e
ata_generic pata_acpi i2c_algo_bit fuse [last unloaded: i2c_i801]
[ 1926.283792] CR2: ffff95b8d4439d40
[ 1926.287879] ---[ end trace 00b88b101da84af3 ]---
[ 1926.293275] RIP: 0010:0xffff95b8d4439d40
[ 1926.297985] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <80> 00 02 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[ 1926.317585] RSP: 95b03ea0:000000000001a220 EFLAGS: 00003046
[ 1926.317586] RAX: ffff95b8e2bd8000 RBX: ffffffffa10b6040 RCX: 00000000000=
00000
[ 1926.317588] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff95b8e2a=
2f1c0
[ 1926.317589] RBP: ffff95b995b15210 R08: 0000000000031980 R09: 00000000000=
009dc
[ 1926.317590] R10: 00000000000009dc R11: 0000000000000000 R12: ffff95b995b=
03e80
[ 1926.317591] R13: ffff95b995b03e80 R14: 000000000002c720 R15: 00000000000=
00046
[ 1926.317593] FS:  0000000000000000(0000) GS:ffff95b995b00000(0063)
knlGS:00000000f6c2e740
[ 1926.317594] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[ 1926.317595] CR2: ffff95b8d4439d40 CR3: 0000000162a22006 CR4: 00000000001=
606a0
[ 1926.317597] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1926.317598] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400

> > See this picture of a test w/ my  RT apps compiled 32 bit on Xeno-3.1,
> > getting an NX protection fault from Dec 10th:
> > https://drive.google.com/file/d/15QYgfa73mVr3vhGdPyrQsghG1WeMFZlL/view?=
usp=3Dsharing
> >
> > Here is another crash dump from Dec 30, in which my RT apps are
> > compiled 64 bit running on Xeno 3.1,
> > getting a Kernel panic this time:
> > https://drive.google.com/file/d/1h7fePxUnrlm5H4PKpKALrQ_TK_dpqXj6/view?=
usp=3Dsharing
> >
> >> Regarding reference configurations: See also
> >> https://source.denx.de/Xenomai/xenomai-images/-/tree/master/recipes-ke=
rnel/linux/files.
> >> Not optimal ones, but tested.
> >
> > I can't seem to find kernel configs in that file tree. Can you guide
> > me to where an x86 kernel config is, so I can diff it against mine ?
>
> https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kerne=
l/linux/files/amd64_defconfig
>
> That's a defconfig, so run "make olddefconfig" against it first.

OK I will diff it against my config tomorrow...

> > Maybe I can build one of these qemu images, but it is a lower priority
> > as I need to do some other tests for you first like running
> > with kernel 5.4 ipipe patch and then Dovetail.
> > I fear that the qemu image would not be a useful test because there
> > wouldn't be serial ports or serial interrupts, right?
>
> There are as well, in fact. The first UART's output is redirected to the
> console when you run start-qemu.sh. You can append a second UART via the
> command line using QEMU options, and then you could even direct that
> virtual UART to a real one of the host system.
>
> The major issue with reproducing in QEMU[/KVM] is, though, that the
> timings will suffer, and applications may even fail to run when
> deadlines are missed. But if you could reproduce in QEMU, we may
> simplify the reproduction to just sharing your VM image.
>
> Jan
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

Thanks  -C Smith

