From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
Date: Fri, 10 Feb 2006 18:58:20 -0200
References: <43EBD9D6.5090404@domain.hid> <43EBE032.40302@domain.hid>
In-Reply-To: <43EBE032.40302@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602101858.21108.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Jan, I started the tests and had problems on unloading the module.

I am probably doing something wrong but I think the driver shouldn't crash.
Probably it is missing some sanity checks on rtdm_munmap like=20

if (! (user_info && user_info->mm))
	return -EXXX;

I'll investigate the problems... I had some unexpected things to investigat=
e=20
today and haven't had enought time to test the patch but hopefully I'll do =
it=20
on monday...

That was the result:

Unable to handle kernel NULL pointer dereference at virtual address 00000030
 printing eip:
e0a1f2fc
*pde =3D 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: rt_dt3153 parport_pc lp parport af_packet nls_iso8859_1 =

nls_cp437 v4l2_common videodev video_buf xeno_rtdm xeno_native xeno_nucleus=
=20
snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_s=
eq=20
snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss=20
snd_mixer_oss snd_pcm e100 mii snd_timer evdev snd soundcore snd_page_alloc=
=20
hw_random i2c_i801 i2c_core ehci_hcd intel_agp agpgart ide_cd uhci_hcd=20
usbcore cdrom
CPU:    0
EIP:    0060:[<e0a1f2fc>]    Not tainted VLI
EFLAGS: 00010286   (2.6.15.4-adeos)
EIP is at rtdm_munmap+0x11/0x44 [xeno_rtdm]
eax: 00000030   ebx: d2e45a70   ecx: 00000000   edx: ffff0001
esi: bfd72660   edi: 00000880   ebp: c2b20000   esp: c2b21f4c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 4254, threadinfo=3Dc2b20000 task=3Dd70bf550)
Stack: e0bfafa0 bfd72660 e0bf7cbc d2e45a70 b7d92000 00096000 e0bfad80 c0132=
e0d
       645f7472 35313374 c0320033 00000246 c03fa4cc c013c881 00000021 c0324=
200
       00000246 c2b21fbc 00000021 00000001 c0324200 bfd72660 00d72660 00000=
000
Call Trace:
 [<e0bf7cbc>] cleanup_module+0x24/0x50 [rt_dt3153]
 [<c0132e0d>] sys_delete_module+0x12e/0x15f
 [<c013c881>] __ipipe_dispatch_event+0x56/0xd5
 [<c0102fc8>] syscall_call+0x7/0xb
Code: 5f 89 e8 81 fd 18 fc ff ff 77 08 8b 5c 24 2c 89 2b 31 c0 59 5b 5b 5e =
5f=20
5d c3 56 53 8b 5c 24 0c 8b 4b 78 8d 41 30 ba 01 00 ff ff <0f> c1 10 85 d2 7=
5=20
4c ff 74 24 14 ff 74 24 14 ff 73 78 e8 2f 02

Regards,

Rodrigo.

____________________________________________________________
Em Quinta 09 Fevereiro 2006 22:37, Jan Kiszka escreveu:

>Jan Kiszka wrote:
>> Hi all,
>>
>> this is a first attempt to add the requested mmap functionality to the
>> RTDM driver API.
>
>... and this version is even more useful than the previous one (now with
>EXPORT_SYMBOL!). Be warned: I just compiled it, I count on third-party
>testers.
>
>Jan

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


