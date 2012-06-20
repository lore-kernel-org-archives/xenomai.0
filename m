MIME-Version: 1.0
In-Reply-To: <4FDB79BB.4060107@mail.polimi.it>
References: <4FCF0FD5.1050201@mail.polimi.it>
	<CA+eKTkb6m22yqmckZusuG+zdzx8pSn1To_hOcgXdEF7ini48sw@mail.gmail.com>
	<4FCF1F22.2030203@mail.polimi.it>
	<CAHpmwf-gF92nsxqYzxQROcW5CRqs9=X5OSFDo3EhRBF4WEMNHA@mail.gmail.com>
	<CAMesUR4rU23ukpC-E0hYWAZ8tiyv4+dzKvyoDGr2ctP5F7vs1g@mail.gmail.com>
	<4FDB79BB.4060107@mail.polimi.it>
Date: Thu, 21 Jun 2012 00:21:36 +0200
Message-ID: <CAMesUR6+srFi3u9mJKBeEsz1qrHqL=fLK2u2wziEaw69qsiMJw@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] analogy attach failed NI-6220
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Danilo De Lorenzo <danilo.delorenzo@mail.polimi.it>
Cc: Xenomai@xenomai.org

Hi,

Sorry for the late answer.

On Fri, Jun 15, 2012 at 8:06 PM, Danilo De Lorenzo
<danilo.delorenzo@mail.polimi.it> wrote:
> - The driver is shown under /proc/analogy/drivers
>
> - Launching analogy_config without options gave me the same error
>
> - this is the part of =A0dmesg output related to mite and comedi (it seem=
s the
> board is detected by mite driver):
>
> [ =A0 29.141006] <30>udevd[365]: starting version 173
> [ =A0 29.797061] lp: driver loaded but no devices found
> [ =A0 29.832660] ni_tio: module is from the staging directory, the qualit=
y is
> unknown, you have been warned.
> [ =A0 29.849476] comedi: module is from the staging directory, the qualit=
y is
> unknown, you have been warned.
> [ =A0 29.853344] comedi: version 0.7.76 - http://www.comedi.org
> [ =A0 29.882067] type=3D1400 audit(1339780810.462:2): apparmor=3D"STATUS"
> operation=3D"profile_load" name=3D"/sbin/dhclient" pid=3D604
> comm=3D"apparmor_parser"
> [ =A0 29.882158] type=3D1400 audit(1339780810.462:3): apparmor=3D"STATUS"
> operation=3D"profile_load"
> name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D604
> comm=3D"apparmor_parser"
> [ =A0 29.882219] type=3D1400 audit(1339780810.462:4): apparmor=3D"STATUS"
> operation=3D"profile_load" name=3D"/usr/lib/connman/scripts/dhclient-scri=
pt"
> pid=3D604 comm=3D"apparmor_parser"
> [ =A0 29.906386] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0x841=
0,
> revision 0
> [ =A0 29.936592] SP5100 TCO timer: SP5100 TCO WatchDog Timer Driver v0.01
> [ =A0 29.936707] SP5100 TCO timer: mmio address 0xfec000f0 already in use
> [ =A0 29.973252] tpm_tis 00:01: 1.2 TPM (device-id 0xB, rev-id 16)
> [ =A0 30.019424] type=3D1400 audit(1339780810.592:5): apparmor=3D"STATUS"
> operation=3D"profile_replace" name=3D"/sbin/dhclient" pid=3D668
> comm=3D"apparmor_parser"
> [ =A0 30.019521] type=3D1400 audit(1339780810.592:6): apparmor=3D"STATUS"
> operation=3D"profile_replace"
> name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D668
> comm=3D"apparmor_parser"
> [ =A0 30.019585] type=3D1400 audit(1339780810.592:7): apparmor=3D"STATUS"
> operation=3D"profile_replace" name=3D"/usr/lib/connman/scripts/dhclient-s=
cript"
> pid=3D668 comm=3D"apparmor_parser"
> [ =A0 30.089668] 8255: module is from the staging directory, the quality =
is
> unknown, you have been warned.
> [ =A0 30.134451] mite: module is from the staging directory, the quality =
is
> unknown, you have been warned.
> [ =A0 30.137068] Available NI device IDs:
> [ =A0 30.137071] =A00x70b0
> [ =A0 30.137073]
> [ =A0 30.157559] EXT4-fs (sda3): re-mounted. Opts: errors=3Dremount-ro
> [ =A0 30.171110] comedi_fc: module is from the staging directory, the qua=
lity
> is unknown, you have been warned.
> [ =A0 30.396292] ni_tiocmd: module is from the staging directory, the qua=
lity
> is unknown, you have been warned.
> [ =A0 30.398776] ni_pcimio: module is from the staging directory, the qua=
lity
> is unknown, you have been warned.
> [ =A0 30.402314] comedi0: ni_pcimio: pci-6220
> [ =A0 30.402370] ni_pcimio 0000:0c:05.0: PCI INT A -> GSI 20 (level, low)=
 ->
