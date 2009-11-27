From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1259345664.2348.773.camel@domain.hid>
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>
	<200911232310.44441.berlemont.hauw@domain.hid>
	<4bed572e0911241334x7691431dh37a17c461be53d98@domain.hid>
	<200911242357.52347.berlemont.hauw@domain.hid>
	<4bed572e0911260022o70a984b1r98e6728044969d93@domain.hid>
	<72cf3fb0911260134m36c1d5b0s9b24843b11610455@domain.hid>
	<1259245325.2348.730.camel@domain.hid>
	<4B0F20AD.6050808@domain.hid>
	<1259345664.2348.773.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 19:30:22 +0100
Message-ID: <1259346622.2348.779.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-11-27 at 19:14 +0100, Philippe Gerum wrote:
> On Fri, 2009-11-27 at 01:43 +0100, Alexis Berlemont wrote:
> > Hi Philippe,
> > 
> > Philippe Gerum wrote:
> > > On Thu, 2009-11-26 at 10:34 +0100, Alexis Berlemont wrote:
> > >> On Thu, Nov 26, 2009 at 9:22 AM, Ettore Pedretti <epedrett@domain.hid> wrote:
> > >>> Hi Alexis,
> > >>>
> > >>> I applied the patch to my local git repository:
> > >>>
> > >>> fangorn:/usr/src#
> > >>> cd xenomai-head/
> > >>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
> > >>> patch_debug_1.diff
> > >>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
> > >>> ../patch_debug_1.diff:14: trailing whitespace.
> > >>>       rtdm_printk("\t handler=%p, irq=%d, cookie=%p\n",
> > >>> warning: 1 line adds whitespace errors.
> > >>>
> > >>> Then created a debian package:
> > >>>
> > >>> git-buildpackage -us -uc -rfakeroot --git-debian-branch=master
> > >>> --git-upstream-branch=origin/master --git-ignore-new
> > >>>
> > >>> built a new kernel package:
> > >>>
> > >>> fakeroot make-kpkg --initrd --added-patches xenomai
> > >>> --revision=ipipeComedi.2.4.06 --config menuconfig binary-arch
> > >>>
> > >>> and installed the Debian package with dpkg -i
> > >>>
> > >>> This is what happens when i insert the module into the kernel:
> > >>>
> > >>> fangorn:~/control/CHAMP/irqTest# insmod irqTest.ko
> > >>> Killed
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:Oops: 0000 [#1] PREEMPT SMP
> > >>> fangorn:~/control/CHAMP/irqTest#
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:last sysfs file: /sys/class/net/lo/operstate
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:Process insmod (pid: 3566, ti=f6c02000 task=f78634b0 task.ti=f6c02000)
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:I-pipe domain Linux
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:Stack:
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:Call Trace:
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:Code:  Bad EIP value.
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
> > >>>
> > >>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
> > >>>  kernel:CR2: 0000000000000000
> > >>>
> > >>> dmesg after insmod:
> > >>>
> > >>> irq_test: before rtdm_irq_request
> > >>> BUG: unable to handle kernel NULL pointer dereference at (null)
> > >>> IP: [<(null)>] (null)
> > >>> *pde = 00000000
> > >>> Oops: 0000 [#1] PREEMPT SMP
> > >>> last sysfs file: /sys/class/net/lo/operstate
> > >>> Modules linked in: irqTest(+) xeno_native analogy_ni_pcimio
> > >>> analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite
> > >>> xeno_analogy xeno_rtdm astropci ext3 jbd mbcache ide_pci_generic
> > >>> ide_core ata_piix sata_mv e1000 libata unix [last unloaded:
> > >>> scsi_wait_scan]
> > >>>
> > >>> Pid: 3566, comm: insmod Not tainted (2.6.31.1 #1) X6DA8
> > >>> EIP: 0060:[<00000000>] EFLAGS: 00010246 CPU: 1
> > >>> EIP is at 0x0
> > >>> EAX: 00000030
> > > 
> > > This is likely IRQ 48, with rthal_irq_enable jumping to address zero.
> > > 
> > >>  EBX: 00000000 ECX: 00000030 EDX: c1250b80
> > >>> ESI: f8e24500 EDI: 00000000 EBP: f6c03f1c ESP: f6c03f18
> > >>>  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> > >>> Process insmod (pid: 3566, ti=f6c02000 task=f78634b0 task.ti=f6c02000)
> > >>> I-pipe domain Linux
> > >>> Stack:
> > >>>  c1154166 f6c03f24 c105abf7 f6c03f40 f8a0ea5d f8e24000 00000000 00000000
> > >>> <0> f8e27000 00000000 f6c03f58 f8e2703e 00000000 f8e24066 00000000 f8e27000
> > >>> <0> f6c03f84 c1001028 f8e243c0 00000001 fffffffc f8e243c0 00000000 f6c03f84
> > >>> Call Trace:
> > >>>  [<c1154166>] ? rthal_irq_enable+0x2d/0x31
> > >>>  [<c105abf7>] ? xnintr_enable+0xb/0xd
> > >>>  [<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
> > >>>  [<f8e24000>] ? test_handler+0x0/0x1c [irqTest]
> > >>>  [<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
> > >>>  [<f8e2703e>] ? __test_init+0x3e/0x7e [irqTest]
> > >>>  [<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
> > >>>  [<c1001028>] ? do_one_initcall+0x23/0x183
> > >>>  [<c103a825>] ? blocking_notifier_call_chain+0x1a/0x1c
> > >>>  [<c10481e9>] ? sys_init_module+0xad/0x1ec
> > >>>  [<c1092cc5>] ? sys_close+0x71/0xb5
> > >>>  [<c1002c25>] ? sysenter_do_call+0x12/0x16
> > >>> Code:  Bad EIP value.
> > >>> EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
> > >>> CR2: 0000000000000000
> > >>> ---[ end trace ac2616367ecf94b2 ]---
> > >>>
> > >>> I hope this is what you wanted me to try. Please let me know.
> > >> So if I understand well, you "insmoded" the little test module which
> > >> does nothing but calling rtdm_irq_request() and the NULL pointer bug
> > >> occured.
> > >>
> > >> This bug occurred before calling analogy_config, you did not tried to
> > >> attach the ni_pcimio driver, right ?
> > >>
> > >> If I am right, it seems like the bug is not located in analogy but
> > >> between Xenomai's nucleus and Ipipe, which is ... weird.
> > >>
> > > 
> > > The IRQ requested does not seem to have been associated with any chip
> > > controller, which is likely the basic issue.
> > 
> > I had a look at arch/x86/kernel/apic/io_apic.c and the only controllers 
> > which seem left unhandled by ipipe are the remapped ones (and the hpet 
> > but I doubt it could be the hpet). Do you see any other possibility ?
> > 
> 
> What needs to be assessed is whether irq48 gets registered through
> ioapic_register_intr() because a routing was found, or not. Likely not.
> 
> > Do you think that writing a little test module which requests the irq 
> > (through Linux API) is a good idea ?
> > 

Sorry, I'm just catching up with your idea. Yes, you could check this
way whether irq48 was registered at low-level, but it would not tell you
why it is not.

-- 
Philippe.



