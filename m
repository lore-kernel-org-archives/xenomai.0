Message-ID: <fa40c032-5580-806f-bcf7-53d323507b7d@siemens.com>
Date: Mon, 3 Jan 2022 08:38:55 +0100
MIME-Version: 1.0
Subject: Re: x86 kernel Oops in Xeno-3.1/3.2
Content-Language: en-US
References: <CA+K1mPGZ3iwY=FKu8ds-6w+JHxFOOurwGvf-1Je1LKqkFemSLw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPGZ3iwY=FKu8ds-6w+JHxFOOurwGvf-1Je1LKqkFemSLw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 03.01.22 08:29, C Smith wrote:
> I have been getting kernel Oopses with x86 Xenomai 3.1 (and 3.2.1).
> In numerous tests, I can't keep a computer running for more than a day
> before the computer hard-locks (no kbd/mouse/ping). Frequently the
> kernel Oopses within 4-6 hours. I have tried 2 identical motherboards,
> changed RAM, and tried another manufacturer's motherboard on a 3rd
> computer.
> 
> * Can someone supply me with a known successful x68 kernel 4.19.89
> config so I can compare and try those settings? I will attach my
> kernel config to this email, in hopes someone can see something wrong
> with them.
> 
> Specs:  Intel i5-4590 CPU, Advantech motherboard with Q87 intel
> chipset, 8G RAM, Moxa 4-port PCI card w/ 16750 UARTs, 2 motherboard
> 16550 UARTS (in ISA memory range), Peak PCI CAN card, Xenomai 3.1
> (also xeno 3.2.1), Distro: RHEL8, with xenomai ipipe-patched 4.19.89
> kernel from kernel.org source.
> 
> Sometimes onscreen (in a text terminal) I get this Oops:
> 
> kernel tried to execute NX-protected page - exploit attempt? (uid: 1000)
> BUG: unable to handle kernel paging request at ...
> PGD ... P4D ... PUD .. PHD ...
> Oops: 0011 [#1] SMP PTI
> CPU: 1 P1D: 3539 Comm: gui Tainted: G OE 4.19.89xeno3.1-i64x3832 #2
> Hardware name: To be filled by O.E.M. To be filled by O.E.M./SHARKBAY,
> BIOS 4.6.5 08/29/2017
> I-pipe domain: Linux
> RIP: ... : ...
> Code: Bad RIP value.
> 
> Which means the Instruction Pointer is in a Data area. That is bad,
> and I think it is caused by Cobalt code not restoring the
> stack/registers correctly during a context switch.
> Other times I get :
> 
> Kernel Panic - not syncing: stack-protector: Kernel stack is corrupted
> in: __xnsched_run.part.63 h -
> CPU: 1 PID: 2409 Comm: appnrtB Tainted: G OE 4.19.89Nen03.1-i64x8632 #2
> Hardware name: To be filled by 0.E.M. To be filled by OEM, BIOS 4.6.5 04/23/2021
> I-pipe domain: Linux
> Call Trace:
> <IRQ>
> dump_stack+8x95/8xna
> panic+8xe§l8x246
> ? ___xnsched_run.part.63+8x5c4/8x4d0
> __stack_chhk_fail+8x19x8x28
> ___xnsched_run.part.63+8x§c4/Bx§d8
> ? release_ioapic_irq+8x3f/8x58
> ? __ipipe_end_fasteoi_irq+BNZZ/8x38
> xnintr;edge_vec_handler+BXBIA/8x558
> __ipipe_do_sync_pipeline+8xS/ana
> dispatch_irq_head+8xe6/Bx118
> __ipipe_dispatch_irq+ax1bc/Bx1e8
> __ipipe_handle_irq+8x198/x208
> ? common_interrupt+8xf/Bx2c
> </IRQ>
> 
> The accompanying stack trace seems to implicate an ipipe interrupt
> handler as causing the problem. I'm using xeno_16550A.ko interrupts on
> an isolated interrupt level (IRQ 18).
> 
> Interestingly, the Cobalt scheduler and my RT userspace app are still
> running after this, even though the Linux kernel is halted. I proved
> this on an oscilloscope: I can see serial packets going into and out
> of the serial ports at the expected periodic time base.
> 
> (Note that the text of these kernel faults above is reconstructed with
> OCR so some addresses are not complete. The computer is hard-locked in
> a text terminal when these happen. I can supply the full JPG pictures
> or re-type addresses if you like.)
> 
> The application scenario which causes the above problems:  The primary
> app, “apprt2”, is a 32-bit userspace app (compiled -m32) running on
> CPU core 1 (by fixed affinity), on 64 bit Xenomai 3.1 with ipipe patch
> applied for x86 kernel 4.19.89. It has shared memory via mmap() with
> an RTDM module (“modrt1”) but nothing is happening in “modrt1” at
> present, no interrupts etc. There are also two non-RT userspace linux
> apps which have attached to the same shared memory via mmap() but
> those are doing nothing much during these tests. I have attached
> several (1-6) RS232 serial devices and one CAN device all
> communicating with “apprt2”.
> 
> The system does not fault (for 48+ hours) when no peripheral
> connections are present (Serial/CAN). The faults happen with Serial
> traffic, whether the CAN device is attached or not. The CAN device
> alone with no Serial does not cause the fault (tested for 48+ hours),
> and the fault has also happened when the motherboard serial ports were
> used, so the PCI Moxa code is not implicated.
> 
> Note that in order to get 32-bit userspace support to fully work I had
> to manually patch the 16550A.c serial driver with the 32 bit
> “compatibility” patch from the xenomai mailing list. That works OK and
> my apps can communicate fine for hours. The serial packets in my
> applications have CRC checks so we know if data ever gets corrupted.
> 
> Note that my apps have been running OK 32-bit on Xenomai v2.6 for two
> years. Also I ran my apps compiled as 64 bit on Xenomai v3.0.12 and
> did not get any faults in a test lasting 21+ hours (serial driver
> only, no CAN).
> 
> Since I imagine Xenomai developers prefer to debug on recent builds, I
> also tested this on Xenomai 3.2.1 and I recompiled my apps 64 bit.  I
> still get kernel Oopses with Xeno 3.2.1 :
> 
> kernel tried to execute NX-protected page - exploit attempt? (uid: 1000)
> BUG: unable to handle kernel paging request at ...
> PGD ... P4D ... PUD ... PMD ...
> Oops: 0011 [#1] SMP PTI
> CPU: 1 P1D: 3539 Comm: appnrtA Tainted: G OE 4.19.89xeno3.1-i64x3832 #2
> Hardware name: To be filled by O.E.M. To be filled by O.E.M./SHARKBAY,
> BIOS 4.6.5 08/29/2017
> I-pipe domain: Linux
> RIP: … : ...
> Code: Bad RIP value.
> …
> 
> * Is there some way to instrument the Cobalt kernel to debug this ? It
> seems impossible to get any debug data from /proc/xenomai because the
> Linux kernel is Oopsed.
> 
> A debugging problem:  occasionally with my apps compiled 64 bit on
> Xeno 3.1 or 3.2 the tests run 24+ hours OK (but would fault
> eventually, or in another test). So I get 'false positives' and it
> takes weeks to make progress.  It is easiest to generate a kernel Oops
> rapidly on Xeno 3.1 with my apps compiled 32 bit. So to expedite the
> testing process may I propose to keep compiling 32 bit and we
> instrument Xeno-3.1 (k4.19.89), and ultimately port the fix to
> xeno-3.2 (k4.19.89)?
> 
> Thanks.  -C Smith

The issue is only with 4.19-ipipe kernels? Are you able to test also
with 5.4-ipipe or 5.10/15-dovetail?

Can you also spend an extra UART for a kernel console so that crash
dumps may have a better chance to be reported?

Regarding reference configurations: See also
https://source.denx.de/Xenomai/xenomai-images/-/tree/master/recipes-kernel/linux/files.
Not optimal ones, but tested.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

