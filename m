From: Ali Umair <ali.umair@tut.fi>
Date: Wed, 1 Jun 2016 12:15:57 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A739854@mb2010-1.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] rtdm_timer_start causes switching to secondary mode and
	Bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello

I am using 3.14.39-xenomai-3.0.1. I am trying following

Kernel module:
- Make a buffer i.e. char  buffer[4000][126] and initializing the buffer us=
ing memset in the initial thread
- Filled the buffer in the read thread of module=20
- After filling the buffer start the timer=20

As I start the timer after filling the buffer the kernel displays the messa=
ge that switching to secondary  mode and A bug. The whole message is end of=
 the email

In userspace
- Open the file and mmap that file
- send the 126 bytes to the kernel module for filling the buffer
- sleep for few nano seconds=20
- continues until all the file is read

Please guide me

Thanks BR
Ali


ERROR MESSAGES

[  415.177259] READ_PWM1: in the first loop and it ends [  415.177283] [Xen=
omai] switching raw_packet to secondary mode after exception #14 in kernel-=
space at 0xc1133361 (pid 3239) [  415.177361] BUG: unable to handle kernel =
paging request at 00002fd5 [  415.177484] IP: [<c1133361>] xntimer_start+0x=
51/0x450 [  415.177585] *pdpt =3D 000000002557b001 *pde =3D 000000000000000=
0 [  415.177682] Oops: 0002 [#1] PREEMPT SMP [  415.177757] Modules linked =
in: xeno_pwm_pcap(OF) rtnetproxy(F) rtcap(F) rt_loopback(F) rtcfg(F) tdma(F=
) rtmac(F) rtpacket(F) rtudp(F) rtipv4(F) bnep(F) rfcomm(F) bluetooth(F) 6l=
owpan_iphc(F) snd_hda_codec_realtek(F) snd_hda_codec_generic(F) hp_wmi(F) i=
915(F) snd_hda_intel(F) gpio_ich(F) hid_generic(F) snd_hda_codec(F) sparse_=
keymap(F) usbhid(F) snd_hwdep(F) snd_pcm(F) hid(F) snd_seq_midi(F) video(F)=
 snd_seq_midi_event(F) drm_kms_helper(F) snd_rawmidi(F) drm(F) snd_seq(F) s=
nd_seq_device(F) i2c_algo_bit(F) rt_8139too(F) snd_timer(F) serio_raw(F) rt=
net(F) lpc_ich(F) snd(F) wmi(F) soundcore(F) ppdev(F) shpchp(F) lp(F) mac_h=
id(F) parport_pc(F) parport(F) psmouse(F) pata_acpi(F) 8139too(F) 8139cp(F)=
 mii(F) floppy(F) tg3(F) ptp(F) pps_core(F) [last unloaded: xeno_pwm_pcap]
[  415.178437] CPU: 1 PID: 3239 Comm: raw_packet Tainted: GF          O 3.1=
4.39-xenomai-3.0.1 #4
[  415.178550] Hardware name: Hewlett-Packard HP Compaq dc7600 Convertible =
Minitower/09F0h, BIOS 786D1 v01.03 05/18/2005 [  415.178627] task: e8fd0000=
 ti: e5532000 task.ti: e5532000 [  415.178668] EIP: 0060:[<c1133361>] EFLAG=
S: 00010246 CPU: 1 [  415.178711] EIP is at xntimer_start+0x51/0x450 [  415=
.178745] EAX: 00000302 EBX: f8532460 ECX: ffff0302 EDX: 00002fd1 [  415.178=
791] ESI: 0003d090 EDI: f8532460 EBP: e5533ee0 ESP: e5533e98 [  415.178836]=
  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 [  415.178877] CR0: 8005003b=
 CR2: 00002fd5 CR3: 25480000 CR4: 000007f0 [  415.178923] I-pipe domain Lin=
ux [  415.178946] Stack:
[  415.178962]  00000000 a8da54cd f77b96c0 00000003 f4341040 f77c11b0 00000=
13b f77b9580 [  415.179042]  00000000 0003d090 00000000 f8532460 f77c11b0 0=
0000000 00000000 00000000 [  415.179120]  c1abab0c f8532460 e5533f18 c11412=
eb 0003d090 00000000 00000001 e5564c80 [  415.179199] Call Trace:
[  415.179226]  [<c11412eb>] rtdm_timer_start+0x6b/0x150 [  415.179268]  [<=
f84b51a0>] pwm_rtdm_read_nrt+0x130/0x1cf [xeno_pwm_pcap] [  415.179320]  [<=
c11430ac>] rtdm_fd_read+0x6c/0x1a0 [  415.179358]  [<c1145ab5>] ? CoBaLt_cl=
ock_nanosleep+0x55/0xa0 [  415.179403]  [<c1148360>] ? CoBaLt_ioctl+0x20/0x=
20 [  415.179442]  [<c114836d>] CoBaLt_read+0xd/0x10 [  415.179479]  [<c115=
59a2>] handle_head_syscall+0xd2/0x3d0 [  415.179521]  [<c1156364>] ipipe_fa=
stcall_hook+0x14/0x20 [  415.179564]  [<c167c8b6>] sysenter_past_esp+0x6b/0=
x77 [  415.179601] Code: c1 89 45 e8 8b 43 48 8b 40 0c 8b 04 85 00 92 9e c1=
 01 45 e8 3e 8d 74 26 00 8b 45 e4 8b 48 1c f6 c1 01 75 1f 8b 10 89 c3 8b 40=
 04 <89> 42 04 89 10 8b 4b 1c c7 03 00 01 10 00 c7 43 04 00 02 20 00 [  415=
.180023] EIP: [<c1133361>] xntimer_start+0x51/0x450 SS:ESP 0068:e5533e98 [ =
 415.180080] CR2: 0000000000002fd5 [  415.200334] ---[ end trace 31e8399e40=
7c0700 ]---


