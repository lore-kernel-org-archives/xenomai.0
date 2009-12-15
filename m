MIME-Version: 1.0
In-Reply-To: <4B16F674.5090200@domain.hid>
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>
	<200911232310.44441.berlemont.hauw@domain.hid>
	<4bed572e0911241334x7691431dh37a17c461be53d98@domain.hid>
	<200911242357.52347.berlemont.hauw@domain.hid>
	<4bed572e0911260022o70a984b1r98e6728044969d93@domain.hid>
	<72cf3fb0911260134m36c1d5b0s9b24843b11610455@domain.hid>
	<4bed572e0911261538m787ec9c9qf2a76d8e892f2d48@domain.hid>
	<4B12FD90.30804@domain.hid>
	<4bed572e0911300041k5bb51bf6nbe83b2a9233d76b0@domain.hid>
	<4B16F674.5090200@domain.hid>
Date: Tue, 15 Dec 2009 15:41:49 +0000
Message-ID: <4bed572e0912150741l37bea514t773c71f645fbeba5@domain.hid>
From: Ettore Pedretti <epedrett@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi,

I have added routeirq to the kernel parameters:

kernel          /boot/vmlinuz-2.6.31.1 root=3DLABEL=3DROOTFS_TEST ro noht
mem=3D2048M memmap=3D1024M pci=3Drouteirq

When I insert your test module:

fangorn:~/control/CHAMP/irqTest# insmod test_module.ko

The trace is:

rq_test: before request_irq
irq_test: after request_irq (err =3D 0)

When I try the attach procedure:

