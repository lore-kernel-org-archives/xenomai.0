Message-ID: <48A359D4.9090002@domain.hid>
Date: Thu, 14 Aug 2008 00:01:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>
	<48A12EA8.4070601@domain.hid> <48A34D75.9090509@domain.hid>
In-Reply-To: <48A34D75.9090509@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5E5D406731FF3FF5229D5810"
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
--------------enig5E5D406731FF3FF5229D5810
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Bernhard Pfund wrote:
> Jan Kiszka wrote:
>> Please post the oops. Also include the Adeos patch version you are usi=
ng
>> for this.
>>
>> Jan
>>
>=20
> Hi Jan
>=20
> Eventually I found the call that is responsible for the mess. It's
> basically not in the rt_e1000 driver when loaded, but the ioctl sent by=

> rtifconfig (ifonfig of RTnet) when trying to activate the NIC. I enable=
d
> i-pipe debugging in the kernel and got the following. I also posted the=

> trace to the RTAI list, but maybe you've seen something similar before?=


That's good that you forwarded it as this is an Adeos issue, not an RTAI =

thing. Added the related list.

>=20
> Bernhard
>=20
> Adeos is RTAI's hal-linux-2.6.26-x86-2.0-09.patch

OK.

>=20
> I-pipe: Domain RTAI registered.
> RTAI[hal]: <magma> mounted over IPIPE-NOTHREADS 2.0-09.
> RTAI[hal]: compiled with gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7).
> RTAI[hal]: mounted (IPIPE-NOTHREADS, IMMEDIATE (INTERNAL IRQs VECTORED)=
,
> ISOL_CPUS_MASK: e).
> PIPELINE layers:
> f8936600 9ac15d93 RTAI 200
> c0737540 0 Linux 100
> RTAI[malloc]: global heap size =3D 4194304 bytes, <BSD>.
> RTAI[sched]: IMMEDIATE, MP, USER/KERNEL SPACE: <with RTAI OWN KTASKs>,
> kstacks pool size =3D 1048576 bytes.
> RTAI[sched]: hard timer type/freq =3D APIC/16666663(Hz); default timing=
:
> periodic; linear timed lists.
> RTAI[sched]: Linux timer freq =3D 1000 (Hz), CPU freq =3D 2400046000 hz=
=2E
> RTAI[sched]: timer setup =3D 999 ns, resched latency =3D 0 ns.
> RTAI[usi]: enabled.
> RTAI[rtai_msgq]: loaded.
> RTAI[mq]: loaded.
> RTDM started.
>=20
> *** RTnet 0.9.11 - built on Aug 13 2008 22:31:19 ***
>=20
> RTnet: initialising real-time networking
> Intel(R) PRO/1000 Network Driver - version 7.1.9
> Copyright (c) 1999-2006 Intel Corporation.
> ACPI: PCI Interrupt Link [APC8] enabled at IRQ 16
> ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [APC8] -> GSI 16 (level,
> low) -> IRQ 16
> PCI: Setting latency timer of device 0000:03:00.0 to 64
> e1000: 0000:03:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
> 00:1b:21:1e:56:64
> RTnet: registered rteth0
> e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> I-pipe: Detected illicit call from domain 'RTAI'
>         into a service reserved for domain 'Linux' and below.
> Pid: 0, comm: swapper Not tainted 2.6.26.2-FuCS #3
>  [<c0156866>] ipipe_check_context+0xd6/0xf0
>  [<c03e202e>] <6>e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 Mbp=
s
> Full Duplex
> _spin_lock_irqsave+0x1e/0x80
>  [<c024a7a6>] pci_bus_read_config_word+0x36/0x80
>  [<c024c29e>] __pci_bus_find_cap_start+0x1e/0x50
>  [<c024c7f4>] pci_find_capability+0x24/0x50
>  [<c0254132>] msi_set_enable+0x22/0x80
>  [<c01176f3>] ? mcount+0x1f/0x23
>  [<c025444f>] msi_set_mask_bits+0xcf/0xe0
>  [<c01176f3>] ? mcount+0x1f/0x23
>  [<c02546f7>] unmask_msi_irq+0x17/0x30
>  [<c01542da>] default_enable+0x1a/0x30
>  [<f892f1ee>] rt_enable_irq+0xe/0x10 [rtai_hal]
>  [<f8dabd99>] ? xnintr_irq_handler+0x149/0x1f0 [rtai_rtdm]
>  [<f893164b>] rtai_hirq_dispatcher+0xfb/0x430 [rtai_hal]
>  [<c01021c5>] default_idle+0x45/0x60
>  [<c0102180>] default_idle+0x0/0x60
>  [<c0103cc7>] common_interrupt+0x2f/0x54
>  [<c0102180>] default_idle+0x0/0x60
>  [<c01500d8>] cgroup_file_write+0x118/0x140
>  [<c01021c5>] default_idle+0x45/0x60
>  [<c0101b76>] cpu_idle+0x86/0x140
>  [<c03dd7bd>] start_secondary+0x16d/0x210
>  [<c03d3a48>] initialize_secondary+0x8/0x20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I-pipe tracer log (100 points):
>  |  +*func                    0 ipipe_trace_panic_freeze+0x9
> (ipipe_check_context+0x94)
>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x8=
8)
>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x8=
8)
>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x8=
8)
>  |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>  |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x8=
8)
>  |  +*func                    0 find_first_bit+0xa (__first_cpu+0x12)
>  |  +*func                   -1 __first_cpu+0x8 (ipipe_check_context+0x=
66)
>  |  +*func                   -1 ipipe_check_context+0x14
> (_spin_lock_irqsave+0x1e)
>  |  +*func                   -1 _spin_lock_irqsave+0x12
> (pci_bus_read_config_word+0x36)
>  |  +*func                   -1 pci_bus_read_config_word+0x14
> (__pci_bus_find_cap_start+0x1e)
>  |  +*func                   -1 __pci_bus_find_cap_start+0xc
> (pci_find_capability+0x24)
>  |  +*func                   -1 pci_find_capability+0x11
> (msi_set_enable+0x22)
>  |  +*func                   -1 msi_set_enable+0x14 (msi_set_mask_bits+=
0xcf)
>  |  +*func                   -1 msi_set_mask_bits+0xe (unmask_msi_irq+0=
x17)
>  |  +*func                   -1 unmask_msi_irq+0x9 (default_enable+0x1a=
)

