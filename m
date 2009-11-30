MIME-Version: 1.0
In-Reply-To: <4B12FD90.30804@domain.hid>
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>
	<200911232310.44441.berlemont.hauw@domain.hid>
	<4bed572e0911241334x7691431dh37a17c461be53d98@domain.hid>
	<200911242357.52347.berlemont.hauw@domain.hid>
	<4bed572e0911260022o70a984b1r98e6728044969d93@domain.hid>
	<72cf3fb0911260134m36c1d5b0s9b24843b11610455@domain.hid>
	<4bed572e0911261538m787ec9c9qf2a76d8e892f2d48@domain.hid>
	<4B12FD90.30804@domain.hid>
Date: Mon, 30 Nov 2009 00:41:27 -0800
Message-ID: <4bed572e0911300041k5bb51bf6nbe83b2a9233d76b0@domain.hid>
From: Ettore Pedretti <epedrett@domain.hid>
Content-Type: multipart/mixed; boundary=00151774051c81c1a10479929b08
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

--00151774051c81c1a10479929b08
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I applied your kernel patch before applying the xenomai patch. When I
insert the kernel patch I obtain:

insmod: error inserting 'test_module.ko': -1 Function not implemented

Attached is the content of dmesg from boot to module insertion.

Cheers
-ep

ps. I am leaving the mountain tomorrow and will be travelling until
Friday. I hope I will be able to test the machine at distance without
crashing it for good.