analogy_config analogy0 analogy_ni_pcimio
Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:Oops: 0000 [#1] PREEMPT SMP

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:last sysfs file: /sys/class/net/lo/operstate

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:Process analogy_config (pid: 3556, ti=3Df6c48000 task=3Df790c730
task.ti=3Df6c48000)

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:I-pipe domain Linux

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:Stack:

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:Call Trace:

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d4 fe ff ff
8b 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00 00 8b 42
18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b 01 00 00 31

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:EIP: [<f8c7f029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
SS:ESP 0068:f6c49dc8

Message from syslogd@domain.hid at Dec 15 07:39:25 ...
 kernel:CR2: 0000000000000004

And the trace:

a4l: analogy_ni_pcimio: pcimio_attach: found pci-6711 board
mite 0000:04:01.0: PCI->APIC IRQ transform: INT A -> IRQ 48
mite 0000:04:01.0: setting latency timer to 64
a4l: MITE: 0xd0801000 mapped to f8e32000
a4l: DAQ: 0xd0800000 mapped to f8e36000
a4l: MITE: version =3D 1, type =3D 1, mite mode =3D 1, interface mode =3D 3
a4l: MITE: num channels =3D 3, write post fifo depth =3D 1, wins =3D 0, iow=
ins =3D 2
a4l: analogy_ni_pcimio: pcimio_attach: found irq 48
BUG: unable to handle kernel NULL pointer dereference at 00000004
IP: [<f8c7f029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
*pde =3D 00000000
Oops: 0000 [#1] PREEMPT SMP
last sysfs file: /sys/class/net/lo/operstate
Modules linked in: test_module xeno_native analogy_ni_pcimio
analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite
xeno_analogy xeno_rtdm astropci ext3 jbd mbcache ide_pci_generic
ide_core ata_piix e1000 sata_mv libata unix [last unloaded:
scsi_wait_scan]

Pid: 3556, comm: analogy_config Not tainted (2.6.31.1 #1) X6DA8
EIP: 0060:[<f8c7f029>] EFLAGS: 00010202 CPU: 1
EIP is at ni_E_init+0x267/0xff1 [analogy_ni_mio]
EAX: 00000000 EBX: f8a24280 ECX: f8c33e6c EDX: f8c33e60
ESI: 00000000 EDI: f8c33e60 EBP: f6c49e38 ESP: f6c49dc8
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process analogy_config (pid: 3556, ti=3Df6c48000 task=3Df790c730 task.ti=3D=
f6c48000)
I-pipe domain Linux
Stack:
 f6c49dd0 c10143ee f6c49dd8 f8c33e60 f6c49de0 c105ad27 f6c49dfc f8a10a5d
<0> f8c2de00 00000000 00000001 f8c33e94 fffffff0 f6c49e14 f8c2e118 00000001
<0> f8c30d0d f8c33e88 f8c33e60 f6c49e38 f8c2eccf 00000001 f8c33e60 00000030
Call Trace:
 [<c10143ee>] ? unmask_IO_APIC_irq+0xd/0xf
 [<c105ad27>] ? xnintr_enable+0xb/0xd
 [<f8a10a5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
 [<f8c2de00>] ? a4l_handle_irq+0x0/0x1a [xeno_analogy]
 [<f8c2e118>] ? __a4l_request_irq+0x33/0x39 [xeno_analogy]
 [<f8c2eccf>] ? a4l_request_irq+0x98/0xaf [xeno_analogy]
 [<f8c8dd8a>] ? pcimio_attach+0x54d/0x664 [analogy_ni_pcimio]
 [<f8c2cfef>] ? a4l_assign_driver+0x61/0x134 [xeno_analogy]
 [<f8c2d2ba>] ? a4l_device_attach+0x54/0x6d [xeno_analogy]
 [<c106641a>] ? xnshadow_ppd_get+0x4f/0x58
 [<f8c2d54f>] ? a4l_ioctl_devcfg+0x57/0x104 [xeno_analogy]
 [<f8c2f36f>] ? a4l_rt_ioctl+0x33/0x3a [xeno_analogy]
 [<f8a0f3e6>] ? __rt_dev_ioctl+0xd1/0xd8 [xeno_rtdm]
 [<f8a11e77>] ? sys_rtdm_open+0x5c/0x64 [xeno_rtdm]
 [<f8a11dde>] ? sys_rtdm_ioctl+0x29/0x2b [xeno_rtdm]
 [<c1069ade>] ? losyscall_event+0xa9/0x190
 [<c10567fe>] ? __ipipe_dispatch_event+0xdf/0x201
 [<c1069a35>] ? losyscall_event+0x0/0x190
 [<c10167d1>] ? __ipipe_syscall_root+0x3b/0xc4
 [<c1002cfd>] ? system_call+0x2d/0x4f
Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d4 fe ff ff 8b 55
9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00 00 8b 42 18 <8b>
40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b 01 00 00 31
EIP: [<f8c7f029>] ni_E_init+0x267/0xff1 [analogy_ni_mio] SS:ESP 0068:f6c49d=
c8
CR2: 0000000000000004
---[ end trace bcff6beb2ba30576 ]---

Ettore


2009/12/2 Alexis Berlemont <berlemont.hauw@domain.hid>:
> Hi,
>
> Ettore Pedretti wrote:
>>
>> Hi,
>
> Sorry for the late reply.
>
>> I applied your kernel patch before applying the xenomai patch. When I
>> insert the kernel patch I obtain:
>>
>> insmod: error inserting 'test_module.ko': -1 Function not implemented
>
> Yes. request_irq returns an error because the io_apic did not register
> the interrupt.
>
>> Attached is the content of dmesg from boot to module insertion.
>
> Thanks to your traces and a look at the x86-specific pci code in the
> kernel (arch/x86/pci), I think I understand the way it works.
>
> The fact that request_irq return -ENOSYS is normal: the irq is not
> "enabled". In order to enable the pci card's irq, we have to enable the
> pci device (thanks to a call to pci_enable()). This operation will route
> the PCI interrupt line to an io_apic irq; after that, the io_apic will
> register the irq. Once this procedure is complete, the irq is made
> available for Linux.
>
> That is the reason why, our little Linux test module failed and our
> little RTDM test module crashed.
>
> If you had the kernel boot argument "pci=3Drouteirq", both test modules
> should insmod fine because all pci interrupt are "enabled" during the
> PCI discovery.
>
> Concerning the analogy driver, that does not explain the problem because
> the pci board enabling is _supposed_ to be ok. Could you also test the
> attach procedure with kernel boot argument specified above ?
>
>> Cheers
>> -ep
>>
>> ps. I am leaving the mountain tomorrow and will be travelling until
>> Friday. I hope I will be able to test the machine at distance without
>> crashing it for good.
>>
>>
>>
>>
>> 2009/11/29 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>
>>> Hi,
>>>
>>> Ettore Pedretti wrote:
>>>>
>>>> 2009/11/26 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>>>
>>>>> On Thu, Nov 26, 2009 at 9:22 AM, Ettore Pedretti <epedrett@domain.hid>
>>>>> wrote:
>>>>>>
>>>>>> Hi Alexis,
>>>>>>
>>>>>> I applied the patch to my local git repository:
>>>>>>
>>>>>> fangorn:/usr/src#
>>>>>> cd xenomai-head/
>>>>>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
>>>>>> patch_debug_1.diff
>>>>>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
>>>>>> ../patch_debug_1.diff:14: trailing whitespace.
>>>>>> =A0 =A0 rtdm_printk("\t handler=3D%p, irq=3D%d, cookie=3D%p\n",
>>>>>> warning: 1 line adds whitespace errors.
>>>>>>
>>>>>> Then created a debian package:
>>>>>>
>>>>>> git-buildpackage -us -uc -rfakeroot --git-debian-branch=3Dmaster
>>>>>> --git-upstream-branch=3Dorigin/master --git-ignore-new
>>>>>>
>>>>>> built a new kernel package:
>>>>>>
>>>>>> fakeroot make-kpkg --initrd --added-patches xenomai
>>>>>> --revision=3DipipeComedi.2.4.06 --config menuconfig binary-arch
>>>>>>
>>>>>> and installed the Debian package with dpkg -i
>>>>>>
>>>>>> This is what happens when i insert the module into the kernel:
>>>>>>
>>>>>> fangorn:~/control/CHAMP/irqTest# insmod irqTest.ko
>>>>>> Killed
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:Oops: 0000 [#1] PREEMPT SMP
>>>>>> fangorn:~/control/CHAMP/irqTest#
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:last sysfs file: /sys/class/net/lo/operstate
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:Process insmod (pid: 3566, ti=3Df6c02000 task=3Df78634b0
>>>>>> task.ti=3Df6c02000)
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:I-pipe domain Linux
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:Stack:
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:Call Trace:
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:Code: =A0Bad EIP value.
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
>>>>>>
>>>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>>>> =A0kernel:CR2: 0000000000000000
>>>>>>
>>>>>> dmesg after insmod:
>>>>>>
>>>>>> irq_test: before rtdm_irq_request
>>>>>> BUG: unable to handle kernel NULL pointer dereference at (null)
>>>>>> IP: [<(null)>] (null)
>>>>>> *pde =3D 00000000
>>>>>> Oops: 0000 [#1] PREEMPT SMP
>>>>>> last sysfs file: /sys/class/net/lo/operstate
>>>>>> Modules linked in: irqTest(+) xeno_native analogy_ni_pcimio
>>>>>> analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite
>>>>>> xeno_analogy xeno_rtdm astropci ext3 jbd mbcache ide_pci_generic
>>>>>> ide_core ata_piix sata_mv e1000 libata unix [last unloaded:
>>>>>> scsi_wait_scan]
>>>>>>
>>>>>> Pid: 3566, comm: insmod Not tainted (2.6.31.1 #1) X6DA8
>>>>>> EIP: 0060:[<00000000>] EFLAGS: 00010246 CPU: 1
>>>>>> EIP is at 0x0
>>>>>> EAX: 00000030 EBX: 00000000 ECX: 00000030 EDX: c1250b80
>>>>>> ESI: f8e24500 EDI: 00000000 EBP: f6c03f1c ESP: f6c03f18
>>>>>> =A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
>>>>>> Process insmod (pid: 3566, ti=3Df6c02000 task=3Df78634b0 task.ti=3Df=
6c02000)
>>>>>> I-pipe domain Linux
>>>>>> Stack:
>>>>>> =A0c1154166 f6c03f24 c105abf7 f6c03f40 f8a0ea5d f8e24000 00000000
>>>>>> 00000000
>>>>>> <0> f8e27000 00000000 f6c03f58 f8e2703e 00000000 f8e24066 00000000
>>>>>> f8e27000
>>>>>> <0> f6c03f84 c1001028 f8e243c0 00000001 fffffffc f8e243c0 00000000
>>>>>> f6c03f84
>>>>>> Call Trace:
>>>>>> =A0[<c1154166>] ? rthal_irq_enable+0x2d/0x31
>>>>>> =A0[<c105abf7>] ? xnintr_enable+0xb/0xd
>>>>>> =A0[<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
>>>>>> =A0[<f8e24000>] ? test_handler+0x0/0x1c [irqTest]
>>>>>> =A0[<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
>>>>>> =A0[<f8e2703e>] ? __test_init+0x3e/0x7e [irqTest]
>>>>>> =A0[<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
>>>>>> =A0[<c1001028>] ? do_one_initcall+0x23/0x183
>>>>>> =A0[<c103a825>] ? blocking_notifier_call_chain+0x1a/0x1c
>>>>>> =A0[<c10481e9>] ? sys_init_module+0xad/0x1ec
>>>>>> =A0[<c1092cc5>] ? sys_close+0x71/0xb5
>>>>>> =A0[<c1002c25>] ? sysenter_do_call+0x12/0x16
>>>>>> Code: =A0Bad EIP value.
>>>>>> EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
>>>>>> CR2: 0000000000000000
>>>>>> ---[ end trace ac2616367ecf94b2 ]---
>>>>>>
>>>>>> I hope this is what you wanted me to try. Please let me know.
>>>>>
>>>>> So if I understand well, you "insmoded" the little test module which
>>>>> does nothing but calling rtdm_irq_request() and the NULL pointer bug
>>>>> occured.
>>>>
>>>> Correct
>>>>
>>>>> This bug occurred before calling analogy_config, you did not tried to
>>>>> attach the ni_pcimio driver, right ?
>>>>
>>>> I insmod-ed the test module that gave that error dump. I later tried
>>>> to attach the driver which causes the usual error. The stack-dumps I
>>>> sent are solely related to insmod of test program.
>>>>
>>>>> If I am right, it seems like the bug is not located in analogy but
>>>>> between Xenomai's nucleus and Ipipe, which is ... weird.
>>>>>
>>>>> What is your kernel configuration ? no IO_APIC ?
>>>>
>>>> I put back my config to IO_APIC. Should I disable that again?
>>>> attached is my kernel configuration (configAnalogy)
>>>>
>>>>
>>>>> Which irq did you try to request ? 48 or 5 ?
>>>>
>>>> I do not know. do I have to pass parameters to insmod?
>>>>
>>>> This is my /proc/interrupts if that is helpful
>>>> =A0 =A0 =A0 =A0 =A0CPU0 =A0 =A0 =A0 CPU1
>>>> =A00: =A0 =A0 =A0 =A0222 =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-edge =A0 =A0=
 =A0timer
>>>> =A01: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A09 =A0 IO-APIC-edge =A0 =
=A0 =A0i8042
>>>> =A02: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0XT-PIC-XT =A0 =
=A0 =A0 =A0cascade
>>>> =A012: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0132 =A0 IO-APIC-edge =A0 =
=A0 =A0i8042
>>>> =A014: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A08 =A0 IO-APIC-edge =A0 =
=A0 =A0ata_piix
>>>> =A015: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A012358 =A0 IO-APIC-edge =A0 =A0 =
=A0ata_piix
>>>> =A020: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =
=A0 astropci0
>>>> =A028: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0235 =A0 IO-APIC-fasteoi =A0=
 sata_mv
>>>> =A054: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A077950 =A0 IO-APIC-fasteoi =A0 e=
th0
>>>> NMI: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Non-maskable interr=
upts
>>>> LOC: =A0 45365307 =A0 45365133 =A0 Local timer interrupts
>>>> SPU: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Spurious interrupts
>>>> CNT: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Performance counter=
 interrupts
>>>> PND: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Performance pending=
 work
>>>> RES: =A0 =A0 =A0 2555 =A0 =A0 =A0 2212 =A0 Rescheduling interrupts
>>>> CAL: =A0 =A0 =A0 =A0 60 =A0 =A0 =A0 =A0 58 =A0 Function call interrupt=
s
>>>> TLB: =A0 =A0 =A0 =A0419 =A0 =A0 =A0 =A0200 =A0 TLB shootdowns
>>>> TRM: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Thermal event inter=
rupts
>>>> THR: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Threshold APIC inte=
rrupts
>>>> MCE: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Machine check excep=
tions
>>>> MCP: =A0 =A0 =A0 =A0152 =A0 =A0 =A0 =A0152 =A0 Machine check polls
>>>> ERR: =A0 =A0 =A0 =A0 =A00
>>>> MIS: =A0 =A0 =A0 =A0 =A00
>>>>
>>>> and my /proc/xenomai/irq
>>>>
>>>> IRQ =A0 =A0 =A0 =A0 CPU0 =A0 =A0 =A0 =A0CPU1
>>>> 516: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [IPI]
>>>> 519: =A0 =A046161773 =A0 =A046161772 =A0 =A0 =A0 =A0 [timer]
>>>> 520: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [crit=
ical sync]
>>>> 546: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [virt=
ual]
>>>>
>>>>
>>>>> Which CPU are you using ?
>>>>
>>>> CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
>>>> CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
>>>>
>>>> As Philippe rightly pointed out this is a 32-bit install although the
>>>> CPUs are 64 bit
>>>
>>> Following Philippe's advice, I attached a little patch for your kernel
>>> sources. Could you apply it and send the kernel log messages ?
>>>
>>> You will also find attached the sources of a little module which calls
>>> Linux' request_irq(48). Could you insmod the module and send a dump of
>>> /proc/interrupts ?
>>>
>>>>> Thank you for your time.
>>>>>
>>>>>> Cheers
>>>>>> Ettore
>>>>>>
>>>>>>
>>>>>> 2009/11/24 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>>>>>
>>>>>>> On Tuesday 24 November 2009 22:34:33 Ettore Pedretti wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Would it help at this stage if I re-enable IO APIC, run your progr=
am
>>>>>>>> and send you the call-stack dump? I am willing to test your patch =
on
>>>>>>>> our hardware as soon as you got one ready, if that can be of help.
>>>>>>>
>>>>>>> Sorry, I did not answer your question. The bug occurs in both
>>>>>>> configurations;
>>>>>>> so, do not bother changing your configuration for the moment.
>>>>>>>
>>>>>>>> Cheers
>>>>>>>> Ettore
>>>>>>>>
>>>>>>>> 2009/11/23 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On Monday 23 November 2009 18:26:15 Ettore Pedretti wrote:
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> It is finally working. here is the dmesg after I insert a module=
:
>>>>>>>>>>
>>>>>>>>>> irq_test: before rtdm_irq_request
>>>>>>>>>> irq_test: after rtdm_irq_request (err =3D -22)
>>>>>>>>>> irq_test: before rtdm_irq_enable
>>>>>>>>>> irq_test: after rtdm_irq_enable (err =3D -22)
>>>>>>>>>
>>>>>>>>> rtdm_irq_request() returns -EINVAL because the IO APIC is disable=
d.
>>>>>>>>> So,
>>>>>>>>> the irq 48 turns into the irq 5;
>>>>>>>>>
>>>>>>>>>> Attached are a complete call-stack dump and my present kernel
>>>>>>>>>> =A0configuration.
>>>>>>>>>
>>>>>>>>> With the fact that there is still a NULL pointer bug without IO
>>>>>>>>> APIC,
>>>>>>>>> the
>>>>>>>>> bug is bound to be located in analogy. There may be some wrong
>>>>>>>>> write
>>>>>>>>> access on the interrupt structure.
>>>>>>>>>
>>>>>>>>> I will come back with a patch which dumps the structure's content
>>>>>>>>> at
>>>>>>>>> various locations in the attach code.
>>>>>>>>>
>>>>>>>>>> Cheers
>>>>>>>>>> Ettore
>>>>>>>>>>
>>>>>>>>>> 2009/11/23 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>>>>>>>>>
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On Mon, Nov 23, 2009 at 9:28 AM, Ettore Pedretti
>>>>>>>>>>> <ep41@domain.hid>
>>>>>>>>>
>>>>>>>>> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> I have compiled the module using this makefile:
>>>>>>>>>>>>
>>>>>>>>>>>> prefix :=3D $(shell /usr/bin/xeno-config --prefix)
>>>>>>>>>>>> obj-m =A0 :=3D irqTest.o
>>>>>>>>>>>>
>>>>>>>>>>>> ifeq ($(prefix),)
>>>>>>>>>>>> $(error Please add <xeno-install>/bin to your PATH variable)
>>>>>>>>>>>> endif
>>>>>>>>>>>>
>>>>>>>>>>>> KDIR =A0 =A0:=3D /lib/modules/$(shell uname -r)/build
>>>>>>>>>>>> PWD =A0 =A0 :=3D $(shell pwd)
>>>>>>>>>>>> EXTRA_CFLAGS :=3D -I/usr/include/xenomai -I/usr/include/
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> all: default
>>>>>>>>>>>>
>>>>>>>>>>>> default:
>>>>>>>>>>>> =A0 =A0 =A0$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules
>>>>>>>>>>>>
>>>>>>>>>>>> install:
>>>>>>>>>>>> =A0 =A0 =A0$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules_install
>>>>>>>>>>>>
>>>>>>>>>>>> clean:
>>>>>>>>>>>> =A0 =A0 =A0rm -fr *.mod.c *.o *.ko irqTest *~ .irqTest* .tmp_v=
ersions
>>>>>>>>>>>>
>>>>>>>>>>>> The module seems to compiles fine:
>>>>>>>>>>>>
>>>>>>>>>>>> make -C /lib/modules/2.6.31.1/build
>>>>>>>>>>>> SUBDIRS=3D/home/ep41/control/CHAMP/irqTest modules
>>>>>>>>>>>> make[1]: Entering directory `/usr/src/linux-2.6.31.1'
>>>>>>>>>>>> =A0CC [M] =A0/home/ep41/control/CHAMP/irqTest/irqTest.o
>>>>>>>>>>>> =A0Building modules, stage 2.
>>>>>>>>>>>> =A0MODPOST 1 modules
>>>>>>>>>>>> =A0CC =A0 =A0 =A0/home/ep41/control/CHAMP/irqTest/irqTest.mod.=
o
>>>>>>>>>>>> =A0LD [M] =A0/home/ep41/control/CHAMP/irqTest/irqTest.ko
>>>>>>>>>>>> make[1]: Leaving directory `/usr/src/linux-2.6.31.1'
>>>>>>>>>>>>
>>>>>>>>>>>> To make sure module dependencies are in place I modprobe
>>>>>>>>>>>> irqbench
>>>>>>>>>>>> (probably not necessary).
>>>>>>>>>>>>
>>>>>>>>>>>> modprobe xeno_irqbench
>>>>>>>>>>>>
>>>>>>>>>>>> All the loaded modules:
>>>>>>>>>>>>
>>>>>>>>>>>> fangorn:~# lsmod
>>>>>>>>>>>> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
>>>>>>>>>>>> xeno_irqbench =A0 =A0 =A0 =A0 =A0 5152 =A00
>>>>>>>>>>>> xeno_native =A0 =A0 =A0 =A0 =A0 =A083296 =A00
>>>>>>>>>>>> analogy_ni_pcimio =A0 =A0 =A015676 =A00
>>>>>>>>>>>> analogy_ni_mio =A0 =A0 =A0 =A0 41596 =A01 analogy_ni_pcimio
>>>>>>>>>>>> analogy_ni_tio =A0 =A0 =A0 =A0 21724 =A01 analogy_ni_mio
>>>>>>>>>>>> analogy_8255 =A0 =A0 =A0 =A0 =A0 =A04060 =A01 analogy_ni_mio
>>>>>>>>>>>> analogy_ni_mite =A0 =A0 =A0 =A0 9980 =A03
>>>>>>>>>>>> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio xeno_analogy
>>>>>>>>>>>> 38876 =A05
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,a=
nalogy_
>>>>>>>>>>>> ni_ mite xeno_rtdm =A0 =A0 =A0 =A0 =A0 =A0 =A024244 =A03
>>>>>>>>>>>> xeno_irqbench,analogy_ni_mio,xeno_analogy astropci
>>>>>>>>>>>> 10968 0
>>>>>>>>>>>> ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0112900 =A01
>>>>>>>>>>>> jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A044016 =A01 ext3
>>>>>>>>>>>> mbcache =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6652 =A01 ext3
>>>>>>>>>>>> ide_pci_generic =A0 =A0 =A0 =A0 3712 =A00
>>>>>>>>>>>> ide_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 79388 =A01 ide_pci_generi=
c
>>>>>>>>>>>> e1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 118204 =A00
>>>>>>>>>>>> ata_piix =A0 =A0 =A0 =A0 =A0 =A0 =A0 15968 =A02
>>>>>>>>>>>> sata_mv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A027632 =A00
>>>>>>>>>>>> libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0151468 =A02 ata_piix,sat=
a_mv
>>>>>>>>>>>> unix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24460 =A010
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> When I insert the module it complains about missing symbols:
>>>>>>>>>>>>
>>>>>>>>>>>> insmod irqTest.ko
>>>>>>>>>>>>
>>>>>>>>>>>> insmod: error inserting 'irqTest.ko': -1 Unknown symbol in
>>>>>>>>>>>> module
>>>>>>>>>>>>
>>>>>>>>>>>> dmesg:
>>>>>>>>>>>>
>>>>>>>>>>>> irqTest: module license 'unspecified' taints kernel.
>>>>>>>>>>>> Disabling lock debugging due to kernel taint
>>>>>>>>>>>> irqTest: Unknown symbol xnintr_enable
>>>>>>>>>>>> irqTest: Unknown symbol xnintr_detach
>>>>>>>>>>>>
>>>>>>>>>>>> What am I doing wrong?
>>>>>>>>>>>
>>>>>>>>>>> It's me who did wrong. I just tested the compilation inside the
>>>>>>>>>>> kernel.
>>>>>>>>>>>
>>>>>>>>>>> xnintr_* symbols are only exported for GPL compliant modules. S=
o,
>>>>>>>>>>> could you add the following line in the test module:
>>>>>>>>>>> MODULE_LICENSE("GPL");
>>>>>>>>>>>
>>>>>>>>>>> With that, the insmod operation should work.
>>>>>>>>>>>
>>>>>>>>>>>> BTW, I disabled =A0CONFIG_X86_IO_APIC and =A0the SMP option: s=
ame
>>>>>>>>>>>> problem.
>>>>>>>>>>>
>>>>>>>>>>> Could you send the call-stack dump ? Maybe, that will unveil a
>>>>>>>>>>> clue.
>>>>>>>>>>>
>>>>>>>>>>>> Cheers
>>>>>>>>>>>> Ettore
>>>>>>>>>>>>
>>>>>>>>>>>> 2009/11/22 Alexis Berlemont <alexis.berlemont@domain.hid>:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Sunday 22 November 2009 20:35:51 Ettore Pedretti wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I downloaded Xenomai 2.5-rc4 from the xenomai-head.git. I ne=
ed
>>>>>>>>>>>>>> to
>>>>>>>>>>>>>> use the comedi drivers for Xenomai for a NI PCI-6711 functio=
n
>>>>>>>>>>>>>> generator board.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> When I try to use the test program cmd_write (or cmd-read) I
>>>>>>>>>>>>>> obtain
>>>>>>>>>>>>>> the following:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> fangorn:~# cmd_write -vcmd_write: device analogy0 opened
>>>>>>>>>>>>>> (fd=3D0)
>>>>>>>>>>>>>> cmd_write: basic descriptor retrieved
>>>>>>>>>>>>>> =A0 =A0 =A0subdevices count =3D 0
>>>>>>>>>>>>>> =A0 =A0 =A0read subdevice index =3D 0
>>>>>>>>>>>>>> =A0 =A0 =A0write subdevice index =3D 0
>>>>>>>>>>>>>> cmd_write: a4l_get_desc failed (ret=3D-22)
>>>>>>>>>>>>>> *** glibc detected *** cmd_write: free(): invalid next size
>>>>>>>>>>>>>> (fast):
>>>>>>>>>>>>>> 0x0804d008 ***
>>>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>>>>>>> /lib/i686/cmov/libc.so.6[0xb7e52624]
>>>>>>>>>>>>>> /lib/i686/cmov/libc.so.6(cfree+0x96)[0xb7e54826]
>>>>>>>>>>>>>> cmd_write[0x804927c]
>>>>>>>>>>>>>> /lib/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7dfa455]
>>>>>>>>>>>>>> cmd_write[0x8048b01]
>>>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>>>>>>> 08048000-0804a000 r-xp 00000000 08:01 10855303
>>>>>>>>>>>>>> /usr/bin/cmd_write
>>>>>>>>>>>>>> 0804a000-0804b000 rw-p 00002000 08:01 10855303
>>>>>>>>>>>>>> /usr/bin/cmd_write
>>>>>>>>>>>>>> 0804b000-0806e000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[=
heap]
>>>>>>>>>>>>>> b7c00000-b7c21000 rw-p 00000000 00:00 0
>>>>>>>>>>>>>> b7c21000-b7d00000 ---p 00000000 00:00 0
>>>>>>>>>>>>>> b7dce000-b7dda000 r-xp 00000000 08:01 6127619
>>>>>>>>>>>>>> =A0/lib/libgcc_s.so.1
>>>>>>>>>>>>>> b7dda000-b7ddb000 rw-p 0000b000 08:01 6127619
>>>>>>>>>>>>>> =A0/lib/libgcc_s.so.1
>>>>>>>>>>>>>> b7de0000-b7de3000 rw-s 00000000 00:0b 426 =A0 =A0 =A0 =A0/de=
v/rtheap
>>>>>>>>>>>>>> b7de3000-b7de4000 rw-p 00000000 00:00 0
>>>>>>>>>>>>>> b7de4000-b7f39000 r-xp 00000000 08:01 6144250
>>>>>>>>>>>>>> =A0/lib/i686/cmov/libc-2.7.so b7f39000-b7f3a000 r--p 0015500=
0
>>>>>>>>>>>>>> 08:01
>>>>>>>>>>>>>> 6144250 =A0 =A0/lib/i686/cmov/libc-2.7.so b7f3a000-b7f3c000 =
rw-p
>>>>>>>>>>>>>> 00156000 08:01 6144250 =A0 =A0/lib/i686/cmov/libc-2.7.so
>>>>>>>>>>>>>> b7f3c000-b7f3f000 rw-p 00000000 00:00 0
>>>>>>>>>>>>>> b7f3f000-b7f54000 r-xp 00000000 08:01 6144264
>>>>>>>>>>>>>> /lib/i686/cmov/libpthread-2.7.so
>>>>>>>>>>>>>> b7f54000-b7f56000 rw-p 00014000 08:01 6144264
>>>>>>>>>>>>>> /lib/i686/cmov/libpthread-2.7.so
>>>>>>>>>>>>>> b7f56000-b7f58000 rw-p 00000000 00:00 0
>>>>>>>>>>>>>> b7f58000-b7f5a000 r-xp 00000000 08:01 10808118
>>>>>>>>>>>>>> /usr/lib/librtdm.so.1.0.0 b7f5a000-b7f5b000 rw-p 00001000
>>>>>>>>>>>>>> 08:01
>>>>>>>>>>>>>> 10808118 =A0 /usr/lib/librtdm.so.1.0.0 b7f5b000-b7f5c000 rw-=
p
>>>>>>>>>>>>>> 00000000 00:00 0
>>>>>>>>>>>>>> b7f5c000-b7f63000 r-xp 00000000 08:01 10808119
>>>>>>>>>>>>>> =A0/usr/lib/libnative.so.3.0.0 b7f63000-b7f64000 rw-p 000060=
00
>>>>>>>>>>>>>> 08:01
>>>>>>>>>>>>>> 10808119 /usr/lib/libnative.so.3.0.0 b7f64000-b7f67000 r-xp
>>>>>>>>>>>>>> 00000000 08:01 10808112 =A0 /usr/lib/libanalogy.so.1.0.0
>>>>>>>>>>>>>> b7f67000-b7f68000 rw-p 00002000 08:01 10808112
>>>>>>>>>>>>>> /usr/lib/libanalogy.so.1.0.0
>>>>>>>>>>>>>> b7f69000-b7f6a000 rw-p 00000000 00:00 0
>>>>>>>>>>>>>> b7f6a000-b7f6d000 rw-s 00000000 00:0b 426 =A0 =A0 =A0 =A0/de=
v/rtheap
>>>>>>>>>>>>>> b7f6d000-b7f6f000 rw-p 00000000 00:00 0
>>>>>>>>>>>>>> b7f6f000-b7f89000 r-xp 00000000 08:01 6127618
>>>>>>>>>>>>>> =A0/lib/ld-2.7.so
>>>>>>>>>>>>>> b7f89000-b7f8b000 rw-p 0001a000 08:01 6127618
>>>>>>>>>>>>>> =A0/lib/ld-2.7.so
>>>>>>>>>>>>>> bfab1000-bfac6000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[=
stack]
>>>>>>>>>>>>>> ffffe000-fffff000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[=
vdso]
>>>>>>>>>>>>>> Aborted
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This is probably because the device /dev/analogy0 does not
>>>>>>>>>>>>>> exist.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This is the output of uname -a
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Linux fangorn 2.6.31.1 #1 SMP PREEMPT Fri Nov 20 20:42:26 PS=
T
>>>>>>>>>>>>>> 2009
>>>>>>>>>>>>>> i686 GNU/Linux
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> And these are the relevant entries in dmesg
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> dmesg:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I-pipe 2.4-06: pipeline enabled.
>>>>>>>>>>>>>> I-pipe: Domain Xenomai registered.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Xenomai: hal/i386 started.
>>>>>>>>>>>>>> Xenomai: scheduling class idle registered.
>>>>>>>>>>>>>> Xenomai: scheduling class rt registered.
>>>>>>>>>>>>>> Xenomai: real-time nucleus v2.5-rc4 (Flying In A Blue Dream)
>>>>>>>>>>>>>> loaded. Xenomai: SMI-enabled chipset found
>>>>>>>>>>>>>> Xenomai: SMI workaround enabled
>>>>>>>>>>>>>> Xenomai: starting RTDM services.
>>>>>>>>>>>>>> Xenomai: starting native API services.
>>>>>>>>>>>>>> Analogy: MITE: Available NI device IDs: 0x1880
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> result of lspci for the relevant board:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 04:01.0 Class ff00: National Instruments PCI-6711
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> And lsmod:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
>>>>>>>>>>>>>> xeno_native =A0 =A0 =A0 =A0 =A0 105088 =A00
>>>>>>>>>>>>>> analogy_ni_pcimio =A0 =A0 =A015644 =A00
>>>>>>>>>>>>>> analogy_ni_mio =A0 =A0 =A0 =A0 44860 =A01 analogy_ni_pcimio
>>>>>>>>>>>>>> analogy_ni_tio =A0 =A0 =A0 =A0 24956 =A01 analogy_ni_mio
>>>>>>>>>>>>>> analogy_8255 =A0 =A0 =A0 =A0 =A0 =A03900 =A01 analogy_ni_mio
>>>>>>>>>>>>>> analogy_ni_mite =A0 =A0 =A0 =A010140 =A03
>>>>>>>>>>>>>> =A0analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio xeno_anal=
ogy
>>>>>>>>>>>>>> =A040220 =A05
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255=
,analog
>>>>>>>>>>>>>> y_n i_mit e xeno_rtdm =A0 =A0 =A0 =A0 =A0 =A0 =A028436 =A02
>>>>>>>>>>>>>> analogy_ni_mio,xeno_analogy astropci =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 10944 =A00
>>>>>>>>>>>>>> ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0109636 =A01
>>>>>>>>>>>>>> jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A043920 =A01 ext3
>>>>>>>>>>>>>> mbcache =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6272 =A01 ext3
>>>>>>>>>>>>>> ide_pci_generic =A0 =A0 =A0 =A0 3712 =A00
>>>>>>>>>>>>>> ide_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 74204 =A01 ide_pci_gene=
ric
>>>>>>>>>>>>>> ata_piix =A0 =A0 =A0 =A0 =A0 =A0 =A0 15748 =A02
>>>>>>>>>>>>>> sata_mv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A026448 =A00
>>>>>>>>>>>>>> e1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 114208 =A00
>>>>>>>>>>>>>> libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0142156 =A02 ata_piix,s=
ata_mv
>>>>>>>>>>>>>> unix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22992 =A010
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> According to this post:
>>>>>>>>>>>>>> http://www.mail-archive.com/xenomai@xenomai.org=
ml
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The analogy driver "a4l_pcimio" will be registered with you=
r
>>>>>>>>>>>>>>> last
>>>>>>>>>>>>>>> insmod (analogy_ni_pcimio). You can check that by typing "c=
at
>>>>>>>>>>>>>>> /proc/analogy/drivers", you will see only one entry:
>>>>>>>>>>>>>>> a4l_pcimio.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> fangorn:~# cat /proc/analogy/drivers
>>>>>>>>>>>>>> -- =A0Analogy drivers --
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> | idx | driver name
>>>>>>>>>>>>>> | =A000 | analogy_ni_pcimio
>>>>>>>>>>>>>> | =A001 | analogy_8255
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> There are two entries and the drivers are not attached:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> fangorn:~# cat /proc/analogy/devices
>>>>>>>>>>>>>> -- =A0Analogy devices --
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> | idx | status | driver
>>>>>>>>>>>>>> | =A000 | Unused | No driver
>>>>>>>>>>>>>> | =A001 | Unused | No driver
>>>>>>>>>>>>>> | =A002 | Unused | No driver
>>>>>>>>>>>>>> | =A003 | Unused | No driver
>>>>>>>>>>>>>> | =A004 | Unused | No driver
>>>>>>>>>>>>>> | =A005 | Unused | No driver
>>>>>>>>>>>>>> | =A006 | Unused | No driver
>>>>>>>>>>>>>> | =A007 | Unused | No driver
>>>>>>>>>>>>>> | =A008 | Unused | No driver
>>>>>>>>>>>>>> | =A009 | Unused | No driver
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'm aware of the name change of the drivers:
>>>>>>>>>>>>>> http://www.mail-archive.com/xenomai-git@xenomai.org=
l
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> - a4l_pcimio becomes analogy_ni_pcimio
>>>>>>>>>>>>>>> - 8255 becomes analogy_8255.
>>>>>>>>>>>>>>> Consequently, the command line to attach these drivers has
>>>>>>>>>>>>>>> changed. Starting from now, we have to type:
>>>>>>>>>>>>>>> - analogy_config analogyX analogy_ni_pcimio (instead of
>>>>>>>>>>>>>>> a4l_pcimio)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This is what happens when I try to attach the driver to de
>>>>>>>>>>>>>> device:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> fangorn:~# analogy_config analogy0 analogy_ni_pcimio
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:Oops: 0000 [#1] PREEMPT SMP
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:last sysfs file:
>>>>>>>>>>>>>> =A0/sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:Process analogy_config (pid: 3409, ti=3Df64cc000
>>>>>>>>>>>>>> task=3Df79013b0 task.ti=3Df64cc000)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:I-pipe domain Linux
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:Stack:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:Call Trace:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85=
 d4
>>>>>>>>>>>>>> fe
>>>>>>>>>>>>>> ff
>>>>>>>>>>>>>> ff 8b 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 =
00
>>>>>>>>>>>>>> 00
>>>>>>>>>>>>>> 8b 42 18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0=
b
>>>>>>>>>>>>>> 01
>>>>>>>>>>>>>> 00
>>>>>>>>>>>>>> 00 31
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:EIP: [<f8c7d029>] ni_E_init+0x267/0xff1
>>>>>>>>>>>>>> [analogy_ni_mio]
>>>>>>>>>>>>>> SS:ESP 0068:f64cddc8
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>>>> =A0kernel:CR2: 0000000000000004
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> relevant dmeg:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> a4l: analogy_ni_pcimio: pcimio_attach: found pci-6711 board
>>>>>>>>>>>>>> mite 0000:04:01.0: PCI->APIC IRQ transform: INT A -> IRQ 48
>>>>>>>>>>>>>> mite 0000:04:01.0: setting latency timer to 64
>>>>>>>>>>>>>> a4l: MITE: 0xd0801000 mapped to f8e26000
>>>>>>>>>>>>>> a4l: DAQ: 0xd0800000 mapped to f8e2a000
>>>>>>>>>>>>>> a4l: MITE: version =3D 1, type =3D 1, mite mode =3D 1, inter=
face
>>>>>>>>>>>>>> mode
>>>>>>>>>>>>>> =3D 3
>>>>>>>>>>>>>> a4l: MITE: num channels =3D 3, write post fifo depth =3D 1, =
wins =3D
>>>>>>>>>>>>>> 0,
>>>>>>>>>>>>>> iowins =3D 2 a4l: analogy_ni_pcimio: pcimio_attach: found ir=
q 48
>>>>>>>>>>>>>> BUG: unable to handle kernel NULL pointer dereference at
>>>>>>>>>>>>>> 00000004
>>>>>>>>>>>>>> IP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
>>>>>>>>>>>>>> *pde =3D 00000000
>>>>>>>>>>>>>> Oops: 0000 [#1] PREEMPT SMP
>>>>>>>>>>>>>> last sysfs file:
>>>>>>>>>>>>>> /sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class
>>>>>>>>>>>>>> Modules
>>>>>>>>>>>>>> linked in: xeno_native analogy_ni_pcimio analogy_ni_mio
>>>>>>>>>>>>>> analogy_ni_tio analogy_8255 analogy_ni_mite xeno_analogy
>>>>>>>>>>>>>> xeno_rtdm
>>>>>>>>>>>>>> astropci ext3 jbd mbcache ide_pci_generic ide_core ata_piix
>>>>>>>>>>>>>> sata_mv
>>>>>>>>>>>>>> e1000 libata unix [last unloaded: scsi_wait_scan]
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Pid: 3409, comm: analogy_config Not tainted (2.6.31.1 #1)
>>>>>>>>>>>>>> X6DA8
>>>>>>>>>>>>>> EIP: 0060:[<f8c7d029>] EFLAGS: 00010202 CPU: 1
>>>>>>>>>>>>>> EIP is at ni_E_init+0x267/0xff1 [analogy_ni_mio]
>>>>>>>>>>>>>> EAX: 00000000 EBX: f8a22280 ECX: f8c31e6c EDX: f8c31e60
>>>>>>>>>>>>>> ESI: 00000000 EDI: f8c31e60 EBP: f64cde38 ESP: f64cddc8
>>>>>>>>>>>>>> =A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
>>>>>>>>>>>>>> Process analogy_config (pid: 3409, ti=3Df64cc000 task=3Df790=
13b0
>>>>>>>>>>>>>> =A0task.ti=3Df64cc000) I-pipe domain Linux
>>>>>>>>>>>>>> Stack:
>>>>>>>>>>>>>> =A0f64cddd0 c10142b6 f64cddd8 f8c31e60 f64cdde0 c105abf7
>>>>>>>>>>>>>> f64cddfc
>>>>>>>>>>>>>> f8a0ea5d <0> f8c2be00 00000000 00000001 f8c31e94 fffffff0
>>>>>>>>>>>>>> f64cde14
>>>>>>>>>>>>>> f8c2c118 00000001 <0> f8c2ed0d f8c31e88 f8c31e60 f64cde38
>>>>>>>>>>>>>> f8c2cccf
>>>>>>>>>>>>>> 00000001 f8c31e60 00000030 Call Trace:
>>>>>>>>>>>>>> =A0[<c10142b6>] ? unmask_IO_APIC_irq+0xd/0xf
>>>>>>>>>>>>>> =A0[<c105abf7>] ? xnintr_enable+0xb/0xd
>>>>>>>>>>>>>> =A0[<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
>>>>>>>>>>>>>> =A0[<f8c2be00>] ? a4l_handle_irq+0x0/0x1a [xeno_analogy]
>>>>>>>>>>>>>> =A0[<f8c2c118>] ? __a4l_request_irq+0x33/0x39 [xeno_analogy]
>>>>>>>>>>>>>> =A0[<f8c2cccf>] ? a4l_request_irq+0x98/0xaf [xeno_analogy]
>>>>>>>>>>>>>> =A0[<f8c8bd8a>] ? pcimio_attach+0x54d/0x664 [analogy_ni_pcim=
io]
>>>>>>>>>>>>>> =A0[<f8c2afef>] ? a4l_assign_driver+0x61/0x134 [xeno_analogy=
]
>>>>>>>>>>>>>> =A0[<f8c2b2ba>] ? a4l_device_attach+0x54/0x6d [xeno_analogy]
>>>>>>>>>>>>>> =A0[<c10662ea>] ? xnshadow_ppd_get+0x4f/0x58
>>>>>>>>>>>>>> =A0[<f8c2b54f>] ? a4l_ioctl_devcfg+0x57/0x104 [xeno_analogy]
>>>>>>>>>>>>>> =A0[<f8c2d36f>] ? a4l_rt_ioctl+0x33/0x3a [xeno_analogy]
>>>>>>>>>>>>>> =A0[<f8a0d3e6>] ? __rt_dev_ioctl+0xd1/0xd8 [xeno_rtdm]
>>>>>>>>>>>>>> =A0[<f8a0fe77>] ? sys_rtdm_open+0x5c/0x64 [xeno_rtdm]
>>>>>>>>>>>>>> =A0[<f8a0fdde>] ? sys_rtdm_ioctl+0x29/0x2b [xeno_rtdm]
>>>>>>>>>>>>>> =A0[<c10699ae>] ? losyscall_event+0xa9/0x190
>>>>>>>>>>>>>> =A0[<c10566ce>] ? __ipipe_dispatch_event+0xdf/0x201
>>>>>>>>>>>>>> =A0[<c1069905>] ? losyscall_event+0x0/0x190
>>>>>>>>>>>>>> =A0[<c10166a1>] ? __ipipe_syscall_root+0x3b/0xc4
>>>>>>>>>>>>>> =A0[<c1002cfd>] ? system_call+0x2d/0x4f
>>>>>>>>>>>>>> Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d4 fe ff =
ff
>>>>>>>>>>>>>> 8b
>>>>>>>>>>>>>> 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00 00 =
8b
>>>>>>>>>>>>>> 42
>>>>>>>>>>>>>> 18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b 01 0=
0
>>>>>>>>>>>>>> 00
>>>>>>>>>>>>>> 31
>>>>>>>>>>>>>> EIP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
>>>>>>>>>>>>>> SS:ESP
>>>>>>>>>>>>>> 0068:f64cddc8 CR2: 0000000000000004
>>>>>>>>>>>>>> ---[ end trace c887d49bb5e86cf4 ]---
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks for such a great report.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I keep two things in mind:
>>>>>>>>>>>>> - cmd_write's error handling path is not buggy (that was
>>>>>>>>>>>>> already
>>>>>>>>>>>>> in
>>>>>>>>>>>>> my todo list). I will fix that as soon as possible.
>>>>>>>>>>>>>
>>>>>>>>>>>>> - according to the call-stack dump you made, the irq handler
>>>>>>>>>>>>> registering seems to be the source of the trouble. What strik=
es
>>>>>>>>>>>>> me
>>>>>>>>>>>>> is that the oops occurred very low (unmask_IO_APIC_irq: we ar=
e
>>>>>>>>>>>>> no
>>>>>>>>>>>>> more in the analogy layer).
>>>>>>>>>>>>>
>>>>>>>>>>>>> In order to be sure that the problem is located in analogy, i=
t
>>>>>>>>>>>>> would
>>>>>>>>>>>>> be great to test that calling rtdm_request_irq(... , 48, ...)
>>>>>>>>>>>>> does
>>>>>>>>>>>>> not trigger the bug.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Here is a little test module you could try to insmod. If you =
do
>>>>>>>>>>>>> not
>>>>>>>>>>>>> want to bother finding out how to compile it, you can replace
>>>>>>>>>>>>> the
>>>>>>>>>>>>> code of an existing rtdm driver (for example:
>>>>>>>>>>>>> xenomai/ksrc/drivers/testing/irqbench.c) with the source belo=
w.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Another interesting test would be to disable CONFIG_X86_IO_AP=
IC
>>>>>>>>>>>>> in
>>>>>>>>>>>>> your kernel configuration (in "Processor type and features",
>>>>>>>>>>>>> disable
>>>>>>>>>>>>> the SMP option and disable "IO APIC" under "Local APIC").
>>>>>>>>>>>>>
>>>>>>>>>>>>> #include <linux/version.h>
>>>>>>>>>>>>> #include <linux/module.h>
>>>>>>>>>>>>> #include <linux/ioport.h>
>>>>>>>>>>>>>
>>>>>>>>>>>>> #include <rtdm/rtdm_driver.h>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> int test_handler(rtdm_irq_t *irq_handle)
>>>>>>>>>>>>> {
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0rtdm_printk("irq_test: INTERRUPT!\n");
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0return RTDM_IRQ_HANDLED;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> static rtdm_irq_t handle;
>>>>>>>>>>>>>
>>>>>>>>>>>>> static int __init __test_init(void)
>>>>>>>>>>>>> {
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0int err;
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0rtdm_printk("irq_test: before rtdm_irq_request\n")=
;
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0err =3D rtdm_irq_request(&handle, 48, test_handler=
, 0,
>>>>>>>>>>>>> "test_irq", NULL);
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0rtdm_printk("irq_test: after rtdm_irq_request (err=
 =3D
>>>>>>>>>>>>> %d)\n",
>>>>>>>>>>>>> err);
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0rtdm_printk("irq_test: before rtdm_irq_enable\n");
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0err =3D rtdm_irq_enable(&handle);
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0rtdm_printk("irq_test: after rtdm_irq_enable (err =
=3D
>>>>>>>>>>>>> %d)\n",
>>>>>>>>>>>>> err);
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0return err;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> static void __exit __test_exit(void)
>>>>>>>>>>>>> {
>>>>>>>>>>>>>
>>>>>>>>>>>>> =A0 =A0 =A0rtdm_irq_free(&handle);
>>>>>>>>>>>>>
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> module_init(__test_init);
>>>>>>>>>>>>> module_exit(__test_exit);
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Can anyone help?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Best regards
>>>>>>>>>>>>>> Ettore Pedretti
>>>>>>>>>>>
>>>>>>>>>>> Alexis.
>>>>>>>>>
>>>>>>>>> Alexis.
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Xenomai-help mailing list
>>>>>>> Xenomai-help@domain.hid
>>>>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>>>>
>>> Alexis.
>>>
>>
>>
>>
>
> Alexis.
>



--=20
Ettore Pedretti, SUPA
School of Physics and Astronomy
University of St Andrews, North Haugh,
St Andrews, Fife, KY16 9SS, Scotland
Ph: +44-1334-461666, Fax: +44-1334-463104
The University of St Andrews is a charity registered in Scotland : No SC013=
532

