Message-ID: <45CCF15F.806@domain.hid>
Date: Sat, 10 Feb 2007 00:10:39 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange deadlock.
References: <45CCCD10.9000008@domain.hid>
	<b647ffbd0702091314y5c452cd2wc48f126763b9b3@domain.hid>
In-Reply-To: <b647ffbd0702091314y5c452cd2wc48f126763b9b3@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Dmitry Adamushko =D0=C9=DB=C5=D4:

> Just to put aside a few (quite) weird assumptions :
>=20
> (1) did you have another task that has been using this mutex and has
> (somehow) exited by the moment of lockup?
there are only 2 task that has access to that mutex.

> (2) bus_monitor_proc[0] is created once and never
> exits_then_created_again while the program is running ?
all task starting from begining of program and never restart.

i renamed mutex name twice to avoid name misspelled access and move=20
throw the struct to avoid offset with another struct - nothing help.
i tried to increase stack size - not helped.

i try to move lock/unlock to macros and add some history logging.

Is possible next scenario:
1. task A lock mutex M
2. task A going to secondary mode
3. task A performing "long" io wait operation and some flags modified.
4. task B tries to lock mutex M
5. core find no task A, because its waiting in secondary mode or it=20
think that task A is zombie or due to flag modification it's do not=20
think task A is RT
6. mutex M is granted to task B
7. task A returns from secondary mode
8. task A unlock mutex M because it's owned
9. task B tries to unlock, and not properly cleared some flags due to=20
step 8.
10. task B tries to lock mutex
11. core see that task B currently not own mutex M and put it into wait=20
queue
12. task A tries to lock mutex.
13. core see that task B currently not own mutex M and put it into wait=20
queue
14. deadlock here.


BTW
at some moment i got a kernel oops, not very informative but...

Feb  9 23:26:02 dev-3 kernel: BUG: unable to handle kernel NULL pointer=20
dereference at virtual address 00000005
Feb  9 23:26:02 dev-3 kernel:  printing eip:
Feb  9 23:26:02 dev-3 kernel: c01b53b2
Feb  9 23:26:02 dev-3 kernel: *pde =3D 0ae5a001
Feb  9 23:26:02 dev-3 kernel: Oops: 0000 [#1]
Feb  9 23:26:02 dev-3 kernel: Modules linked in: ipv6 sunrpc dm_mirror=20
dm_mod lp parport_pc parport ohci1394 ieee1394 floppy snd_intel8x0=20
snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss i2c_i801=20
snd_seq_midi_event snd_seq i2c_core snd_seq_device snd_pcm_oss=20
snd_mixer_oss snd_pcm serio_raw snd_timer e100 snd mxser mii soundcore=20
snd_page_alloc
Feb  9 23:26:02 dev-3 kernel: CPU:    0
Feb  9 23:26:02 dev-3 kernel: EIP:    0060:[<c01b53b2>]    Not tainted VL=
I
Feb  9 23:26:02 dev-3 kernel: EFLAGS: 00210246   (2.6.17.14-xenomai #1)
Feb  9 23:26:02 dev-3 kernel: EIP is at remove_proc_entry+0x22/0x1b0
Feb  9 23:26:02 dev-3 kernel: eax: 00000000   ebx: c03a90f4   ecx:=20
ffffffff   edx: ce2bfb40
Feb  9 23:26:02 dev-3 kernel: esi: 00000004   edi: 00000005   ebp:=20
00000000   esp: cfec9e78
Feb  9 23:26:02 dev-3 kernel: ds: 007b   es: 007b   ss: 0068
Feb  9 23:26:02 dev-3 kernel: Process events/0 (pid: 3,=20
threadinfo=3Dcfec8000 task=3Dc1259030)
Feb  9 23:26:02 dev-3 kernel: Stack: cafed7a0 c01b51f1 0000033d 00008000=20
ce2bfb40 00000005 c03a90f4 00000004
Feb  9 23:26:02 dev-3 kernel:        ce2bfb40 00000000 c014476e ce2bfb40=20
cafeda20 c036352c c0363599 00000000
Feb  9 23:26:02 dev-3 kernel:        cff254a0 c036352c c0363599 ce2bfcc0=20
67f8acfc eaeb76d2 75bf19d4 c1e67be3
Feb  9 23:26:02 dev-3 kernel: Call Trace:
Feb  9 23:26:02 dev-3 kernel:  <c01b51f1> proc_register+0x31/0xe0=20
<c014476e> registry_proc_callback+0x17e/0x370
Feb  9 23:26:02 dev-3 kernel:  <c01644d0> free_hot_cold_page+0xc0/0x130=20
  <c022f956> memmove+0x36/0x40
Feb  9 23:26:02 dev-3 kernel:  <c017b1da> drain_array+0x7a/0xe0=20
<c034a5a4> schedule+0x2e4/0x690
Feb  9 23:26:02 dev-3 kernel:  <c034a5d8> schedule+0x318/0x690=20
<c0123930> run_workqueue+0x90/0x110
Feb  9 23:26:02 dev-3 kernel:  <c01445f0>=20
registry_proc_callback+0x0/0x370  <c0123e97> worker_thread+0x117/0x140
Feb  9 23:26:02 dev-3 kernel:  <c0111c30> default_wake_function+0x0/0x10=20
  <c0123d80> worker_thread+0x0/0x140
Feb  9 23:26:02 dev-3 kernel:  <c012676d> kthread+0x9d/0xd0  <c01266d0>=20
kthread+0x0/0xd0
Feb  9 23:26:02 dev-3 kernel:  <c0100cb5> kernel_thread_helper+0x5/0x10
Feb  9 23:26:02 dev-3 kernel: Code: 76 00 8d bc 27 00 00 00 00 55 57 56=20
53 83 ec 18 85 d2 89 54 24 10 89 44 24 14 0f 84 35 01 00 00 8b 7c 24 14=20
31 c0 b9 ff ff ff ff <f2> ae f7 d1 49 8b 5c 24 10 89 cd 83 c3 38 8b 3b=20
85 ff 0f 84 c8
Feb  9 23:26:02 dev-3 kernel: EIP: [<c01b53b2>]=20
remove_proc_entry+0x22/0x1b0 SS:ESP 0068:cfec9e78


--=20
________________________________________
Maksym Veremeyenko