2009/11/29 Alexis Berlemont <berlemont.hauw@domain.hid>:
> Hi,
>
> Ettore Pedretti wrote:
>>
>> 2009/11/26 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>
>>> On Thu, Nov 26, 2009 at 9:22 AM, Ettore Pedretti <epedrett@domain.hid>
>>> wrote:
>>>>
>>>> Hi Alexis,
>>>>
>>>> I applied the patch to my local git repository:
>>>>
>>>> fangorn:/usr/src#
>>>> cd xenomai-head/
>>>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
>>>> patch_debug_1.diff
>>>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
>>>> ../patch_debug_1.diff:14: trailing whitespace.
>>>> =A0 =A0 =A0rtdm_printk("\t handler=3D%p, irq=3D%d, cookie=3D%p\n",
>>>> warning: 1 line adds whitespace errors.
>>>>
>>>> Then created a debian package:
>>>>
>>>> git-buildpackage -us -uc -rfakeroot --git-debian-branch=3Dmaster
>>>> --git-upstream-branch=3Dorigin/master --git-ignore-new
>>>>
>>>> built a new kernel package:
>>>>
>>>> fakeroot make-kpkg --initrd --added-patches xenomai
>>>> --revision=3DipipeComedi.2.4.06 --config menuconfig binary-arch
>>>>
>>>> and installed the Debian package with dpkg -i
>>>>
>>>> This is what happens when i insert the module into the kernel:
>>>>
>>>> fangorn:~/control/CHAMP/irqTest# insmod irqTest.ko
>>>> Killed
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:Oops: 0000 [#1] PREEMPT SMP
>>>> fangorn:~/control/CHAMP/irqTest#
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:last sysfs file: /sys/class/net/lo/operstate
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:Process insmod (pid: 3566, ti=3Df6c02000 task=3Df78634b0
>>>> task.ti=3Df6c02000)
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:I-pipe domain Linux
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:Stack:
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:Call Trace:
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:Code: =A0Bad EIP value.
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
>>>>
>>>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>>>> =A0kernel:CR2: 0000000000000000
>>>>
>>>> dmesg after insmod:
>>>>
>>>> irq_test: before rtdm_irq_request
>>>> BUG: unable to handle kernel NULL pointer dereference at (null)
>>>> IP: [<(null)>] (null)
>>>> *pde =3D 00000000
>>>> Oops: 0000 [#1] PREEMPT SMP
>>>> last sysfs file: /sys/class/net/lo/operstate
>>>> Modules linked in: irqTest(+) xeno_native analogy_ni_pcimio
>>>> analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite
>>>> xeno_analogy xeno_rtdm astropci ext3 jbd mbcache ide_pci_generic
>>>> ide_core ata_piix sata_mv e1000 libata unix [last unloaded:
>>>> scsi_wait_scan]
>>>>
>>>> Pid: 3566, comm: insmod Not tainted (2.6.31.1 #1) X6DA8
>>>> EIP: 0060:[<00000000>] EFLAGS: 00010246 CPU: 1
>>>> EIP is at 0x0
>>>> EAX: 00000030 EBX: 00000000 ECX: 00000030 EDX: c1250b80
>>>> ESI: f8e24500 EDI: 00000000 EBP: f6c03f1c ESP: f6c03f18
>>>> =A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
>>>> Process insmod (pid: 3566, ti=3Df6c02000 task=3Df78634b0 task.ti=3Df6c=
02000)
>>>> I-pipe domain Linux
>>>> Stack:
>>>> =A0c1154166 f6c03f24 c105abf7 f6c03f40 f8a0ea5d f8e24000 00000000 0000=
0000
>>>> <0> f8e27000 00000000 f6c03f58 f8e2703e 00000000 f8e24066 00000000
>>>> f8e27000
>>>> <0> f6c03f84 c1001028 f8e243c0 00000001 fffffffc f8e243c0 00000000
>>>> f6c03f84
>>>> Call Trace:
>>>> =A0[<c1154166>] ? rthal_irq_enable+0x2d/0x31
>>>> =A0[<c105abf7>] ? xnintr_enable+0xb/0xd
>>>> =A0[<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
>>>> =A0[<f8e24000>] ? test_handler+0x0/0x1c [irqTest]
>>>> =A0[<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
>>>> =A0[<f8e2703e>] ? __test_init+0x3e/0x7e [irqTest]
>>>> =A0[<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
>>>> =A0[<c1001028>] ? do_one_initcall+0x23/0x183
>>>> =A0[<c103a825>] ? blocking_notifier_call_chain+0x1a/0x1c
>>>> =A0[<c10481e9>] ? sys_init_module+0xad/0x1ec
>>>> =A0[<c1092cc5>] ? sys_close+0x71/0xb5
>>>> =A0[<c1002c25>] ? sysenter_do_call+0x12/0x16
>>>> Code: =A0Bad EIP value.
>>>> EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
>>>> CR2: 0000000000000000
>>>> ---[ end trace ac2616367ecf94b2 ]---
>>>>
>>>> I hope this is what you wanted me to try. Please let me know.
>>>
>>> So if I understand well, you "insmoded" the little test module which
>>> does nothing but calling rtdm_irq_request() and the NULL pointer bug
>>> occured.
>>
>> Correct
>>
>>> This bug occurred before calling analogy_config, you did not tried to
>>> attach the ni_pcimio driver, right ?
>>
>> I insmod-ed the test module that gave that error dump. I later tried
>> to attach the driver which causes the usual error. The stack-dumps I
>> sent are solely related to insmod of test program.
>>
>>> If I am right, it seems like the bug is not located in analogy but
>>> between Xenomai's nucleus and Ipipe, which is ... weird.
>>>
>>> What is your kernel configuration ? no IO_APIC ?
>>
>> I put back my config to IO_APIC. Should I disable that again?
>> attached is my kernel configuration (configAnalogy)
>>
>>
>>> Which irq did you try to request ? 48 or 5 ?
>>
>> I do not know. do I have to pass parameters to insmod?
>>
>> This is my /proc/interrupts if that is helpful
>> =A0 =A0 =A0 =A0 =A0 CPU0 =A0 =A0 =A0 CPU1
>> =A00: =A0 =A0 =A0 =A0222 =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-edge =A0 =A0 =
=A0timer
>> =A01: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A09 =A0 IO-APIC-edge =A0 =A0=
 =A0i8042
>> =A02: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0XT-PIC-XT =A0 =A0=
 =A0 =A0cascade
>> =A012: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0132 =A0 IO-APIC-edge =A0 =A0 =
=A0i8042
>> =A014: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A08 =A0 IO-APIC-edge =A0 =
=A0 =A0ata_piix
>> =A015: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A012358 =A0 IO-APIC-edge =A0 =A0 =
=A0ata_piix
>> =A020: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =A0=
 astropci0
>> =A028: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0235 =A0 IO-APIC-fasteoi =A0 s=
ata_mv
>> =A054: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A077950 =A0 IO-APIC-fasteoi =A0 eth=
0
>> NMI: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Non-maskable interrup=
ts
>> LOC: =A0 45365307 =A0 45365133 =A0 Local timer interrupts
>> SPU: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Spurious interrupts
>> CNT: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Performance counter i=
nterrupts
>> PND: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Performance pending w=
ork
>> RES: =A0 =A0 =A0 2555 =A0 =A0 =A0 2212 =A0 Rescheduling interrupts
>> CAL: =A0 =A0 =A0 =A0 60 =A0 =A0 =A0 =A0 58 =A0 Function call interrupts
>> TLB: =A0 =A0 =A0 =A0419 =A0 =A0 =A0 =A0200 =A0 TLB shootdowns
>> TRM: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Thermal event interru=
pts
>> THR: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Threshold APIC interr=
upts
>> MCE: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 Machine check excepti=
ons
>> MCP: =A0 =A0 =A0 =A0152 =A0 =A0 =A0 =A0152 =A0 Machine check polls
>> ERR: =A0 =A0 =A0 =A0 =A00
>> MIS: =A0 =A0 =A0 =A0 =A00
>>
>> and my /proc/xenomai/irq
>>
>> IRQ =A0 =A0 =A0 =A0 CPU0 =A0 =A0 =A0 =A0CPU1
>> 516: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [IPI]
>> 519: =A0 =A046161773 =A0 =A046161772 =A0 =A0 =A0 =A0 [timer]
>> 520: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [critic=
al sync]
>> 546: =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0 =A0 [virtua=
l]
>>
>>
>>> Which CPU are you using ?
>>
>> CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
>> CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
>>
>> As Philippe rightly pointed out this is a 32-bit install although the
>> CPUs are 64 bit
>
> Following Philippe's advice, I attached a little patch for your kernel
> sources. Could you apply it and send the kernel log messages ?
>
> You will also find attached the sources of a little module which calls
> Linux' request_irq(48). Could you insmod the module and send a dump of
> /proc/interrupts ?
>
>>> Thank you for your time.
>>>
>>>> Cheers
>>>> Ettore
>>>>
>>>>
>>>> 2009/11/24 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>>>
>>>>> On Tuesday 24 November 2009 22:34:33 Ettore Pedretti wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Would it help at this stage if I re-enable IO APIC, run your program
>>>>>> and send you the call-stack dump? I am willing to test your patch on
>>>>>> our hardware as soon as you got one ready, if that can be of help.
>>>>>
>>>>> Sorry, I did not answer your question. The bug occurs in both
>>>>> configurations;
>>>>> so, do not bother changing your configuration for the moment.
>>>>>
>>>>>> Cheers
>>>>>> Ettore
>>>>>>
>>>>>> 2009/11/23 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Monday 23 November 2009 18:26:15 Ettore Pedretti wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> It is finally working. here is the dmesg after I insert a module:
>>>>>>>>
>>>>>>>> irq_test: before rtdm_irq_request
>>>>>>>> irq_test: after rtdm_irq_request (err =3D -22)
>>>>>>>> irq_test: before rtdm_irq_enable
>>>>>>>> irq_test: after rtdm_irq_enable (err =3D -22)
>>>>>>>
>>>>>>> rtdm_irq_request() returns -EINVAL because the IO APIC is disabled.
>>>>>>> So,
>>>>>>> the irq 48 turns into the irq 5;
>>>>>>>
>>>>>>>> Attached are a complete call-stack dump and my present kernel
>>>>>>>> =A0configuration.
>>>>>>>
>>>>>>> With the fact that there is still a NULL pointer bug without IO API=
C,
>>>>>>> the
>>>>>>> bug is bound to be located in analogy. There may be some wrong writ=
e
>>>>>>> access on the interrupt structure.
>>>>>>>
>>>>>>> I will come back with a patch which dumps the structure's content a=
t
>>>>>>> various locations in the attach code.
>>>>>>>
>>>>>>>> Cheers
>>>>>>>> Ettore
>>>>>>>>
>>>>>>>> 2009/11/23 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On Mon, Nov 23, 2009 at 9:28 AM, Ettore Pedretti
>>>>>>>>> <ep41@domain.hid>
>>>>>>>
>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I have compiled the module using this makefile:
>>>>>>>>>>
>>>>>>>>>> prefix :=3D $(shell /usr/bin/xeno-config --prefix)
>>>>>>>>>> obj-m =A0 :=3D irqTest.o
>>>>>>>>>>
>>>>>>>>>> ifeq ($(prefix),)
>>>>>>>>>> $(error Please add <xeno-install>/bin to your PATH variable)
>>>>>>>>>> endif
>>>>>>>>>>
>>>>>>>>>> KDIR =A0 =A0:=3D /lib/modules/$(shell uname -r)/build
>>>>>>>>>> PWD =A0 =A0 :=3D $(shell pwd)
>>>>>>>>>> EXTRA_CFLAGS :=3D -I/usr/include/xenomai -I/usr/include/
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> all: default
>>>>>>>>>>
>>>>>>>>>> default:
>>>>>>>>>> =A0 =A0 =A0 $(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules
>>>>>>>>>>
>>>>>>>>>> install:
>>>>>>>>>> =A0 =A0 =A0 $(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules_install
>>>>>>>>>>
>>>>>>>>>> clean:
>>>>>>>>>> =A0 =A0 =A0 rm -fr *.mod.c *.o *.ko irqTest *~ .irqTest* .tmp_ve=
rsions
>>>>>>>>>>
>>>>>>>>>> The module seems to compiles fine:
>>>>>>>>>>
>>>>>>>>>> make -C /lib/modules/2.6.31.1/build
>>>>>>>>>> SUBDIRS=3D/home/ep41/control/CHAMP/irqTest modules
>>>>>>>>>> make[1]: Entering directory `/usr/src/linux-2.6.31.1'
>>>>>>>>>> =A0CC [M] =A0/home/ep41/control/CHAMP/irqTest/irqTest.o
>>>>>>>>>> =A0Building modules, stage 2.
>>>>>>>>>> =A0MODPOST 1 modules
>>>>>>>>>> =A0CC =A0 =A0 =A0/home/ep41/control/CHAMP/irqTest/irqTest.mod.o
>>>>>>>>>> =A0LD [M] =A0/home/ep41/control/CHAMP/irqTest/irqTest.ko
>>>>>>>>>> make[1]: Leaving directory `/usr/src/linux-2.6.31.1'
>>>>>>>>>>
>>>>>>>>>> To make sure module dependencies are in place I modprobe irqbenc=
h
>>>>>>>>>> (probably not necessary).
>>>>>>>>>>
>>>>>>>>>> modprobe xeno_irqbench
>>>>>>>>>>
>>>>>>>>>> All the loaded modules:
>>>>>>>>>>
>>>>>>>>>> fangorn:~# lsmod
>>>>>>>>>> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
>>>>>>>>>> xeno_irqbench =A0 =A0 =A0 =A0 =A0 5152 =A00
>>>>>>>>>> xeno_native =A0 =A0 =A0 =A0 =A0 =A083296 =A00
>>>>>>>>>> analogy_ni_pcimio =A0 =A0 =A015676 =A00
>>>>>>>>>> analogy_ni_mio =A0 =A0 =A0 =A0 41596 =A01 analogy_ni_pcimio
>>>>>>>>>> analogy_ni_tio =A0 =A0 =A0 =A0 21724 =A01 analogy_ni_mio
>>>>>>>>>> analogy_8255 =A0 =A0 =A0 =A0 =A0 =A04060 =A01 analogy_ni_mio
>>>>>>>>>> analogy_ni_mite =A0 =A0 =A0 =A0 9980 =A03
>>>>>>>>>> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio xeno_analogy
>>>>>>>>>> 38876 =A05
>>>>>>>>>>
>>>>>>>>>> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,ana=
logy_
>>>>>>>>>> ni_ mite xeno_rtdm =A0 =A0 =A0 =A0 =A0 =A0 =A024244 =A03
>>>>>>>>>> xeno_irqbench,analogy_ni_mio,xeno_analogy astropci
>>>>>>>>>> 10968 0
>>>>>>>>>> ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0112900 =A01
>>>>>>>>>> jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A044016 =A01 ext3
>>>>>>>>>> mbcache =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6652 =A01 ext3
>>>>>>>>>> ide_pci_generic =A0 =A0 =A0 =A0 3712 =A00
>>>>>>>>>> ide_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 79388 =A01 ide_pci_generic
>>>>>>>>>> e1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 118204 =A00
>>>>>>>>>> ata_piix =A0 =A0 =A0 =A0 =A0 =A0 =A0 15968 =A02
>>>>>>>>>> sata_mv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A027632 =A00
>>>>>>>>>> libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0151468 =A02 ata_piix,sata_=
mv
>>>>>>>>>> unix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24460 =A010
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> When I insert the module it complains about missing symbols:
>>>>>>>>>>
>>>>>>>>>> insmod irqTest.ko
>>>>>>>>>>
>>>>>>>>>> insmod: error inserting 'irqTest.ko': -1 Unknown symbol in modul=
e
>>>>>>>>>>
>>>>>>>>>> dmesg:
>>>>>>>>>>
>>>>>>>>>> irqTest: module license 'unspecified' taints kernel.
>>>>>>>>>> Disabling lock debugging due to kernel taint
>>>>>>>>>> irqTest: Unknown symbol xnintr_enable
>>>>>>>>>> irqTest: Unknown symbol xnintr_detach
>>>>>>>>>>
>>>>>>>>>> What am I doing wrong?
>>>>>>>>>
>>>>>>>>> It's me who did wrong. I just tested the compilation inside the
>>>>>>>>> kernel.
>>>>>>>>>
>>>>>>>>> xnintr_* symbols are only exported for GPL compliant modules. So,
>>>>>>>>> could you add the following line in the test module:
>>>>>>>>> MODULE_LICENSE("GPL");
>>>>>>>>>
>>>>>>>>> With that, the insmod operation should work.
>>>>>>>>>
>>>>>>>>>> BTW, I disabled =A0CONFIG_X86_IO_APIC and =A0the SMP option: sam=
e
>>>>>>>>>> problem.
>>>>>>>>>
>>>>>>>>> Could you send the call-stack dump ? Maybe, that will unveil a
>>>>>>>>> clue.
>>>>>>>>>
>>>>>>>>>> Cheers
>>>>>>>>>> Ettore
>>>>>>>>>>
>>>>>>>>>> 2009/11/22 Alexis Berlemont <alexis.berlemont@domain.hid>:
>>>>>>>>>>>
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On Sunday 22 November 2009 20:35:51 Ettore Pedretti wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hello,
>>>>>>>>>>>>
>>>>>>>>>>>> I downloaded Xenomai 2.5-rc4 from the xenomai-head.git. I need
>>>>>>>>>>>> to
>>>>>>>>>>>> use the comedi drivers for Xenomai for a NI PCI-6711 function
>>>>>>>>>>>> generator board.
>>>>>>>>>>>>
>>>>>>>>>>>> When I try to use the test program cmd_write (or cmd-read) I
>>>>>>>>>>>> obtain
>>>>>>>>>>>> the following:
>>>>>>>>>>>>
>>>>>>>>>>>> fangorn:~# cmd_write -vcmd_write: device analogy0 opened (fd=
=3D0)
>>>>>>>>>>>> cmd_write: basic descriptor retrieved
>>>>>>>>>>>> =A0 =A0 =A0 subdevices count =3D 0
>>>>>>>>>>>> =A0 =A0 =A0 read subdevice index =3D 0
>>>>>>>>>>>> =A0 =A0 =A0 write subdevice index =3D 0
>>>>>>>>>>>> cmd_write: a4l_get_desc failed (ret=3D-22)
>>>>>>>>>>>> *** glibc detected *** cmd_write: free(): invalid next size
>>>>>>>>>>>> (fast):
>>>>>>>>>>>> 0x0804d008 ***
>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>>>>> /lib/i686/cmov/libc.so.6[0xb7e52624]
>>>>>>>>>>>> /lib/i686/cmov/libc.so.6(cfree+0x96)[0xb7e54826]
>>>>>>>>>>>> cmd_write[0x804927c]
>>>>>>>>>>>> /lib/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7dfa455]
>>>>>>>>>>>> cmd_write[0x8048b01]
>>>>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>>>>> 08048000-0804a000 r-xp 00000000 08:01 10855303
>>>>>>>>>>>> /usr/bin/cmd_write
>>>>>>>>>>>> 0804a000-0804b000 rw-p 00002000 08:01 10855303
>>>>>>>>>>>> /usr/bin/cmd_write
>>>>>>>>>>>> 0804b000-0806e000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[he=
ap]
>>>>>>>>>>>> b7c00000-b7c21000 rw-p 00000000 00:00 0
>>>>>>>>>>>> b7c21000-b7d00000 ---p 00000000 00:00 0
>>>>>>>>>>>> b7dce000-b7dda000 r-xp 00000000 08:01 6127619
>>>>>>>>>>>> =A0/lib/libgcc_s.so.1
>>>>>>>>>>>> b7dda000-b7ddb000 rw-p 0000b000 08:01 6127619
>>>>>>>>>>>> =A0/lib/libgcc_s.so.1
>>>>>>>>>>>> b7de0000-b7de3000 rw-s 00000000 00:0b 426 =A0 =A0 =A0 =A0/dev/=
rtheap
>>>>>>>>>>>> b7de3000-b7de4000 rw-p 00000000 00:00 0
>>>>>>>>>>>> b7de4000-b7f39000 r-xp 00000000 08:01 6144250
>>>>>>>>>>>> =A0/lib/i686/cmov/libc-2.7.so b7f39000-b7f3a000 r--p 00155000
>>>>>>>>>>>> 08:01
>>>>>>>>>>>> 6144250 =A0 =A0/lib/i686/cmov/libc-2.7.so b7f3a000-b7f3c000 rw=
-p
>>>>>>>>>>>> 00156000 08:01 6144250 =A0 =A0/lib/i686/cmov/libc-2.7.so
>>>>>>>>>>>> b7f3c000-b7f3f000 rw-p 00000000 00:00 0
>>>>>>>>>>>> b7f3f000-b7f54000 r-xp 00000000 08:01 6144264
>>>>>>>>>>>> /lib/i686/cmov/libpthread-2.7.so
>>>>>>>>>>>> b7f54000-b7f56000 rw-p 00014000 08:01 6144264
>>>>>>>>>>>> /lib/i686/cmov/libpthread-2.7.so
>>>>>>>>>>>> b7f56000-b7f58000 rw-p 00000000 00:00 0
>>>>>>>>>>>> b7f58000-b7f5a000 r-xp 00000000 08:01 10808118
>>>>>>>>>>>> /usr/lib/librtdm.so.1.0.0 b7f5a000-b7f5b000 rw-p 00001000 08:0=
1
>>>>>>>>>>>> 10808118 =A0 /usr/lib/librtdm.so.1.0.0 b7f5b000-b7f5c000 rw-p
>>>>>>>>>>>> 00000000 00:00 0
>>>>>>>>>>>> b7f5c000-b7f63000 r-xp 00000000 08:01 10808119
>>>>>>>>>>>> =A0/usr/lib/libnative.so.3.0.0 b7f63000-b7f64000 rw-p 00006000
>>>>>>>>>>>> 08:01
>>>>>>>>>>>> 10808119 /usr/lib/libnative.so.3.0.0 b7f64000-b7f67000 r-xp
>>>>>>>>>>>> 00000000 08:01 10808112 =A0 /usr/lib/libanalogy.so.1.0.0
>>>>>>>>>>>> b7f67000-b7f68000 rw-p 00002000 08:01 10808112
>>>>>>>>>>>> /usr/lib/libanalogy.so.1.0.0
>>>>>>>>>>>> b7f69000-b7f6a000 rw-p 00000000 00:00 0
>>>>>>>>>>>> b7f6a000-b7f6d000 rw-s 00000000 00:0b 426 =A0 =A0 =A0 =A0/dev/=
rtheap
>>>>>>>>>>>> b7f6d000-b7f6f000 rw-p 00000000 00:00 0
>>>>>>>>>>>> b7f6f000-b7f89000 r-xp 00000000 08:01 6127618 =A0 =A0/lib/ld-2=
.7.so
>>>>>>>>>>>> b7f89000-b7f8b000 rw-p 0001a000 08:01 6127618 =A0 =A0/lib/ld-2=
.7.so
>>>>>>>>>>>> bfab1000-bfac6000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[st=
ack]
>>>>>>>>>>>> ffffe000-fffff000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[vd=
so]
>>>>>>>>>>>> Aborted
>>>>>>>>>>>>
>>>>>>>>>>>> This is probably because the device /dev/analogy0 does not
>>>>>>>>>>>> exist.
>>>>>>>>>>>>
>>>>>>>>>>>> This is the output of uname -a
>>>>>>>>>>>>
>>>>>>>>>>>> Linux fangorn 2.6.31.1 #1 SMP PREEMPT Fri Nov 20 20:42:26 PST
>>>>>>>>>>>> 2009
>>>>>>>>>>>> i686 GNU/Linux
>>>>>>>>>>>>
>>>>>>>>>>>> And these are the relevant entries in dmesg
>>>>>>>>>>>>
>>>>>>>>>>>> dmesg:
>>>>>>>>>>>>
>>>>>>>>>>>> I-pipe 2.4-06: pipeline enabled.
>>>>>>>>>>>> I-pipe: Domain Xenomai registered.
>>>>>>>>>>>>
>>>>>>>>>>>> Xenomai: hal/i386 started.
>>>>>>>>>>>> Xenomai: scheduling class idle registered.
>>>>>>>>>>>> Xenomai: scheduling class rt registered.
>>>>>>>>>>>> Xenomai: real-time nucleus v2.5-rc4 (Flying In A Blue Dream)
>>>>>>>>>>>> loaded. Xenomai: SMI-enabled chipset found
>>>>>>>>>>>> Xenomai: SMI workaround enabled
>>>>>>>>>>>> Xenomai: starting RTDM services.
>>>>>>>>>>>> Xenomai: starting native API services.
>>>>>>>>>>>> Analogy: MITE: Available NI device IDs: 0x1880
>>>>>>>>>>>>
>>>>>>>>>>>> result of lspci for the relevant board:
>>>>>>>>>>>>
>>>>>>>>>>>> 04:01.0 Class ff00: National Instruments PCI-6711
>>>>>>>>>>>>
>>>>>>>>>>>> And lsmod:
>>>>>>>>>>>>
>>>>>>>>>>>> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
>>>>>>>>>>>> xeno_native =A0 =A0 =A0 =A0 =A0 105088 =A00
>>>>>>>>>>>> analogy_ni_pcimio =A0 =A0 =A015644 =A00
>>>>>>>>>>>> analogy_ni_mio =A0 =A0 =A0 =A0 44860 =A01 analogy_ni_pcimio
>>>>>>>>>>>> analogy_ni_tio =A0 =A0 =A0 =A0 24956 =A01 analogy_ni_mio
>>>>>>>>>>>> analogy_8255 =A0 =A0 =A0 =A0 =A0 =A03900 =A01 analogy_ni_mio
>>>>>>>>>>>> analogy_ni_mite =A0 =A0 =A0 =A010140 =A03
>>>>>>>>>>>> =A0analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio xeno_analog=
y
>>>>>>>>>>>> =A040220 =A05
>>>>>>>>>>>>
>>>>>>>>>>>> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,a=
nalog
>>>>>>>>>>>> y_n i_mit e xeno_rtdm =A0 =A0 =A0 =A0 =A0 =A0 =A028436 =A02
>>>>>>>>>>>> analogy_ni_mio,xeno_analogy astropci =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 10944 =A00
>>>>>>>>>>>> ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0109636 =A01
>>>>>>>>>>>> jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A043920 =A01 ext3
>>>>>>>>>>>> mbcache =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6272 =A01 ext3
>>>>>>>>>>>> ide_pci_generic =A0 =A0 =A0 =A0 3712 =A00
>>>>>>>>>>>> ide_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 74204 =A01 ide_pci_generi=
c
>>>>>>>>>>>> ata_piix =A0 =A0 =A0 =A0 =A0 =A0 =A0 15748 =A02
>>>>>>>>>>>> sata_mv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A026448 =A00
>>>>>>>>>>>> e1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 114208 =A00
>>>>>>>>>>>> libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0142156 =A02 ata_piix,sat=
a_mv
>>>>>>>>>>>> unix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22992 =A010
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> According to this post:
>>>>>>>>>>>> http://www.mail-archive.com/xenomai@xenomai.org
>>>>>>>>>>>>
>>>>>>>>>>>>> The analogy driver "a4l_pcimio" will be registered with your
>>>>>>>>>>>>> last
>>>>>>>>>>>>> insmod (analogy_ni_pcimio). You can check that by typing "cat
>>>>>>>>>>>>> /proc/analogy/drivers", you will see only one entry:
>>>>>>>>>>>>> a4l_pcimio.
>>>>>>>>>>>>
>>>>>>>>>>>> fangorn:~# cat /proc/analogy/drivers
>>>>>>>>>>>> -- =A0Analogy drivers --
>>>>>>>>>>>>
>>>>>>>>>>>> | idx | driver name
>>>>>>>>>>>> | =A000 | analogy_ni_pcimio
>>>>>>>>>>>> | =A001 | analogy_8255
>>>>>>>>>>>>
>>>>>>>>>>>> There are two entries and the drivers are not attached:
>>>>>>>>>>>>
>>>>>>>>>>>> fangorn:~# cat /proc/analogy/devices
>>>>>>>>>>>> -- =A0Analogy devices --
>>>>>>>>>>>>
>>>>>>>>>>>> | idx | status | driver
>>>>>>>>>>>> | =A000 | Unused | No driver
>>>>>>>>>>>> | =A001 | Unused | No driver
>>>>>>>>>>>> | =A002 | Unused | No driver
>>>>>>>>>>>> | =A003 | Unused | No driver
>>>>>>>>>>>> | =A004 | Unused | No driver
>>>>>>>>>>>> | =A005 | Unused | No driver
>>>>>>>>>>>> | =A006 | Unused | No driver
>>>>>>>>>>>> | =A007 | Unused | No driver
>>>>>>>>>>>> | =A008 | Unused | No driver
>>>>>>>>>>>> | =A009 | Unused | No driver
>>>>>>>>>>>>
>>>>>>>>>>>> I'm aware of the name change of the drivers:
>>>>>>>>>>>> http://www.mail-archive.com/xenomai-git@xenomai.org
>>>>>>>>>>>>
>>>>>>>>>>>>> - a4l_pcimio becomes analogy_ni_pcimio
>>>>>>>>>>>>> - 8255 becomes analogy_8255.
>>>>>>>>>>>>> Consequently, the command line to attach these drivers has
>>>>>>>>>>>>> changed. Starting from now, we have to type:
>>>>>>>>>>>>> - analogy_config analogyX analogy_ni_pcimio (instead of
>>>>>>>>>>>>> a4l_pcimio)
>>>>>>>>>>>>
>>>>>>>>>>>> This is what happens when I try to attach the driver to de
>>>>>>>>>>>> device:
>>>>>>>>>>>>
>>>>>>>>>>>> fangorn:~# analogy_config analogy0 analogy_ni_pcimio
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:Oops: 0000 [#1] PREEMPT SMP
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:last sysfs file:
>>>>>>>>>>>> =A0/sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:Process analogy_config (pid: 3409, ti=3Df64cc000
>>>>>>>>>>>> task=3Df79013b0 task.ti=3Df64cc000)
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:I-pipe domain Linux
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:Stack:
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:Call Trace:
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d=
4 fe
>>>>>>>>>>>> ff
>>>>>>>>>>>> ff 8b 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00
>>>>>>>>>>>> 00
>>>>>>>>>>>> 8b 42 18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b =
01
>>>>>>>>>>>> 00
>>>>>>>>>>>> 00 31
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:EIP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_=
mio]
>>>>>>>>>>>> SS:ESP 0068:f64cddc8
>>>>>>>>>>>>
>>>>>>>>>>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>>>>>>>>>> =A0kernel:CR2: 0000000000000004
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> relevant dmeg:
>>>>>>>>>>>>
>>>>>>>>>>>> a4l: analogy_ni_pcimio: pcimio_attach: found pci-6711 board
>>>>>>>>>>>> mite 0000:04:01.0: PCI->APIC IRQ transform: INT A -> IRQ 48
>>>>>>>>>>>> mite 0000:04:01.0: setting latency timer to 64
>>>>>>>>>>>> a4l: MITE: 0xd0801000 mapped to f8e26000
>>>>>>>>>>>> a4l: DAQ: 0xd0800000 mapped to f8e2a000
>>>>>>>>>>>> a4l: MITE: version =3D 1, type =3D 1, mite mode =3D 1, interfa=
ce mode
>>>>>>>>>>>> =3D 3
>>>>>>>>>>>> a4l: MITE: num channels =3D 3, write post fifo depth =3D 1, wi=
ns =3D
>>>>>>>>>>>> 0,
>>>>>>>>>>>> iowins =3D 2 a4l: analogy_ni_pcimio: pcimio_attach: found irq =
48
>>>>>>>>>>>> BUG: unable to handle kernel NULL pointer dereference at
>>>>>>>>>>>> 00000004
>>>>>>>>>>>> IP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
>>>>>>>>>>>> *pde =3D 00000000
>>>>>>>>>>>> Oops: 0000 [#1] PREEMPT SMP
>>>>>>>>>>>> last sysfs file:
>>>>>>>>>>>> /sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class Module=
s
>>>>>>>>>>>> linked in: xeno_native analogy_ni_pcimio analogy_ni_mio
>>>>>>>>>>>> analogy_ni_tio analogy_8255 analogy_ni_mite xeno_analogy
>>>>>>>>>>>> xeno_rtdm
>>>>>>>>>>>> astropci ext3 jbd mbcache ide_pci_generic ide_core ata_piix
>>>>>>>>>>>> sata_mv
>>>>>>>>>>>> e1000 libata unix [last unloaded: scsi_wait_scan]
>>>>>>>>>>>>
>>>>>>>>>>>> Pid: 3409, comm: analogy_config Not tainted (2.6.31.1 #1) X6DA=
8
>>>>>>>>>>>> EIP: 0060:[<f8c7d029>] EFLAGS: 00010202 CPU: 1
>>>>>>>>>>>> EIP is at ni_E_init+0x267/0xff1 [analogy_ni_mio]
>>>>>>>>>>>> EAX: 00000000 EBX: f8a22280 ECX: f8c31e6c EDX: f8c31e60
>>>>>>>>>>>> ESI: 00000000 EDI: f8c31e60 EBP: f64cde38 ESP: f64cddc8
>>>>>>>>>>>> =A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
>>>>>>>>>>>> Process analogy_config (pid: 3409, ti=3Df64cc000 task=3Df79013=
b0
>>>>>>>>>>>> =A0task.ti=3Df64cc000) I-pipe domain Linux
>>>>>>>>>>>> Stack:
>>>>>>>>>>>> =A0f64cddd0 c10142b6 f64cddd8 f8c31e60 f64cdde0 c105abf7 f64cd=
dfc
>>>>>>>>>>>> f8a0ea5d <0> f8c2be00 00000000 00000001 f8c31e94 fffffff0
>>>>>>>>>>>> f64cde14
>>>>>>>>>>>> f8c2c118 00000001 <0> f8c2ed0d f8c31e88 f8c31e60 f64cde38
>>>>>>>>>>>> f8c2cccf
>>>>>>>>>>>> 00000001 f8c31e60 00000030 Call Trace:
>>>>>>>>>>>> =A0[<c10142b6>] ? unmask_IO_APIC_irq+0xd/0xf
>>>>>>>>>>>> =A0[<c105abf7>] ? xnintr_enable+0xb/0xd
>>>>>>>>>>>> =A0[<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
>>>>>>>>>>>> =A0[<f8c2be00>] ? a4l_handle_irq+0x0/0x1a [xeno_analogy]
>>>>>>>>>>>> =A0[<f8c2c118>] ? __a4l_request_irq+0x33/0x39 [xeno_analogy]
>>>>>>>>>>>> =A0[<f8c2cccf>] ? a4l_request_irq+0x98/0xaf [xeno_analogy]
>>>>>>>>>>>> =A0[<f8c8bd8a>] ? pcimio_attach+0x54d/0x664 [analogy_ni_pcimio=
]
>>>>>>>>>>>> =A0[<f8c2afef>] ? a4l_assign_driver+0x61/0x134 [xeno_analogy]
>>>>>>>>>>>> =A0[<f8c2b2ba>] ? a4l_device_attach+0x54/0x6d [xeno_analogy]
>>>>>>>>>>>> =A0[<c10662ea>] ? xnshadow_ppd_get+0x4f/0x58
>>>>>>>>>>>> =A0[<f8c2b54f>] ? a4l_ioctl_devcfg+0x57/0x104 [xeno_analogy]
>>>>>>>>>>>> =A0[<f8c2d36f>] ? a4l_rt_ioctl+0x33/0x3a [xeno_analogy]
>>>>>>>>>>>> =A0[<f8a0d3e6>] ? __rt_dev_ioctl+0xd1/0xd8 [xeno_rtdm]
>>>>>>>>>>>> =A0[<f8a0fe77>] ? sys_rtdm_open+0x5c/0x64 [xeno_rtdm]
>>>>>>>>>>>> =A0[<f8a0fdde>] ? sys_rtdm_ioctl+0x29/0x2b [xeno_rtdm]
>>>>>>>>>>>> =A0[<c10699ae>] ? losyscall_event+0xa9/0x190
>>>>>>>>>>>> =A0[<c10566ce>] ? __ipipe_dispatch_event+0xdf/0x201
>>>>>>>>>>>> =A0[<c1069905>] ? losyscall_event+0x0/0x190
>>>>>>>>>>>> =A0[<c10166a1>] ? __ipipe_syscall_root+0x3b/0xc4
>>>>>>>>>>>> =A0[<c1002cfd>] ? system_call+0x2d/0x4f
>>>>>>>>>>>> Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d4 fe ff ff
>>>>>>>>>>>> 8b
>>>>>>>>>>>> 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00 00 8b
>>>>>>>>>>>> 42
>>>>>>>>>>>> 18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b 01 00 =
00
>>>>>>>>>>>> 31
>>>>>>>>>>>> EIP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio] SS:ES=
P
>>>>>>>>>>>> 0068:f64cddc8 CR2: 0000000000000004
>>>>>>>>>>>> ---[ end trace c887d49bb5e86cf4 ]---
>>>>>>>>>>>
>>>>>>>>>>> Thanks for such a great report.
>>>>>>>>>>>
>>>>>>>>>>> I keep two things in mind:
>>>>>>>>>>> - cmd_write's error handling path is not buggy (that was alread=
y
>>>>>>>>>>> in
>>>>>>>>>>> my todo list). I will fix that as soon as possible.
>>>>>>>>>>>
>>>>>>>>>>> - according to the call-stack dump you made, the irq handler
>>>>>>>>>>> registering seems to be the source of the trouble. What strikes
>>>>>>>>>>> me
>>>>>>>>>>> is that the oops occurred very low (unmask_IO_APIC_irq: we are =
no
>>>>>>>>>>> more in the analogy layer).
>>>>>>>>>>>
>>>>>>>>>>> In order to be sure that the problem is located in analogy, it
>>>>>>>>>>> would
>>>>>>>>>>> be great to test that calling rtdm_request_irq(... , 48, ...)
>>>>>>>>>>> does
>>>>>>>>>>> not trigger the bug.
>>>>>>>>>>>
>>>>>>>>>>> Here is a little test module you could try to insmod. If you do
>>>>>>>>>>> not
>>>>>>>>>>> want to bother finding out how to compile it, you can replace t=
he
>>>>>>>>>>> code of an existing rtdm driver (for example:
>>>>>>>>>>> xenomai/ksrc/drivers/testing/irqbench.c) with the source below.
>>>>>>>>>>>
>>>>>>>>>>> Another interesting test would be to disable CONFIG_X86_IO_APIC
>>>>>>>>>>> in
>>>>>>>>>>> your kernel configuration (in "Processor type and features",
>>>>>>>>>>> disable
>>>>>>>>>>> the SMP option and disable "IO APIC" under "Local APIC").
>>>>>>>>>>>
>>>>>>>>>>> #include <linux/version.h>
>>>>>>>>>>> #include <linux/module.h>
>>>>>>>>>>> #include <linux/ioport.h>
>>>>>>>>>>>
>>>>>>>>>>> #include <rtdm/rtdm_driver.h>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> int test_handler(rtdm_irq_t *irq_handle)
>>>>>>>>>>> {
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 rtdm_printk("irq_test: INTERRUPT!\n");
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 return RTDM_IRQ_HANDLED;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> static rtdm_irq_t handle;
>>>>>>>>>>>
>>>>>>>>>>> static int __init __test_init(void)
>>>>>>>>>>> {
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 int err;
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 rtdm_printk("irq_test: before rtdm_irq_request\n");
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 err =3D rtdm_irq_request(&handle, 48, test_handler,=
 0,
>>>>>>>>>>> "test_irq", NULL);
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 rtdm_printk("irq_test: after rtdm_irq_request (err =
=3D
>>>>>>>>>>> %d)\n",
>>>>>>>>>>> err);
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 rtdm_printk("irq_test: before rtdm_irq_enable\n");
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 err =3D rtdm_irq_enable(&handle);
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 rtdm_printk("irq_test: after rtdm_irq_enable (err =
=3D %d)\n",
>>>>>>>>>>> err);
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 return err;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> static void __exit __test_exit(void)
>>>>>>>>>>> {
>>>>>>>>>>>
>>>>>>>>>>> =A0 =A0 =A0 rtdm_irq_free(&handle);
>>>>>>>>>>>
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> module_init(__test_init);
>>>>>>>>>>> module_exit(__test_exit);
>>>>>>>>>>>
>>>>>>>>>>>> Can anyone help?
>>>>>>>>>>>>
>>>>>>>>>>>> Best regards
>>>>>>>>>>>> Ettore Pedretti
>>>>>>>>>
>>>>>>>>> Alexis.
>>>>>>>
>>>>>>> Alexis.
>>>>>
>>>>> _______________________________________________
>>>>> Xenomai-help mailing list
>>>>> Xenomai-help@domain.hid
>>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>>
>>> >
>
> Alexis.
>



--=20
Ettore Pedretti, SUPA
School of Physics and Astronomy
University of St Andrews, North Haugh,
St Andrews, Fife, KY16 9SS, Scotland
Ph: +44 1334 461669, Fax: +44-1334-463104
The University of St Andrews is a charity registered in Scotland : No SC013=
532

--00151774051c81c1a10479929b08
Content-Type: application/octet-stream; name=dmesg30Nov09
Content-Disposition: attachment; filename=dmesg30Nov09
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2mzkey10

ZmFuZ29ybjp+L2NvbnRyb2wvQ0hBTVAvaXJxVGVzdCMgaW5zbW9kIHRlc3RfbW9kdWxlLmtvIApp
bnNtb2Q6IGVycm9yIGluc2VydGluZyAndGVzdF9tb2R1bGUua28nOiAtMSBGdW5jdGlvbiBub3Qg
aW1wbGVtZW50ZWQKZmFuZ29ybjp+L2NvbnRyb2wvQ0hBTVAvaXJxVGVzdCMgZG1lc2cKTGludXgg
dmVyc2lvbiAyLjYuMzEuMSAocm9vdEBmYW5nb3JuKSAoZ2NjIHZlcnNpb24gNC4zLjIgKERlYmlh
biA0LjMuMi0xLjEpICkgIzEgU01QIFBSRUVNUFQgTW9uIE5vdiAzMCAwMDowMzoxNiBQU1QgMjAw
OQpLRVJORUwgc3VwcG9ydGVkIGNwdXM6CiAgSW50ZWwgR2VudWluZUludGVsCiAgQU1EIEF1dGhl
bnRpY0FNRAogIE5TQyBHZW9kZSBieSBOU0MKICBDeXJpeCBDeXJpeEluc3RlYWQKICBDZW50YXVy
IENlbnRhdXJIYXVscwogIFRyYW5zbWV0YSBHZW51aW5lVE14ODYKICBUcmFuc21ldGEgVHJhbnNt
ZXRhQ1BVCiAgVU1DIFVNQyBVTUMgVU1DCkJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoK
IEJJT1MtZTgyMDogMDAwMDAwMDAwMDAwMDAwMCAtIDAwMDAwMDAwMDAwOWE4MDAgKHVzYWJsZSkK
IEJJT1MtZTgyMDogMDAwMDAwMDAwMDA5YTgwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVk
KQogQklPUy1lODIwOiAwMDAwMDAwMDAwMGNlMDAwIC0gMDAwMDAwMDAwMDBkMDAwMCAocmVzZXJ2
ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZTQwMDAgLSAwMDAwMDAwMDAwMTAwMDAwIChyZXNl
cnZlZCkKIEJJT1MtZTgyMDogMDAwMDAwMDAwMDEwMDAwMCAtIDAwMDAwMDAwYmZmNzAwMDAgKHVz
YWJsZSkKIEJJT1MtZTgyMDogMDAwMDAwMDBiZmY3MDAwMCAtIDAwMDAwMDAwYmZmNzcwMDAgKEFD
UEkgZGF0YSkKIEJJT1MtZTgyMDogMDAwMDAwMDBiZmY3NzAwMCAtIDAwMDAwMDAwYmZmODAwMDAg
KEFDUEkgTlZTKQogQklPUy1lODIwOiAwMDAwMDAwMGJmZjgwMDAwIC0gMDAwMDAwMDBjMDAwMDAw
MCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwZTAwMDAwMDAgLSAwMDAwMDAwMGYwMDAw
MDAwIChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAwMDAwMDBmZWMwMDAwMCAtIDAwMDAwMDAwZmVj
MTAwMDAgKHJlc2VydmVkKQogQklPUy1lODIwOiAwMDAwMDAwMGZlZTAwMDAwIC0gMDAwMDAwMDBm
ZWUwMTAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwZmY4MDAwMDAgLSAwMDAwMDAw
MGZmYzAwMDAwIChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAwMDAwMDBmZmZmZmMwMCAtIDAwMDAw
MDAxMDAwMDAwMDAgKHJlc2VydmVkKQpETUkgcHJlc2VudC4KUGhvZW5peCBCSU9TIGRldGVjdGVk
OiBCSU9TIG1heSBjb3JydXB0IGxvdyBSQU0sIHdvcmtpbmcgYXJvdW5kIGl0LgplODIwIHVwZGF0
ZSByYW5nZTogMDAwMDAwMDAwMDAwMDAwMCAtIDAwMDAwMDAwMDAwMTAwMDAgKHVzYWJsZSkgPT0+
IChyZXNlcnZlZCkKbGFzdF9wZm4gPSAweGJmZjcwIG1heF9hcmNoX3BmbiA9IDB4MTAwMDAwCk1U
UlIgZGVmYXVsdCB0eXBlOiB1bmNhY2hhYmxlCk1UUlIgZml4ZWQgcmFuZ2VzIGVuYWJsZWQ6CiAg
MDAwMDAtOUZGRkYgd3JpdGUtYmFjawogIEEwMDAwLUJGRkZGIHVuY2FjaGFibGUKICBDMDAwMC1D
N0ZGRiB3cml0ZS1wcm90ZWN0CiAgQzgwMDAtREZGRkYgdW5jYWNoYWJsZQogIEUwMDAwLUZGRkZG
IHdyaXRlLXByb3RlY3QKTVRSUiB2YXJpYWJsZSByYW5nZXMgZW5hYmxlZDoKICAwIGJhc2UgMDAw
MDAwMDAwIG1hc2sgRjgwMDAwMDAwIHdyaXRlLWJhY2sKICAxIGJhc2UgMDgwMDAwMDAwIG1hc2sg
RkMwMDAwMDAwIHdyaXRlLWJhY2sKICAyIGJhc2UgMEJGRjgwMDAwIG1hc2sgRkZGRjgwMDAwIHVu
Y2FjaGFibGUKICAzIGRpc2FibGVkCiAgNCBkaXNhYmxlZAogIDUgZGlzYWJsZWQKICA2IGRpc2Fi
bGVkCiAgNyBkaXNhYmxlZApXYXJuaW5nIG9ubHkgODk1TUIgd2lsbCBiZSB1c2VkLgpVc2UgYSBI
SUdITUVNIGVuYWJsZWQga2VybmVsLgppbml0aWFsIG1lbW9yeSBtYXBwZWQgOiAwIC0gMDE4MDAw
MDAKaW5pdF9tZW1vcnlfbWFwcGluZzogMDAwMDAwMDAwMDAwMDAwMC0wMDAwMDAwMDM3ZjFlMDAw
CiAwMDAwMDAwMDAwIC0gMDAwMDQwMDAwMCBwYWdlIDRrCiAwMDAwNDAwMDAwIC0gMDAzN2MwMDAw
MCBwYWdlIDJNCiAwMDM3YzAwMDAwIC0gMDAzN2YxZTAwMCBwYWdlIDRrCmtlcm5lbCBkaXJlY3Qg
bWFwcGluZyB0YWJsZXMgdXAgdG8gMzdmMWUwMDAgQCAxMDAwMC0xNTAwMApSQU1ESVNLOiAzN2Ux
NjAwMCAtIDM3ZmVmMThjCkFsbG9jYXRlZCBuZXcgUkFNRElTSzogMDAxMDAwMDAgLSAwMDJkOTE4
YwpNb3ZlIFJBTURJU0sgZnJvbSAwMDAwMDAwMDM3ZTE2MDAwIC0gMDAwMDAwMDAzN2ZlZjE4YiB0
byAwMDEwMDAwMCAtIDAwMmQ5MThiCjg5NU1CIExPV01FTSBhdmFpbGFibGUuCiAgbWFwcGVkIGxv
dyByYW06IDAgLSAzN2YxZTAwMAogIGxvdyByYW06IDAgLSAzN2YxZTAwMAogIG5vZGUgMCBsb3cg
cmFtOiAwMDAwMDAwMCAtIDM3ZjFlMDAwCiAgbm9kZSAwIGJvb3RtYXAgMDAwMTEwMDAgLSAwMDAx
N2ZlNAooOSBlYXJseSByZXNlcnZhdGlvbnMpID09PiBib290bWVtIFswMDAwMDAwMDAwIC0gMDAz
N2YxZTAwMF0KICAjMCBbMDAwMDAwMDAwMCAtIDAwMDAwMDEwMDBdICAgQklPUyBkYXRhIHBhZ2Ug
PT0+IFswMDAwMDAwMDAwIC0gMDAwMDAwMTAwMF0KICAjMSBbMDAwMDAwMTAwMCAtIDAwMDAwMDIw
MDBdICAgIEVYIFRSQU1QT0xJTkUgPT0+IFswMDAwMDAxMDAwIC0gMDAwMDAwMjAwMF0KICAjMiBb
MDAwMDAwNjAwMCAtIDAwMDAwMDcwMDBdICAgICAgIFRSQU1QT0xJTkUgPT0+IFswMDAwMDA2MDAw
IC0gMDAwMDAwNzAwMF0KICAjMyBbMDAwMTAwMDAwMCAtIDAwMDEzMTcxMzhdICAgIFRFWFQgREFU
QSBCU1MgPT0+IFswMDAxMDAwMDAwIC0gMDAwMTMxNzEzOF0KICAjNCBbMDAwMDA5YTgwMCAtIDAw
MDAxMDAwMDBdICAgIEJJT1MgcmVzZXJ2ZWQgPT0+IFswMDAwMDlhODAwIC0gMDAwMDEwMDAwMF0K
ICAjNSBbMDAwMTMxODAwMCAtIDAwMDEzMWUxNzBdICAgICAgICAgICAgICBCUksgPT0+IFswMDAx
MzE4MDAwIC0gMDAwMTMxZTE3MF0KICAjNiBbMDAwMDAxMDAwMCAtIDAwMDAwMTEwMDBdICAgICAg
ICAgIFBHVEFCTEUgPT0+IFswMDAwMDEwMDAwIC0gMDAwMDAxMTAwMF0KICAjNyBbMDAwMDEwMDAw
MCAtIDAwMDAyZDkxOGNdICAgICAgTkVXIFJBTURJU0sgPT0+IFswMDAwMTAwMDAwIC0gMDAwMDJk
OTE4Y10KICAjOCBbMDAwMDAxMTAwMCAtIDAwMDAwMTgwMDBdICAgICAgICAgIEJPT1RNQVAgPT0+
IFswMDAwMDExMDAwIC0gMDAwMDAxODAwMF0KZm91bmQgU01QIE1QLXRhYmxlIGF0IFtjMDBmNWQ5
MF0gZjVkOTAKWm9uZSBQRk4gcmFuZ2VzOgogIERNQSAgICAgIDB4MDAwMDAwMTAgLT4gMHgwMDAw
MTAwMAogIE5vcm1hbCAgIDB4MDAwMDEwMDAgLT4gMHgwMDAzN2YxZQpNb3ZhYmxlIHpvbmUgc3Rh
cnQgUEZOIGZvciBlYWNoIG5vZGUKZWFybHlfbm9kZV9tYXBbMl0gYWN0aXZlIFBGTiByYW5nZXMK
ICAgIDA6IDB4MDAwMDAwMTAgLT4gMHgwMDAwMDA5YQogICAgMDogMHgwMDAwMDEwMCAtPiAweDAw
MDM3ZjFlCk9uIG5vZGUgMCB0b3RhbHBhZ2VzOiAyMjkwMzIKZnJlZV9hcmVhX2luaXRfbm9kZTog
bm9kZSAwLCBwZ2RhdCBjMTI1ZDY4MCwgbm9kZV9tZW1fbWFwIGMxMzFmMjAwCiAgRE1BIHpvbmU6
IDMyIHBhZ2VzIHVzZWQgZm9yIG1lbW1hcAogIERNQSB6b25lOiAwIHBhZ2VzIHJlc2VydmVkCiAg
RE1BIHpvbmU6IDM5NDYgcGFnZXMsIExJRk8gYmF0Y2g6MAogIE5vcm1hbCB6b25lOiAxNzU5IHBh
Z2VzIHVzZWQgZm9yIG1lbW1hcAogIE5vcm1hbCB6b25lOiAyMjMyOTUgcGFnZXMsIExJRk8gYmF0
Y2g6MzEKVXNpbmcgQVBJQyBkcml2ZXIgZGVmYXVsdApJbnRlbCBNdWx0aVByb2Nlc3NvciBTcGVj
aWZpY2F0aW9uIHYxLjQKICAgIFZpcnR1YWwgV2lyZSBjb21wYXRpYmlsaXR5IG1vZGUuCk1QVEFC
TEU6IE9FTSBJRDogSU5URUwgICAKTVBUQUJMRTogUHJvZHVjdCBJRDogTGluZGVuaHVyc3QgCk1Q
VEFCTEU6IEFQSUMgYXQ6IDB4RkVFMDAwMDAKUHJvY2Vzc29yICMwIChCb290dXAtQ1BVKQpQcm9j
ZXNzb3IgIzYKSS9PIEFQSUMgIzIgVmVyc2lvbiAzMiBhdCAweEZFQzAwMDAwLgpJL08gQVBJQyAj
MyBWZXJzaW9uIDMyIGF0IDB4RkVDODEwMDAuCkkvTyBBUElDICM0IFZlcnNpb24gMzIgYXQgMHhG
RUM4MTQwMC4KRW5hYmxpbmcgQVBJQyBtb2RlOiAgRmxhdC4gIFVzaW5nIDMgSS9PIEFQSUNzClBy
b2Nlc3NvcnM6IDIKU01QOiBBbGxvd2luZyAyIENQVXMsIDAgaG90cGx1ZyBDUFVzCm5yX2lycXNf
Z3NpOiA3MgpBbGxvY2F0aW5nIFBDSSByZXNvdXJjZXMgc3RhcnRpbmcgYXQgYzAwMDAwMDAgKGdh
cDogYzAwMDAwMDA6MjAwMDAwMDApCk5SX0NQVVM6OCBucl9jcHVtYXNrX2JpdHM6OCBucl9jcHVf
aWRzOjIgbnJfbm9kZV9pZHM6MQpQRVJDUFU6IEVtYmVkZGVkIDEzIHBhZ2VzIGF0IGMxYTIzMDAw
LCBzdGF0aWMgZGF0YSAzMDQ5MiBieXRlcwpCdWlsdCAxIHpvbmVsaXN0cyBpbiBab25lIG9yZGVy
LCBtb2JpbGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiAyMjcyNDEKS2VybmVsIGNvbW1h
bmQgbGluZTogcm9vdD0vZGV2L3NkYTEgcm8gcXVpZXQKUElEIGhhc2ggdGFibGUgZW50cmllczog
NDA5NiAob3JkZXI6IDEyLCAxNjM4NCBieXRlcykKRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50
cmllczogMTMxMDcyIChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQpJbm9kZS1jYWNoZSBoYXNoIHRh
YmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQpFbmFibGluZyBmYXN0
IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uIGRvbmUuCkVuYWJsaW5nIHVubWFza2VkIFNJTUQgRlBV
IGV4Y2VwdGlvbiBzdXBwb3J0Li4uIGRvbmUuCkluaXRpYWxpemluZyBDUFUjMApNZW1vcnk6IDkw
MjcxNmsvOTE2NjAwayBhdmFpbGFibGUgKDE3OTJrIGtlcm5lbCBjb2RlLCAxMzE3MmsgcmVzZXJ2
ZWQsIDYzOWsgZGF0YSwgMjkyayBpbml0LCAwayBoaWdobWVtKQp2aXJ0dWFsIGtlcm5lbCBtZW1v
cnkgbGF5b3V0OgogICAgZml4bWFwICA6IDB4ZmZmMjAwMDAgLSAweGZmZmZmMDAwICAgKCA4OTIg
a0IpCiAgICB2bWFsbG9jIDogMHhmODcxZTAwMCAtIDB4ZmZmMWUwMDAgICAoIDEyMCBNQikKICAg
IGxvd21lbSAgOiAweGMwMDAwMDAwIC0gMHhmN2YxZTAwMCAgICggODk1IE1CKQogICAgICAuaW5p
dCA6IDB4YzEyNjEwMDAgLSAweGMxMmFhMDAwICAgKCAyOTIga0IpCiAgICAgIC5kYXRhIDogMHhj
MTFjMDIzYyAtIDB4YzEyNjAyMzggICAoIDYzOSBrQikKICAgICAgLnRleHQgOiAweGMxMDAwMDAw
IC0gMHhjMTFjMDIzYyAgICgxNzkyIGtCKQpDaGVja2luZyBpZiB0aGlzIHByb2Nlc3NvciBob25v
dXJzIHRoZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1vZGUuLi5Pay4KTlJfSVJRUzo1MTIK
RmFzdCBUU0MgY2FsaWJyYXRpb24gdXNpbmcgUElUCkRldGVjdGVkIDMwMDAuMTYwIE1IeiBwcm9j
ZXNzb3IuCkktcGlwZSAyLjQtMDY6IHBpcGVsaW5lIGVuYWJsZWQuCkNvbnNvbGU6IGNvbG91ciBW
R0ErIDgweDI1CmNvbnNvbGUgW3R0eTBdIGVuYWJsZWQKQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAo
c2tpcHBlZCksIHZhbHVlIGNhbGN1bGF0ZWQgdXNpbmcgdGltZXIgZnJlcXVlbmN5Li4gNjAwMC4z
MiBCb2dvTUlQUyAobHBqPTMwMDAxNjApCk1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczog
NTEyCkNQVTogVHJhY2UgY2FjaGU6IDEySyB1b3BzLCBMMSBEIGNhY2hlOiAxNksKQ1BVOiBMMiBj
YWNoZTogMjA0OEsKQ1BVOiBQaHlzaWNhbCBQcm9jZXNzb3IgSUQ6IDAKQ1BVOiBQcm9jZXNzb3Ig
Q29yZSBJRDogMAptY2U6IENQVSBzdXBwb3J0cyA0IE1DRSBiYW5rcwpDUFUwOiBUaGVybWFsIG1v
bml0b3JpbmcgZW5hYmxlZCAoVE0xKQpDaGVja2luZyAnaGx0JyBpbnN0cnVjdGlvbi4uLiBPSy4K
RnJlZWluZyBTTVAgYWx0ZXJuYXRpdmVzOiAxMGsgZnJlZWQKRXh0SU5UIG5vdCBzZXR1cCBpbiBo
YXJkd2FyZSBidXQgcmVwb3J0ZWQgYnkgTVAgdGFibGUKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGly
cSA9IDEsIHRyaWcgPSAwLCBhcGljX3RyaWcgPSAwLCByZW1hcCA9IDAKaW9hcGljX3JlZ2lzdGVy
X2ludHI6IGlycSA9IDAsIHRyaWcgPSAwLCBhcGljX3RyaWcgPSAwLCByZW1hcCA9IDAKaW9hcGlj
X3JlZ2lzdGVyX2ludHI6IGlycSA9IDMsIHRyaWcgPSAwLCBhcGljX3RyaWcgPSAwLCByZW1hcCA9
IDAKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDQsIHRyaWcgPSAwLCBhcGljX3RyaWcgPSAw
LCByZW1hcCA9IDAKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDYsIHRyaWcgPSAwLCBhcGlj
X3RyaWcgPSAwLCByZW1hcCA9IDAKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDcsIHRyaWcg
PSAwLCBhcGljX3RyaWcgPSAwLCByZW1hcCA9IDAKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9
IDgsIHRyaWcgPSAwLCBhcGljX3RyaWcgPSAwLCByZW1hcCA9IDAKaW9hcGljX3JlZ2lzdGVyX2lu
dHI6IGlycSA9IDksIHRyaWcgPSAwLCBhcGljX3RyaWcgPSAwLCByZW1hcCA9IDAKaW9hcGljX3Jl
Z2lzdGVyX2ludHI6IGlycSA9IDEyLCB0cmlnID0gMCwgYXBpY190cmlnID0gMCwgcmVtYXAgPSAw
CmlvYXBpY19yZWdpc3Rlcl9pbnRyOiBpcnEgPSAxMywgdHJpZyA9IDAsIGFwaWNfdHJpZyA9IDAs
IHJlbWFwID0gMAppb2FwaWNfcmVnaXN0ZXJfaW50cjogaXJxID0gMTQsIHRyaWcgPSAwLCBhcGlj
X3RyaWcgPSAwLCByZW1hcCA9IDAKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDE1LCB0cmln
ID0gMCwgYXBpY190cmlnID0gMCwgcmVtYXAgPSAwCmlvYXBpY19yZWdpc3Rlcl9pbnRyOiBpcnEg
PSAxNiwgdHJpZyA9IDEsIGFwaWNfdHJpZyA9IDEsIHJlbWFwID0gMAppb2FwaWNfcmVnaXN0ZXJf
aW50cjogaXJxID0gMTcsIHRyaWcgPSAxLCBhcGljX3RyaWcgPSAxLCByZW1hcCA9IDAKaW9hcGlj
X3JlZ2lzdGVyX2ludHI6IGlycSA9IDE4LCB0cmlnID0gMSwgYXBpY190cmlnID0gMSwgcmVtYXAg
PSAwCmlvYXBpY19yZWdpc3Rlcl9pbnRyOiBpcnEgPSAxOSwgdHJpZyA9IDEsIGFwaWNfdHJpZyA9
IDEsIHJlbWFwID0gMAppb2FwaWNfcmVnaXN0ZXJfaW50cjogaXJxID0gMjAsIHRyaWcgPSAxLCBh
cGljX3RyaWcgPSAxLCByZW1hcCA9IDAKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDIzLCB0
cmlnID0gMSwgYXBpY190cmlnID0gMSwgcmVtYXAgPSAwCi4uVElNRVI6IHZlY3Rvcj0weDMwIGFw
aWMxPTAgcGluMT0yIGFwaWMyPTAgcGluMj0wCi4uTVAtQklPUyBidWc6IDgyNTQgdGltZXIgbm90
IGNvbm5lY3RlZCB0byBJTy1BUElDCi4uLnRyeWluZyB0byBzZXQgdXAgdGltZXIgKElSUTApIHRo
cm91Z2ggdGhlIDgyNTlBIC4uLgouLi4uLiAoZm91bmQgYXBpYyAwIHBpbiAwKSAuLi4KLi4uLi4u
LiB3b3Jrcy4KQ1BVMDogSW50ZWwoUikgWGVvbihUTSkgQ1BVIDMuMDBHSHogc3RlcHBpbmcgMDMK
Qm9vdGluZyBwcm9jZXNzb3IgMSBBUElDIDB4NiBpcCAweDYwMDAKSW5pdGlhbGl6aW5nIENQVSMx
CkNhbGlicmF0aW5nIGRlbGF5IHVzaW5nIHRpbWVyIHNwZWNpZmljIHJvdXRpbmUuLiA1OTk5LjE2
IEJvZ29NSVBTIChscGo9Mjk5OTU4NCkKQ1BVOiBUcmFjZSBjYWNoZTogMTJLIHVvcHMsIEwxIEQg
Y2FjaGU6IDE2SwpDUFU6IEwyIGNhY2hlOiAyMDQ4SwpDUFU6IFBoeXNpY2FsIFByb2Nlc3NvciBJ
RDogMwpDUFU6IFByb2Nlc3NvciBDb3JlIElEOiAwCm1jZTogQ1BVIHN1cHBvcnRzIDQgTUNFIGJh
bmtzCkNQVTE6IFRoZXJtYWwgbW9uaXRvcmluZyBlbmFibGVkIChUTTEpCkNQVTE6IEludGVsKFIp
IFhlb24oVE0pIENQVSAzLjAwR0h6IHN0ZXBwaW5nIDAzCmNoZWNraW5nIFRTQyBzeW5jaHJvbml6
YXRpb24gW0NQVSMwIC0+IENQVSMxXTogcGFzc2VkLgpCcm91Z2h0IHVwIDIgQ1BVcwpUb3RhbCBv
ZiAyIHByb2Nlc3NvcnMgYWN0aXZhdGVkICgxMTk5OS40OCBCb2dvTUlQUykuCk5FVDogUmVnaXN0
ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYKUENJOiBQQ0kgQklPUyByZXZpc2lvbiAyLjEwIGVudHJ5
IGF0IDB4ZmQ4NzAsIGxhc3QgYnVzPTYKUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMSBm
b3IgYmFzZSBhY2Nlc3MKYmlvOiBjcmVhdGUgc2xhYiA8YmlvLTA+IGF0IDAKU0NTSSBzdWJzeXN0
ZW0gaW5pdGlhbGl6ZWQKUENJOiBQcm9iaW5nIFBDSSBoYXJkd2FyZQpQQ0k6IFByb2JpbmcgUENJ
IGhhcmR3YXJlIChidXMgMDApCnBjaSAwMDAwOjAwOjAyLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20g
RDAgRDNob3QgRDNjb2xkCnBjaSAwMDAwOjAwOjAyLjA6IFBNRSMgZGlzYWJsZWQKcGNpIDAwMDA6
MDA6MDMuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKcGNpIDAwMDA6MDA6
MDMuMDogUE1FIyBkaXNhYmxlZApwY2kgMDAwMDowMDowNC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQwIEQzaG90IEQzY29sZApwY2kgMDAwMDowMDowNC4wOiBQTUUjIGRpc2FibGVkCnBjaSAwMDAw
OjAwOjFkLjA6IHJlZyAyMCBpbyBwb3J0OiBbMHgxODQwLTB4MTg1Zl0KcGNpIDAwMDA6MDA6MWQu
MTogcmVnIDIwIGlvIHBvcnQ6IFsweDE4NjAtMHgxODdmXQpwY2kgMDAwMDowMDoxZC4yOiByZWcg
MjAgaW8gcG9ydDogWzB4MTg4MC0weDE4OWZdCnBjaSAwMDAwOjAwOjFkLjM6IHJlZyAyMCBpbyBw
b3J0OiBbMHgxOGEwLTB4MThiZl0KcGNpIDAwMDA6MDA6MWQuNzogcmVnIDEwIDMyYml0IG1taW86
IFsweGQwMDAwMDAwLTB4ZDAwMDAzZmZdCnBjaSAwMDAwOjAwOjFkLjc6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDAgRDNob3QgRDNjb2xkCnBjaSAwMDAwOjAwOjFkLjc6IFBNRSMgZGlzYWJsZWQKcGNp
IDAwMDA6MDA6MWYuMDogcXVpcms6IHJlZ2lvbiAxMDAwLTEwN2YgY2xhaW1lZCBieSBJQ0g0IEFD
UEkvR1BJTy9UQ08KcGNpIDAwMDA6MDA6MWYuMDogcXVpcms6IHJlZ2lvbiAxMTgwLTExYmYgY2xh
aW1lZCBieSBJQ0g0IEdQSU8KcGNpIDAwMDA6MDA6MWYuMjogcmVnIDEwIGlvIHBvcnQ6IFsweDAw
LTB4MDddCnBjaSAwMDAwOjAwOjFmLjI6IHJlZyAxNCBpbyBwb3J0OiBbMHgwMC0weDAzXQpwY2kg
MDAwMDowMDoxZi4yOiByZWcgMTggaW8gcG9ydDogWzB4MDAtMHgwN10KcGNpIDAwMDA6MDA6MWYu
MjogcmVnIDFjIGlvIHBvcnQ6IFsweDAwLTB4MDNdCnBjaSAwMDAwOjAwOjFmLjI6IHJlZyAyMCBp
byBwb3J0OiBbMHgxOGYwLTB4MThmZl0KcGNpIDAwMDA6MDA6MWYuMzogcmVnIDIwIGlvIHBvcnQ6
IFsweDExMDAtMHgxMTFmXQpwY2kgMDAwMDowMDoxZi41OiByZWcgMTAgaW8gcG9ydDogWzB4MTQw
MC0weDE0ZmZdCnBjaSAwMDAwOjAwOjFmLjU6IHJlZyAxNCBpbyBwb3J0OiBbMHgxODAwLTB4MTgz
Zl0KcGNpIDAwMDA6MDA6MWYuNTogcmVnIDE4IDMyYml0IG1taW86IFsweGQwMDAwYzAwLTB4ZDAw
MDBkZmZdCnBjaSAwMDAwOjAwOjFmLjU6IHJlZyAxYyAzMmJpdCBtbWlvOiBbMHhkMDAwMDgwMC0w
eGQwMDAwOGZmXQpwY2kgMDAwMDowMDoxZi41OiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90
IEQzY29sZApwY2kgMDAwMDowMDoxZi41OiBQTUUjIGRpc2FibGVkCnBjaSAwMDAwOjAyOjAwLjA6
IFBYSCBxdWlyayBkZXRlY3RlZDsgU0hQQyBkZXZpY2UgTVNJIGRpc2FibGVkCnBjaSAwMDAwOjAy
OjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkCnBjaSAwMDAwOjAyOjAw
LjA6IFBNRSMgZGlzYWJsZWQKcGNpIDAwMDA6MDI6MDAuMTogcmVnIDEwIDMyYml0IG1taW86IFsw
eGQwMTAwMDAwLTB4ZDAxMDBmZmZdCnBjaSAwMDAwOjAyOjAwLjI6IFBYSCBxdWlyayBkZXRlY3Rl
ZDsgU0hQQyBkZXZpY2UgTVNJIGRpc2FibGVkCnBjaSAwMDAwOjAyOjAwLjI6IFBNRSMgc3VwcG9y
dGVkIGZyb20gRDAgRDNob3QgRDNjb2xkCnBjaSAwMDAwOjAyOjAwLjI6IFBNRSMgZGlzYWJsZWQK
cGNpIDAwMDA6MDI6MDAuMzogcmVnIDEwIDMyYml0IG1taW86IFsweGQwMTAxMDAwLTB4ZDAxMDFm
ZmZdCnBjaSAwMDAwOjAwOjAzLjA6IGJyaWRnZSBpbyBwb3J0OiBbMHgyMDAwLTB4M2ZmZl0KcGNp
IDAwMDA6MDA6MDMuMDogYnJpZGdlIDMyYml0IG1taW86IFsweGQwMTAwMDAwLTB4ZDA4ZmZmZmZd
CnBjaSAwMDAwOjAzOjAzLjA6IHJlZyAxMCA2NGJpdCBtbWlvOiBbMHhkMDIwMDAwMC0weGQwMmZm
ZmZmXQpwY2kgMDAwMDowMzowMy4wOiByZWcgMTggaW8gcG9ydDogWzB4MjAwMC0weDIwZmZdCnBj
aSAwMDAwOjAzOjAzLjA6IHJlZyAxYyA2NGJpdCBtbWlvOiBbMHhkMDQwMDAwMC0weGQwN2ZmZmZm
XQpwY2kgMDAwMDowMzowMy4wOiByZWcgMzAgMzJiaXQgbW1pbzogWzB4MDAwMDAwLTB4M2ZmZmZm
XQpwY2kgMDAwMDowMjowMC4wOiBicmlkZ2UgaW8gcG9ydDogWzB4MjAwMC0weDJmZmZdCnBjaSAw
MDAwOjAyOjAwLjA6IGJyaWRnZSAzMmJpdCBtbWlvOiBbMHhkMDIwMDAwMC0weGQwN2ZmZmZmXQpw
Y2kgMDAwMDowNDowMS4wOiByZWcgMTAgMzJiaXQgbW1pbzogWzB4ZDA4MDEwMDAtMHhkMDgwMWZm
Zl0KcGNpIDAwMDA6MDQ6MDEuMDogcmVnIDE0IDMyYml0IG1taW86IFsweGQwODAwMDAwLTB4ZDA4
MDBmZmZdCnBjaSAwMDAwOjA0OjAyLjA6IHJlZyAxMCA2NGJpdCBtbWlvOiBbMHhkMDgyMDAwMC0w
eGQwODNmZmZmXQpwY2kgMDAwMDowNDowMi4wOiByZWcgMjAgaW8gcG9ydDogWzB4MzAwMC0weDMw
M2ZdCnBjaSAwMDAwOjA0OjAyLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xk
CnBjaSAwMDAwOjA0OjAyLjA6IFBNRSMgZGlzYWJsZWQKcGNpIDAwMDA6MDQ6MDIuMTogcmVnIDEw
IDY0Yml0IG1taW86IFsweGQwODQwMDAwLTB4ZDA4NWZmZmZdCnBjaSAwMDAwOjA0OjAyLjE6IHJl
ZyAyMCBpbyBwb3J0OiBbMHgzMDQwLTB4MzA3Zl0KcGNpIDAwMDA6MDQ6MDIuMTogUE1FIyBzdXBw
b3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKcGNpIDAwMDA6MDQ6MDIuMTogUE1FIyBkaXNhYmxl
ZApwY2kgMDAwMDowMjowMC4yOiBicmlkZ2UgaW8gcG9ydDogWzB4MzAwMC0weDNmZmZdCnBjaSAw
MDAwOjAyOjAwLjI6IGJyaWRnZSAzMmJpdCBtbWlvOiBbMHhkMDgwMDAwMC0weGQwOGZmZmZmXQpw
Y2kgMDAwMDowNTowMC4wOiByZWcgMTAgMzJiaXQgbW1pbzogWzB4ZDgwMDAwMDAtMHhkZmZmZmZm
Zl0KcGNpIDAwMDA6MDU6MDAuMDogcmVnIDE0IGlvIHBvcnQ6IFsweDQwMDAtMHg0MGZmXQpwY2kg
MDAwMDowNTowMC4wOiByZWcgMTggMzJiaXQgbW1pbzogWzB4ZDA5MDAwMDAtMHhkMDkwZmZmZl0K
cGNpIDAwMDA6MDU6MDAuMDogcmVnIDMwIDMyYml0IG1taW86IFsweDAwMDAwMC0weDAxZmZmZl0K
cGNpIDAwMDA6MDU6MDAuMDogc3VwcG9ydHMgRDEgRDIKcGNpIDAwMDA6MDU6MDAuMTogcmVnIDEw
IDMyYml0IG1taW86IFsweGQwOTEwMDAwLTB4ZDA5MWZmZmZdCnBjaSAwMDAwOjA1OjAwLjE6IHN1
cHBvcnRzIEQxIEQyCnBjaSAwMDAwOjAwOjA0LjA6IGJyaWRnZSBpbyBwb3J0OiBbMHg0MDAwLTB4
NGZmZl0KcGNpIDAwMDA6MDA6MDQuMDogYnJpZGdlIDMyYml0IG1taW86IFsweGQwOTAwMDAwLTB4
ZDA5ZmZmZmZdCnBjaSAwMDAwOjAwOjA0LjA6IGJyaWRnZSA2NGJpdCBtbWlvIHByZWY6IFsweGQ4
MDAwMDAwLTB4ZGZmZmZmZmZdCnBjaSAwMDAwOjA2OjAyLjA6IHJlZyAxMCAzMmJpdCBtbWlvOiBb
MHhkMGEwMDAwMC0weGQwYTBmZmZmXQpwY2kgMDAwMDowMDoxZS4wOiB0cmFuc3BhcmVudCBicmlk
Z2UKcGNpIDAwMDA6MDA6MWUuMDogYnJpZGdlIDMyYml0IG1taW86IFsweGQwYTAwMDAwLTB4ZDBh
ZmZmZmZdCnBjaSAwMDAwOjAwOjFmLjA6IFBJSVgvSUNIIElSUSByb3V0ZXIgWzgwODY6MjRkMF0K
cGNpIDAwMDA6MDA6MDIuMDogUENJIGJyaWRnZSwgc2Vjb25kYXJ5IGJ1cyAwMDAwOjAxCnBjaSAw
MDAwOjAwOjAyLjA6ICAgSU8gd2luZG93OiBkaXNhYmxlZApwY2kgMDAwMDowMDowMi4wOiAgIE1F
TSB3aW5kb3c6IGRpc2FibGVkCnBjaSAwMDAwOjAwOjAyLjA6ICAgUFJFRkVUQ0ggd2luZG93OiBk
aXNhYmxlZApwY2kgMDAwMDowMjowMC4wOiBQQ0kgYnJpZGdlLCBzZWNvbmRhcnkgYnVzIDAwMDA6
MDMKcGNpIDAwMDA6MDI6MDAuMDogICBJTyB3aW5kb3c6IDB4MjAwMC0weDJmZmYKcGNpIDAwMDA6
MDI6MDAuMDogICBNRU0gd2luZG93OiAweGQwMjAwMDAwLTB4ZDA3ZmZmZmYKcGNpIDAwMDA6MDI6
MDAuMDogICBQUkVGRVRDSCB3aW5kb3c6IDB4YzAwMDAwMDAtMHhjMDNmZmZmZgpwY2kgMDAwMDow
MjowMC4yOiBQQ0kgYnJpZGdlLCBzZWNvbmRhcnkgYnVzIDAwMDA6MDQKcGNpIDAwMDA6MDI6MDAu
MjogICBJTyB3aW5kb3c6IDB4MzAwMC0weDNmZmYKcGNpIDAwMDA6MDI6MDAuMjogICBNRU0gd2lu
ZG93OiAweGQwODAwMDAwLTB4ZDA4ZmZmZmYKcGNpIDAwMDA6MDI6MDAuMjogICBQUkVGRVRDSCB3
aW5kb3c6IGRpc2FibGVkCnBjaSAwMDAwOjAwOjAzLjA6IFBDSSBicmlkZ2UsIHNlY29uZGFyeSBi
dXMgMDAwMDowMgpwY2kgMDAwMDowMDowMy4wOiAgIElPIHdpbmRvdzogMHgyMDAwLTB4M2ZmZgpw
Y2kgMDAwMDowMDowMy4wOiAgIE1FTSB3aW5kb3c6IDB4ZDAxMDAwMDAtMHhkMDhmZmZmZgpwY2kg
MDAwMDowMDowMy4wOiAgIFBSRUZFVENIIHdpbmRvdzogMHhjMDAwMDAwMC0weGMwM2ZmZmZmCnBj
aSAwMDAwOjAwOjA0LjA6IFBDSSBicmlkZ2UsIHNlY29uZGFyeSBidXMgMDAwMDowNQpwY2kgMDAw
MDowMDowNC4wOiAgIElPIHdpbmRvdzogMHg0MDAwLTB4NGZmZgpwY2kgMDAwMDowMDowNC4wOiAg
IE1FTSB3aW5kb3c6IDB4ZDA5MDAwMDAtMHhkMDlmZmZmZgpwY2kgMDAwMDowMDowNC4wOiAgIFBS
RUZFVENIIHdpbmRvdzogMHgwMDAwMDBkODAwMDAwMC0weDAwMDAwMGRmZmZmZmZmCnBjaSAwMDAw
OjAwOjFlLjA6IFBDSSBicmlkZ2UsIHNlY29uZGFyeSBidXMgMDAwMDowNgpwY2kgMDAwMDowMDox
ZS4wOiAgIElPIHdpbmRvdzogZGlzYWJsZWQKcGNpIDAwMDA6MDA6MWUuMDogICBNRU0gd2luZG93
OiAweGQwYTAwMDAwLTB4ZDBhZmZmZmYKcGNpIDAwMDA6MDA6MWUuMDogICBQUkVGRVRDSCB3aW5k
b3c6IGRpc2FibGVkCmlvYXBpY19yZWdpc3Rlcl9pbnRyOiBpcnEgPSAxNiwgdHJpZyA9IDEsIGFw
aWNfdHJpZyA9IDEsIHJlbWFwID0gMApwY2kgMDAwMDowMDowMi4wOiBQQ0ktPkFQSUMgSVJRIHRy
YW5zZm9ybTogSU5UIEEgLT4gSVJRIDE2CnBjaSAwMDAwOjAwOjAyLjA6IHNldHRpbmcgbGF0ZW5j
eSB0aW1lciB0byA2NApwY2kgMDAwMDowMDowMy4wOiBQQ0ktPkFQSUMgSVJRIHRyYW5zZm9ybTog
SU5UIEEgLT4gSVJRIDE2CnBjaSAwMDAwOjAwOjAzLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0
byA2NApwY2kgMDAwMDowMjowMC4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKcGNpIDAw
MDA6MDI6MDAuMjogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0CnBjaSAwMDAwOjAwOjA0LjA6
IFBDSS0+QVBJQyBJUlEgdHJhbnNmb3JtOiBJTlQgQSAtPiBJUlEgMTYKcGNpIDAwMDA6MDA6MDQu
MDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0CnBjaSAwMDAwOjAwOjFlLjA6IHNldHRpbmcg
bGF0ZW5jeSB0aW1lciB0byA2NApwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDAgaW86ICBbMHgw
MC0weGZmZmZdCnBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgMSBtZW06IFsweDAwMDAwMC0weGZm
ZmZmZmZmXQpwY2lfYnVzIDAwMDA6MDI6IHJlc291cmNlIDAgaW86ICBbMHgyMDAwLTB4M2ZmZl0K
cGNpX2J1cyAwMDAwOjAyOiByZXNvdXJjZSAxIG1lbTogWzB4ZDAxMDAwMDAtMHhkMDhmZmZmZl0K
cGNpX2J1cyAwMDAwOjAyOiByZXNvdXJjZSAyIHByZWYgbWVtIFsweGMwMDAwMDAwLTB4YzAzZmZm
ZmZdCnBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMCBpbzogIFsweDIwMDAtMHgyZmZmXQpwY2lf
YnVzIDAwMDA6MDM6IHJlc291cmNlIDEgbWVtOiBbMHhkMDIwMDAwMC0weGQwN2ZmZmZmXQpwY2lf
YnVzIDAwMDA6MDM6IHJlc291cmNlIDIgcHJlZiBtZW0gWzB4YzAwMDAwMDAtMHhjMDNmZmZmZl0K
cGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSAwIGlvOiAgWzB4MzAwMC0weDNmZmZdCnBjaV9idXMg
MDAwMDowNDogcmVzb3VyY2UgMSBtZW06IFsweGQwODAwMDAwLTB4ZDA4ZmZmZmZdCnBjaV9idXMg
MDAwMDowNTogcmVzb3VyY2UgMCBpbzogIFsweDQwMDAtMHg0ZmZmXQpwY2lfYnVzIDAwMDA6MDU6
IHJlc291cmNlIDEgbWVtOiBbMHhkMDkwMDAwMC0weGQwOWZmZmZmXQpwY2lfYnVzIDAwMDA6MDU6
IHJlc291cmNlIDIgcHJlZiBtZW0gWzB4ZDgwMDAwMDAtMHhkZmZmZmZmZl0KcGNpX2J1cyAwMDAw
OjA2OiByZXNvdXJjZSAxIG1lbTogWzB4ZDBhMDAwMDAtMHhkMGFmZmZmZl0KcGNpX2J1cyAwMDAw
OjA2OiByZXNvdXJjZSAzIGlvOiAgWzB4MDAtMHhmZmZmXQpwY2lfYnVzIDAwMDA6MDY6IHJlc291
cmNlIDQgbWVtOiBbMHgwMDAwMDAtMHhmZmZmZmZmZl0KTkVUOiBSZWdpc3RlcmVkIHByb3RvY29s
IGZhbWlseSAyCklQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVy
OiA1LCAxMzEwNzIgYnl0ZXMpClRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDEz
MTA3MiAob3JkZXI6IDgsIDEwNDg1NzYgYnl0ZXMpClRDUCBiaW5kIGhhc2ggdGFibGUgZW50cmll
czogNjU1MzYgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMpClRDUDogSGFzaCB0YWJsZXMgY29uZmln
dXJlZCAoZXN0YWJsaXNoZWQgMTMxMDcyIGJpbmQgNjU1MzYpClRDUCByZW5vIHJlZ2lzdGVyZWQK
VW5wYWNraW5nIGluaXRyYW1mcy4uLgpGcmVlaW5nIGluaXRyZCBtZW1vcnk6IDE4OTJrIGZyZWVk
CnBsYXRmb3JtIHJ0Y19jbW9zOiByZWdpc3RlcmVkIHBsYXRmb3JtIFJUQyBkZXZpY2UgKG5vIFBO
UCBkZXZpY2UgZm91bmQpCmF1ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzb2NrZXQgKGRpc2Fi
bGVkKQp0eXBlPTIwMDAgYXVkaXQoMTI1OTU2OTM1Mi4yODQ6MSk6IGluaXRpYWxpemVkCkktcGlw
ZTogRG9tYWluIFhlbm9tYWkgcmVnaXN0ZXJlZC4KWGVub21haTogaGFsL2kzODYgc3RhcnRlZC4K
WGVub21haTogc2NoZWR1bGluZyBjbGFzcyBpZGxlIHJlZ2lzdGVyZWQuClhlbm9tYWk6IHNjaGVk
dWxpbmcgY2xhc3MgcnQgcmVnaXN0ZXJlZC4KWGVub21haTogcmVhbC10aW1lIG51Y2xldXMgdjIu
NS1yYzQgKEZseWluZyBJbiBBIEJsdWUgRHJlYW0pIGxvYWRlZC4KbXNnbW5pIGhhcyBiZWVuIHNl
dCB0byAxNzY3CmlvIHNjaGVkdWxlciBub29wIHJlZ2lzdGVyZWQKaW8gc2NoZWR1bGVyIGRlYWRs
aW5lIHJlZ2lzdGVyZWQgKGRlZmF1bHQpCnBjaSAwMDAwOjA1OjAwLjA6IEJvb3QgdmlkZW8gZGV2
aWNlCnBjaWVwb3J0LWRyaXZlciAwMDAwOjAwOjAyLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0
byA2NApwY2llcG9ydC1kcml2ZXIgMDAwMDowMDowMy4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIg
dG8gNjQKcGNpZXBvcnQtZHJpdmVyIDAwMDA6MDA6MDQuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVy
IHRvIDY0CnNlcmlvOiBpODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKc2VyaW86IGk4
MDQyIEFVWCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMTIKbWljZTogUFMvMiBtb3VzZSBkZXZpY2Ug
Y29tbW9uIGZvciBhbGwgbWljZQpUQ1AgY3ViaWMgcmVnaXN0ZXJlZApORVQ6IFJlZ2lzdGVyZWQg
cHJvdG9jb2wgZmFtaWx5IDE3ClVzaW5nIElQSSBTaG9ydGN1dCBtb2RlCkZyZWVpbmcgdW51c2Vk
IGtlcm5lbCBtZW1vcnk6IDI5MmsgZnJlZWQKaW5wdXQ6IEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5
Ym9hcmQgYXMgL2NsYXNzL2lucHV0L2lucHV0MApORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFt
aWx5IDEKbGliYXRhIHZlcnNpb24gMy4wMCBsb2FkZWQuCnNhdGFfbXYgMDAwMDowMzowMy4wOiB2
ZXJzaW9uIDEuMjgKaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDI4LCB0cmlnID0gMSwgYXBp
Y190cmlnID0gMSwgcmVtYXAgPSAwCnNhdGFfbXYgMDAwMDowMzowMy4wOiBQQ0ktPkFQSUMgSVJR
IHRyYW5zZm9ybTogSU5UIEEgLT4gSVJRIDI4CnNhdGFfbXYgMDAwMDowMzowMy4wOiBHZW4tSUkg
MzIgc2xvdHMgOCBwb3J0cyBTQ1NJIG1vZGUgSVJRIHZpYSBJTlR4CkludGVsKFIpIFBSTy8xMDAw
IE5ldHdvcmsgRHJpdmVyIC0gdmVyc2lvbiA3LjMuMjEtazMtTkFQSQpDb3B5cmlnaHQgKGMpIDE5
OTktMjAwNiBJbnRlbCBDb3Jwb3JhdGlvbi4KaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDU0
LCB0cmlnID0gMSwgYXBpY190cmlnID0gMSwgcmVtYXAgPSAwCmUxMDAwIDAwMDA6MDQ6MDIuMDog
UENJLT5BUElDIElSUSB0cmFuc2Zvcm06IElOVCBBIC0+IElSUSA1NAphdGFfcGlpeCAwMDAwOjAw
OjFmLjI6IHZlcnNpb24gMi4xMwppb2FwaWNfcmVnaXN0ZXJfaW50cjogaXJxID0gMTgsIHRyaWcg
PSAxLCBhcGljX3RyaWcgPSAxLCByZW1hcCA9IDAKYXRhX3BpaXggMDAwMDowMDoxZi4yOiBQQ0kt
PkFQSUMgSVJRIHRyYW5zZm9ybTogSU5UIEEgLT4gSVJRIDE4CmF0YV9waWl4IDAwMDA6MDA6MWYu
MjogTUFQIFsgSURFIElERSBQMCBQMSBdCnNjc2kwIDogc2F0YV9tdgpzY3NpMSA6IHNhdGFfbXYK
c2NzaTIgOiBzYXRhX212CnNjc2kzIDogc2F0YV9tdgpzY3NpNCA6IHNhdGFfbXYKc2NzaTUgOiBz
YXRhX212CnNjc2k2IDogc2F0YV9tdgpzY3NpNyA6IHNhdGFfbXYKYXRhMTogU0FUQSBtYXggVURN
QS8xMzMgbW1pbyBtMTA0ODU3NkAweGQwMjAwMDAwIHBvcnQgMHhkMDIyMjAwMCBpcnEgMjgKYXRh
MjogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBtMTA0ODU3NkAweGQwMjAwMDAwIHBvcnQgMHhkMDIy
NDAwMCBpcnEgMjgKYXRhMzogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBtMTA0ODU3NkAweGQwMjAw
MDAwIHBvcnQgMHhkMDIyNjAwMCBpcnEgMjgKYXRhNDogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBt
MTA0ODU3NkAweGQwMjAwMDAwIHBvcnQgMHhkMDIyODAwMCBpcnEgMjgKYXRhNTogU0FUQSBtYXgg
VURNQS8xMzMgbW1pbyBtMTA0ODU3NkAweGQwMjAwMDAwIHBvcnQgMHhkMDIzMjAwMCBpcnEgMjgK
YXRhNjogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBtMTA0ODU3NkAweGQwMjAwMDAwIHBvcnQgMHhk
MDIzNDAwMCBpcnEgMjgKYXRhNzogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBtMTA0ODU3NkAweGQw
MjAwMDAwIHBvcnQgMHhkMDIzNjAwMCBpcnEgMjgKYXRhODogU0FUQSBtYXggVURNQS8xMzMgbW1p
byBtMTA0ODU3NkAweGQwMjAwMDAwIHBvcnQgMHhkMDIzODAwMCBpcnEgMjgKYXRhX3BpaXggMDAw
MDowMDoxZi4yOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKc2NzaTggOiBhdGFfcGlpeApz
Y3NpOSA6IGF0YV9waWl4CmF0YTk6IFBBVEEgbWF4IFVETUEvMTAwIGNtZCAweDFmMCBjdGwgMHgz
ZjYgYm1kbWEgMHgxOGYwIGlycSAxNAphdGExMDogU0FUQSBtYXggVURNQS8xMzMgY21kIDB4MTcw
IGN0bCAweDM3NiBibWRtYSAweDE4ZjggaXJxIDE1CmlucHV0OiBJbVBTLzIgTG9naXRlY2ggV2hl
ZWwgTW91c2UgYXMgL2NsYXNzL2lucHV0L2lucHV0MQplMTAwMDogMDAwMDowNDowMi4wOiBlMTAw
MF9wcm9iZTogKFBDSTozM01Iejo2NC1iaXQpIDAwOjMwOjQ4OjJlOjk0OmI2CmUxMDAwOiBldGgw
OiBlMTAwMF9wcm9iZTogSW50ZWwoUikgUFJPLzEwMDAgTmV0d29yayBDb25uZWN0aW9uCmlvYXBp
Y19yZWdpc3Rlcl9pbnRyOiBpcnEgPSA1NSwgdHJpZyA9IDEsIGFwaWNfdHJpZyA9IDEsIHJlbWFw
ID0gMAplMTAwMCAwMDAwOjA0OjAyLjE6IFBDSS0+QVBJQyBJUlEgdHJhbnNmb3JtOiBJTlQgQiAt
PiBJUlEgNTUKYXRhMTAuMDA6IEFUQS03OiBIRFQ3MjI1MjVETEEzODAsIFY0NE9BOTZBLCBtYXgg
VURNQS8xMzMKYXRhMTAuMDA6IDQ4ODM5NzE2OCBzZWN0b3JzLCBtdWx0aSAxNjogTEJBNDggTkNR
IChkZXB0aCAwLzMyKQphdGExOiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9sIDMw
MCkKYXRhMTAuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMzCmF0YTkuMDA6IEFUQVBJOiBTT05Z
ICAgIERWRCBSVyBEVy1RMzBBLCBZWVMyLCBtYXggVURNQS82NgphdGE5LjAwOiBsaW1pdGVkIHRv
IFVETUEvMzMgZHVlIHRvIDQwLXdpcmUgY2FibGUKYXRhOS4wMDogY29uZmlndXJlZCBmb3IgVURN
QS8zMwplMTAwMDogMDAwMDowNDowMi4xOiBlMTAwMF9wcm9iZTogKFBDSTozM01Iejo2NC1iaXQp
IDAwOjMwOjQ4OjJlOjk0OmI3CmUxMDAwOiBldGgxOiBlMTAwMF9wcm9iZTogSW50ZWwoUikgUFJP
LzEwMDAgTmV0d29yayBDb25uZWN0aW9uCmF0YTI6IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAg
U0NvbnRyb2wgMzAwKQphdGEzOiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9sIDMw
MCkKYXRhNDogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMDApCmF0YTU6IFNB
VEEgbGluayBkb3duIChTU3RhdHVzIDAgU0NvbnRyb2wgMzAwKQphdGE2OiBTQVRBIGxpbmsgZG93
biAoU1N0YXR1cyAwIFNDb250cm9sIDMwMCkKYXRhNzogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMg
MCBTQ29udHJvbCAzMDApCmF0YTg6IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAgU0NvbnRyb2wg
MzAwKQpzY3NpIDg6MDowOjA6IENELVJPTSAgICAgICAgICAgIFNPTlkgICAgIERWRCBSVyBEVy1R
MzBBICAgWVlTMiBQUTogMCBBTlNJOiA1CnNjc2kgOTowOjA6MDogRGlyZWN0LUFjY2VzcyAgICAg
QVRBICAgICAgSERUNzIyNTI1RExBMzgwICBWNDRPIFBROiAwIEFOU0k6IDUKc2QgOTowOjA6MDog
W3NkYV0gNDg4Mzk3MTY4IDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoMjUwIEdCLzIzMiBHaUIp
CnNkIDk6MDowOjA6IFtzZGFdIFdyaXRlIFByb3RlY3QgaXMgb2ZmCnNkIDk6MDowOjA6IFtzZGFd
IE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwCnNkIDk6MDowOjA6IFtzZGFdIFdyaXRlIGNhY2hlOiBl
bmFibGVkLCByZWFkIGNhY2hlOiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZVQQog
c2RhOiBzZGExIHNkYTIgPCBzZGE1ID4Kc2QgOTowOjA6MDogW3NkYV0gQXR0YWNoZWQgU0NTSSBk
aXNrClVuaWZvcm0gTXVsdGktUGxhdGZvcm0gRS1JREUgZHJpdmVyCmtqb3VybmFsZCBzdGFydGlu
Zy4gIENvbW1pdCBpbnRlcnZhbCA1IHNlY29uZHMKRVhUMy1mczogbW91bnRlZCBmaWxlc3lzdGVt
IHdpdGggd3JpdGViYWNrIGRhdGEgbW9kZS4KdWRldmQgdmVyc2lvbiAxMjUgc3RhcnRlZAooYXN0
cm9wY2lfaW5pdCk6ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwooYXN0cm9wY2lf
aW5pdCk6IHwgICBBU1RST1BDSSAtIEluaXRpYWxpemF0aW9uICAgfAooYXN0cm9wY2lfaW5pdCk6
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwooYXN0cm9wY2lfcHJvYmUpOiBsb29r
aW5nIGZvciBBUkMgUENJIGJvYXJkcyAuLi4KaW9hcGljX3JlZ2lzdGVyX2ludHI6IGlycSA9IDIw
LCB0cmlnID0gMSwgYXBpY190cmlnID0gMSwgcmVtYXAgPSAwCmFzdHJvcGNpIDAwMDA6MDY6MDIu
MDogUENJLT5BUElDIElSUSB0cmFuc2Zvcm06IElOVCBBIC0+IElSUSAyMAooYXN0cm9wY2lfcHJv
YmUpOiBJU1IgbmFtZTogYXN0cm9wY2kwIGRldmljZSBudW06IDAKSVJRIDIwL2FzdHJvcGNpMDog
SVJRRl9ESVNBQkxFRCBpcyBub3QgZ3VhcmFudGVlZCBvbiBzaGFyZWQgSVJRcwooYXN0cm9wY2lf
cHJvYmUpOiBTdWNjZXNzZnVsbHkgcHJvYmVkIGRldmljZSAwLCBoYXNfaXJxOiAxLCBpcnEgMjAs
IGZ1bmMgMTYKKGFzdHJvcGNpX3Byb2JlKTogZmluaXNoZWQgbG9va2luZyBmb3IgQVJDIFBDSSBi
b2FyZHMKWGVub21haTogU01JLWVuYWJsZWQgY2hpcHNldCBmb3VuZApYZW5vbWFpOiBTTUkgd29y
a2Fyb3VuZCBlbmFibGVkClhlbm9tYWk6IHN0YXJ0aW5nIFJURE0gc2VydmljZXMuCkFuYWxvZ3k6
IE1JVEU6IEF2YWlsYWJsZSBOSSBkZXZpY2UgSURzOiAweDE4ODAKQWRkaW5nIDI2NTA2ODRrIHN3
YXAgb24gL2Rldi9zZGE1LiAgUHJpb3JpdHk6LTEgZXh0ZW50czoxIGFjcm9zczoyNjUwNjg0ayAK
RVhUMyBGUyBvbiBzZGExLCBpbnRlcm5hbCBqb3VybmFsClhlbm9tYWk6IHN0YXJ0aW5nIG5hdGl2
ZSBBUEkgc2VydmljZXMuCmUxMDAwOiBldGgwIE5JQyBMaW5rIGlzIFVwIDEwMCBNYnBzIEZ1bGwg
RHVwbGV4LCBGbG93IENvbnRyb2w6IFJYL1RYCndhcm5pbmc6IGBudHBkJyB1c2VzIDMyLWJpdCBj
YXBhYmlsaXRpZXMgKGxlZ2FjeSBzdXBwb3J0IGluIHVzZSkKaXJxX3Rlc3Q6IGJlZm9yZSByZXF1
ZXN0X2lycQppcnFfdGVzdDogYWZ0ZXIgcmVxdWVzdF9pcnEgKGVyciA9IC0zOCkK
--00151774051c81c1a10479929b08--

