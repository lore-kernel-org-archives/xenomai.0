Message-ID: <44B75B1C.7070400@domain.hid>
Date: Fri, 14 Jul 2006 10:51:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT timer help
References: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>	<17590.14655.583084.480317@domain.hid>	<e325d110607130737j3011b167wef31d2bf8fa6fd42@domain.hid>	<17590.23816.918869.787019@domain.hid>	<e325d110607130902r6bdd04e4l1001f33e094d9d4a@domain.hid>	<17590.28495.53263.24303@domain.hid>	<e325d110607130946m47041caai13413b69288b71a1@domain.hid>	<17590.31244.141411.473429@domain.hid>	<e325d110607131026qdb0aac8p53bb9f1ddad58181@domain.hid>	<17590.40418.205139.609207@domain.hid>
	<e325d110607140124s58999affoe349860eeede0de4@domain.hid>
In-Reply-To: <e325d110607140124s58999affoe349860eeede0de4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB28D71981E4C750D7C35EA5B"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB28D71981E4C750D7C35EA5B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kim Chuan Lim wrote:
> dmesg..
>=20
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.2-rc3 (Engines Of Creation) loaded.
> Xenomai: SMI-enabled chipset found but SMI workaround not enabled (chec=
k
>         CONFIG_XENO_HW_SMI_WORKAROUND). You may encounter high
>         interrupt latencies!

Check the related configuration under Real-time sub-system -> Machine ->
SMI workaround. Switching it on is recommended (but shouldn't be the
reason for the strange timing - but who knows...).

> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
>=20
> Pentium 4 3.2GHz with HT.
> My current configuration only able to detect one CPU. :(

Again, HT is EVIL for real-time because it's only pseudo SMP. You cannot
reliably predict when central CPU resources are blocked by any of the
virtual CPUs. Thus, you may suffer from ugly priority inversions between
Linux running on one HT sub-core and Xenomai running on the other, but
both competing for shared resources.

> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
> stepping        : 9
> cpu MHz         : 3216.093
> cache size      : 512 KB
> physical id     : 0
> siblings        : 1
> core id         : 0
> cpu cores       : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe up
> cid xtpr
> bogomips        : 6440.74
>=20
>=20
> zcat /proc/config.gz
> I have disabled Power Management.
>=20
> #
> # Power management options (ACPI, APM)
> #
> # CONFIG_PM is not set
>=20
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> # CONFIG_ACPI is not set
>=20
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
>=20
> Please find the attachment for my /proc/config.gz
>=20

Some suggestions for tests:

 o switch on SMI workaround
 o switch off SMP, if that helps, re-enable but leave SCHED_SMT
   (hyperthreading) disabled
 o switch on ACPI, but leave ACPI_PROCESSOR off

Jan


PS: CONFIG_XENO_OPT_TIMING_PERIODIC is not required unless you really
base your timing on a periodically ticking timer instead of the default
one-shot high-resolution mode. Otherwise this switch only adds overhead.



--------------enigB28D71981E4C750D7C35EA5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEt1sfniDOoMHTA+kRAq86AJ9tHE/+M2JOuRveFMw4PgVggy5sZQCcDvx/
AHcF0ONOxuxG0HUro1rIUIw=
=kg1d
-----END PGP SIGNATURE-----

--------------enigB28D71981E4C750D7C35EA5B--

