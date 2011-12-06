MIME-Version: 1.0
In-Reply-To: <4ED79747.10809@domain.hid>
References: <4ED66FD7.4010403@domain.hid> <4ED79747.10809@domain.hid>
Date: Tue, 6 Dec 2011 23:47:52 +0100
Message-ID: <CAMesUR5gouRy88TV3YZqnuZ-OFVpO5uTSFergNuuvQaC=1MGVQ@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Analogy/mite
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi

On Thu, Dec 1, 2011 at 4:03 PM, Anders Blomdell
<anders.blomdell@domain.hid> wrote:
> On 11/30/2011 07:03 PM, Anders Blomdell wrote:
>>
>> Hi, just found that
>>
>> echo 0000:06:01.0 > /sys/bus/pci/drivers/analogy_mite/unbind
>>
>> does not do the same thing as
>>
>> analogy_config -r analogyN
>>
>> in fact it leaves the system in a state where using the driver results
>> in a kernel OOPS.
>>
>> Will try to look into it further tomorrow...
>
> OK seems like we have some interrupt cleanup problem, the following comma=
nd
> sequence:
>

OK thank you for the report. I did not have time to look at it yet but
that will be done soon.

Is it blocking for you?

Alexis.

> modprobe xeno_native
> modprobe analogy_ni_pcimio
> sleep 1
> /usr/local/sbin/analogy_config analogy0 analogy_ni_pcimio 6,1
> /usr/local/sbin/analogy_config -r analogy0
> rmmod analogy_ni_pcimio
> rmmod analogy_ni_mio
> rmmod analogy_ni_tio
> rmmod analogy_8255
> rmmod analogy_ni_mite
> rmmod xeno_analogy
>
> sleep 2
>
> modprobe xeno_native
> modprobe analogy_ni_pcimio
> sleep 1
> /usr/local/sbin/analogy_config analogy0 analogy_ni_pcimio 6,1
>
> Gives:
>
> [ =A0412.623639] Analogy: MITE: Available NI device IDs: 0x70af
> [ =A0413.648335] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-622=
1
> board
> [ =A0413.676105] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 22
> [ =A0413.682385] BUG: unable to handle kernel paging request at f8bc4bf4
> [ =A0413.683367] IP: [<f8846efe>] xnintr_attach+0x6e/0xfe [xeno_nucleus]
> [ =A0413.683367] *pdpt =3D 0000000000aca001 *pde =3D 0000000031ca5067 *pt=
e =3D
> 0000000000000000
> [ =A0413.683367] Oops: 0000 [#1] SMP
> [ =A0413.683367] last sysfs file: /sys/bus/pci/drivers/analogy_mite/ueven=
t
> [ =A0413.683367] Modules linked in: analogy_ni_pcimio analogy_ni_mio
> analogy_ni_tio analogy_8255 analogy_ni_mite xeno_analogy xeno_native nfs
> fscache snd_hda_codec_idt snd_hda_intel snd_hda_codec snd_hwdep snd_seq
> snd_seq_device snd_pcm snd_timer snd soundcore rt_e1000 rt_e1000_new rtne=
t
> xeno_rtdm nfsd lockd nfs_acl auth_rpcgss xeno_nucleus snd_page_alloc ppde=
v
> iTCO_wdt iTCO_vendor_support microcode sunrpc exportfs i2c_i801 pcspkr
> serio_raw e1000e parport_pc parport uinput ipv6 firewire_ohci firewire_co=
re
> ata_generic pata_acpi crc_itu_t pata_marvell i915 drm_kms_helper drm
> i2c_algo_bit i2c_core video [last unloaded: xeno_analogy]
> [ =A0413.683367]
> [ =A0413.683367] Pid: 1579, comm: analogy_config Not tainted
> 2.6.38.8.xenomai.2.6.0.rtnet.26db745.20111130.1211 #1 /DG965SS
> [ =A0413.683367] EIP: 0060:[<f8846efe>] EFLAGS: 00010286 CPU: 1
> [ =A0413.683367] EIP is at xnintr_attach+0x6e/0xfe [xeno_nucleus]
> [ =A0413.683367] EAX: f8bc4be4 EBX: f87d2be4 ECX: 00000001 EDX: 00000003
> [ =A0413.683367] ESI: f885b840 EDI: fffffff0 EBP: f169ddf4 ESP: f169dde0
> [ =A0413.683367] =A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> [ =A0413.683367] Process analogy_config (pid: 1579, ti=3Df169c000 task=3D=
f40925e0
> task.ti=3Df169c000)
> [ =A0413.683367] I-pipe domain Linux
> [ =A0413.683367] Stack:
> [ =A0413.683367] =A0205bde08 00000001 f87d2be4 00000000 00000001 f169de10
> f89a0c91 f87cea28
> [ =A0413.683367] =A000000000 00000001 f87d2bd8 00000000 f169de28 f87ceb64
> 00000001 f87d134f
> [ =A0413.683367] =A0f87d2bd8 f87d2bb8 f169de44 f87cf727 00000001 f87d2bb8
> 00000016 f87d2bb8
> [ =A0413.683367] Call Trace:
> [ =A0413.683367] =A0[<f89a0c91>] rtdm_irq_request+0x37/0x5a [xeno_rtdm]
> [ =A0413.683367] =A0[<f87cea28>] ? a4l_handle_irq+0x0/0x1f [xeno_analogy]
> [ =A0413.683367] =A0[<f87ceb64>] __a4l_request_irq+0x38/0x3e [xeno_analog=
y]
> [ =A0413.683367] =A0[<f87cf727>] a4l_request_irq+0x67/0xad [xeno_analogy]
> [ =A0413.683367] =A0[<f86b1593>] pcimio_attach+0x4e0/0x53e [analogy_ni_pc=
imio]
> [ =A0413.683367] =A0[<f87cde93>] a4l_assign_driver+0x73/0x100 [xeno_analo=
gy]
> [ =A0413.683367] =A0[<f87cdfd9>] a4l_device_attach+0x59/0x6e [xeno_analog=
y]
> [ =A0413.683367] =A0[<f87ce0d7>] a4l_ioctl_devcfg+0xbd/0xf6 [xeno_analogy=
]
> [ =A0413.683367] =A0[<f87cf943>] a4l_ioctl+0x1e/0x20 [xeno_analogy]
> [ =A0413.683367] =A0[<f899fa5a>] __rt_dev_ioctl+0x4d/0x104 [xeno_rtdm]
> [ =A0413.683367] =A0[<c07c35b6>] ? do_page_fault+0x2f7/0x322
> [ =A0413.683367] =A0[<f89a1a85>] sys_rtdm_ioctl+0x2e/0x30 [xeno_rtdm]
> [ =A0413.683367] =A0[<f8851414>] losyscall_event+0xb1/0x174 [xeno_nucleus=
]
> [ =A0413.683367] =A0[<c04887ab>] __ipipe_dispatch_event+0xcb/0x17a
> [ =A0413.683367] =A0[<f8851363>] ? losyscall_event+0x0/0x174 [xeno_nucleu=
s]
> [ =A0413.683367] =A0[<c0415b32>] __ipipe_syscall_root+0x50/0xc9
> [ =A0413.683367] =A0[<c07c0a21>] system_call+0x2d/0x53
> [ =A0413.683367] Code: 00 e8 73 ff ff ff 8b 4b 10 f7 c1 00 00 01 00 89 45=
 f0
> 0f 85 92 00 00 00 8b 73 14 c1 e6 06 81 c6 c0 b2 85 f8 8b 46 24 85 c0 74 2=
5
> <8b> 50 10 89 ce 21 d6 83 e6 01 74 73 8b 73 18 39 70 18 75 6b 31
> [ =A0413.683367] EIP: [<f8846efe>] xnintr_attach+0x6e/0xfe [xeno_nucleus]
> SS:ESP 0068:f169dde0
> [ =A0413.683367] CR2: 00000000f8bc4bf4
>
>
>
>
>>
>> /Anders
>
>
>
> --
> Anders Blomdell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Email: anders.blomdell=
@control.lth.se
> Department of Automatic Control
> Lund University =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Phone: =A0 =A0+46 46 2=
22 4625
> P.O. Box 118 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Fax: =A0 =A0 =A0+46 =
46 138118
> SE-221 00 Lund, Sweden
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

