Message-ID: <48A3D595.9040607@domain.hid>
Date: Thu, 14 Aug 2008 08:49:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>	<48A12EA8.4070601@domain.hid>	<48A34D75.9090509@domain.hid>
	<48A359D4.9090002@domain.hid> <48A3D20B.2080509@domain.hid>
In-Reply-To: <48A3D20B.2080509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig317E9B29DEE5EC6D9310D2D8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [RTnet-users] e1000 & MSI
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Bernhard Pfund <bernhard@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, RTnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig317E9B29DEE5EC6D9310D2D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Bernhard Pfund wrote:
>>> Jan Kiszka wrote:
>>>> Please post the oops. Also include the Adeos patch version you are u=
sing
>>>> for this.
>>>>
>>>> Jan
>>>>
>>> Hi Jan
>>>
>>> Eventually I found the call that is responsible for the mess. It's
>>> basically not in the rt_e1000 driver when loaded, but the ioctl sent =
by
>>> rtifconfig (ifonfig of RTnet) when trying to activate the NIC. I enab=
led
>>> i-pipe debugging in the kernel and got the following. I also posted t=
he
>>> trace to the RTAI list, but maybe you've seen something similar befor=
e?
>> That's good that you forwarded it as this is an Adeos issue, not an RT=
AI
>> thing. Added the related list.
>>
>>> Bernhard
>>>
>>> Adeos is RTAI's hal-linux-2.6.26-x86-2.0-09.patch
>> OK.
>>
>>> I-pipe: Domain RTAI registered.
>>> RTAI[hal]: <magma> mounted over IPIPE-NOTHREADS 2.0-09.
>>> RTAI[hal]: compiled with gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7).
>>> RTAI[hal]: mounted (IPIPE-NOTHREADS, IMMEDIATE (INTERNAL IRQs VECTORE=
D),
>>> ISOL_CPUS_MASK: e).
>>> PIPELINE layers:
>>> f8936600 9ac15d93 RTAI 200
>>> c0737540 0 Linux 100
>>> RTAI[malloc]: global heap size =3D 4194304 bytes, <BSD>.
>>> RTAI[sched]: IMMEDIATE, MP, USER/KERNEL SPACE: <with RTAI OWN KTASKs>=
,
>>> kstacks pool size =3D 1048576 bytes.
>>> RTAI[sched]: hard timer type/freq =3D APIC/16666663(Hz); default timi=
ng:
>>> periodic; linear timed lists.
>>> RTAI[sched]: Linux timer freq =3D 1000 (Hz), CPU freq =3D 2400046000 =
hz.
>>> RTAI[sched]: timer setup =3D 999 ns, resched latency =3D 0 ns.
>>> RTAI[usi]: enabled.
>>> RTAI[rtai_msgq]: loaded.
>>> RTAI[mq]: loaded.
>>> RTDM started.
>>>
>>> *** RTnet 0.9.11 - built on Aug 13 2008 22:31:19 ***
>>>
>>> RTnet: initialising real-time networking
>>> Intel(R) PRO/1000 Network Driver - version 7.1.9
>>> Copyright (c) 1999-2006 Intel Corporation.
>>> ACPI: PCI Interrupt Link [APC8] enabled at IRQ 16
>>> ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [APC8] -> GSI 16 (level,
>>> low) -> IRQ 16
>>> PCI: Setting latency timer of device 0000:03:00.0 to 64
>>> e1000: 0000:03:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
>>> 00:1b:21:1e:56:64
>>> RTnet: registered rteth0
>>> e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network Connection
>>> I-pipe: Detected illicit call from domain 'RTAI'
>>>         into a service reserved for domain 'Linux' and below.
>>> Pid: 0, comm: swapper Not tainted 2.6.26.2-FuCS #3
>>>  [<c0156866>] ipipe_check_context+0xd6/0xf0
>>>  [<c03e202e>] <6>e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 M=
bps
>>> Full Duplex
>>> _spin_lock_irqsave+0x1e/0x80
>>>  [<c024a7a6>] pci_bus_read_config_word+0x36/0x80
>>>  [<c024c29e>] __pci_bus_find_cap_start+0x1e/0x50
>>>  [<c024c7f4>] pci_find_capability+0x24/0x50
>>>  [<c0254132>] msi_set_enable+0x22/0x80
>>>  [<c01176f3>] ? mcount+0x1f/0x23
>>>  [<c025444f>] msi_set_mask_bits+0xcf/0xe0
>>>  [<c01176f3>] ? mcount+0x1f/0x23
>>>  [<c02546f7>] unmask_msi_irq+0x17/0x30
>>>  [<c01542da>] default_enable+0x1a/0x30
>>>  [<f892f1ee>] rt_enable_irq+0xe/0x10 [rtai_hal]
>>>  [<f8dabd99>] ? xnintr_irq_handler+0x149/0x1f0 [rtai_rtdm]
>>>  [<f893164b>] rtai_hirq_dispatcher+0xfb/0x430 [rtai_hal]
>>>  [<c01021c5>] default_idle+0x45/0x60
>>>  [<c0102180>] default_idle+0x0/0x60
>>>  [<c0103cc7>] common_interrupt+0x2f/0x54
>>>  [<c0102180>] default_idle+0x0/0x60
>>>  [<c01500d8>] cgroup_file_write+0x118/0x140
>>>  [<c01021c5>] default_idle+0x45/0x60
>>>  [<c0101b76>] cpu_idle+0x86/0x140
>>>  [<c03dd7bd>] start_secondary+0x16d/0x210
>>>  [<c03d3a48>] initialize_secondary+0x8/0x20
>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>> I-pipe tracer log (100 points):
>>>  |  +*func                    0 ipipe_trace_panic_freeze+0x9
>>> (ipipe_check_context+0x94)
>>>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0=
x88)
>>>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0=
x88)
>>>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0=
x88)
>>>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>>>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0=
x88)
>>>  |  +*func                    0 find_first_bit+0xa (__first_cpu+0x12)=

