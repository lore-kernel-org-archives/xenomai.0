Message-ID: <5d3652f8-cd5c-b78b-2db2-705b9cabfa96@siemens.com>
Date: Tue, 4 Jan 2022 08:05:36 +0100
MIME-Version: 1.0
Subject: Re: x86 kernel Oops in Xeno-3.1/3.2
Content-Language: en-US
References: <CA+K1mPGZ3iwY=FKu8ds-6w+JHxFOOurwGvf-1Je1LKqkFemSLw@mail.gmail.com>
 <fa40c032-5580-806f-bcf7-53d323507b7d@siemens.com>
 <CA+K1mPEW1b6fYuzgYTc78477K0p5EbEc8J3rOmE_wd9-Xzyu3Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPEW1b6fYuzgYTc78477K0p5EbEc8J3rOmE_wd9-Xzyu3Q@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 03.01.22 22:12, C Smith wrote:
> On Sun, Jan 2, 2022 at 11:38 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 03.01.22 08:29, C Smith wrote:
>>> I have been getting kernel Oopses with x86 Xenomai 3.1 (and 3.2.1).
>>> In numerous tests, I can't keep a computer running for more than a day
>>> before the computer hard-locks (no kbd/mouse/ping). Frequently the
>>> kernel Oopses within 4-6 hours. I have tried 2 identical motherboards,
>>> changed RAM, and tried another manufacturer's motherboard on a 3rd
>>> computer.
>>>
>>> * Can someone supply me with a known successful x68 kernel 4.19.89
>>> config so I can compare and try those settings? I will attach my
>>> kernel config to this email, in hopes someone can see something wrong
>>> with them.
>>>
>>> Specs:  Intel i5-4590 CPU, Advantech motherboard with Q87 intel
>>> chipset, 8G RAM, Moxa 4-port PCI card w/ 16750 UARTs, 2 motherboard
>>> 16550 UARTS (in ISA memory range), Peak PCI CAN card, Xenomai 3.1
>>> (also xeno 3.2.1), Distro: RHEL8, with xenomai ipipe-patched 4.19.89
>>> kernel from kernel.org source.
>>>
>>> Sometimes onscreen (in a text terminal) I get this Oops:
>>>
>>> kernel tried to execute NX-protected page - exploit attempt? (uid: 1000)
>>> BUG: unable to handle kernel paging request at ...
>>> PGD ... P4D ... PUD .. PHD ...
>>> Oops: 0011 [#1] SMP PTI
>>> CPU: 1 P1D: 3539 Comm: gui Tainted: G OE 4.19.89xeno3.1-i64x3832 #2
>>> Hardware name: To be filled by O.E.M. To be filled by O.E.M./SHARKBAY,
>>> BIOS 4.6.5 08/29/2017
>>> I-pipe domain: Linux
>>> RIP: ... : ...
>>> Code: Bad RIP value.
>>>
>>> Which means the Instruction Pointer is in a Data area. That is bad,
>>> and I think it is caused by Cobalt code not restoring the
>>> stack/registers correctly during a context switch.
>>> Other times I get :
>>>
>>> Kernel Panic - not syncing: stack-protector: Kernel stack is corrupted
>>> in: __xnsched_run.part.63 h -
>>> CPU: 1 PID: 2409 Comm: appnrtB Tainted: G OE 4.19.89Nen03.1-i64x8632 #2
>>> Hardware name: To be filled by 0.E.M. To be filled by OEM, BIOS 4.6.5 04/23/2021
>>> I-pipe domain: Linux
>>> Call Trace:
>>> <IRQ>
>>> dump_stack+8x95/8xna
>>> panic+8xe§l8x246
>>> ? ___xnsched_run.part.63+8x5c4/8x4d0
>>> __stack_chhk_fail+8x19x8x28
>>> ___xnsched_run.part.63+8x§c4/Bx§d8
>>> ? release_ioapic_irq+8x3f/8x58
>>> ? __ipipe_end_fasteoi_irq+BNZZ/8x38
>>> xnintr;edge_vec_handler+BXBIA/8x558
>>> __ipipe_do_sync_pipeline+8xS/ana
>>> dispatch_irq_head+8xe6/Bx118
>>> __ipipe_dispatch_irq+ax1bc/Bx1e8
>>> __ipipe_handle_irq+8x198/x208
>>> ? common_interrupt+8xf/Bx2c
>>> </IRQ>
>>>
>>> The accompanying stack trace seems to implicate an ipipe interrupt
>>> handler as causing the problem. I'm using xeno_16550A.ko interrupts on
>>> an isolated interrupt level (IRQ 18).
>>>
>>> Interestingly, the Cobalt scheduler and my RT userspace app are still
>>> running after this, even though the Linux kernel is halted. I proved
>>> this on an oscilloscope: I can see serial packets going into and out
>>> of the serial ports at the expected periodic time base.
>>>
>>> (Note that the text of these kernel faults above is reconstructed with
>>> OCR so some addresses are not complete. The computer is hard-locked in
>>> a text terminal when these happen. I can supply the full JPG pictures
>>> or re-type addresses if you like.)
>>>
>>> The application scenario which causes the above problems:  The primary
>>> app, “apprt2”, is a 32-bit userspace app (compiled -m32) running on
>>> CPU core 1 (by fixed affinity), on 64 bit Xenomai 3.1 with ipipe patch
>>> applied for x86 kernel 4.19.89. It has shared memory via mmap() with
>>> an RTDM module (“modrt1”) but nothing is happening in “modrt1” at
>>> present, no interrupts etc. There are also two non-RT userspace linux
>>> apps which have attached to the same shared memory via mmap() but
>>> those are doing nothing much during these tests. I have attached
>>> several (1-6) RS232 serial devices and one CAN device all
>>> communicating with “apprt2”.
>>>
>>> The system does not fault (for 48+ hours) when no peripheral
>>> connections are present (Serial/CAN). The faults happen with Serial
>>> traffic, whether the CAN device is attached or not. The CAN device
>>> alone with no Serial does not cause the fault (tested for 48+ hours),
>>> and the fault has also happened when the motherboard serial ports were
>>> used, so the PCI Moxa code is not implicated.
>>>
>>> Note that in order to get 32-bit userspace support to fully work I had
>>> to manually patch the 16550A.c serial driver with the 32 bit
>>> “compatibility” patch from the xenomai mailing list. That works OK and
>>> my apps can communicate fine for hours. The serial packets in my
>>> applications have CRC checks so we know if data ever gets corrupted.
>>>
>>> Note that my apps have been running OK 32-bit on Xenomai v2.6 for two
>>> years. Also I ran my apps compiled as 64 bit on Xenomai v3.0.12 and
>>> did not get any faults in a test lasting 21+ hours (serial driver
>>> only, no CAN).
>>>
>>> Since I imagine Xenomai developers prefer to debug on recent builds, I
>>> also tested this on Xenomai 3.2.1 and I recompiled my apps 64 bit.  I
>>> still get kernel Oopses with Xeno 3.2.1 :
>>>
>>> kernel tried to execute NX-protected page - exploit attempt? (uid: 1000)
>>> BUG: unable to handle kernel paging request at ...
>>> PGD ... P4D ... PUD ... PMD ...
>>> Oops: 0011 [#1] SMP PTI
>>> CPU: 1 P1D: 3539 Comm: appnrtA Tainted: G OE 4.19.89xeno3.1-i64x3832 #2
>>> Hardware name: To be filled by O.E.M. To be filled by O.E.M./SHARKBAY,
>>> BIOS 4.6.5 08/29/2017
>>> I-pipe domain: Linux
>>> RIP: … : ...
>>> Code: Bad RIP value.
>>> …
>>>
>>> * Is there some way to instrument the Cobalt kernel to debug this ? It
>>> seems impossible to get any debug data from /proc/xenomai because the
>>> Linux kernel is Oopsed.
>>>
>>> A debugging problem:  occasionally with my apps compiled 64 bit on
>>> Xeno 3.1 or 3.2 the tests run 24+ hours OK (but would fault
>>> eventually, or in another test). So I get 'false positives' and it
>>> takes weeks to make progress.  It is easiest to generate a kernel Oops
>>> rapidly on Xeno 3.1 with my apps compiled 32 bit. So to expedite the
>>> testing process may I propose to keep compiling 32 bit and we
>>> instrument Xeno-3.1 (k4.19.89), and ultimately port the fix to
>>> xeno-3.2 (k4.19.89)?
>>>
>>> Thanks.  -C Smith
>>
>> The issue is only with 4.19-ipipe kernels?
> 
> Yes all of the oopses were on 4.19.89 ipipe kernels (x86).
> 
>> Are you able to test also
>> with 5.4-ipipe or 5.10/15-dovetail?
> 
> Yes I can test with both of those. I'll do that shortly.
> 
>> Can you also spend an extra UART for a kernel console so that crash
>> dumps may have a better chance to be reported?
> 
> I can spare a serial port for a terminal, but I believe I have
> complete crash dumps I can show
> you already in photos, so as to show you what has been happening
> historically in my tests this month.

The major drawback of screen-reported crashes is that you only have what
is on the frozen screen, nothing from the past before that. Plus, you
can't search in that.

> See this picture of a test w/ my  RT apps compiled 32 bit on Xeno-3.1,
> getting an NX protection fault from Dec 10th:
> https://drive.google.com/file/d/15QYgfa73mVr3vhGdPyrQsghG1WeMFZlL/view?usp=sharing
> 
> Here is another crash dump from Dec 30, in which my RT apps are
> compiled 64 bit running on Xeno 3.1,
> getting a Kernel panic this time:
> https://drive.google.com/file/d/1h7fePxUnrlm5H4PKpKALrQ_TK_dpqXj6/view?usp=sharing
> 
>> Regarding reference configurations: See also
>> https://source.denx.de/Xenomai/xenomai-images/-/tree/master/recipes-kernel/linux/files.
>> Not optimal ones, but tested.
> 
> I can't seem to find kernel configs in that file tree. Can you guide
> me to where an x86 kernel config is, so I can diff it against mine ?

https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/files/amd64_defconfig

That's a defconfig, so run "make olddefconfig" against it first.

> Maybe I can build one of these qemu images, but it is a lower priority
> as I need to do some other tests for you first like running
> with kernel 5.4 ipipe patch and then Dovetail.
> I fear that the qemu image would not be a useful test because there
> wouldn't be serial ports or serial interrupts, right?

There are as well, in fact. The first UART's output is redirected to the
console when you run start-qemu.sh. You can append a second UART via the
command line using QEMU options, and then you could even direct that
virtual UART to a real one of the host system.

The major issue with reproducing in QEMU[/KVM] is, though, that the
timings will suffer, and applications may even fail to run when
deadlines are missed. But if you could reproduce in QEMU, we may
simplify the reproduction to just sharing your VM image.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