> IRQ 20
> [ =A0 30.402399] MITE:0xd2001000 mapped to ffffc9000035e000
> [ =A0 30.402405] DAQ:0xd2000000 mapped to ffffc90000368000
> [ =A0 30.402412] mite: version =3D 1, type =3D 4, mite mode =3D 1,interfa=
ce mode =3D 3
> [ =A0 30.402414] mite: num channels =3D 8, write post fifo depth =3D 1,wi=
ns =3D 0,
> iowins =3D 2
> [ =A0 30.402424] mite: fifo size is 64.
> [ =A0 30.426067] =A0( irq =3D 20 )
> [ =A0 30.570182] usb 1-6: usbfs: USBDEVFS_CONTROL failed cmd mtp-probe rq=
t 128
> rq 6 len 255 ret -110
> [ =A0 30.733353] Analogy: MITE: Available NI device IDs:
> [ =A0 31.103558] nvidia: module license 'NVIDIA' taints kernel.
> [ =A0 31.103565] Disabling lock debugging due to kernel tai
>
>
> Also, looking at the kernel.log when trying several options I found this:
>
> Jun =A06 15:04:08 .............. kernel: [12804.406688] Analogy:
> a4l_assign_driver: call(drv->attach) failed (ret=3D-22)
> Jun =A06 15:11:07 .............. kernel: [13222.826688] Analogy:
> a4l_assign_driver: call(alloc) failed
> Jun =A06 15:11:16 .............. kernel: [13232.266499] Analogy:
> a4l_assign_driver: call(alloc) failed
> Jun =A06 15:11:54 .............. kernel: [13269.486717] BUG: unable to ha=
ndle
> kernel NULL pointer dereference at 000000000000000c
> Jun =A06 15:11:54 .............. kernel: [13269.486725] IP:
> [<ffffffff810fe0fb>] get_free_range+0x5b/0x170
> Jun =A06 15:11:54 .............. kernel: [13269.486735] PGD 47bfe067 PUD
> 47bf6067 PMD 0
> Jun =A06 15:11:54 .............. kernel: [13269.486741] Oops: 0000 [#1]
> PREEMPT SMP
> Jun =A06 15:11:54 .............. kernel: [13269.486746] last sysfs file:
> /sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_map
> Jun =A06 15:11:54 .............. kernel: [13269.486751] CPU 1
> Jun =A06 15:11:54 .............. kernel: [13269.486753] Modules linked in=
: sco
> rfcomm bnep l2cap bluetooth parport_pc ppdev dm_crypt nvidia(P)
> snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm
> snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq analogy_ni_pcimio
> analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite xeno_analogy
> ni_pcimio(C) ni_tiocmd(C) comedi_fc(C) mite(C) snd_timer snd_seq_device
> 8255(C) snd tpm_infineon sp5100_tco i2c_piix4 soundcore snd_page_alloc
> psmouse comedi(C) ni_tio(C) tpm_tis tpm serio_raw tpm_bios lp parport usb=
hid
> hid r8169 floppy ahci pata_atiixp libahci
> Jun =A06 15:11:54 .............. kernel: [13269.486813]
> Jun =A06 15:11:54 .............. kernel: [13269.486816] Pid: 2118, comm:
> analogy_config Tainted: P =A0 =A0 =A0 =A0 C =A02.6.38.8-xenomai #1 FUJITS=
U SIEMENS
> ESPRIMO P =A0 =A0 =A0 =A0 =A0 /D2451-A3
> Jun =A06 15:11:54 .............. kernel: [13269.486824] RIP:
> 0010:[<ffffffff810fe0fb>] =A0[<ffffffff810fe0fb>] get_free_range+0x5b/0x1=
70
> Jun =A06 15:11:54 .............. kernel: [13269.486830] RSP:
> 0018:ffff880035147bd0 =A0EFLAGS: 00010206
> Jun =A06 15:11:54 .............. kernel: [13269.486833] RAX: 000000000000=
000c
> RBX: ffffc90001509200 RCX: 000000000000000c
> Jun =A06 15:11:54 .............. kernel: [13269.486836] RDX: 000000000000=
0000
> RSI: 0000000000005000 RDI: ffffffff821ac3c0
> Jun =A06 15:11:54 .............. kernel: [13269.486839] RBP: ffff88003514=
7bf8
> R08: ffffc90001508000 R09: 000000000000000c
> Jun =A06 15:11:54 .............. kernel: [13269.486842] R10: 000000000000=
0200
> R11: 0000000000000200 R12: 0000000000000400
> Jun =A06 15:11:54 .............. kernel: [13269.486845] R13: ffffc9000150=
9000
> R14: ffffc90001509000 R15: ffffffff821ac408
> Jun =A06 15:11:54 .............. kernel: [13269.486849] FS:
> =A000007f2246a9f720(0000) GS:ffff88007fd00000(0000) knlGS:000000000000000=
0
> Jun =A06 15:11:54 .............. kernel: [13269.486852] CS: =A00010 DS: 0=
000 ES:
> 0000 CR0: 0000000080050033
> Jun =A06 15:11:54 .............. kernel: [13269.486855] CR2: 000000000000=
000c
> CR3: 0000000035216000 CR4: 00000000000006e0
> Jun =A06 15:11:54 .............. kernel: [13269.486858] DR0: 000000000000=
0000
> DR1: 0000000000000000 DR2: 0000000000000000
> Jun =A06 15:11:54 .............. kernel: [13269.486861] DR3: 000000000000=
0000
> DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Jun =A06 15:11:54 .............. kernel: [13269.486864] Process analogy_c=
onfig
> (pid: 2118, threadinfo ffff880035144000, task ffff8800353c0000)
> Jun =A06 15:11:54 .............. kernel: [13269.486867] Stack:
> Jun =A06 15:11:54 .............. kernel: [13269.486869] =A000001d08949cb5=
7b
> 0000000000000001 ffff880035147cd0 ffffffff821ac3c0
> Jun =A06 15:11:54 .............. kernel: [13269.486876] =A000000000000050=
00
> ffff880035147c68 ffffffff810ff9e9 ffff880035147c28
> Jun =A06 15:11:54 .............. kernel: [13269.486882] =A000000000000000=
01
> ffff880035147c88 ffffffff810ff793 000000000000eb20
> Jun =A06 15:11:54 .............. kernel: [13269.486888] Call Trace:
> Jun =A06 15:11:54 .............. kernel: [13269.486894] =A0[<ffffffff810f=
f9e9>]
> xnheap_alloc+0x4b9/0x4e0
> Jun =A06 15:11:54 .............. kernel: [13269.486899] =A0[<ffffffff810f=
f793>]
> ? xnheap_alloc+0x263/0x4e0
> Jun =A06 15:11:54 .............. kernel: [13269.486910] =A0[<ffffffffa013=
e238>]
> a4l_assign_driver+0x58/0x220 [xeno_analogy]
> Jun =A06 15:11:54 .............. kernel: [13269.486916] =A0[<ffffffffa013=
e534>]
> a4l_device_attach+0x74/0x90 [xeno_analogy]
> Jun =A06 15:11:54 .............. kernel: [13269.486922] =A0[<ffffffffa013=
e5eb>]
> a4l_ioctl_devcfg+0x6b/0x150 [xeno_analogy]
> Jun =A06 15:11:54 .............. kernel: [13269.486928] =A0[<ffffffffa014=
07de>]
> a4l_ioctl+0x1e/0x20 [xeno_analogy]
> Jun =A06 15:11:54 .............. kernel: [13269.486935] =A0[<ffffffff8117=
76eb>]
> __rt_dev_ioctl+0x12b/0x160
> Jun =A06 15:11:54 .............. kernel: [13269.486940] =A0[<ffffffff811a=
3eee>]
> ? handle_mm_fault+0x13e/0x240
> Jun =A06 15:11:54 .............. kernel: [13269.486945] =A0[<ffffffff8117=
d878>]
> sys_rtdm_ioctl+0x28/0x30
> Jun =A06 15:11:54 .............. kernel: [13269.486949] =A0[<ffffffff8111=
8a31>]
> losyscall_event+0xd1/0x260
> Jun =A06 15:11:54 .............. kernel: [13269.486954] =A0[<ffffffff810c=
d2ac>]
> __ipipe_dispatch_event+0x11c/0x1e0
> Jun =A06 15:11:54 .............. kernel: [13269.486960] =A0[<ffffffff8101=
f90c>]
> __ipipe_syscall_root+0x5c/0x130
> Jun =A06 15:11:54 .............. kernel: [13269.486970] =A0[<ffffffff8161=
d521>]
> __ipipe_syscall_root_thunk+0x35/0x6a
> Jun =A06 15:11:54 .............. kernel: [13269.486977] =A0[<ffffffff8100=
2f04>]
> ? system_call_after_swapgs+0x54/0x79
> Jun =A06 15:11:54 .............. kernel: [13269.486980] Code: 74 4b 4c 8b=
 5f
> 18 4d 89 f1 0f 1f 80 00 00 00 00 4d 89 da 4c 89 c8 eb 13 0f 1f 84 00 00 0=
0
> 00 00 49 39 f2 73 16 4d 89 e2 48 89 c8 <48> 8b 08 4a 8d 1c 18 4f 8d 24 1a=
 48
> 39 d9 74 e5 4c 39 d6 76 30
> Jun =A06 15:11:54 .............. kernel: [13269.487035] RIP
> =A0[<ffffffff810fe0fb>] get_free_range+0x5b/0x170
> Jun =A06 15:11:54 .............. kernel: [13269.487040] =A0RSP
> <ffff880035147bd0>
> Jun =A06 15:11:54 .............. kernel: [13269.487042] CR2: 000000000000=
000c
>
>
> Any clues on the causes of the problem?
>

It seems that, in your kernel configuration, you have enabled both
comedi and analogy. I saw comedi messages in your kernel logs.
Could you try to disable comedi? there are two mite drivers loaded.

Are you sure the analogy mite driver detected your board? I only saw:
[   30.733353] Analogy: MITE: Available NI device IDs:
No device ID is listed.

Could you enable XENO_DRIVERS_ANALOGY_DEBUG and set
XENO_DRIVERS_ANALOGY_DEBUG_LEVEL to 5 in your kernel configuration?
You are supposed to see messages like
"mio_common: registering AI subdevice...\n",
"mio_common: registering AO subdevice...\n"
With more verbosity, we might be able to locate the code which
triggers the kernel oops.

Alexis.

> Thanks a lot.
>
>
> Danilo De Lorenzo, PhD
> NearLab - Bioengineering Department
> Politecnico di Milano, via Colombo 40, 20133 Milan, Italy
> www.nearlab.polimi.it
>
> email: danilo.delorenzo@mail.polimi.it
> phone: +39 02-2399-9013
> fax: +39 02-2399-9003
>
>
> On 06/07/2012 09:07 AM, Alexis Berlemont wrote:
>>
>> Hi,
>>
>> On Wed, Jun 6, 2012 at 8:25 PM, Danilo De Lorenzo
>> <danilo.delorenzo@mail.polimi.it> =A0wrote:
>>>
>>> Anyone else has any suggestions? At least a hint on how to find where i=
s
>>> the problem?
>>>
>> The error code -2 means -ENOENT; so
>> - either the driver is not available inside the kernel (according to
>> your former mail, it is not the case; you can ensure this point by
>> checking the content of /proc/analogy/drivers)
>> -or the card is not detected, could you look in the kernel logs for a
>> message stating that the card was detected by the mite driver (maybe
>> verbose log should be activated)?
>> - could you launch analogy_config without the optional arguments? just
>> type:
>> /usr/xenomai/sbin/analogy_config analogy0 analogy_ni_pcimio
>>
>>> Thanks
>>> Il giorno 06/giu/2012 11:13, "Danilo De Lorenzo"<
>>> danilo.delorenzo@mail.polimi.it> =A0ha scritto:
>>>
>> Alexis.

