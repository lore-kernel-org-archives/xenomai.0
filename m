From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Thu, 11 Aug 2011 11:31:11 -0300
References: <201108101449.54243.carlosnov@domain.hid>
	<201108101810.02640.carlosnov@domain.hid>
	<4E438724.2070709@domain.hid>
In-Reply-To: <4E438724.2070709@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ve+QOz1soO5YBoN"
Message-Id: <201108111131.11981.carlosnov@domain.hid>
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--Boundary-00=_ve+QOz1soO5YBoN
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Here it comes.
I found out that if wait is called inside an IOCTL, there is no hangs at al=
l,=20
everything work as expected, except from te fact that it seens a litle bit=
=20
strange (to me) to use ioctl to read or write, I would expect to use the=20
correspondent rad and write functions and ioctl to setup something.
I tried to reduce the code, in the tarball there are one Makefile, one c fi=
le=20
for the module and one c file for the app. There is one define line on the=
=20
module file, comment it ou to get the hangs. The app will simply open the=20
device, issue an wait ioctl (dummy if the module is compiled to wait in=20
read_rt) and the do the actual reading (it hangs on my system if i tell the=
=20
module to wait on the read_rt function).

Here comes the kernel log from one run that does the error but fortunately=
=20
does not hang the entire system.

[  208.986250] Xenomai: RTDM: RT open handler is deprecated, driver require=
s=20
update.
[  208.986256] Xenomai: RTDM: RT close handler is deprecated, driver requir=
es=20
update.
[  215.500264] Open Device RT
[  215.500268] rtdm_timer_start returned 0
[  215.500270] IOCTL Device RT. Request =3D 9
[  215.600264] timer proc function
[  215.600268] rtdm_timer_start_in_handler returned 0
[  215.600270] Read Device RT
[  215.600272] IOCTL Device RT. Request =3D 9
[  215.700243] timer proc function
[  215.700246] rtdm_timer_start_in_handler returned 0
[  215.700248] Read Device RT
[  215.700250] IOCTL Device RT. Request =3D 9
[  215.800223] timer proc function
[  215.800227] rtdm_timer_start_in_handler returned 0
[  215.800229] Read Device RT
[  215.800230] IOCTL Device RT. Request =3D 9
[  215.900205] timer proc function
[  215.900209] rtdm_timer_start_in_handler returned 0
[  215.900211] Read Device RT
[  215.900213] IOCTL Device RT. Request =3D 9
[  216.000190] timer proc function
[  216.000194] rtdm_timer_start_in_handler returned 0
[  216.000196] Read Device RT
[  216.000197] IOCTL Device RT. Request =3D 9
[  216.100165] timer proc function
[  216.100170] rtdm_timer_start_in_handler returned 0
[  216.100172] Read Device RT
[  216.100173] IOCTL Device RT. Request =3D 9
[  216.200169] timer proc function
[  216.200174] rtdm_timer_start_in_handler returned 0
[  216.200176] Read Device RT
[  216.200177] Close Device RT
[  235.671035] Xenomai: RTDM: RT open handler is deprecated, driver require=
s=20
update.
[  235.671041] Xenomai: RTDM: RT close handler is deprecated, driver requir=
es=20
update.
[  237.814763] Open Device RT
[  237.814767] rtdm_timer_start returned 0
[  237.814769] IOCTL Device RT. Request =3D 9
[  237.814771] Read Device RT
[  237.814803] BUG: unable to handle kernel NULL pointer dereference at=20
00000000000000c0
[  237.814808] IP: [<ffffffff811408b8>] rtdm_event_timedwait+0x78/0x1a0
[  237.814819] PGD 4557e067 PUD 4f8e1067 PMD 0=20
[  237.814823] Oops: 0000 [#1] SMP=20
[  237.814827] last sysfs file:=20
/sys/devices/pci0000:00/0000:00:0d.0/0000:04:00.0/local_cpus
[  237.814831] CPU 0=20
[  237.814834] Modules linked in: testcase_wait_hang binfmt_misc rfcomm sco=
=20
bnep l2cap dm_crypt snd_hda_codec_realtek vmnet vmblock vsock vmci vmmon pp=
dev=20
snd_hda_intel snd_usb_audio snd_usbmidi_lib snd_hda_codec snd_hwdep snd_pcm=
=20
snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi amd64_edac_mod btusb=20
edac_core uvcvideo bluetooth videodev v4l2_compat_ioctl32 snd_timer=20
snd_seq_device parport_pc psmouse k8temp asus_atk0110 snd serio_raw=20
i2c_nforce2 edac_mce_amd soundcore snd_page_alloc lp parport uvesafb forced=
eth=20
ahci libahci pata_amd [last unloaded: testcase_wait_hang]
[  237.814878]=20
[  237.814881] Pid: 4553, comm: testcase_wait_h Not tainted 2.6.38.8-
xenomai-01 #1 System manufacturer System Product Name/M2N-X
[  237.814888] RIP: 0010:[<ffffffff811408b8>]  [<ffffffff811408b8>]=20
rtdm_event_timedwait+0x78/0x1a0
[  237.814894] RSP: 0018:ffff88003a207d28  EFLAGS: 00010246
[  237.814897] RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 00000000000=
0001f
[  237.814900] RDX: 0000000000000000 RSI: 000000003b9aca00 RDI:=20
00000000000000a8
[  237.814903] RBP: ffff88003a207d68 R08: 00007f0905e3a238 R09: 00007fff9f3=
13e50
[  237.814906] R10: 00007fff9f314480 R11: 0000000000000206 R12:=20
00000000000000a8
[  237.814909] R13: 000000000000ea60 R14: 0000000000000028 R15: ffff88003a2=
07d80
[  237.814913] FS:  00007f0906864720(0000) GS:ffff88007fc00000(0000)=20
knlGS:00000000f5fb6710
[  237.814916] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  237.814919] CR2: 00000000000000c0 CR3: 0000000079773000 CR4:=20
00000000000006f0
[  237.814922] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=20
0000000000000000
[  237.814925] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[  237.814929] Process testcase_wait_h (pid: 4553, threadinfo ffff88003a204=
000,=20
task ffff880041a98000)
[  237.814935] Stack:
[  237.814937]  00007fff9f314720 0000000000000028 ffff88003a207d48=20
00007fff9f314720
[  237.814942]  ffffc90010909600 00007fff9f314720 0000000000000028 ffff8800=
41a98000
[  237.814947]  ffff88003a207d98 ffffffffa0297135 ffff88003a207f58 0000003a=
8b52e88e
[  237.814952] Call Trace:
[  237.814959]  [<ffffffffa0297135>] testcase_read_rt+0x45/0x90=20
[testcase_wait_hang]
[  237.814964]  [<ffffffff8113dd1a>] __rt_dev_read+0x6a/0xc0
[  237.814968]  [<ffffffff81141266>] sys_rtdm_read+0x26/0x30
[  237.814972]  [<ffffffff81109688>] hisyscall_event+0x1e8/0x4c0
[  237.814978]  [<ffffffff81310e90>] ? rb_insert_color+0x110/0x150
[  237.814983]  [<ffffffff810c5bed>] __ipipe_dispatch_event+0x11d/0x1e0
[  237.814989]  [<ffffffff8101eebf>] __ipipe_syscall_root+0x5f/0x140
[  237.814995]  [<ffffffff815c42c1>] __ipipe_syscall_root_thunk+0x35/0x6a
[  237.815001]  [<ffffffff81002ec4>] ? system_call_after_swapgs+0x54/0x79
[  237.815004] Code: 8f 00 83 e3 01 65 8b 14 25 30 c6 00 00 39 c2 0f 84 8e =
00=20
00 00 b8 ff ff ff ff f0 0f b1 15 31 22 8f 00 83 f8 ff 0f 85 fd 00 00 00 <49=
> 8b 44=20
24 18 a9 00 00 00 01 0f 85 e2 00 00 00 a9 00 00 00 02=20
[  237.815049] RIP  [<ffffffff811408b8>] rtdm_event_timedwait+0x78/0x1a0
[  237.815053]  RSP <ffff88003a207d28>
[  237.815055] CR2: 00000000000000c0
[  237.815059] ---[ end trace af39d7f5f5df4bfd ]---
[  237.823941] Close Device NRT
[  237.914730] timer proc function
[  237.914735] rtdm_timer_start_in_handler returned 0
[  238.014707] timer proc function
[  238.014711] rtdm_timer_start_in_handler returned 0
[  238.114687] timer proc function
[  238.114690] rtdm_timer_start_in_handler returned 0
=2E.. goes on forever as the timer was not shut down properly.



