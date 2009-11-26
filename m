MIME-Version: 1.0
In-Reply-To: <72cf3fb0911260134m36c1d5b0s9b24843b11610455@domain.hid>
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>
	<200911232310.44441.berlemont.hauw@domain.hid>
	<4bed572e0911241334x7691431dh37a17c461be53d98@domain.hid>
	<200911242357.52347.berlemont.hauw@domain.hid>
	<4bed572e0911260022o70a984b1r98e6728044969d93@domain.hid>
	<72cf3fb0911260134m36c1d5b0s9b24843b11610455@domain.hid>
Date: Thu, 26 Nov 2009 15:38:06 -0800
Message-ID: <4bed572e0911261538m787ec9c9qf2a76d8e892f2d48@domain.hid>
From: Ettore Pedretti <epedrett@domain.hid>
Content-Type: multipart/mixed; boundary=000e0cd6aa06cde4eb04794eaa58
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

--000e0cd6aa06cde4eb04794eaa58
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/26 Alexis Berlemont <berlemont.hauw@domain.hid>:
> On Thu, Nov 26, 2009 at 9:22 AM, Ettore Pedretti <epedrett@domain.hid> wro=
te:
>> Hi Alexis,
>>
>> I applied the patch to my local git repository:
>>
>> fangorn:/usr/src#
>> cd xenomai-head/
>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
>> patch_debug_1.diff
>> fangorn:/usr/src/xenomai-head# git apply ../patch_debug_1.diff
>> ../patch_debug_1.diff:14: trailing whitespace.
>> =A0 =A0 =A0 rtdm_printk("\t handler=3D%p, irq=3D%d, cookie=3D%p\n",
>> warning: 1 line adds whitespace errors.
>>
>> Then created a debian package:
>>
>> git-buildpackage -us -uc -rfakeroot --git-debian-branch=3Dmaster
>> --git-upstream-branch=3Dorigin/master --git-ignore-new
>>
>> built a new kernel package:
>>
>> fakeroot make-kpkg --initrd --added-patches xenomai
>> --revision=3DipipeComedi.2.4.06 --config menuconfig binary-arch
>>
>> and installed the Debian package with dpkg -i
>>
>> This is what happens when i insert the module into the kernel:
>>
>> fangorn:~/control/CHAMP/irqTest# insmod irqTest.ko
>> Killed
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:Oops: 0000 [#1] PREEMPT SMP
>> fangorn:~/control/CHAMP/irqTest#
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:last sysfs file: /sys/class/net/lo/operstate
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:Process insmod (pid: 3566, ti=3Df6c02000 task=3Df78634b0 task.=
ti=3Df6c02000)
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:I-pipe domain Linux
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:Stack:
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:Call Trace:
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:Code: =A0Bad EIP value.
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
>>
>> Message from syslogd@domain.hid at Nov 26 00:09:52 ...
>> =A0kernel:CR2: 0000000000000000
>>
>> dmesg after insmod:
>>
>> irq_test: before rtdm_irq_request
>> BUG: unable to handle kernel NULL pointer dereference at (null)
>> IP: [<(null)>] (null)
>> *pde =3D 00000000
>> Oops: 0000 [#1] PREEMPT SMP
>> last sysfs file: /sys/class/net/lo/operstate
>> Modules linked in: irqTest(+) xeno_native analogy_ni_pcimio
>> analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite
>> xeno_analogy xeno_rtdm astropci ext3 jbd mbcache ide_pci_generic
>> ide_core ata_piix sata_mv e1000 libata unix [last unloaded:
>> scsi_wait_scan]
>>
>> Pid: 3566, comm: insmod Not tainted (2.6.31.1 #1) X6DA8
>> EIP: 0060:[<00000000>] EFLAGS: 00010246 CPU: 1
>> EIP is at 0x0
>> EAX: 00000030 EBX: 00000000 ECX: 00000030 EDX: c1250b80
>> ESI: f8e24500 EDI: 00000000 EBP: f6c03f1c ESP: f6c03f18
>> =A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
>> Process insmod (pid: 3566, ti=3Df6c02000 task=3Df78634b0 task.ti=3Df6c02=
000)
>> I-pipe domain Linux
>> Stack:
>> =A0c1154166 f6c03f24 c105abf7 f6c03f40 f8a0ea5d f8e24000 00000000 000000=
00
>> <0> f8e27000 00000000 f6c03f58 f8e2703e 00000000 f8e24066 00000000 f8e27=
000
>> <0> f6c03f84 c1001028 f8e243c0 00000001 fffffffc f8e243c0 00000000 f6c03=
f84
>> Call Trace:
>> =A0[<c1154166>] ? rthal_irq_enable+0x2d/0x31
>> =A0[<c105abf7>] ? xnintr_enable+0xb/0xd
>> =A0[<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
>> =A0[<f8e24000>] ? test_handler+0x0/0x1c [irqTest]
>> =A0[<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
>> =A0[<f8e2703e>] ? __test_init+0x3e/0x7e [irqTest]
>> =A0[<f8e27000>] ? __test_init+0x0/0x7e [irqTest]
>> =A0[<c1001028>] ? do_one_initcall+0x23/0x183
>> =A0[<c103a825>] ? blocking_notifier_call_chain+0x1a/0x1c
>> =A0[<c10481e9>] ? sys_init_module+0xad/0x1ec
>> =A0[<c1092cc5>] ? sys_close+0x71/0xb5
>> =A0[<c1002c25>] ? sysenter_do_call+0x12/0x16
>> Code: =A0Bad EIP value.
>> EIP: [<00000000>] 0x0 SS:ESP 0068:f6c03f18
>> CR2: 0000000000000000
>> ---[ end trace ac2616367ecf94b2 ]---
>>
>> I hope this is what you wanted me to try. Please let me know.
>
> So if I understand well, you "insmoded" the little test module which
> does nothing but calling rtdm_irq_request() and the NULL pointer bug
> occured.

Correct

>
> This bug occurred before calling analogy_config, you did not tried to
> attach the ni_pcimio driver, right ?

I insmod-ed the test module that gave that error dump. I later tried
to attach the driver which causes the usual error. The stack-dumps I
sent are solely related to insmod of test program.

>
> If I am right, it seems like the bug is not located in analogy but
> between Xenomai's nucleus and Ipipe, which is ... weird.
>
> What is your kernel configuration ? no IO_APIC ?

I put back my config to IO_APIC. Should I disable that again?
attached is my kernel configuration (configAnalogy)


> Which irq did you try to request ? 48 or 5 ?

I do not know. do I have to pass parameters to insmod?

This is my /proc/interrupts if that is helpful
           CPU0       CPU1
  0:        222          0   IO-APIC-edge      timer
  1:          0          9   IO-APIC-edge      i8042
  2:          0          0    XT-PIC-XT        cascade
 12:          0        132   IO-APIC-edge      i8042
 14:          0          8   IO-APIC-edge      ata_piix
 15:          0      12358   IO-APIC-edge      ata_piix
 20:          0          0   IO-APIC-fasteoi   astropci0
 28:          0        235   IO-APIC-fasteoi   sata_mv
 54:          0      77950   IO-APIC-fasteoi   eth0
NMI:          0          0   Non-maskable interrupts
LOC:   45365307   45365133   Local timer interrupts
SPU:          0          0   Spurious interrupts
CNT:          0          0   Performance counter interrupts
PND:          0          0   Performance pending work
RES:       2555       2212   Rescheduling interrupts
CAL:         60         58   Function call interrupts
TLB:        419        200   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:        152        152   Machine check polls
ERR:          0
MIS:          0

and my /proc/xenomai/irq

IRQ         CPU0        CPU1
516:           0           0         [IPI]
519:    46161773    46161772         [timer]
520:           0           0         [critical sync]
546:           0           0         [virtual]


>
> Which CPU are you using ?

CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03

As Philippe rightly pointed out this is a 32-bit install although the
CPUs are 64 bit

>
> Thank you for your time.
>
>> Cheers
>> Ettore
>>
>>
>> 2009/11/24 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>> On Tuesday 24 November 2009 22:34:33 Ettore Pedretti wrote:
>>>> Hi,
>>>>
>>>> Would it help at this stage if I re-enable IO APIC, run your program
>>>> and send you the call-stack dump? I am willing to test your patch on
>>>> our hardware as soon as you got one ready, if that can be of help.
>>>
>>> Sorry, I did not answer your question. The bug occurs in both configura=
tions;
>>> so, do not bother changing your configuration for the moment.
>>>
>>>> Cheers
>>>> Ettore
>>>>
>>>> 2009/11/23 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>> > Hi,
>>>> >
>>>> > On Monday 23 November 2009 18:26:15 Ettore Pedretti wrote:
>>>> >> Hi,
>>>> >>
>>>> >> It is finally working. here is the dmesg after I insert a module:
>>>> >>
>>>> >> irq_test: before rtdm_irq_request
>>>> >> irq_test: after rtdm_irq_request (err =3D -22)
>>>> >> irq_test: before rtdm_irq_enable
>>>> >> irq_test: after rtdm_irq_enable (err =3D -22)
>>>> >
>>>> > rtdm_irq_request() returns -EINVAL because the IO APIC is disabled. =
So,
>>>> > the irq 48 turns into the irq 5;
>>>> >
>>>> >> Attached are a complete call-stack dump and my present kernel
>>>> >> =A0configuration.
>>>> >
>>>> > With the fact that there is still a NULL pointer bug without IO APIC=
, the
>>>> > bug is bound to be located in analogy. There may be some wrong write
>>>> > access on the interrupt structure.
>>>> >
>>>> > I will come back with a patch which dumps the structure's content at
>>>> > various locations in the attach code.
>>>> >
>>>> >> Cheers
>>>> >> Ettore
>>>> >>
>>>> >> 2009/11/23 Alexis Berlemont <berlemont.hauw@domain.hid>:
>>>> >> > Hi,
>>>> >> >
>>>> >> > On Mon, Nov 23, 2009 at 9:28 AM, Ettore Pedretti <ep41@domain.hid.=
uk>
>>>> >
>>>> > wrote:
>>>> >> >> Hi,
>>>> >> >>
>>>> >> >> I have compiled the module using this makefile:
>>>> >> >>
>>>> >> >> prefix :=3D $(shell /usr/bin/xeno-config --prefix)
>>>> >> >> obj-m =A0 :=3D irqTest.o
>>>> >> >>
>>>> >> >> ifeq ($(prefix),)
>>>> >> >> $(error Please add <xeno-install>/bin to your PATH variable)
>>>> >> >> endif
>>>> >> >>
>>>> >> >> KDIR =A0 =A0:=3D /lib/modules/$(shell uname -r)/build
>>>> >> >> PWD =A0 =A0 :=3D $(shell pwd)
>>>> >> >> EXTRA_CFLAGS :=3D -I/usr/include/xenomai -I/usr/include/
>>>> >> >>
>>>> >> >>
>>>> >> >> all: default
>>>> >> >>
>>>> >> >> default:
>>>> >> >> =A0 =A0 =A0 =A0$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules
>>>> >> >>
>>>> >> >> install:
>>>> >> >> =A0 =A0 =A0 =A0$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules_insta=
ll
>>>> >> >>
>>>> >> >> clean:
>>>> >> >> =A0 =A0 =A0 =A0rm -fr *.mod.c *.o *.ko irqTest *~ .irqTest* .tmp=
_versions
>>>> >> >>
>>>> >> >> The module seems to compiles fine:
>>>> >> >>
>>>> >> >> make -C /lib/modules/2.6.31.1/build
>>>> >> >> SUBDIRS=3D/home/ep41/control/CHAMP/irqTest modules
>>>> >> >> make[1]: Entering directory `/usr/src/linux-2.6.31.1'
>>>> >> >> =A0CC [M] =A0/home/ep41/control/CHAMP/irqTest/irqTest.o
>>>> >> >> =A0Building modules, stage 2.
>>>> >> >> =A0MODPOST 1 modules
>>>> >> >> =A0CC =A0 =A0 =A0/home/ep41/control/CHAMP/irqTest/irqTest.mod.o
>>>> >> >> =A0LD [M] =A0/home/ep41/control/CHAMP/irqTest/irqTest.ko
>>>> >> >> make[1]: Leaving directory `/usr/src/linux-2.6.31.1'
>>>> >> >>
>>>> >> >> To make sure module dependencies are in place I modprobe irqbenc=
h
>>>> >> >> (probably not necessary).
>>>> >> >>
>>>> >> >> modprobe xeno_irqbench
>>>> >> >>
>>>> >> >> All the loaded modules:
>>>> >> >>
>>>> >> >> fangorn:~# lsmod
>>>> >> >> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
>>>> >> >> xeno_irqbench =A0 =A0 =A0 =A0 =A0 5152 =A00
>>>> >> >> xeno_native =A0 =A0 =A0 =A0 =A0 =A083296 =A00
>>>> >> >> analogy_ni_pcimio =A0 =A0 =A015676 =A00
>>>> >> >> analogy_ni_mio =A0 =A0 =A0 =A0 41596 =A01 analogy_ni_pcimio
>>>> >> >> analogy_ni_tio =A0 =A0 =A0 =A0 21724 =A01 analogy_ni_mio
>>>> >> >> analogy_8255 =A0 =A0 =A0 =A0 =A0 =A04060 =A01 analogy_ni_mio
>>>> >> >> analogy_ni_mite =A0 =A0 =A0 =A0 9980 =A03
>>>> >> >> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio xeno_analogy
>>>> >> >> 38876 =A05
>>>> >> >> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,ana=
logy_
>>>> >> >>ni_ mite xeno_rtdm =A0 =A0 =A0 =A0 =A0 =A0 =A024244 =A03
>>>> >> >> xeno_irqbench,analogy_ni_mio,xeno_analogy astropci
>>>> >> >> 10968 0
>>>> >> >> ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0112900 =A01
>>>> >> >> jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A044016 =A01 ext3
>>>> >> >> mbcache =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6652 =A01 ext3
>>>> >> >> ide_pci_generic =A0 =A0 =A0 =A0 3712 =A00
>>>> >> >> ide_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 79388 =A01 ide_pci_generic
>>>> >> >> e1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 118204 =A00
>>>> >> >> ata_piix =A0 =A0 =A0 =A0 =A0 =A0 =A0 15968 =A02
>>>> >> >> sata_mv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A027632 =A00
>>>> >> >> libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0151468 =A02 ata_piix,sata_=
mv
>>>> >> >> unix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24460 =A010
>>>> >> >>
>>>> >> >>
>>>> >> >> When I insert the module it complains about missing symbols:
>>>> >> >>
>>>> >> >> insmod irqTest.ko
>>>> >> >>
>>>> >> >> insmod: error inserting 'irqTest.ko': -1 Unknown symbol in modul=
e
>>>> >> >>
>>>> >> >> dmesg:
>>>> >> >>
>>>> >> >> irqTest: module license 'unspecified' taints kernel.
>>>> >> >> Disabling lock debugging due to kernel taint
>>>> >> >> irqTest: Unknown symbol xnintr_enable
>>>> >> >> irqTest: Unknown symbol xnintr_detach
>>>> >> >>
>>>> >> >> What am I doing wrong?
>>>> >> >
>>>> >> > It's me who did wrong. I just tested the compilation inside the
>>>> >> > kernel.
>>>> >> >
>>>> >> > xnintr_* symbols are only exported for GPL compliant modules. So,
>>>> >> > could you add the following line in the test module:
>>>> >> > MODULE_LICENSE("GPL");
>>>> >> >
>>>> >> > With that, the insmod operation should work.
>>>> >> >
>>>> >> >> BTW, I disabled =A0CONFIG_X86_IO_APIC and =A0the SMP option: sam=
e
>>>> >> >> problem.
>>>> >> >
>>>> >> > Could you send the call-stack dump ? Maybe, that will unveil a cl=
ue.
>>>> >> >
>>>> >> >> Cheers
>>>> >> >> Ettore
>>>> >> >>
>>>> >> >> 2009/11/22 Alexis Berlemont <alexis.berlemont@domain.hid>:
>>>> >> >>> Hi,
>>>> >> >>>
>>>> >> >>> On Sunday 22 November 2009 20:35:51 Ettore Pedretti wrote:
>>>> >> >>>> Hello,
>>>> >> >>>>
>>>> >> >>>> I downloaded Xenomai 2.5-rc4 from the xenomai-head.git. I need=
 to
>>>> >> >>>> use the comedi drivers for Xenomai for a NI PCI-6711 function
>>>> >> >>>> generator board.
>>>> >> >>>>
>>>> >> >>>> When I try to use the test program cmd_write (or cmd-read) I o=
btain
>>>> >> >>>> the following:
>>>> >> >>>>
>>>> >> >>>> fangorn:~# cmd_write -vcmd_write: device analogy0 opened (fd=
=3D0)
>>>> >> >>>> cmd_write: basic descriptor retrieved
>>>> >> >>>> =A0 =A0 =A0 =A0subdevices count =3D 0
>>>> >> >>>> =A0 =A0 =A0 =A0read subdevice index =3D 0
>>>> >> >>>> =A0 =A0 =A0 =A0write subdevice index =3D 0
>>>> >> >>>> cmd_write: a4l_get_desc failed (ret=3D-22)
>>>> >> >>>> *** glibc detected *** cmd_write: free(): invalid next size (f=
ast):
>>>> >> >>>> 0x0804d008 ***
>>>> >> >>>> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> >> >>>> /lib/i686/cmov/libc.so.6[0xb7e52624]
>>>> >> >>>> /lib/i686/cmov/libc.so.6(cfree+0x96)[0xb7e54826]
>>>> >> >>>> cmd_write[0x804927c]
>>>> >> >>>> /lib/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7dfa455]
>>>> >> >>>> cmd_write[0x8048b01]
>>>> >> >>>> =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
>>>> >> >>>> 08048000-0804a000 r-xp 00000000 08:01 10855303 =A0 /usr/bin/cm=
d_write
>>>> >> >>>> 0804a000-0804b000 rw-p 00002000 08:01 10855303 =A0 /usr/bin/cm=
d_write
>>>> >> >>>> 0804b000-0806e000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[he=
ap]
>>>> >> >>>> b7c00000-b7c21000 rw-p 00000000 00:00 0
>>>> >> >>>> b7c21000-b7d00000 ---p 00000000 00:00 0
>>>> >> >>>> b7dce000-b7dda000 r-xp 00000000 08:01 6127619 =A0 =A0/lib/libg=
cc_s.so.1
>>>> >> >>>> b7dda000-b7ddb000 rw-p 0000b000 08:01 6127619 =A0 =A0/lib/libg=
cc_s.so.1
>>>> >> >>>> b7de0000-b7de3000 rw-s 00000000 00:0b 426 =A0 =A0 =A0 =A0/dev/=
rtheap
>>>> >> >>>> b7de3000-b7de4000 rw-p 00000000 00:00 0
>>>> >> >>>> b7de4000-b7f39000 r-xp 00000000 08:01 6144250
>>>> >> >>>> =A0/lib/i686/cmov/libc-2.7.so b7f39000-b7f3a000 r--p 00155000 =
08:01
>>>> >> >>>> 6144250 =A0 =A0/lib/i686/cmov/libc-2.7.so b7f3a000-b7f3c000 rw=
-p
>>>> >> >>>> 00156000 08:01 6144250 =A0 =A0/lib/i686/cmov/libc-2.7.so
>>>> >> >>>> b7f3c000-b7f3f000 rw-p 00000000 00:00 0
>>>> >> >>>> b7f3f000-b7f54000 r-xp 00000000 08:01 6144264
>>>> >> >>>> /lib/i686/cmov/libpthread-2.7.so
>>>> >> >>>> b7f54000-b7f56000 rw-p 00014000 08:01 6144264
>>>> >> >>>> /lib/i686/cmov/libpthread-2.7.so
>>>> >> >>>> b7f56000-b7f58000 rw-p 00000000 00:00 0
>>>> >> >>>> b7f58000-b7f5a000 r-xp 00000000 08:01 10808118
>>>> >> >>>> /usr/lib/librtdm.so.1.0.0 b7f5a000-b7f5b000 rw-p 00001000 08:0=
1
>>>> >> >>>> 10808118 =A0 /usr/lib/librtdm.so.1.0.0 b7f5b000-b7f5c000 rw-p
>>>> >> >>>> 00000000 00:00 0
>>>> >> >>>> b7f5c000-b7f63000 r-xp 00000000 08:01 10808119
>>>> >> >>>> =A0/usr/lib/libnative.so.3.0.0 b7f63000-b7f64000 rw-p 00006000=
 08:01
>>>> >> >>>> 10808119 /usr/lib/libnative.so.3.0.0 b7f64000-b7f67000 r-xp
>>>> >> >>>> 00000000 08:01 10808112 =A0 /usr/lib/libanalogy.so.1.0.0
>>>> >> >>>> b7f67000-b7f68000 rw-p 00002000 08:01 10808112
>>>> >> >>>> /usr/lib/libanalogy.so.1.0.0
>>>> >> >>>> b7f69000-b7f6a000 rw-p 00000000 00:00 0
>>>> >> >>>> b7f6a000-b7f6d000 rw-s 00000000 00:0b 426 =A0 =A0 =A0 =A0/dev/=
rtheap
>>>> >> >>>> b7f6d000-b7f6f000 rw-p 00000000 00:00 0
>>>> >> >>>> b7f6f000-b7f89000 r-xp 00000000 08:01 6127618 =A0 =A0/lib/ld-2=
.7.so
>>>> >> >>>> b7f89000-b7f8b000 rw-p 0001a000 08:01 6127618 =A0 =A0/lib/ld-2=
.7.so
>>>> >> >>>> bfab1000-bfac6000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[st=
ack]
>>>> >> >>>> ffffe000-fffff000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[vd=
so]
>>>> >> >>>> Aborted
>>>> >> >>>>
>>>> >> >>>> This is probably because the device /dev/analogy0 does not exi=
st.
>>>> >> >>>>
>>>> >> >>>> This is the output of uname -a
>>>> >> >>>>
>>>> >> >>>> Linux fangorn 2.6.31.1 #1 SMP PREEMPT Fri Nov 20 20:42:26 PST =
2009
>>>> >> >>>> i686 GNU/Linux
>>>> >> >>>>
>>>> >> >>>> And these are the relevant entries in dmesg
>>>> >> >>>>
>>>> >> >>>> dmesg:
>>>> >> >>>>
>>>> >> >>>> I-pipe 2.4-06: pipeline enabled.
>>>> >> >>>> I-pipe: Domain Xenomai registered.
>>>> >> >>>>
>>>> >> >>>> Xenomai: hal/i386 started.
>>>> >> >>>> Xenomai: scheduling class idle registered.
>>>> >> >>>> Xenomai: scheduling class rt registered.
>>>> >> >>>> Xenomai: real-time nucleus v2.5-rc4 (Flying In A Blue Dream)
>>>> >> >>>> loaded. Xenomai: SMI-enabled chipset found
>>>> >> >>>> Xenomai: SMI workaround enabled
>>>> >> >>>> Xenomai: starting RTDM services.
>>>> >> >>>> Xenomai: starting native API services.
>>>> >> >>>> Analogy: MITE: Available NI device IDs: 0x1880
>>>> >> >>>>
>>>> >> >>>> result of lspci for the relevant board:
>>>> >> >>>>
>>>> >> >>>> 04:01.0 Class ff00: National Instruments PCI-6711
>>>> >> >>>>
>>>> >> >>>> And lsmod:
>>>> >> >>>>
>>>> >> >>>> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
>>>> >> >>>> xeno_native =A0 =A0 =A0 =A0 =A0 105088 =A00
>>>> >> >>>> analogy_ni_pcimio =A0 =A0 =A015644 =A00
>>>> >> >>>> analogy_ni_mio =A0 =A0 =A0 =A0 44860 =A01 analogy_ni_pcimio
>>>> >> >>>> analogy_ni_tio =A0 =A0 =A0 =A0 24956 =A01 analogy_ni_mio
>>>> >> >>>> analogy_8255 =A0 =A0 =A0 =A0 =A0 =A03900 =A01 analogy_ni_mio
>>>> >> >>>> analogy_ni_mite =A0 =A0 =A0 =A010140 =A03
>>>> >> >>>> =A0analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio xeno_analog=
y
>>>> >> >>>> =A040220 =A05
>>>> >> >>>> analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,a=
nalog
>>>> >> >>>>y_n i_mit e xeno_rtdm =A0 =A0 =A0 =A0 =A0 =A0 =A028436 =A02
>>>> >> >>>> analogy_ni_mio,xeno_analogy astropci =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 10944 =A00
>>>> >> >>>> ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0109636 =A01
>>>> >> >>>> jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A043920 =A01 ext3
>>>> >> >>>> mbcache =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 6272 =A01 ext3
>>>> >> >>>> ide_pci_generic =A0 =A0 =A0 =A0 3712 =A00
>>>> >> >>>> ide_core =A0 =A0 =A0 =A0 =A0 =A0 =A0 74204 =A01 ide_pci_generi=
c
>>>> >> >>>> ata_piix =A0 =A0 =A0 =A0 =A0 =A0 =A0 15748 =A02
>>>> >> >>>> sata_mv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A026448 =A00
>>>> >> >>>> e1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 114208 =A00
>>>> >> >>>> libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0142156 =A02 ata_piix,sat=
a_mv
>>>> >> >>>> unix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22992 =A010
>>>> >> >>>>
>>>> >> >>>>
>>>> >> >>>> According to this post:
>>>> >> >>>> http://www.mail-archive.com/xenomai@xenomai.org
>>>> >> >>>>
>>>> >> >>>> >The analogy driver "a4l_pcimio" will be registered with your =
last
>>>> >> >>>> >insmod (analogy_ni_pcimio). You can check that by typing "cat
>>>> >> >>>> >/proc/analogy/drivers", you will see only one entry: a4l_pcim=
io.
>>>> >> >>>>
>>>> >> >>>> fangorn:~# cat /proc/analogy/drivers
>>>> >> >>>> -- =A0Analogy drivers --
>>>> >> >>>>
>>>> >> >>>> | idx | driver name
>>>> >> >>>> | =A000 | analogy_ni_pcimio
>>>> >> >>>> | =A001 | analogy_8255
>>>> >> >>>>
>>>> >> >>>> There are two entries and the drivers are not attached:
>>>> >> >>>>
>>>> >> >>>> fangorn:~# cat /proc/analogy/devices
>>>> >> >>>> -- =A0Analogy devices --
>>>> >> >>>>
>>>> >> >>>> | idx | status | driver
>>>> >> >>>> | =A000 | Unused | No driver
>>>> >> >>>> | =A001 | Unused | No driver
>>>> >> >>>> | =A002 | Unused | No driver
>>>> >> >>>> | =A003 | Unused | No driver
>>>> >> >>>> | =A004 | Unused | No driver
>>>> >> >>>> | =A005 | Unused | No driver
>>>> >> >>>> | =A006 | Unused | No driver
>>>> >> >>>> | =A007 | Unused | No driver
>>>> >> >>>> | =A008 | Unused | No driver
>>>> >> >>>> | =A009 | Unused | No driver
>>>> >> >>>>
>>>> >> >>>> I'm aware of the name change of the drivers:
>>>> >> >>>> http://www.mail-archive.com/xenomai-git@xenomai.org
>>>> >> >>>>
>>>> >> >>>> >- a4l_pcimio becomes analogy_ni_pcimio
>>>> >> >>>> >- 8255 becomes analogy_8255.
>>>> >> >>>> >Consequently, the command line to attach these drivers has
>>>> >> >>>> >changed. Starting from now, we have to type:
>>>> >> >>>> >- analogy_config analogyX analogy_ni_pcimio (instead of
>>>> >> >>>> > a4l_pcimio)
>>>> >> >>>>
>>>> >> >>>> This is what happens when I try to attach the driver to de dev=
ice:
>>>> >> >>>>
>>>> >> >>>> fangorn:~# analogy_config analogy0 analogy_ni_pcimio
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:Oops: 0000 [#1] PREEMPT SMP
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:last sysfs file:
>>>> >> >>>> =A0/sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:Process analogy_config (pid: 3409, ti=3Df64cc000
>>>> >> >>>> task=3Df79013b0 task.ti=3Df64cc000)
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:I-pipe domain Linux
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:Stack:
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:Call Trace:
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d=
4 fe ff
>>>> >> >>>> ff 8b 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00=
 00
>>>> >> >>>> 8b 42 18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b =
01 00
>>>> >> >>>> 00 31
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:EIP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_=
mio]
>>>> >> >>>> SS:ESP 0068:f64cddc8
>>>> >> >>>>
>>>> >> >>>> Message from syslogd@domain.hid at Nov 21 23:22:37 ...
>>>> >> >>>> =A0kernel:CR2: 0000000000000004
>>>> >> >>>>
>>>> >> >>>>
>>>> >> >>>> relevant dmeg:
>>>> >> >>>>
>>>> >> >>>> a4l: analogy_ni_pcimio: pcimio_attach: found pci-6711 board
>>>> >> >>>> mite 0000:04:01.0: PCI->APIC IRQ transform: INT A -> IRQ 48
>>>> >> >>>> mite 0000:04:01.0: setting latency timer to 64
>>>> >> >>>> a4l: MITE: 0xd0801000 mapped to f8e26000
>>>> >> >>>> a4l: DAQ: 0xd0800000 mapped to f8e2a000
>>>> >> >>>> a4l: MITE: version =3D 1, type =3D 1, mite mode =3D 1, interfa=
ce mode =3D 3
>>>> >> >>>> a4l: MITE: num channels =3D 3, write post fifo depth =3D 1, wi=
ns =3D 0,
>>>> >> >>>> iowins =3D 2 a4l: analogy_ni_pcimio: pcimio_attach: found irq =
48
>>>> >> >>>> BUG: unable to handle kernel NULL pointer dereference at 00000=
004
>>>> >> >>>> IP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio]
>>>> >> >>>> *pde =3D 00000000
>>>> >> >>>> Oops: 0000 [#1] PREEMPT SMP
>>>> >> >>>> last sysfs file:
>>>> >> >>>> /sys/devices/pci0000:00/0000:00:1e.0/0000:06:02.0/class Module=
s
>>>> >> >>>> linked in: xeno_native analogy_ni_pcimio analogy_ni_mio
>>>> >> >>>> analogy_ni_tio analogy_8255 analogy_ni_mite xeno_analogy xeno_=
rtdm
>>>> >> >>>> astropci ext3 jbd mbcache ide_pci_generic ide_core ata_piix sa=
ta_mv
>>>> >> >>>> e1000 libata unix [last unloaded: scsi_wait_scan]
>>>> >> >>>>
>>>> >> >>>> Pid: 3409, comm: analogy_config Not tainted (2.6.31.1 #1) X6DA=
8
>>>> >> >>>> EIP: 0060:[<f8c7d029>] EFLAGS: 00010202 CPU: 1
>>>> >> >>>> EIP is at ni_E_init+0x267/0xff1 [analogy_ni_mio]
>>>> >> >>>> EAX: 00000000 EBX: f8a22280 ECX: f8c31e6c EDX: f8c31e60
>>>> >> >>>> ESI: 00000000 EDI: f8c31e60 EBP: f64cde38 ESP: f64cddc8
>>>> >> >>>> =A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
>>>> >> >>>> Process analogy_config (pid: 3409, ti=3Df64cc000 task=3Df79013=
b0
>>>> >> >>>> =A0task.ti=3Df64cc000) I-pipe domain Linux
>>>> >> >>>> Stack:
>>>> >> >>>> =A0f64cddd0 c10142b6 f64cddd8 f8c31e60 f64cdde0 c105abf7 f64cd=
dfc
>>>> >> >>>> f8a0ea5d <0> f8c2be00 00000000 00000001 f8c31e94 fffffff0 f64c=
de14
>>>> >> >>>> f8c2c118 00000001 <0> f8c2ed0d f8c31e88 f8c31e60 f64cde38 f8c2=
cccf
>>>> >> >>>> 00000001 f8c31e60 00000030 Call Trace:
>>>> >> >>>> =A0[<c10142b6>] ? unmask_IO_APIC_irq+0xd/0xf
>>>> >> >>>> =A0[<c105abf7>] ? xnintr_enable+0xb/0xd
>>>> >> >>>> =A0[<f8a0ea5d>] ? rtdm_irq_request+0x48/0x5e [xeno_rtdm]
>>>> >> >>>> =A0[<f8c2be00>] ? a4l_handle_irq+0x0/0x1a [xeno_analogy]
>>>> >> >>>> =A0[<f8c2c118>] ? __a4l_request_irq+0x33/0x39 [xeno_analogy]
>>>> >> >>>> =A0[<f8c2cccf>] ? a4l_request_irq+0x98/0xaf [xeno_analogy]
>>>> >> >>>> =A0[<f8c8bd8a>] ? pcimio_attach+0x54d/0x664 [analogy_ni_pcimio=
]
>>>> >> >>>> =A0[<f8c2afef>] ? a4l_assign_driver+0x61/0x134 [xeno_analogy]
>>>> >> >>>> =A0[<f8c2b2ba>] ? a4l_device_attach+0x54/0x6d [xeno_analogy]
>>>> >> >>>> =A0[<c10662ea>] ? xnshadow_ppd_get+0x4f/0x58
>>>> >> >>>> =A0[<f8c2b54f>] ? a4l_ioctl_devcfg+0x57/0x104 [xeno_analogy]
>>>> >> >>>> =A0[<f8c2d36f>] ? a4l_rt_ioctl+0x33/0x3a [xeno_analogy]
>>>> >> >>>> =A0[<f8a0d3e6>] ? __rt_dev_ioctl+0xd1/0xd8 [xeno_rtdm]
>>>> >> >>>> =A0[<f8a0fe77>] ? sys_rtdm_open+0x5c/0x64 [xeno_rtdm]
>>>> >> >>>> =A0[<f8a0fdde>] ? sys_rtdm_ioctl+0x29/0x2b [xeno_rtdm]
>>>> >> >>>> =A0[<c10699ae>] ? losyscall_event+0xa9/0x190
>>>> >> >>>> =A0[<c10566ce>] ? __ipipe_dispatch_event+0xdf/0x201
>>>> >> >>>> =A0[<c1069905>] ? losyscall_event+0x0/0x190
>>>> >> >>>> =A0[<c10166a1>] ? __ipipe_syscall_root+0x3b/0xc4
>>>> >> >>>> =A0[<c1002cfd>] ? system_call+0x2d/0x4f
>>>> >> >>>> Code: 8b 45 9c e8 f2 f1 fa ff 89 c2 83 f8 01 0f 85 d4 fe ff ff=
 8b
>>>> >> >>>> 55 9c 8b 82 74 01 00 00 8b 00 f6 40 3c 06 0f 84 22 01 00 00 8b=
 42
>>>> >> >>>> 18 <8b> 40 04 89 45 b0 8b 40 14 8b 40 04 85 c0 0f 84 0b 01 00 =
00 31
>>>> >> >>>> EIP: [<f8c7d029>] ni_E_init+0x267/0xff1 [analogy_ni_mio] SS:ES=
P
>>>> >> >>>> 0068:f64cddc8 CR2: 0000000000000004
>>>> >> >>>> ---[ end trace c887d49bb5e86cf4 ]---
>>>> >> >>>
>>>> >> >>> Thanks for such a great report.
>>>> >> >>>
>>>> >> >>> I keep two things in mind:
>>>> >> >>> - cmd_write's error handling path is not buggy (that was alread=
y in
>>>> >> >>> my todo list). I will fix that as soon as possible.
>>>> >> >>>
>>>> >> >>> - according to the call-stack dump you made, the irq handler
>>>> >> >>> registering seems to be the source of the trouble. What strikes=
 me
>>>> >> >>> is that the oops occurred very low (unmask_IO_APIC_irq: we are =
no
>>>> >> >>> more in the analogy layer).
>>>> >> >>>
>>>> >> >>> In order to be sure that the problem is located in analogy, it =
would
>>>> >> >>> be great to test that calling rtdm_request_irq(... , 48, ...) d=
oes
>>>> >> >>> not trigger the bug.
>>>> >> >>>
>>>> >> >>> Here is a little test module you could try to insmod. If you do=
 not
>>>> >> >>> want to bother finding out how to compile it, you can replace t=
he
>>>> >> >>> code of an existing rtdm driver (for example:
>>>> >> >>> xenomai/ksrc/drivers/testing/irqbench.c) with the source below.
>>>> >> >>>
>>>> >> >>> Another interesting test would be to disable CONFIG_X86_IO_APIC=
 in
>>>> >> >>> your kernel configuration (in "Processor type and features", di=
sable
>>>> >> >>> the SMP option and disable "IO APIC" under "Local APIC").
>>>> >> >>>
>>>> >> >>> #include <linux/version.h>
>>>> >> >>> #include <linux/module.h>
>>>> >> >>> #include <linux/ioport.h>
>>>> >> >>>
>>>> >> >>> #include <rtdm/rtdm_driver.h>
>>>> >> >>>
>>>> >> >>>
>>>> >> >>> int test_handler(rtdm_irq_t *irq_handle)
>>>> >> >>> {
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0rtdm_printk("irq_test: INTERRUPT!\n");
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0return RTDM_IRQ_HANDLED;
>>>> >> >>> }
>>>> >> >>>
>>>> >> >>> static rtdm_irq_t handle;
>>>> >> >>>
>>>> >> >>> static int __init __test_init(void)
>>>> >> >>> {
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0int err;
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0rtdm_printk("irq_test: before rtdm_irq_request\n=
");
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0err =3D rtdm_irq_request(&handle, 48, test_handl=
er, 0,
>>>> >> >>> "test_irq", NULL);
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0rtdm_printk("irq_test: after rtdm_irq_request (e=
rr =3D %d)\n",
>>>> >> >>> err);
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0rtdm_printk("irq_test: before rtdm_irq_enable\n"=
);
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0err =3D rtdm_irq_enable(&handle);
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0rtdm_printk("irq_test: after rtdm_irq_enable (er=
r =3D %d)\n",
>>>> >> >>> err);
>>>> >> >>>
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0return err;
>>>> >> >>> }
>>>> >> >>>
>>>> >> >>> static void __exit __test_exit(void)
>>>> >> >>> {
>>>> >> >>>
>>>> >> >>> =A0 =A0 =A0 =A0rtdm_irq_free(&handle);
>>>> >> >>>
>>>> >> >>> }
>>>> >> >>>
>>>> >> >>> module_init(__test_init);
>>>> >> >>> module_exit(__test_exit);
>>>> >> >>>
>>>> >> >>>> Can anyone help?
>>>> >> >>>>
>>>> >> >>>> Best regards
>>>> >> >>>> Ettore Pedretti
>>>> >> >
>>>> >> > Alexis.
>>>> >
>>>> > Alexis.
>>>>
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>

--000e0cd6aa06cde4eb04794eaa58
Content-Type: application/octet-stream; name=ConfigAnalogy
Content-Disposition: attachment; filename=ConfigAnalogy
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2i5ygr20

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4zMS4xCiMgTW9uIE5vdiAyMyAxNjoxMToyNCAyMDA5CiMK
IyBDT05GSUdfNjRCSVQgaXMgbm90IHNldApDT05GSUdfWDg2XzMyPXkKIyBDT05GSUdfWDg2XzY0
IGlzIG5vdCBzZXQKQ09ORklHX1g4Nj15CkNPTkZJR19PVVRQVVRfRk9STUFUPSJlbGYzMi1pMzg2
IgpDT05GSUdfQVJDSF9ERUZDT05GSUc9ImFyY2gveDg2L2NvbmZpZ3MvaTM4Nl9kZWZjb25maWci
CkNPTkZJR19HRU5FUklDX1RJTUU9eQpDT05GSUdfR0VORVJJQ19DTU9TX1VQREFURT15CkNPTkZJ
R19DTE9DS1NPVVJDRV9XQVRDSERPRz15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTPXkKQ09O
RklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUPXkKQ09ORklHX0xPQ0tERVBfU1VQUE9S
VD15CkNPTkZJR19TVEFDS1RSQUNFX1NVUFBPUlQ9eQpDT05GSUdfSEFWRV9MQVRFTkNZVE9QX1NV
UFBPUlQ9eQpDT05GSUdfRkFTVF9DTVBYQ0hHX0xPQ0FMPXkKQ09ORklHX01NVT15CkNPTkZJR19a
T05FX0RNQT15CkNPTkZJR19HRU5FUklDX0lTQV9ETUE9eQpDT05GSUdfR0VORVJJQ19JT01BUD15
CkNPTkZJR19HRU5FUklDX0JVRz15CkNPTkZJR19HRU5FUklDX0hXRUlHSFQ9eQpDT05GSUdfQVJD
SF9NQVlfSEFWRV9QQ19GREM9eQojIENPTkZJR19SV1NFTV9HRU5FUklDX1NQSU5MT0NLIGlzIG5v
dCBzZXQKQ09ORklHX1JXU0VNX1hDSEdBRERfQUxHT1JJVEhNPXkKQ09ORklHX0FSQ0hfSEFTX0NQ
VV9JRExFX1dBSVQ9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQojIENPTkZJR19H
RU5FUklDX1RJTUVfVlNZU0NBTEwgaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNfQ1BVX1JFTEFY
PXkKQ09ORklHX0FSQ0hfSEFTX0RFRkFVTFRfSURMRT15CkNPTkZJR19BUkNIX0hBU19DQUNIRV9M
SU5FX1NJWkU9eQpDT05GSUdfSEFWRV9TRVRVUF9QRVJfQ1BVX0FSRUE9eQpDT05GSUdfSEFWRV9E
WU5BTUlDX1BFUl9DUFVfQVJFQT15CiMgQ09ORklHX0hBVkVfQ1BVTUFTS19PRl9DUFVfTUFQIGlz
IG5vdCBzZXQKQ09ORklHX0FSQ0hfSElCRVJOQVRJT05fUE9TU0lCTEU9eQpDT05GSUdfQVJDSF9T
VVNQRU5EX1BPU1NJQkxFPXkKIyBDT05GSUdfWk9ORV9ETUEzMiBpcyBub3Qgc2V0CkNPTkZJR19B
UkNIX1BPUFVMQVRFU19OT0RFX01BUD15CiMgQ09ORklHX0FVRElUX0FSQ0ggaXMgbm90IHNldApD
T05GSUdfQVJDSF9TVVBQT1JUU19PUFRJTUlaRURfSU5MSU5JTkc9eQpDT05GSUdfQVJDSF9TVVBQ
T1JUU19ERUJVR19QQUdFQUxMT0M9eQpDT05GSUdfR0VORVJJQ19IQVJESVJRUz15CkNPTkZJR19H
RU5FUklDX0hBUkRJUlFTX05PX19ET19JUlE9eQpDT05GSUdfR0VORVJJQ19JUlFfUFJPQkU9eQpD
T05GSUdfR0VORVJJQ19QRU5ESU5HX0lSUT15CkNPTkZJR19VU0VfR0VORVJJQ19TTVBfSEVMUEVS
Uz15CkNPTkZJR19YODZfMzJfU01QPXkKQ09ORklHX1g4Nl9IVD15CkNPTkZJR19YODZfVFJBTVBP
TElORT15CkNPTkZJR19YODZfMzJfTEFaWV9HUz15CkNPTkZJR19LVElNRV9TQ0FMQVI9eQpDT05G
SUdfREVGQ09ORklHX0xJU1Q9Ii9saWIvbW9kdWxlcy8kVU5BTUVfUkVMRUFTRS8uY29uZmlnIgpD
T05GSUdfQ09OU1RSVUNUT1JTPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX0VYUEVSSU1F
TlRBTD15CkNPTkZJR19MT0NLX0tFUk5FTD15CkNPTkZJR19JTklUX0VOVl9BUkdfTElNSVQ9MzIK
Q09ORklHX0xPQ0FMVkVSU0lPTj0iIgpDT05GSUdfTE9DQUxWRVJTSU9OX0FVVE89eQpDT05GSUdf
SEFWRV9LRVJORUxfR1pJUD15CkNPTkZJR19IQVZFX0tFUk5FTF9CWklQMj15CkNPTkZJR19IQVZF
X0tFUk5FTF9MWk1BPXkKQ09ORklHX0tFUk5FTF9HWklQPXkKIyBDT05GSUdfS0VSTkVMX0JaSVAy
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VSTkVMX0xaTUEgaXMgbm90IHNldApDT05GSUdfU1dBUD15
CkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX1NZU1ZJUENfU1lTQ1RMPXkKQ09ORklHX1BPU0lYX01R
VUVVRT15CkNPTkZJR19QT1NJWF9NUVVFVUVfU1lTQ1RMPXkKIyBDT05GSUdfQlNEX1BST0NFU1Nf
QUNDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1RBU0tTVEFUUyBpcyBub3Qgc2V0CkNPTkZJR19BVURJ
VD15CkNPTkZJR19BVURJVFNZU0NBTEw9eQpDT05GSUdfQVVESVRfVFJFRT15CgojCiMgUkNVIFN1
YnN5c3RlbQojCkNPTkZJR19DTEFTU0lDX1JDVT15CiMgQ09ORklHX1RSRUVfUkNVIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUFJFRU1QVF9SQ1UgaXMgbm90IHNldAojIENPTkZJR19UUkVFX1JDVV9UUkFD
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFRfUkNVX1RSQUNFIGlzIG5vdCBzZXQKIyBDT05G
SUdfSUtDT05GSUcgaXMgbm90IHNldApDT05GSUdfTE9HX0JVRl9TSElGVD0xNQpDT05GSUdfSEFW
RV9VTlNUQUJMRV9TQ0hFRF9DTE9DSz15CiMgQ09ORklHX0dST1VQX1NDSEVEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ0dST1VQUyBpcyBub3Qgc2V0CkNPTkZJR19TWVNGU19ERVBSRUNBVEVEPXkKQ09O
RklHX1NZU0ZTX0RFUFJFQ0FURURfVjI9eQojIENPTkZJR19SRUxBWSBpcyBub3Qgc2V0CkNPTkZJ
R19OQU1FU1BBQ0VTPXkKIyBDT05GSUdfVVRTX05TIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBDX05T
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNFUl9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BJRF9OUyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9OUyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lOSVRS
RD15CkNPTkZJR19JTklUUkFNRlNfU09VUkNFPSIiCkNPTkZJR19SRF9HWklQPXkKQ09ORklHX1JE
X0JaSVAyPXkKQ09ORklHX1JEX0xaTUE9eQojIENPTkZJR19DQ19PUFRJTUlaRV9GT1JfU0laRSBp
cyBub3Qgc2V0CkNPTkZJR19TWVNDVEw9eQpDT05GSUdfQU5PTl9JTk9ERVM9eQojIENPTkZJR19F
TUJFRERFRCBpcyBub3Qgc2V0CkNPTkZJR19VSUQxNj15CkNPTkZJR19TWVNDVExfU1lTQ0FMTD15
CkNPTkZJR19LQUxMU1lNUz15CiMgQ09ORklHX0tBTExTWU1TX0VYVFJBX1BBU1MgaXMgbm90IHNl
dApDT05GSUdfSE9UUExVRz15CkNPTkZJR19QUklOVEs9eQpDT05GSUdfQlVHPXkKQ09ORklHX0VM
Rl9DT1JFPXkKQ09ORklHX1BDU1BLUl9QTEFURk9STT15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05G
SUdfRlVURVg9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lHTkFMRkQ9eQpDT05GSUdfVElNRVJG
RD15CkNPTkZJR19FVkVOVEZEPXkKQ09ORklHX1NITUVNPXkKQ09ORklHX0FJTz15CkNPTkZJR19I
QVZFX1BFUkZfQ09VTlRFUlM9eQoKIwojIFBlcmZvcm1hbmNlIENvdW50ZXJzCiMKIyBDT05GSUdf
UEVSRl9DT1VOVEVSUyBpcyBub3Qgc2V0CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CkNPTkZJ
R19QQ0lfUVVJUktTPXkKIyBDT05GSUdfU1RSSVBfQVNNX1NZTVMgaXMgbm90IHNldApDT05GSUdf
Q09NUEFUX0JSSz15CkNPTkZJR19TTEFCPXkKIyBDT05GSUdfU0xVQiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NMT0IgaXMgbm90IHNldAojIENPTkZJR19QUk9GSUxJTkcgaXMgbm90IHNldAojIENPTkZJ
R19NQVJLRVJTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfT1BST0ZJTEU9eQojIENPTkZJR19LUFJP
QkVTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NFU1M9eQpD
T05GSUdfSEFWRV9JT1JFTUFQX1BST1Q9eQpDT05GSUdfSEFWRV9LUFJPQkVTPXkKQ09ORklHX0hB
VkVfS1JFVFBST0JFUz15CkNPTkZJR19IQVZFX0FSQ0hfVFJBQ0VIT09LPXkKQ09ORklHX0hBVkVf
RE1BX0FUVFJTPXkKQ09ORklHX0hBVkVfRE1BX0FQSV9ERUJVRz15CgojCiMgR0NPVi1iYXNlZCBr
ZXJuZWwgcHJvZmlsaW5nCiMKIyBDT05GSUdfU0xPV19XT1JLIGlzIG5vdCBzZXQKQ09ORklHX0hB
VkVfR0VORVJJQ19ETUFfQ09IRVJFTlQ9eQpDT05GSUdfU0xBQklORk89eQpDT05GSUdfUlRfTVVU
RVhFUz15CkNPTkZJR19CQVNFX1NNQUxMPTAKQ09ORklHX01PRFVMRVM9eQojIENPTkZJR19NT0RV
TEVfRk9SQ0VfTE9BRCBpcyBub3Qgc2V0CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKIyBDT05GSUdf
TU9EVUxFX0ZPUkNFX1VOTE9BRCBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFZFUlNJT05TIGlzIG5v
dCBzZXQKIyBDT05GSUdfTU9EVUxFX1NSQ1ZFUlNJT05fQUxMIGlzIG5vdCBzZXQKQ09ORklHX1NU
T1BfTUFDSElORT15CkNPTkZJR19CTE9DSz15CkNPTkZJR19MQkRBRj15CiMgQ09ORklHX0JMS19E
RVZfQlNHIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFkgaXMgbm90IHNldAoK
IwojIElPIFNjaGVkdWxlcnMKIwpDT05GSUdfSU9TQ0hFRF9OT09QPXkKIyBDT05GSUdfSU9TQ0hF
RF9BUyBpcyBub3Qgc2V0CkNPTkZJR19JT1NDSEVEX0RFQURMSU5FPXkKIyBDT05GSUdfSU9TQ0hF
RF9DRlEgaXMgbm90IHNldAojIENPTkZJR19ERUZBVUxUX0FTIGlzIG5vdCBzZXQKQ09ORklHX0RF
RkFVTFRfREVBRExJTkU9eQojIENPTkZJR19ERUZBVUxUX0NGUSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFRkFVTFRfTk9PUCBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0lPU0NIRUQ9ImRlYWRsaW5l
IgoKIwojIFJlYWwtdGltZSBzdWItc3lzdGVtCiMKQ09ORklHX1hFTk9NQUk9eQpDT05GSUdfWEVO
T19HRU5FUklDX1NUQUNLUE9PTD15CkNPTkZJR19YRU5PX0ZBU1RTWU5DSD15CkNPTkZJR19YRU5P
X09QVF9OVUNMRVVTPXkKQ09ORklHX1hFTk9fT1BUX1BFUlZBU0lWRT15CkNPTkZJR19YRU5PX09Q
VF9QUklPQ1BMPXkKQ09ORklHX1hFTk9fT1BUX1BJUEVMSU5FX0hFQUQ9eQojIENPTkZJR19YRU5P
X09QVF9TQ0hFRF9DTEFTU0VTIGlzIG5vdCBzZXQKQ09ORklHX1hFTk9fT1BUX1BJUEU9eQpDT05G
SUdfWEVOT19PUFRfUElQRV9OUkRFVj0zMgpDT05GSUdfWEVOT19PUFRfUkVHSVNUUllfTlJTTE9U
Uz01MTIKQ09ORklHX1hFTk9fT1BUX1NZU19IRUFQU1o9MjA0OApDT05GSUdfWEVOT19PUFRfU1lT
X1NUQUNLUE9PTFNaPTMyCkNPTkZJR19YRU5PX09QVF9TRU1fSEVBUFNaPTEyCkNPTkZJR19YRU5P
X09QVF9HTE9CQUxfU0VNX0hFQVBTWj0xMgpDT05GSUdfWEVOT19PUFRfU1RBVFM9eQojIENPTkZJ
R19YRU5PX09QVF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1hFTk9fT1BUX1NISVJRIGlzIG5v
dCBzZXQKQ09ORklHX1hFTk9fT1BUX1NFTEVDVD15CgojCiMgVGltaW5nCiMKIyBDT05GSUdfWEVO
T19PUFRfVElNSU5HX1BFUklPRElDIGlzIG5vdCBzZXQKQ09ORklHX1hFTk9fT1BUX1RJTUlOR19W
SVJUSUNLPTEwMDAKQ09ORklHX1hFTk9fT1BUX1RJTUlOR19TQ0hFRExBVD0wCgojCiMgU2NhbGFi
aWxpdHkKIwojIENPTkZJR19YRU5PX09QVF9TQ0FMQUJMRV9TQ0hFRCBpcyBub3Qgc2V0CkNPTkZJ
R19YRU5PX09QVF9USU1FUl9MSVNUPXkKIyBDT05GSUdfWEVOT19PUFRfVElNRVJfSEVBUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1hFTk9fT1BUX1RJTUVSX1dIRUVMIGlzIG5vdCBzZXQKCiMKIyBNYWNo
aW5lCiMKQ09ORklHX1hFTk9fSFdfRlBVPXkKCiMKIyBOTUkgd2F0Y2hkb2cKIwojIENPTkZJR19Y
RU5PX0hXX05NSV9ERUJVR19MQVRFTkNZIGlzIG5vdCBzZXQKCiMKIyBTTUkgd29ya2Fyb3VuZAoj
CiMgQ09ORklHX1hFTk9fSFdfU01JX0RFVEVDVF9ESVNBQkxFIGlzIG5vdCBzZXQKQ09ORklHX1hF
Tk9fSFdfU01JX0RFVEVDVD15CkNPTkZJR19YRU5PX0hXX1NNSV9XT1JLQVJPVU5EPXkKQ09ORklH
X1hFTk9fSFdfU01JX0FMTD15CgojCiMgSW50ZXJmYWNlcwojCkNPTkZJR19YRU5PX1NLSU5fTkFU
SVZFPW0KQ09ORklHX1hFTk9fT1BUX05BVElWRV9QRVJJT0Q9MApDT05GSUdfWEVOT19PUFRfTkFU
SVZFX1BJUEU9eQpDT05GSUdfWEVOT19PUFRfTkFUSVZFX1BJUEVfQlVGU1o9NjU1MzYKQ09ORklH
X1hFTk9fT1BUX05BVElWRV9TRU09eQpDT05GSUdfWEVOT19PUFRfTkFUSVZFX0VWRU5UPXkKQ09O
RklHX1hFTk9fT1BUX05BVElWRV9NVVRFWD15CkNPTkZJR19YRU5PX09QVF9OQVRJVkVfQ09ORD15
CkNPTkZJR19YRU5PX09QVF9OQVRJVkVfUVVFVUU9eQpDT05GSUdfWEVOT19PUFRfTkFUSVZFX0JV
RkZFUj15CkNPTkZJR19YRU5PX09QVF9OQVRJVkVfSEVBUD15CkNPTkZJR19YRU5PX09QVF9OQVRJ
VkVfQUxBUk09eQpDT05GSUdfWEVOT19PUFRfTkFUSVZFX01QUz15CkNPTkZJR19YRU5PX09QVF9O
QVRJVkVfSU5UUj15CkNPTkZJR19YRU5PX1NLSU5fUE9TSVg9bQpDT05GSUdfWEVOT19PUFRfUE9T
SVhfUEVSSU9EPTAKIyBDT05GSUdfWEVOT19PUFRfUE9TSVhfU0hNIGlzIG5vdCBzZXQKIyBDT05G
SUdfWEVOT19PUFRfUE9TSVhfSU5UUiBpcyBub3Qgc2V0CiMgQ09ORklHX1hFTk9fT1BUX1BPU0lY
X1NFTEVDVCBpcyBub3Qgc2V0CkNPTkZJR19YRU5PX09QVF9ERUJVR19QT1NJWD15CiMgQ09ORklH
X1hFTk9fU0tJTl9QU09TIGlzIG5vdCBzZXQKIyBDT05GSUdfWEVOT19TS0lOX1VJVFJPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1hFTk9fU0tJTl9WUlRYIGlzIG5vdCBzZXQKIyBDT05GSUdfWEVOT19T
S0lOX1ZYV09SS1MgaXMgbm90IHNldAojIENPTkZJR19YRU5PX1NLSU5fUlRBSSBpcyBub3Qgc2V0
CiMgQ09ORklHX1hFTk9fT1BUX05PV0FSTl9ERVBSRUNBVEVEIGlzIG5vdCBzZXQKQ09ORklHX1hF
Tk9fU0tJTl9SVERNPW0KQ09ORklHX1hFTk9fT1BUX1JURE1fUEVSSU9EPTAKQ09ORklHX1hFTk9f
T1BUX1JURE1fRklMREVTPTEyOApDT05GSUdfWEVOT19PUFRfUlRETV9TRUxFQ1Q9eQoKIwojIERy
aXZlcnMKIwoKIwojIFNlcmlhbCBkcml2ZXJzCiMKIyBDT05GSUdfWEVOT19EUklWRVJTXzE2NTUw
QSBpcyBub3Qgc2V0CgojCiMgVGVzdGluZyBkcml2ZXJzCiMKQ09ORklHX1hFTk9fS0xBVEVOQ1lf
TU9EVUxFPW0KIyBDT05GSUdfWEVOT19EUklWRVJTX1RJTUVSQkVOQ0ggaXMgbm90IHNldAojIENP
TkZJR19YRU5PX0RSSVZFUlNfSVJRQkVOQ0ggaXMgbm90IHNldAojIENPTkZJR19YRU5PX0RSSVZF
UlNfU1dJVENIVEVTVCBpcyBub3Qgc2V0CgojCiMgQ0FOIGRyaXZlcnMKIwojIENPTkZJR19YRU5P
X0RSSVZFUlNfQ0FOIGlzIG5vdCBzZXQKCiMKIyBBTkFMT0dZIGRyaXZlcnMKIwpDT05GSUdfWEVO
T19EUklWRVJTX0FOQUxPR1k9bQpDT05GSUdfWEVOT19EUklWRVJTX0FOQUxPR1lfREVCVUc9eQpD
T05GSUdfWEVOT19EUklWRVJTX0FOQUxPR1lfREVCVUdfTEVWRUw9MAojIENPTkZJR19YRU5PX0RS
SVZFUlNfQU5BTE9HWV9GQUtFIGlzIG5vdCBzZXQKIyBDT05GSUdfWEVOT19EUklWRVJTX0FOQUxP
R1lfTE9PUCBpcyBub3Qgc2V0CkNPTkZJR19YRU5PX0RSSVZFUlNfQU5BTE9HWV84MjU1PW0KQ09O
RklHX1hFTk9fRFJJVkVSU19BTkFMT0dZX05JX01JVEU9bQpDT05GSUdfWEVOT19EUklWRVJTX0FO
QUxPR1lfTklfVElPPW0KQ09ORklHX1hFTk9fRFJJVkVSU19BTkFMT0dZX05JX01JTz1tCkNPTkZJ
R19YRU5PX0RSSVZFUlNfQU5BTE9HWV9OSV9QQ0lNSU89bQoKIwojIFJlYWwtdGltZSBJUEMgZHJp
dmVycwojCiMgQ09ORklHX1hFTk9fRFJJVkVSU19SVElQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZS
RUVaRVIgaXMgbm90IHNldAoKIwojIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcwojCiMgQ09O
RklHX05PX0haIGlzIG5vdCBzZXQKIyBDT05GSUdfSElHSF9SRVNfVElNRVJTIGlzIG5vdCBzZXQK
Q09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlVJTEQ9eQpDT05GSUdfU01QPXkKIyBDT05GSUdf
U1BBUlNFX0lSUSBpcyBub3Qgc2V0CkNPTkZJR19YODZfTVBQQVJTRT15CiMgQ09ORklHX1g4Nl9C
SUdTTVAgaXMgbm90IHNldApDT05GSUdfWDg2X0VYVEVOREVEX1BMQVRGT1JNPXkKIyBDT05GSUdf
WDg2X0VMQU4gaXMgbm90IHNldAojIENPTkZJR19YODZfUkRDMzIxWCBpcyBub3Qgc2V0CiMgQ09O
RklHX1g4Nl8zMl9OT05fU1RBTkRBUkQgaXMgbm90IHNldApDT05GSUdfU0NIRURfT01JVF9GUkFN
RV9QT0lOVEVSPXkKIyBDT05GSUdfTUVNVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX00zODYgaXMg
bm90IHNldAojIENPTkZJR19NNDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTTU4NiBpcyBub3Qgc2V0
CiMgQ09ORklHX001ODZUU0MgaXMgbm90IHNldAojIENPTkZJR19NNTg2TU1YIGlzIG5vdCBzZXQK
IyBDT05GSUdfTTY4NiBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNSUkgaXMgbm90IHNldAoj
IENPTkZJR19NUEVOVElVTUlJSSBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNTSBpcyBub3Qg
c2V0CkNPTkZJR19NUEVOVElVTTQ9eQojIENPTkZJR19NSzYgaXMgbm90IHNldAojIENPTkZJR19N
SzcgaXMgbm90IHNldAojIENPTkZJR19NSzggaXMgbm90IHNldAojIENPTkZJR19NQ1JVU09FIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUVGRklDRU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVBD
NiBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQM0QgaXMgbm90IHNldAojIENPTkZJR19NR0VP
REVHWDEgaXMgbm90IHNldAojIENPTkZJR19NR0VPREVfTFggaXMgbm90IHNldAojIENPTkZJR19N
Q1lSSVhJSUkgaXMgbm90IHNldAojIENPTkZJR19NVklBQzNfMiBpcyBub3Qgc2V0CiMgQ09ORklH
X01WSUFDNyBpcyBub3Qgc2V0CiMgQ09ORklHX01QU0MgaXMgbm90IHNldAojIENPTkZJR19NQ09S
RTIgaXMgbm90IHNldAojIENPTkZJR19HRU5FUklDX0NQVSBpcyBub3Qgc2V0CiMgQ09ORklHX1g4
Nl9HRU5FUklDIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9DUFU9eQpDT05GSUdfWDg2X0wxX0NBQ0hF
X0JZVEVTPTY0CkNPTkZJR19YODZfSU5URVJOT0RFX0NBQ0hFX0JZVEVTPTY0CkNPTkZJR19YODZf
Q01QWENIRz15CkNPTkZJR19YODZfTDFfQ0FDSEVfU0hJRlQ9NwpDT05GSUdfWDg2X1hBREQ9eQpD
T05GSUdfWDg2X1dQX1dPUktTX09LPXkKQ09ORklHX1g4Nl9JTlZMUEc9eQpDT05GSUdfWDg2X0JT
V0FQPXkKQ09ORklHX1g4Nl9QT1BBRF9PSz15CkNPTkZJR19YODZfSU5URUxfVVNFUkNPUFk9eQpD
T05GSUdfWDg2X1VTRV9QUFJPX0NIRUNLU1VNPXkKQ09ORklHX1g4Nl9UU0M9eQpDT05GSUdfWDg2
X0NNT1Y9eQpDT05GSUdfWDg2X01JTklNVU1fQ1BVX0ZBTUlMWT00CkNPTkZJR19YODZfREVCVUdD
VExNU1I9eQpDT05GSUdfQ1BVX1NVUF9JTlRFTD15CkNPTkZJR19DUFVfU1VQX0NZUklYXzMyPXkK
Q09ORklHX0NQVV9TVVBfQU1EPXkKQ09ORklHX0NQVV9TVVBfQ0VOVEFVUj15CkNPTkZJR19DUFVf
U1VQX1RSQU5TTUVUQV8zMj15CkNPTkZJR19DUFVfU1VQX1VNQ18zMj15CiMgQ09ORklHX1g4Nl9E
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRVRfVElNRVIgaXMgbm90IHNldApDT05GSUdfRE1JPXkK
IyBDT05GSUdfSU9NTVVfSEVMUEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9NTVVfQVBJIGlzIG5v
dCBzZXQKQ09ORklHX05SX0NQVVM9OAojIENPTkZJR19TQ0hFRF9TTVQgaXMgbm90IHNldApDT05G
SUdfU0NIRURfTUM9eQojIENPTkZJR19QUkVFTVBUX05PTkUgaXMgbm90IHNldAojIENPTkZJR19Q
UkVFTVBUX1ZPTFVOVEFSWSBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUPXkKQ09ORklHX0lQSVBF
PXkKQ09ORklHX0lQSVBFX0RPTUFJTlM9NApDT05GSUdfSVBJUEVfQ09NUEFUPXkKQ09ORklHX0lQ
SVBFX0RFTEFZRURfQVRPTUlDU1c9eQojIENPTkZJR19JUElQRV9VTk1BU0tFRF9DT05URVhUX1NX
SVRDSCBpcyBub3Qgc2V0CkNPTkZJR19YODZfTE9DQUxfQVBJQz15CkNPTkZJR19YODZfSU9fQVBJ
Qz15CiMgQ09ORklHX1g4Nl9SRVJPVVRFX0ZPUl9CUk9LRU5fQk9PVF9JUlFTIGlzIG5vdCBzZXQK
Q09ORklHX1g4Nl9NQ0U9eQojIENPTkZJR19YODZfT0xEX01DRSBpcyBub3Qgc2V0CkNPTkZJR19Y
ODZfTkVXX01DRT15CkNPTkZJR19YODZfTUNFX0lOVEVMPXkKIyBDT05GSUdfWDg2X01DRV9BTUQg
aXMgbm90IHNldAojIENPTkZJR19YODZfQU5DSUVOVF9NQ0UgaXMgbm90IHNldApDT05GSUdfWDg2
X01DRV9USFJFU0hPTEQ9eQojIENPTkZJR19YODZfTUNFX0lOSkVDVCBpcyBub3Qgc2V0CkNPTkZJ
R19YODZfVEhFUk1BTF9WRUNUT1I9eQpDT05GSUdfVk04Nj15CiMgQ09ORklHX1RPU0hJQkEgaXMg
bm90IHNldAojIENPTkZJR19JOEsgaXMgbm90IHNldAojIENPTkZJR19YODZfUkVCT09URklYVVBT
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9DT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X01T
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9DUFVJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9D
UFVfREVCVUcgaXMgbm90IHNldApDT05GSUdfTk9ISUdITUVNPXkKIyBDT05GSUdfSElHSE1FTTRH
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElHSE1FTTY0RyBpcyBub3Qgc2V0CkNPTkZJR19QQUdFX09G
RlNFVD0weEMwMDAwMDAwCiMgQ09ORklHX1g4Nl9QQUUgaXMgbm90IHNldAojIENPTkZJR19BUkNI
X1BIWVNfQUREUl9UXzY0QklUIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfRkxBVE1FTV9FTkFCTEU9
eQpDT05GSUdfQVJDSF9TUEFSU0VNRU1fRU5BQkxFPXkKQ09ORklHX0FSQ0hfU0VMRUNUX01FTU9S
WV9NT0RFTD15CkNPTkZJR19TRUxFQ1RfTUVNT1JZX01PREVMPXkKQ09ORklHX0ZMQVRNRU1fTUFO
VUFMPXkKIyBDT05GSUdfRElTQ09OVElHTUVNX01BTlVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NQ
QVJTRU1FTV9NQU5VQUwgaXMgbm90IHNldApDT05GSUdfRkxBVE1FTT15CkNPTkZJR19GTEFUX05P
REVfTUVNX01BUD15CkNPTkZJR19TUEFSU0VNRU1fU1RBVElDPXkKQ09ORklHX1BBR0VGTEFHU19F
WFRFTkRFRD15CkNPTkZJR19TUExJVF9QVExPQ0tfQ1BVUz00CiMgQ09ORklHX1BIWVNfQUREUl9U
XzY0QklUIGlzIG5vdCBzZXQKQ09ORklHX1pPTkVfRE1BX0ZMQUc9MQpDT05GSUdfQk9VTkNFPXkK
Q09ORklHX1ZJUlRfVE9fQlVTPXkKQ09ORklHX0hBVkVfTUxPQ0s9eQpDT05GSUdfSEFWRV9NTE9D
S0VEX1BBR0VfQklUPXkKQ09ORklHX0RFRkFVTFRfTU1BUF9NSU5fQUREUj00MDk2CiMgQ09ORklH
X1g4Nl9DSEVDS19CSU9TX0NPUlJVUFRJT04gaXMgbm90IHNldApDT05GSUdfWDg2X1JFU0VSVkVf
TE9XXzY0Sz15CiMgQ09ORklHX01BVEhfRU1VTEFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX01UUlI9
eQpDT05GSUdfTVRSUl9TQU5JVElaRVI9eQpDT05GSUdfTVRSUl9TQU5JVElaRVJfRU5BQkxFX0RF
RkFVTFQ9MApDT05GSUdfTVRSUl9TQU5JVElaRVJfU1BBUkVfUkVHX05SX0RFRkFVTFQ9MQojIENP
TkZJR19YODZfUEFUIGlzIG5vdCBzZXQKQ09ORklHX1NFQ0NPTVA9eQojIENPTkZJR19DQ19TVEFD
S1BST1RFQ1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0haXzEwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X0haXzI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0haXzMwMCBpcyBub3Qgc2V0CkNPTkZJR19IWl8x
MDAwPXkKQ09ORklHX0haPTEwMDAKIyBDT05GSUdfU0NIRURfSFJUSUNLIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0VYRUMgaXMgbm90IHNldApDT05GSUdfUEhZU0lDQUxfU1RBUlQ9MHgxMDAwMDAwCiMg
Q09ORklHX1JFTE9DQVRBQkxFIGlzIG5vdCBzZXQKQ09ORklHX1BIWVNJQ0FMX0FMSUdOPTB4MTAw
MDAwCiMgQ09ORklHX0hPVFBMVUdfQ1BVIGlzIG5vdCBzZXQKQ09ORklHX0NPTVBBVF9WRFNPPXkK
IyBDT05GSUdfQ01ETElORV9CT09MIGlzIG5vdCBzZXQKCiMKIyBQb3dlciBtYW5hZ2VtZW50IGFu
ZCBBQ1BJIG9wdGlvbnMKIwojIENPTkZJR19QTSBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1ZW5j
eSBzY2FsaW5nCiMKIyBDT05GSUdfQ1BVX0ZSRVEgaXMgbm90IHNldAojIENPTkZJR19DUFVfSURM
RSBpcyBub3Qgc2V0CgojCiMgQnVzIG9wdGlvbnMgKFBDSSBldGMuKQojCkNPTkZJR19QQ0k9eQoj
IENPTkZJR19QQ0lfR09CSU9TIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0dPTU1DT05GSUcgaXMg
bm90IHNldAojIENPTkZJR19QQ0lfR09ESVJFQ1QgaXMgbm90IHNldAojIENPTkZJR19QQ0lfR09P
TFBDIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9HT0FOWT15CkNPTkZJR19QQ0lfQklPUz15CkNPTkZJ
R19QQ0lfRElSRUNUPXkKQ09ORklHX1BDSV9ET01BSU5TPXkKQ09ORklHX1BDSUVQT1JUQlVTPXkK
Q09ORklHX1BDSUVBRVI9eQojIENPTkZJR19QQ0lFX0VDUkMgaXMgbm90IHNldAojIENPTkZJR19Q
Q0lFQUVSX0lOSkVDVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSUVBU1BNIGlzIG5vdCBzZXQKQ09O
RklHX0FSQ0hfU1VQUE9SVFNfTVNJPXkKIyBDT05GSUdfUENJX01TSSBpcyBub3Qgc2V0CkNPTkZJ
R19QQ0lfTEVHQUNZPXkKIyBDT05GSUdfUENJX1NUVUIgaXMgbm90IHNldApDT05GSUdfSFRfSVJR
PXkKIyBDT05GSUdfUENJX0lPViBpcyBub3Qgc2V0CkNPTkZJR19JU0FfRE1BX0FQST15CiMgQ09O
RklHX0lTQSBpcyBub3Qgc2V0CiMgQ09ORklHX01DQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDeDIw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX09MUEMgaXMgbm90IHNldAojIENPTkZJR19QQ0NBUkQgaXMg
bm90IHNldAojIENPTkZJR19IT1RQTFVHX1BDSSBpcyBub3Qgc2V0CgojCiMgRXhlY3V0YWJsZSBm
aWxlIGZvcm1hdHMgLyBFbXVsYXRpb25zCiMKQ09ORklHX0JJTkZNVF9FTEY9eQojIENPTkZJR19D
T1JFX0RVTVBfREVGQVVMVF9FTEZfSEVBREVSUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0FPVVQ9
eQpDT05GSUdfQklORk1UX0FPVVQ9eQpDT05GSUdfQklORk1UX01JU0M9eQpDT05GSUdfSEFWRV9B
VE9NSUNfSU9NQVA9eQpDT05GSUdfTkVUPXkKCiMKIyBOZXR3b3JraW5nIG9wdGlvbnMKIwpDT05G
SUdfUEFDS0VUPXkKIyBDT05GSUdfUEFDS0VUX01NQVAgaXMgbm90IHNldApDT05GSUdfVU5JWD1t
CkNPTkZJR19YRlJNPXkKIyBDT05GSUdfWEZSTV9VU0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZS
TV9TVUJfUE9MSUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZSTV9NSUdSQVRFIGlzIG5vdCBzZXQK
IyBDT05GSUdfWEZSTV9TVEFUSVNUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0tFWSBpcyBu
b3Qgc2V0CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FE
VkFOQ0VEX1JPVVRFUiBpcyBub3Qgc2V0CkNPTkZJR19JUF9GSUJfSEFTSD15CiMgQ09ORklHX0lQ
X1BOUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0lQR1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdf
QVJQRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5FVF9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5FVF9JUENPTVAgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hGUk1fVFVOTkVMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5FVF9UVU5ORUwgaXMgbm90IHNldApDT05GSUdfSU5FVF9YRlJNX01PREVf
VFJBTlNQT1JUPW0KQ09ORklHX0lORVRfWEZSTV9NT0RFX1RVTk5FTD1tCkNPTkZJR19JTkVUX1hG
Uk1fTU9ERV9CRUVUPW0KIyBDT05GSUdfSU5FVF9MUk8gaXMgbm90IHNldApDT05GSUdfSU5FVF9E
SUFHPW0KQ09ORklHX0lORVRfVENQX0RJQUc9bQojIENPTkZJR19UQ1BfQ09OR19BRFZBTkNFRCBp
cyBub3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19DVUJJQz15CkNPTkZJR19ERUZBVUxUX1RDUF9DT05H
PSJjdWJpYyIKIyBDT05GSUdfVENQX01ENVNJRyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjYgaXMg
bm90IHNldAojIENPTkZJR19ORVRXT1JLX1NFQ01BUksgaXMgbm90IHNldApDT05GSUdfTkVURklM
VEVSPXkKIyBDT05GSUdfTkVURklMVEVSX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRF
Ul9BRFZBTkNFRD15CgojCiMgQ29yZSBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCiMgQ09ORklH
X05FVEZJTFRFUl9ORVRMSU5LX1FVRVVFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX05F
VExJTktfTE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfQ09OTlRSQUNLIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVURklMVEVSX1hUQUJMRVMgaXMgbm90IHNldAojIENPTkZJR19JUF9WUyBpcyBub3Qg
c2V0CgojCiMgSVA6IE5ldGZpbHRlciBDb25maWd1cmF0aW9uCiMKIyBDT05GSUdfTkZfREVGUkFH
X0lQVjQgaXMgbm90IHNldApDT05GSUdfSVBfTkZfUVVFVUU9eQojIENPTkZJR19JUF9ORl9JUFRB
QkxFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX0FSUFRBQkxFUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQX0RDQ1AgaXMgbm90IHNldAojIENPTkZJR19JUF9TQ1RQIGlzIG5vdCBzZXQKIyBDT05G
SUdfVElQQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMgQ09ORklHX0JSSURH
RSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9EU0EgaXMgbm90IHNldAojIENPTkZJR19WTEFOXzgw
MjFRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTExDMiBp
cyBub3Qgc2V0CiMgQ09ORklHX0lQWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQUxLIGlzIG5vdCBz
ZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qgc2V0CiMgQ09O
RklHX0VDT05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTl9ST1VURVIgaXMgbm90IHNldAojIENP
TkZJR19QSE9ORVQgaXMgbm90IHNldAojIENPTkZJR19JRUVFODAyMTU0IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfRENCIGlzIG5vdCBzZXQKCiMKIyBO
ZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlzIG5vdCBzZXQKIyBDT05GSUdf
SEFNUkFESU8gaXMgbm90IHNldAojIENPTkZJR19DQU4gaXMgbm90IHNldAojIENPTkZJR19JUkRB
IGlzIG5vdCBzZXQKIyBDT05GSUdfQlQgaXMgbm90IHNldAojIENPTkZJR19BRl9SWFJQQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1dJUkVMRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfV0lNQVggaXMgbm90
IHNldAojIENPTkZJR19SRktJTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfOVAgaXMgbm90IHNl
dAoKIwojIERldmljZSBEcml2ZXJzCiMKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKQ09O
RklHX1VFVkVOVF9IRUxQRVJfUEFUSD0iL3NiaW4vaG90cGx1ZyIKQ09ORklHX1NUQU5EQUxPTkU9
eQpDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15CkNPTkZJR19GV19MT0FERVI9eQpDT05G
SUdfRklSTVdBUkVfSU5fS0VSTkVMPXkKQ09ORklHX0VYVFJBX0ZJUk1XQVJFPSIiCiMgQ09ORklH
X1NZU19IWVBFUlZJU09SIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09OTkVDVE9SIGlzIG5vdCBzZXQK
IyBDT05GSUdfTVREIGlzIG5vdCBzZXQKQ09ORklHX1BBUlBPUlQ9bQpDT05GSUdfUEFSUE9SVF9Q
Qz1tCiMgQ09ORklHX1BBUlBPUlRfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9Q
Q19GSUZPIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9QQ19TVVBFUklPIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFSUE9SVF9HU0MgaXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUX0FYODg3OTYg
aXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUXzEyODQgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19ERVZJQ0VTIGlzIG5vdCBzZXQKQ09ORklHX0hB
VkVfSURFPXkKQ09ORklHX0lERT1tCgojCiMgUGxlYXNlIHNlZSBEb2N1bWVudGF0aW9uL2lkZS9p
ZGUudHh0IGZvciBoZWxwL2luZm8gb24gSURFIGRyaXZlcwojCkNPTkZJR19JREVfWEZFUl9NT0RF
PXkKQ09ORklHX0lERV9USU1JTkdTPXkKQ09ORklHX0lERV9BVEFQST15CiMgQ09ORklHX0JMS19E
RVZfSURFX1NBVEEgaXMgbm90IHNldApDT05GSUdfSURFX0dEPW0KQ09ORklHX0lERV9HRF9BVEE9
eQojIENPTkZJR19JREVfR0RfQVRBUEkgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVDRD1t
CkNPTkZJR19CTEtfREVWX0lERUNEX1ZFUkJPU0VfRVJST1JTPXkKIyBDT05GSUdfQkxLX0RFVl9J
REVUQVBFIGlzIG5vdCBzZXQKIyBDT05GSUdfSURFX1RBU0tfSU9DVEwgaXMgbm90IHNldApDT05G
SUdfSURFX1BST0NfRlM9eQoKIwojIElERSBjaGlwc2V0IHN1cHBvcnQvYnVnZml4ZXMKIwpDT05G
SUdfSURFX0dFTkVSSUM9bQojIENPTkZJR19CTEtfREVWX1BMQVRGT1JNIGlzIG5vdCBzZXQKQ09O
RklHX0JMS19ERVZfQ01ENjQwPW0KIyBDT05GSUdfQkxLX0RFVl9DTUQ2NDBfRU5IQU5DRUQgaXMg
bm90IHNldAoKIwojIFBDSSBJREUgY2hpcHNldHMgc3VwcG9ydAojCkNPTkZJR19CTEtfREVWX0lE
RVBDST15CiMgQ09ORklHX0JMS19ERVZfT0ZGQk9BUkQgaXMgbm90IHNldApDT05GSUdfQkxLX0RF
Vl9HRU5FUklDPW0KIyBDT05GSUdfQkxLX0RFVl9PUFRJNjIxIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfUloxMDAwPW0KIyBDT05GSUdfQkxLX0RFVl9BRUM2MlhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9BTEkxNVgzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9BTUQ3NFhYIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9BVElJWFAgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWX0NNRDY0WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJJRkxFWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfQ1M1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DUzU1
MzAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NTNTUzNSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfQ1M1NTM2IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQzNjYgaXMgbm90
IHNldAojIENPTkZJR19CTEtfREVWX0pNSUNST04gaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X1NDMTIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUElJWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfSVQ4MTcyIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JVDgyMTMgaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX0lUODIxWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfTlM4NzQxNSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUERDMjAyWFhfT0xEIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9ORVcgaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX1NWV0tTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TSUlNQUdFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9TSVM1NTEzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9T
TEM5MEU2NiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJNMjkwIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9WSUE4MkNYWFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1RDODZD
MDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVETUEgaXMgbm90IHNldAoKIwojIFND
U0kgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19SQUlEX0FUVFJTIGlzIG5vdCBzZXQKQ09ORklH
X1NDU0k9eQpDT05GSUdfU0NTSV9ETUE9eQojIENPTkZJR19TQ1NJX1RHVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfTkVUTElOSyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1BST0NfRlM9eQoKIwoj
IFNDU0kgc3VwcG9ydCB0eXBlIChkaXNrLCB0YXBlLCBDRC1ST00pCiMKQ09ORklHX0JMS19ERVZf
U0Q9eQojIENPTkZJR19DSFJfREVWX1NUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hSX0RFVl9PU1NU
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NIUl9E
RVZfU0cgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX1NDSCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfTVVMVElfTFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9DT05TVEFOVFMgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NDQU5f
QVNZTkMgaXMgbm90IHNldApDT05GSUdfU0NTSV9XQUlUX1NDQU49bQoKIwojIFNDU0kgVHJhbnNw
b3J0cwojCiMgQ09ORklHX1NDU0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9G
Q19BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX1NBU19MSUJTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NSUF9BVFRS
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTE9XTEVWRUwgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0RIIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9PU0RfSU5JVElBVE9SIGlzIG5vdCBzZXQK
Q09ORklHX0FUQT1tCiMgQ09ORklHX0FUQV9OT05TVEFOREFSRCBpcyBub3Qgc2V0CkNPTkZJR19T
QVRBX1BNUD15CiMgQ09ORklHX1NBVEFfQUhDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfU0lM
MjQgaXMgbm90IHNldApDT05GSUdfQVRBX1NGRj15CiMgQ09ORklHX1NBVEFfU1ZXIGlzIG5vdCBz
ZXQKQ09ORklHX0FUQV9QSUlYPW0KQ09ORklHX1NBVEFfTVY9bQojIENPTkZJR19TQVRBX05WIGlz
IG5vdCBzZXQKIyBDT05GSUdfUERDX0FETUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1FTVE9S
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9QUk9NSVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FU
QV9TWDQgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NB
VEFfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9VTEkgaXMgbm90IHNldAojIENPTkZJR19T
QVRBX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVklURVNTRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NBVEFfSU5JQzE2MlggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0FMSSBpcyBub3Qgc2V0
CiMgQ09ORklHX1BBVEFfQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9BUlRPUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NDBf
UENJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX0NTNTUyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQ1M1NTMwIGlzIG5vdCBzZXQKIyBD
T05GSUdfUEFUQV9DUzU1MzUgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0NTNTUzNiBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfQ1lQUkVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfRUZBUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0FUQV9HRU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9I
UFQzNjYgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDM3WCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfSFBUM1gyTiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUM1gzIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9JVDgyMVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0lUODIxMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfSk1JQ1JPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVFJJ
RkxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfTUFSVkVMTCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfTVBJSVggaXMgbm90IHNldAojIENPTkZJR19QQVRBX09MRFBJSVggaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX05FVENFTEwgaXMgbm90IHNldAojIENPTkZJR19QQVRBX05JTkpBMzIgaXMg
bm90IHNldAojIENPTkZJR19QQVRBX05TODc0MTAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX05T
ODc0MTUgaXMgbm90IHNldAojIENPTkZJR19QQVRBX09QVEkgaXMgbm90IHNldAojIENPTkZJR19Q
QVRBX09QVElETUEgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1BEQ19PTEQgaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX1JBRElTWVMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1JaMTAwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfU0MxMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9TRVJW
RVJXT1JLUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDMjAyN1ggaXMgbm90IHNldAojIENP
TkZJR19QQVRBX1NJTDY4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfU0lTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9WSUEgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1dJTkJPTkQgaXMgbm90
IHNldAojIENPTkZJR19QQVRBX1NDSCBpcyBub3Qgc2V0CiMgQ09ORklHX01EIGlzIG5vdCBzZXQK
IyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKCiMKIyBJRUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBw
b3J0CiMKCiMKIyBZb3UgY2FuIGVuYWJsZSBvbmUgb3IgYm90aCBGaXJlV2lyZSBkcml2ZXIgc3Rh
Y2tzLgojCgojCiMgU2VlIHRoZSBoZWxwIHRleHRzIGZvciBtb3JlIGluZm9ybWF0aW9uLgojCiMg
Q09ORklHX0ZJUkVXSVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfSUVFRTEzOTQgaXMgbm90IHNldAoj
IENPTkZJR19JMk8gaXMgbm90IHNldAojIENPTkZJR19NQUNJTlRPU0hfRFJJVkVSUyBpcyBub3Qg
c2V0CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX0RVTU1ZPW0KIyBDT05GSUdfQk9ORElORyBp
cyBub3Qgc2V0CiMgQ09ORklHX01BQ1ZMQU4gaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIg
aXMgbm90IHNldAojIENPTkZJR19UVU4gaXMgbm90IHNldAojIENPTkZJR19WRVRIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZTElCIGlzIG5vdCBzZXQK
Q09ORklHX05FVF9FVEhFUk5FVD15CkNPTkZJR19NSUk9eQojIENPTkZJR19IQVBQWU1FQUwgaXMg
bm90IHNldAojIENPTkZJR19TVU5HRU0gaXMgbm90IHNldAojIENPTkZJR19DQVNTSU5JIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfRVRIT0Mg
aXMgbm90IHNldAojIENPTkZJR19ETkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1RVTElQIGlz
IG5vdCBzZXQKIyBDT05GSUdfSFAxMDAgaXMgbm90IHNldAojIENPTkZJR19JQk1fTkVXX0VNQUNf
Wk1JSSBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19SR01JSSBpcyBub3Qgc2V0CiMg
Q09ORklHX0lCTV9ORVdfRU1BQ19UQUggaXMgbm90IHNldAojIENPTkZJR19JQk1fTkVXX0VNQUNf
RU1BQzQgaXMgbm90IHNldAojIENPTkZJR19JQk1fTkVXX0VNQUNfTk9fRkxPV19DVFJMIGlzIG5v
dCBzZXQKIyBDT05GSUdfSUJNX05FV19FTUFDX01BTF9DTFJfSUNJTlRTVEFUIGlzIG5vdCBzZXQK
IyBDT05GSUdfSUJNX05FV19FTUFDX01BTF9DT01NT05fRVJSIGlzIG5vdCBzZXQKQ09ORklHX05F
VF9QQ0k9eQojIENPTkZJR19QQ05FVDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EODExMV9FVEgg
aXMgbm90IHNldAojIENPTkZJR19BREFQVEVDX1NUQVJGSVJFIGlzIG5vdCBzZXQKIyBDT05GSUdf
QjQ0IGlzIG5vdCBzZXQKIyBDT05GSUdfRk9SQ0VERVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfRTEw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZFQUxOWCBpcyBub3Qgc2V0CiMgQ09ORklHX05BVFNFTUkg
aXMgbm90IHNldAojIENPTkZJR19ORTJLX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHXzgxMzlDUCBp
cyBub3Qgc2V0CkNPTkZJR184MTM5VE9PPW0KQ09ORklHXzgxMzlUT09fUElPPXkKIyBDT05GSUdf
ODEzOVRPT19UVU5FX1RXSVNURVIgaXMgbm90IHNldAojIENPTkZJR184MTM5VE9PXzgxMjkgaXMg
bm90IHNldAojIENPTkZJR184MTM5X09MRF9SWF9SRVNFVCBpcyBub3Qgc2V0CiMgQ09ORklHX1I2
MDQwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0lTOTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRVBJQzEw
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NNU0M5NDIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VOREFO
Q0UgaXMgbm90IHNldAojIENPTkZJR19UTEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfS1M4ODQyIGlz
IG5vdCBzZXQKIyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKIyBDT05GSUdfU0M5MjAzMSBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9QT0NLRVQgaXMgbm90IHNldAojIENPTkZJR19BVEwyIGlz
IG5vdCBzZXQKQ09ORklHX05FVERFVl8xMDAwPXkKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBzZXQK
IyBDT05GSUdfREwySyBpcyBub3Qgc2V0CkNPTkZJR19FMTAwMD1tCiMgQ09ORklHX0UxMDAwRSBp
cyBub3Qgc2V0CiMgQ09ORklHX0lQMTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0lHQiBpcyBub3Qg
c2V0CiMgQ09ORklHX0lHQlZGIGlzIG5vdCBzZXQKIyBDT05GSUdfTlM4MzgyMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hBTUFDSEkgaXMgbm90IHNldAojIENPTkZJR19ZRUxMT1dGSU4gaXMgbm90IHNl
dAojIENPTkZJR19SODE2OSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJUzE5MCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NLR0UgaXMgbm90IHNldAojIENPTkZJR19TS1kyIGlzIG5vdCBzZXQKIyBDT05GSUdf
VklBX1ZFTE9DSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfVElHT04zIGlzIG5vdCBzZXQKIyBDT05G
SUdfQk5YMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NOSUMgaXMgbm90IHNldAojIENPTkZJR19RTEEz
WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRMMSBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTDFFIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVRMMUMgaXMgbm90IHNldAojIENPTkZJR19KTUUgaXMgbm90IHNl
dAojIENPTkZJR19ORVRERVZfMTAwMDAgaXMgbm90IHNldAojIENPTkZJR19UUiBpcyBub3Qgc2V0
CgojCiMgV2lyZWxlc3MgTEFOCiMKIyBDT05GSUdfV0xBTl9QUkU4MDIxMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1dMQU5fODAyMTEgaXMgbm90IHNldAoKIwojIEVuYWJsZSBXaU1BWCAoTmV0d29ya2lu
ZyBvcHRpb25zKSB0byBzZWUgdGhlIFdpTUFYIGRyaXZlcnMKIwojIENPTkZJR19XQU4gaXMgbm90
IHNldAojIENPTkZJR19GRERJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElQUEkgaXMgbm90IHNldAoj
IENPTkZJR19QTElQIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0xJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVENP
TlNPTEUgaXMgbm90IHNldAojIENPTkZJR19ORVRQT0xMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1BPTExfQ09OVFJPTExFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAojIENP
TkZJR19QSE9ORSBpcyBub3Qgc2V0CgojCiMgSW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdf
SU5QVVQ9eQojIENPTkZJR19JTlBVVF9GRl9NRU1MRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5Q
VVRfUE9MTERFViBpcyBub3Qgc2V0CgojCiMgVXNlcmxhbmQgaW50ZXJmYWNlcwojCkNPTkZJR19J
TlBVVF9NT1VTRURFVj15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9QU0FVWD15CkNPTkZJR19JTlBV
VF9NT1VTRURFVl9TQ1JFRU5fWD0xMDI0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03
NjgKIyBDT05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRVZERVYg
aXMgbm90IHNldAojIENPTkZJR19JTlBVVF9FVkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2
aWNlIERyaXZlcnMKIwpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRL
QkQ9eQojIENPTkZJR19LRVlCT0FSRF9MS0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJE
X05FV1RPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1NUT1dBV0FZIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VZQk9BUkRfU1VOS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfWFRL
QkQgaXMgbm90IHNldApDT05GSUdfSU5QVVRfTU9VU0U9eQpDT05GSUdfTU9VU0VfUFMyPXkKQ09O
RklHX01PVVNFX1BTMl9BTFBTPXkKQ09ORklHX01PVVNFX1BTMl9MT0dJUFMyUFA9eQpDT05GSUdf
TU9VU0VfUFMyX1NZTkFQVElDUz15CkNPTkZJR19NT1VTRV9QUzJfTElGRUJPT0s9eQpDT05GSUdf
TU9VU0VfUFMyX1RSQUNLUE9JTlQ9eQojIENPTkZJR19NT1VTRV9QUzJfRUxBTlRFQ0ggaXMgbm90
IHNldAojIENPTkZJR19NT1VTRV9QUzJfVE9VQ0hLSVQgaXMgbm90IHNldAojIENPTkZJR19NT1VT
RV9TRVJJQUwgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9WU1hYWEFBIGlzIG5vdCBzZXQKIyBD
T05GSUdfTU9VU0VfU1lOQVBUSUNTX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0pPWVNU
SUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVEFCTEVUIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5QVVRfVE9VQ0hTQ1JFRU4gaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NSVNDIGlzIG5vdCBz
ZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwpDT05GSUdfU0VSSU89eQpDT05GSUdfU0VSSU9f
STgwNDI9eQojIENPTkZJR19TRVJJT19TRVJQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9f
Q1Q4MkM3MTAgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19QQVJLQkQgaXMgbm90IHNldAojIENP
TkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNldApDT05GSUdfU0VSSU9fTElCUFMyPXkKIyBDT05G
SUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQKIyBDT05GSUdfR0FNRVBPUlQgaXMgbm90IHNldAoKIwoj
IENoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1ZUPXkKQ09ORklHX0NPTlNPTEVfVFJBTlNMQVRJ
T05TPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfSFdfQ09OU09MRT15CiMgQ09ORklHX1ZU
X0hXX0NPTlNPTEVfQklORElORyBpcyBub3Qgc2V0CkNPTkZJR19ERVZLTUVNPXkKIyBDT05GSUdf
U0VSSUFMX05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfTk9aT01JIGlzIG5vdCBzZXQK
CiMKIyBTZXJpYWwgZHJpdmVycwojCkNPTkZJR19TRVJJQUxfODI1MD1tCkNPTkZJR19GSVhfRUFS
TFlDT05fTUVNPXkKQ09ORklHX1NFUklBTF84MjUwX1BDST1tCkNPTkZJR19TRVJJQUxfODI1MF9O
Ul9VQVJUUz00CkNPTkZJR19TRVJJQUxfODI1MF9SVU5USU1FX1VBUlRTPTQKIyBDT05GSUdfU0VS
SUFMXzgyNTBfRVhURU5ERUQgaXMgbm90IHNldAoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1
cHBvcnQKIwpDT05GSUdfU0VSSUFMX0NPUkU9bQojIENPTkZJR19TRVJJQUxfSlNNIGlzIG5vdCBz
ZXQKQ09ORklHX1VOSVg5OF9QVFlTPXkKIyBDT05GSUdfREVWUFRTX01VTFRJUExFX0lOU1RBTkNF
UyBpcyBub3Qgc2V0CkNPTkZJR19MRUdBQ1lfUFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZX0NPVU5U
PTI1NgpDT05GSUdfUFJJTlRFUj1tCiMgQ09ORklHX0xQX0NPTlNPTEUgaXMgbm90IHNldAojIENP
TkZJR19QUERFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lQTUlfSEFORExFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX0hXX1JBTkRPTSBpcyBub3Qgc2V0CiMgQ09ORklHX05WUkFNIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VOX1JUQyBpcyBub3Qgc2V0CiMgQ09ORklH
X1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQTElDT00gaXMgbm90IHNldAojIENPTkZJR19T
T05ZUEkgaXMgbm90IHNldAojIENPTkZJR19NV0FWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDODcz
NnhfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05TQ19HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1M1NTM1X0dQSU8gaXMgbm90IHNldAojIENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfSEFOR0NIRUNLX1RJTUVSIGlzIG5vdCBzZXQKIyBDT05GSUdfVENHX1RQTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1RFTENMT0NLIGlzIG5vdCBzZXQKQ09ORklHX0RFVlBPUlQ9eQpDT05GSUdf
STJDPW0KQ09ORklHX0kyQ19CT0FSRElORk89eQojIENPTkZJR19JMkNfQ0hBUkRFViBpcyBub3Qg
c2V0CkNPTkZJR19JMkNfSEVMUEVSX0FVVE89eQpDT05GSUdfSTJDX0FMR09CSVQ9bQoKIwojIEky
QyBIYXJkd2FyZSBCdXMgc3VwcG9ydAojCgojCiMgUEMgU01CdXMgaG9zdCBjb250cm9sbGVyIGRy
aXZlcnMKIwojIENPTkZJR19JMkNfQUxJMTUzNSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkx
NTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19J
MkNfQU1ENzU2IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRDgxMTEgaXMgbm90IHNldAojIENP
TkZJR19JMkNfSTgwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JU0NIIGlzIG5vdCBzZXQKIyBD
T05GSUdfSTJDX1BJSVg0IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX05GT1JDRTIgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfU0lTNTU5NSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM2MzAgaXMg
bm90IHNldAojIENPTkZJR19JMkNfU0lTOTZYIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZJQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUFQUk8gaXMgbm90IHNldAoKIwojIEkyQyBzeXN0ZW0g
YnVzIGRyaXZlcnMgKG1vc3RseSBlbWJlZGRlZCAvIHN5c3RlbS1vbi1jaGlwKQojCiMgQ09ORklH
X0kyQ19PQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKCiMK
IyBFeHRlcm5hbCBJMkMvU01CdXMgYWRhcHRlciBkcml2ZXJzCiMKIyBDT05GSUdfSTJDX1BBUlBP
UlQgaXMgbm90IHNldAojIENPTkZJR19JMkNfUEFSUE9SVF9MSUdIVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19UQU9TX0VWTSBpcyBub3Qgc2V0CgojCiMgR3JhcGhpY3MgYWRhcHRlciBJMkMvRERD
IGNoYW5uZWwgZHJpdmVycwojCiMgQ09ORklHX0kyQ19WT09ET08zIGlzIG5vdCBzZXQKCiMKIyBP
dGhlciBJMkMvU01CdXMgYnVzIGRyaXZlcnMKIwojIENPTkZJR19JMkNfUENBX1BMQVRGT1JNIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1NUVUIgaXMgbm90IHNldAojIENPTkZJR19TQ3gyMDBfQUNC
IGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5lb3VzIEkyQyBDaGlwIHN1cHBvcnQKIwojIENPTkZJ
R19EUzE2ODIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDRjg1NzQgaXMgbm90IHNldAoj
IENPTkZJR19QQ0Y4NTc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQ0E5NTM5IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19UU0wyNTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RF
QlVHX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0kyQ19ERUJVR19CVVMgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQ0hJUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CgojCiMgUFBTIHN1cHBvcnQKIwojIENP
TkZJR19QUFMgaXMgbm90IHNldApDT05GSUdfQVJDSF9XQU5UX09QVElPTkFMX0dQSU9MSUI9eQoj
IENPTkZJR19HUElPTElCIGlzIG5vdCBzZXQKIyBDT05GSUdfVzEgaXMgbm90IHNldAojIENPTkZJ
R19QT1dFUl9TVVBQTFkgaXMgbm90IHNldApDT05GSUdfSFdNT049bQojIENPTkZJR19IV01PTl9W
SUQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FCSVRVR1VSVSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfQUJJVFVHVVJVMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQUQ3NDE0
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRDc0MTggaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0FETTEwMjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjUgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMjYgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0FETTEwMjkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FETTEwMzEgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0FETTkyNDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0
NjIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0NzAgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0FEVDc0NzMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FEVDc0NzUgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0s4VEVNUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQVNCMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BVFhQMSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfRFMxNjIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JNUtfQU1C
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19GNzE4MDVGIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19GNzE4ODJGRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjc1Mzc1UyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRlNDSEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19GU0NQT1MgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZTQ0hNRCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfRzc2MEEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTE4U00g
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dMNTIwU00gaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0NPUkVURU1QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JVDg3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MTTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc1
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MTTc4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19M
TTkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19MTTkzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjE1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19MVEM0MjQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19M
TTk1MjQxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVgxNjE5IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19NQVg2NjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3MzYw
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3NDI3IGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19QQ0Y4NTkxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1NTk1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19ETUUxNzM3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19TTVNDNDdNMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3TTE5MiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3QjM5NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQURTNzgyOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVEhNQzUwIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19UTVA0MDEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZJQTY4
NkEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZUMTIxMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfVlQ4MjMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3ODFEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19XODM3OTJEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTMgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1c4M0w3ODVUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgz
TDc4Nk5HIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM2MjdIRiBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfVzgzNjI3RUhGIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19IREFQ
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVBQTEVTTUMgaXMgbm90IHNldAojIENPTkZJ
R19IV01PTl9ERUJVR19DSElQIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1dBVENIRE9HIGlzIG5vdCBzZXQKQ09ORklHX1NTQl9QT1NTSUJMRT15CgojCiMg
U29uaWNzIFNpbGljb24gQmFja3BsYW5lCiMKIyBDT05GSUdfU1NCIGlzIG5vdCBzZXQKCiMKIyBN
dWx0aWZ1bmN0aW9uIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfTUZEX0NPUkUgaXMgbm90IHNl
dAojIENPTkZJR19NRkRfU001MDEgaXMgbm90IHNldAojIENPTkZJR19IVENfUEFTSUMzIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1RNSU8gaXMgbm90IHNldAojIENPTkZJR19NRkRfV004NDAwIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUZEX1dNODM1MF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRf
UENGNTA2MzMgaXMgbm90IHNldAojIENPTkZJR19BQjMxMDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1JFR1VMQVRPUiBpcyBub3Qgc2V0CiMgQ09ORklHX01FRElBX1NVUFBPUlQgaXMgbm90IHNl
dAoKIwojIEdyYXBoaWNzIHN1cHBvcnQKIwpDT05GSUdfQUdQPW0KIyBDT05GSUdfQUdQX0FMSSBp
cyBub3Qgc2V0CiMgQ09ORklHX0FHUF9BVEkgaXMgbm90IHNldAojIENPTkZJR19BR1BfQU1EIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUdQX0FNRDY0IGlzIG5vdCBzZXQKQ09ORklHX0FHUF9JTlRFTD1t
CiMgQ09ORklHX0FHUF9OVklESUEgaXMgbm90IHNldAojIENPTkZJR19BR1BfU0lTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUdQX1NXT1JLUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9WSUEgaXMgbm90
IHNldAojIENPTkZJR19BR1BfRUZGSUNFT04gaXMgbm90IHNldApDT05GSUdfRFJNPW0KIyBDT05G
SUdfRFJNX1RERlggaXMgbm90IHNldAojIENPTkZJR19EUk1fUjEyOCBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9SQURFT04gaXMgbm90IHNldAojIENPTkZJR19EUk1fSTgxMCBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9JODMwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0k5MTUgaXMgbm90IHNldAoj
IENPTkZJR19EUk1fTUdBIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NJUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0RSTV9WSUEgaXMgbm90IHNldAojIENPTkZJR19EUk1fU0FWQUdFIGlzIG5vdCBzZXQK
IyBDT05GSUdfVkdBU1RBVEUgaXMgbm90IHNldAojIENPTkZJR19WSURFT19PVVRQVVRfQ09OVFJP
TCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xD
RF9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBEaXNwbGF5IGRldmljZSBzdXBwb3J0CiMKIyBDT05G
SUdfRElTUExBWV9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVy
IHN1cHBvcnQKIwpDT05GSUdfVkdBX0NPTlNPTEU9eQojIENPTkZJR19WR0FDT05fU09GVF9TQ1JP
TExCQUNLIGlzIG5vdCBzZXQKQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQojIENPTkZJR19TT1VORCBp
cyBub3Qgc2V0CkNPTkZJR19ISURfU1VQUE9SVD15CkNPTkZJR19ISUQ9bQpDT05GSUdfSElEX0RF
QlVHPXkKIyBDT05GSUdfSElEUkFXIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BJRCBpcyBub3Qg
c2V0CgojCiMgU3BlY2lhbCBISUQgZHJpdmVycwojCiMgQ09ORklHX1VTQl9TVVBQT1JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVdCIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldAojIENPTkZJR19ORVdfTEVEUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0FDQ0VTU0lCSUxJVFkgaXMgbm90IHNldAojIENPTkZJR19JTkZJTklCQU5EIGlzIG5v
dCBzZXQKIyBDT05GSUdfRURBQyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19DTEFTUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RNQURFVklDRVMgaXMgbm90IHNldAojIENPTkZJR19BVVhESVNQTEFZIGlz
IG5vdCBzZXQKIyBDT05GSUdfVUlPIGlzIG5vdCBzZXQKCiMKIyBUSSBWTFlOUQojCiMgQ09ORklH
X1NUQUdJTkcgaXMgbm90IHNldApDT05GSUdfWDg2X1BMQVRGT1JNX0RFVklDRVM9eQoKIwojIEZp
cm13YXJlIERyaXZlcnMKIwojIENPTkZJR19FREQgaXMgbm90IHNldApDT05GSUdfRklSTVdBUkVf
TUVNTUFQPXkKIyBDT05GSUdfREVMTF9SQlUgaXMgbm90IHNldAojIENPTkZJR19EQ0RCQVMgaXMg
bm90IHNldApDT05GSUdfRE1JSUQ9eQojIENPTkZJR19JU0NTSV9JQkZUX0ZJTkQgaXMgbm90IHNl
dAoKIwojIEZpbGUgc3lzdGVtcwojCkNPTkZJR19FWFQyX0ZTPW0KIyBDT05GSUdfRVhUMl9GU19Y
QVRUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDJfRlNfWElQIGlzIG5vdCBzZXQKQ09ORklHX0VY
VDNfRlM9bQojIENPTkZJR19FWFQzX0RFRkFVTFRTX1RPX09SREVSRUQgaXMgbm90IHNldApDT05G
SUdfRVhUM19GU19YQVRUUj15CiMgQ09ORklHX0VYVDNfRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQK
IyBDT05GSUdfRVhUM19GU19TRUNVUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDRfRlMgaXMg
bm90IHNldApDT05GSUdfSkJEPW0KQ09ORklHX0ZTX01CQ0FDSEU9bQojIENPTkZJR19SRUlTRVJG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZTX1BP
U0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0dG
UzJfRlMgaXMgbm90IHNldAojIENPTkZJR19PQ0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JU
UkZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ZJTEVfTE9DS0lORz15CkNPTkZJR19GU05PVElGWT15
CkNPTkZJR19ETk9USUZZPXkKQ09ORklHX0lOT1RJRlk9eQpDT05GSUdfSU5PVElGWV9VU0VSPXkK
IyBDT05GSUdfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90IHNldApD
T05GSUdfQVVUT0ZTNF9GUz1tCiMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAoKIwojIENhY2hl
cwojCiMgQ09ORklHX0ZTQ0FDSEUgaXMgbm90IHNldAoKIwojIENELVJPTS9EVkQgRmlsZXN5c3Rl
bXMKIwpDT05GSUdfSVNPOTY2MF9GUz15CkNPTkZJR19KT0xJRVQ9eQojIENPTkZJR19aSVNPRlMg
aXMgbm90IHNldApDT05GSUdfVURGX0ZTPXkKQ09ORklHX1VERl9OTFM9eQoKIwojIERPUy9GQVQv
TlQgRmlsZXN5c3RlbXMKIwojIENPTkZJR19NU0RPU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZG
QVRfRlMgaXMgbm90IHNldAojIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBQc2V1ZG8g
ZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJPQ19GUz15CkNPTkZJR19QUk9DX0tDT1JFPXkKQ09ORklH
X1BST0NfU1lTQ1RMPXkKQ09ORklHX1BST0NfUEFHRV9NT05JVE9SPXkKQ09ORklHX1NZU0ZTPXkK
Q09ORklHX1RNUEZTPXkKIyBDT05GSUdfVE1QRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05G
SUdfSFVHRVRMQkZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFVHRVRMQl9QQUdFIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ09ORklHRlNfRlMgaXMgbm90IHNldApDT05GSUdfTUlTQ19GSUxFU1lTVEVNUz15
CiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZTX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExVU19GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19DUkFNRlMgaXMgbm90IHNldAojIENP
TkZJR19TUVVBU0hGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19NSU5JWF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09NRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19IUEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfUk9NRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19TWVNWX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfVUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTklMRlMyX0ZTIGlzIG5vdCBzZXQKQ09O
RklHX05FVFdPUktfRklMRVNZU1RFTVM9eQojIENPTkZJR19ORlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19ORlNEIGlzIG5vdCBzZXQKIyBDT05GSUdfU01CX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFf
RlMgaXMgbm90IHNldAojIENPTkZJR19BRlNfRlMgaXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBU
eXBlcwojCiMgQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRCBpcyBub3Qgc2V0CkNPTkZJR19NU0RP
U19QQVJUSVRJT049eQpDT05GSUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEi
CkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PW0KIyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV83NzUgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfODUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODU3IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODYyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODY1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV84NjkgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV85MzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzggaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0FT
Q0lJIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMSBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8zIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5
XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzkgaXMgbm90IHNl
dAojIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5
XzE0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTUgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfVSBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19VVEY4IGlzIG5vdCBzZXQKIyBDT05GSUdfRExNIGlzIG5vdCBzZXQKCiMKIyBL
ZXJuZWwgaGFja2luZwojCkNPTkZJR19UUkFDRV9JUlFGTEFHU19TVVBQT1JUPXkKIyBDT05GSUdf
UFJJTlRLX1RJTUUgaXMgbm90IHNldApDT05GSUdfRU5BQkxFX1dBUk5fREVQUkVDQVRFRD15CkNP
TkZJR19FTkFCTEVfTVVTVF9DSEVDSz15CkNPTkZJR19GUkFNRV9XQVJOPTEwMjQKIyBDT05GSUdf
TUFHSUNfU1lTUlEgaXMgbm90IHNldApDT05GSUdfVU5VU0VEX1NZTUJPTFM9eQojIENPTkZJR19E
RUJVR19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hFQURFUlNfQ0hFQ0sgaXMgbm90IHNldAojIENP
TkZJR19JUElQRV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tFUk5FTCBpcyBub3Qg
c2V0CkNPTkZJR19ERUJVR19CVUdWRVJCT1NFPXkKQ09ORklHX0RFQlVHX01FTU9SWV9JTklUPXkK
Q09ORklHX0FSQ0hfV0FOVF9GUkFNRV9QT0lOVEVSUz15CkNPTkZJR19GUkFNRV9QT0lOVEVSPXkK
IyBDT05GSUdfUkNVX0NQVV9TVEFMTF9ERVRFQ1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xBVEVO
Q1lUT1AgaXMgbm90IHNldAojIENPTkZJR19TWVNDVExfU1lTQ0FMTF9DSEVDSyBpcyBub3Qgc2V0
CkNPTkZJR19VU0VSX1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX1RS
QUNFUj15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX0dSQVBIX1RSQUNFUj15CkNPTkZJR19IQVZFX0ZV
TkNUSU9OX0dSQVBIX0ZQX1RFU1Q9eQpDT05GSUdfSEFWRV9GVU5DVElPTl9UUkFDRV9NQ09VTlRf
VEVTVD15CkNPTkZJR19IQVZFX0RZTkFNSUNfRlRSQUNFPXkKQ09ORklHX0hBVkVfRlRSQUNFX01D
T1VOVF9SRUNPUkQ9eQpDT05GSUdfSEFWRV9GVFJBQ0VfU1lTQ0FMTFM9eQpDT05GSUdfVFJBQ0lO
R19TVVBQT1JUPXkKIyBDT05GSUdfRlRSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJPVklERV9P
SENJMTM5NF9ETUFfSU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNQV9BUElfREVCVUcgaXMgbm90
IHNldAojIENPTkZJR19TQU1QTEVTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LR0RCPXkK
Q09ORklHX0hBVkVfQVJDSF9LTUVNQ0hFQ0s9eQojIENPTkZJR19TVFJJQ1RfREVWTUVNIGlzIG5v
dCBzZXQKQ09ORklHX1g4Nl9WRVJCT1NFX0JPT1RVUD15CkNPTkZJR19FQVJMWV9QUklOVEs9eQoj
IENPTkZJR19FQVJMWV9QUklOVEtfREJHUCBpcyBub3Qgc2V0CiMgQ09ORklHXzRLU1RBQ0tTIGlz
IG5vdCBzZXQKQ09ORklHX0RPVUJMRUZBVUxUPXkKIyBDT05GSUdfSU9NTVVfU1RSRVNTIGlzIG5v
dCBzZXQKQ09ORklHX0hBVkVfTU1JT1RSQUNFX1NVUFBPUlQ9eQpDT05GSUdfSU9fREVMQVlfVFlQ
RV8wWDgwPTAKQ09ORklHX0lPX0RFTEFZX1RZUEVfMFhFRD0xCkNPTkZJR19JT19ERUxBWV9UWVBF
X1VERUxBWT0yCkNPTkZJR19JT19ERUxBWV9UWVBFX05PTkU9MwpDT05GSUdfSU9fREVMQVlfMFg4
MD15CiMgQ09ORklHX0lPX0RFTEFZXzBYRUQgaXMgbm90IHNldAojIENPTkZJR19JT19ERUxBWV9V
REVMQVkgaXMgbm90IHNldAojIENPTkZJR19JT19ERUxBWV9OT05FIGlzIG5vdCBzZXQKQ09ORklH
X0RFRkFVTFRfSU9fREVMQVlfVFlQRT0wCiMgQ09ORklHX09QVElNSVpFX0lOTElOSU5HIGlzIG5v
dCBzZXQKCiMKIyBTZWN1cml0eSBvcHRpb25zCiMKIyBDT05GSUdfS0VZUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFQ1VSSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlGUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFQ1VSSVRZX0ZJTEVfQ0FQQUJJTElUSUVTIGlzIG5vdCBzZXQKQ09ORklHX0NS
WVBUTz15CgojCiMgQ3J5cHRvIGNvcmUgb3IgaGVscGVyCiMKIyBDT05GSUdfQ1JZUFRPX0ZJUFMg
aXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FMR0FQST1tCkNPTkZJR19DUllQVE9fQUxHQVBJMj1t
CkNPTkZJR19DUllQVE9fSEFTSD1tCkNPTkZJR19DUllQVE9fSEFTSDI9bQojIENPTkZJR19DUllQ
VE9fTUFOQUdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19NQU5BR0VSMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19HRjEyOE1VTCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19OVUxM
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NSWVBURCBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19BVVRIRU5DIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RFU1QgaXMgbm90IHNldAoK
IwojIEF1dGhlbnRpY2F0ZWQgRW5jcnlwdGlvbiB3aXRoIEFzc29jaWF0ZWQgRGF0YQojCiMgQ09O
RklHX0NSWVBUT19DQ00gaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fR0NNIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX1NFUUlWIGlzIG5vdCBzZXQKCiMKIyBCbG9jayBtb2RlcwojCiMgQ09O
RklHX0NSWVBUT19DQkMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1RSIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX0NUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19FQ0IgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fTFJXIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1BDQkMg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWFRTIGlzIG5vdCBzZXQKCiMKIyBIYXNoIG1vZGVz
CiMKIyBDT05GSUdfQ1JZUFRPX0hNQUMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWENCQyBp
cyBub3Qgc2V0CgojCiMgRGlnZXN0CiMKQ09ORklHX0NSWVBUT19DUkMzMkM9bQojIENPTkZJR19D
UllQVE9fQ1JDMzJDX0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX01ENCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19NRDUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fTUlDSEFF
TF9NSUMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fUk1EMTI4IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1JNRDE2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19STUQyNTYgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fUk1EMzIwIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NI
QTEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0hBMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1NIQTUxMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UR1IxOTIgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fV1A1MTIgaXMgbm90IHNldAoKIwojIENpcGhlcnMKIwojIENPTkZJ
R19DUllQVE9fQUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0FFU181ODYgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fQU5VQklTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0FSQzQg
aXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQkxPV0ZJU0ggaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fQ0FNRUxMSUEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ0FTVDUgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fQ0FTVDYgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVTIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0ZDUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19LSEFaQUQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0FMU0EyMCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19TQUxTQTIwXzU4NiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRUVE
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFUlBFTlQgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fVEVBIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RXT0ZJU0ggaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fVFdPRklTSF81ODYgaXMgbm90IHNldAoKIwojIENvbXByZXNzaW9uCiMK
IyBDT05GSUdfQ1JZUFRPX0RFRkxBVEUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fWkxJQiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWk8gaXMgbm90IHNldAoKIwojIFJhbmRvbSBOdW1i
ZXIgR2VuZXJhdGlvbgojCiMgQ09ORklHX0NSWVBUT19BTlNJX0NQUk5HIGlzIG5vdCBzZXQKQ09O
RklHX0NSWVBUT19IVz15CiMgQ09ORklHX0NSWVBUT19ERVZfUEFETE9DSyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19ERVZfR0VPREUgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVWX0hJ
Rk5fNzk1WCBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0tWTT15CkNPTkZJR19IQVZFX0tWTV9JUlFD
SElQPXkKIyBDT05GSUdfVklSVFVBTElaQVRJT04gaXMgbm90IHNldAojIENPTkZJR19CSU5BUllf
UFJJTlRGIGlzIG5vdCBzZXQKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0JJVFJFVkVS
U0U9bQpDT05GSUdfR0VORVJJQ19GSU5EX0ZJUlNUX0JJVD15CkNPTkZJR19HRU5FUklDX0ZJTkRf
TkVYVF9CSVQ9eQpDT05GSUdfR0VORVJJQ19GSU5EX0xBU1RfQklUPXkKIyBDT05GSUdfQ1JDX0ND
SVRUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMTYgaXMgbm90IHNldAojIENPTkZJR19DUkNfVDEw
RElGIGlzIG5vdCBzZXQKQ09ORklHX0NSQ19JVFVfVD15CkNPTkZJR19DUkMzMj1tCiMgQ09ORklH
X0NSQzcgaXMgbm90IHNldApDT05GSUdfTElCQ1JDMzJDPW0KQ09ORklHX0FVRElUX0dFTkVSSUM9
eQpDT05GSUdfWkxJQl9JTkZMQVRFPXkKQ09ORklHX0RFQ09NUFJFU1NfR1pJUD15CkNPTkZJR19E
RUNPTVBSRVNTX0JaSVAyPXkKQ09ORklHX0RFQ09NUFJFU1NfTFpNQT15CkNPTkZJR19IQVNfSU9N
RU09eQpDT05GSUdfSEFTX0lPUE9SVD15CkNPTkZJR19IQVNfRE1BPXkKQ09ORklHX05MQVRUUj15
Cg==
--000e0cd6aa06cde4eb04794eaa58--