>>>  |  +*func                   -1 __first_cpu+0x8
>>> (ipipe_check_context+0x66)
>>>  |  +*func                   -1 ipipe_check_context+0x14
>>> (_spin_lock_irqsave+0x1e)
>>>  |  +*func                   -1 _spin_lock_irqsave+0x12
>>> (pci_bus_read_config_word+0x36)
>>>  |  +*func                   -1 pci_bus_read_config_word+0x14
>>> (__pci_bus_find_cap_start+0x1e)
>>>  |  +*func                   -1 __pci_bus_find_cap_start+0xc
>>> (pci_find_capability+0x24)
>>>  |  +*func                   -1 pci_find_capability+0x11
>>> (msi_set_enable+0x22)
>>>  |  +*func                   -1 msi_set_enable+0x14
>>> (msi_set_mask_bits+0xcf)
>>>  |  +*func                   -1 msi_set_mask_bits+0xe
>>> (unmask_msi_irq+0x17)
>>>  |  +*func                   -1 unmask_msi_irq+0x9 (default_enable+0x=
1a)
>> I think to remember a similar issue biting the preempt-rt patch, and
>> that resulted in some activity to cache that capability information. /=
me
>> needs to dig into the archives, will let you know if I find something
>> (tomorrow, likely).
>=20
> Found it. Could you give this patch a try and report the result?
>=20
> http://permalink.gmane.org/gmane.linux.kernel/682362
>=20
> If it's ok, I guess we should include it in ipipe until someone (From
> -rt) manages to get it accepted upstream (I didn't recall much activity=

> in this direction yet, though).

Not true, the patch is in 2.6.27-rcX.

But there is also
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=3Dce6fce4295ba727b36fdc73040e444bd1aae64cd
which makes me wonder, for 2.6.27, if that may generate cases where
masking MSI interrupts will not work as expected for ipipe (Linux should
catch masked IRQs internally). However, future problems...

Jan


--------------enig317E9B29DEE5EC6D9310D2D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkij1ZkACgkQniDOoMHTA+nGrgCfTQvIRpAG5bAEL4e/FMjoktuv
dzkAnRwKBAKEo5Lw04wtlvE2uTMi6SE7
=+jX4
-----END PGP SIGNATURE-----

--------------enig317E9B29DEE5EC6D9310D2D8--