Em qui 11 ago 2011, =C3=A0s 04:39:16, Gilles Chanteperdrix escreveu:
> On 08/10/2011 11:10 PM, Carlos Eduardo de Brito Novaes wrote:
> > Hello again.
> > I traced the errors down and now dicovered that calling printf (as it
> > would be) turns a real time task in a non real time one. so I chaged the
> > code and it is almost working as expected, except for something that now
> > seens to be some kind of bug. If I use any sord of
> > rtdm_event_[timed,]wait, the app returns and there is a trace on kernel
> > about a null pointer, just after the call to wait. It seens similar with
> > <http://www.mail-archive.com/xenomai@xenomai.org>
> > And I there is no other references on google. So I will try to recompile
> > with some changes and maybe test with another kernel. Hope you can point
> > something I am running in a AMD Athlon(tm) 64 X2 Dual Core Processor
> > 4000+, kernel 2.6.38-8, ubuntu natty 11.04 and latest stable xenomai
> > source.
> > If it will help, I can send the code.
>=20
> Please try and reduce the code to a simple, self-contained test case
> which we can run to reproduce the issue. It is the only way we can help.

--Boundary-00=_ve+QOz1soO5YBoN
Content-Type: application/x-bzip-compressed-tar;
  name="testcase_wait_hang.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="testcase_wait_hang.tar.bz2"

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

--Boundary-00=_ve+QOz1soO5YBoN--