I think to remember a similar issue biting the preempt-rt patch, and=20
that resulted in some activity to cache that capability information. /me =

needs to dig into the archives, will let you know if I find something=20
(tomorrow, likely).

>  |  +*func                   -2 default_enable+0x9 (rt_enable_irq+0xe
> [rtai_hal])
>  |  +*func                   -2 alloc_rtskb+0x14 [rtnet]
> (e1000_alloc_rx_buffers+0x147 [rt_e1000])
>  |  +*func                   -2 e1000_alloc_rx_buffers+0xe [rt_e1000]
> (e1000_intr+0x37d [rt_e1000])
>  |  +*func                   -5 e1000_intr+0x11 [rt_e1000]
> (xnintr_irq_handler+0x9e [rtai_rtdm])
>  |  +*func                   -5 xnintr_irq_handler+0xe [rtai_rtdm]
> (rtai_hirq_dispatcher+0xfb [rtai_hal])
>  |  +*func                   -5 ack_ioapic_irq+0x8
> (__ipipe_ack_edge_irq+0xe)
>  |  +*func                   -6 __ipipe_ack_edge_irq+0x8
> (__ipipe_ack_irq+0x19)
>  |  +*func                   -6 __ipipe_ack_irq+0x8
> (rtai_hirq_dispatcher+0x66 [rtai_hal])
>  |   +begin   0xffffff23     -6 common_interrupt+0x29 (default_idle+0x4=
5)
>      +end     0x8000000e   -600 default_idle+0x43 (cpu_idle+0x86)
>      +func                 -600 default_idle+0x8 (cpu_idle+0x86)
>  |   +end     0x80000001   -600 ipipe_suspend_domain+0xd7 (cpu_idle+0x8=
4)
>  |   #begin   0x80000001   -600 ipipe_suspend_domain+0xee (cpu_idle+0x8=
4)
>      #func                 -600 ipipe_suspend_domain+0xe (cpu_idle+0x84=
)
>      +func                 -601 ipipe_check_context+0x14 (cpu_idle+0x5b=
)
>      +func                 -601 ipipe_check_context+0x14
> (_spin_unlock_irqrestore+0x23)
>  |   +end     0x80000000   -601 __ipipe_unstall_root+0x4a
> (__ipipe_restore_root+0x27)
>  |   #begin   0x80000000   -601 __ipipe_unstall_root+0x5b
> (__ipipe_restore_root+0x27)
>      #func                 -601 __ipipe_unstall_root+0x8
> (__ipipe_restore_root+0x27)
>      #func                 -601 __ipipe_restore_root+0x8
> (_spin_unlock_irqrestore+0x3d)
>      #func                 -601 _spin_unlock_irqrestore+0x8
> (rcu_check_callbacks+0x5c)
>      #func                 -601 __rcu_advance_callbacks+0x8
> (rcu_check_callbacks+0x35)
>      #func                 -601 ipipe_check_context+0x14
> (_spin_lock_irqsave+0x49)
>      +func                 -602 ipipe_check_context+0x14
> (_spin_lock_irqsave+0x1e)
>      +func                 -602 _spin_lock_irqsave+0x12
> (rcu_check_callbacks+0x2c)
>      +func                 -602 rcu_check_mb+0x8 (rcu_check_callbacks+0=
x1b)
>      +func                 -602 rcu_check_callbacks+0xa (cpu_idle+0xb2)=

>      +func                 -602 rcu_pending+0x8 (cpu_idle+0xa5)
>  |   +end     0x8000000d   -602 __ipipe_unstall_iret_root+0x36
> (restore_nocheck_notrace+0x0)
>  |   #func                 -602 __ipipe_unstall_iret_root+0x9
> (restore_nocheck_notrace+0x0)
>  |   #end     0xffffff15   -602 ipipe_ipiX+0x3e (default_idle+0x45)
>  |   +end     0x8000000d   -603 __ipipe_unstall_iret_root+0x36
> (restore_nocheck_notrace+0x0)
>  |   #func                 -603 __ipipe_unstall_iret_root+0x9
> (restore_nocheck_notrace+0x0)
>      #func                 -605 __ipipe_do_critical_sync+0x9
> (__ipipe_sync_stage+0x27b)
>  |   #end     0x80000000   -606 __ipipe_sync_stage+0x21f
> (rtai_hirq_dispatcher+0x3a1 [rtai_hal])
>  |   +func                 -606 __ipipe_sync_stage+0xe
> (rtai_hirq_dispatcher+0x3a1 [rtai_hal])
>  |   #func                 -606 __ipipe_ack_apic+0x8
> (rtai_hirq_dispatcher+0x257 [rtai_hal])
>  |   +begin   0xffffff15   -606 ipipe_ipiX+0x2e (default_idle+0x45)
>      +end     0x8000000e  -113749 default_idle+0x43 (cpu_idle+0x86)
>      +func                -113749 default_idle+0x8 (cpu_idle+0x86)
>  |   +end     0x80000001  -113749 ipipe_suspend_domain+0xd7 (cpu_idle+0=
x84)
>  |   #begin   0x80000001  -113749 ipipe_suspend_domain+0xee (cpu_idle+0=
x84)
>      #func                -113749 ipipe_suspend_domain+0xe (cpu_idle+0x=
84)
>      +func                -113749 ipipe_check_context+0x14 (cpu_idle+0x=
5b)
>      +func                -113749 rcu_pending+0x8 (cpu_idle+0xa5)
>  |   +end     0x80000000  -113750 __ipipe_unstall_root+0x4a
> (__ipipe_restore_root+0x27)
>  |   #begin   0x80000000  -113750 __ipipe_unstall_root+0x5b
> (__ipipe_restore_root+0x27)
>      #func                -113750 __ipipe_unstall_root+0x8
> (__ipipe_restore_root+0x27)
>      #func                -113750 __ipipe_restore_root+0x8
> (tick_nohz_stop_sched_tick+0x23b)
>      #func                -113750 ipipe_check_context+0x14
> (hrtimer_start+0xe1)
>      #func                -113750 ipipe_check_context+0x14
> (_spin_unlock_irqrestore+0x23)
>      #func                -113750 __ipipe_restore_root+0x8
> (_spin_unlock_irqrestore+0x19)
>      #func                -113750 _spin_unlock_irqrestore+0x8
> (hrtimer_start+0xd2)
>      #func                -113750 ipipe_check_context+0x14
> (hrtimer_start+0xba)
>      #func                -113750 rb_insert_color+0xe (enqueue_hrtimer+=
0x7d)
>      #func                -113751 lapic_next_event+0x8
> (clockevents_program_event+0x9e)
>      #func                -113751 clockevents_program_event+0x14
> (tick_program_event+0x44)
>      #func                -113751 set_normalized_timespec+0x8
> (ktime_get_ts+0x43)
>      #func                -113751 native_read_tsc+0x8 (read_tsc+0xe)
>      #func                -113751 read_tsc+0x9 (getnstimeofday+0x48)
>      #func                -113751 getnstimeofday+0xe (ktime_get_ts+0x22=
)
>      #func                -113751 ktime_get_ts+0xa (ktime_get+0x1e)
>      #func                -113751 ktime_get+0x14 (tick_program_event+0x=
29)
>      #func                -113751 tick_program_event+0xe
> (hrtimer_reprogram+0x86)
>      #func                -113751 hrtimer_reprogram+0x14
> (enqueue_hrtimer+0xaa)
>      #func                -113751 enqueue_hrtimer+0xe (hrtimer_start+0x=
ad)
>      #func                -113752 rb_erase+0xe (__remove_hrtimer+0x57)
>      #func                -113752 hrtimer_force_reprogram+0xa
> (__remove_hrtimer+0x83)
>      #func                -113752 rb_next+0x9 (__remove_hrtimer+0x5e)
>      #func                -113752 __remove_hrtimer+0x16
> (hrtimer_start+0x123)
>      #func                -113752 ipipe_check_context+0x14
> (_spin_lock_irqsave+0x49)
>      #func                -113752 ipipe_check_context+0x14
> (_spin_lock_irqsave+0x1e)
>      #func                -113752 _spin_lock_irqsave+0x12
> (lock_hrtimer_base+0x28)
>      #func                -113752 lock_hrtimer_base+0x16
> (hrtimer_start+0x1e)
>      #func                -113752 hrtimer_start+0xe
> (tick_nohz_stop_sched_tick+0x255)
>      #func                -113753 hweight32+0x8
> (select_nohz_load_balancer+0x58)
>      #func                -113753 hweight32+0x8
> (select_nohz_load_balancer+0x4a)
>      #func                -113753 select_nohz_load_balancer+0xa
> (tick_nohz_stop_sched_tick+0x287)
>      #func                -113753 rcu_needs_cpu+0x8
> (tick_nohz_stop_sched_tick+0x13c)
>      #func                -113753 ipipe_check_context+0x14
> (_spin_unlock_irqrestore+0x23)
>      #func                -113753 __ipipe_restore_root+0x8
> (_spin_unlock_irqrestore+0x19)

Jan


--------------enig5E5D406731FF3FF5229D5810
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkijWdQACgkQniDOoMHTA+le2ACePIWE2ge+mrgGSXj+pvGH0wD9
h3IAoIN98WdjPQtTeBoMaybhnr1D3XDG
=8LP2
-----END PGP SIGNATURE-----

--------------enig5E5D406731FF3FF5229D5810--

