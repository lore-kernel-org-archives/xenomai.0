Message-ID: <44C9D75C.8000906@domain.hid>
Date: Fri, 28 Jul 2006 11:22:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] configuration of pentium III 1GHz
References: <e325d110607280158w436c5d53k5f0e3cee4b6015d9@domain.hid>
In-Reply-To: <e325d110607280158w436c5d53k5f0e3cee4b6015d9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig675C9491D7C27FB9E5462476"
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
--------------enig675C9491D7C27FB9E5462476
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kim Chuan Lim wrote:
> Hi ya,
>=20
> I managed to install and run all the xenomai test program int my
> pentium IV machine and i decided to install it in another slower
> pentium III 1GHz machine.
> The following is some details of my config.gz at pentium III machine.
>=20
> #
> # Real-time sub-system
> #
> CONFIG_XENOMAI=3Dy
> CONFIG_XENO_OPT_NUCLEUS=3Dy
> CONFIG_XENO_OPT_PERVASIVE=3Dy
> # CONFIG_XENO_OPT_ISHIELD is not set
> # CONFIG_XENO_OPT_RPIDISABLE is not set
> CONFIG_XENO_OPT_SECURITY_ACCESS=3Dy
> CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
> CONFIG_XENO_OPT_PIPE=3Dy
> CONFIG_XENO_OPT_PIPE_NRDEV=3D32
> CONFIG_XENO_OPT_REGISTRY=3Dy
> CONFIG_X
> ENO_OPT_REGISTRY_NRSLOTS=3D512
> CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
> CONFIG_XENO_OPT_STATS=3Dy
> # CONFIG_XENO_OPT_DEBUG is not set
> # CONFIG_XENO_OPT_WATCHDOG is not set
>=20
> #
> # Timing
> #
> # CONFIG_XENO_OPT_TIMING_PERIODIC is not set
> CONFIG_XENO_OPT_TIMING_PERIOD=3D0
> CONFIG_XENO_OPT_TIMING_TIMERLAT=3D0
> CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0
>=20
> #
> # SMI workaround
> #
> # CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
> CONFIG_XENO_HW_SMI_DETECT=3Dy
> CONFIG_XENO_HW_SMI_WORKAROUND=3Dy
> CONFIG_XENO_HW_SMI_ALL=3Dy
>=20
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=3Dy
> CONFIG_PM_LEGACY=3Dy
> # CONFIG_PM_DEBUG is not set
> CONFIG_SOFTWARE_SUSPEND=3Dy
> CONFIG_PM_STD_PARTITION=3D""
>=20
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=3Dy
> # CONFIG_ACPI_SLEEP is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> # CONFIG_ACPI_BUTTON is not set
> # CONFIG_ACPI_VIDEO is not set
> # CONFIG_ACPI_HOTKEY is not set
> # CONFIG_ACPI_FAN is not set
> # CONFIG_ACPI_PROCESSOR is not set
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_CUSTOM_DSDT is not set
> CONFIG_ACPI_BLACKLIST_YEAR=3D0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_SYSTEM=3Dy
> CONFIG_X86_PM_TIMER=3Dy
> # CONFIG_ACPI_CONTAINER is not set
>=20
> #
> # APM (Advanced Power Management) BIOS Support
> #
> # CONFIG_APM is not set
>=20
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
>=20
> Linux version 2.6.17-default (engkcl@domain.hid) (gcc version 3.3.5 20050117
> (prerelease) (SUSE Linux)) #3 Thu Jul 27 16:48:49 BST 2006

Looks to me like you patched a SuSE kernel with I-pipe, did you? I'm
also running SuSE, but I always use a vanilla kernel as platform for
Xenomai. The config can be migrated from the original system (except for
the known ACPI / CPU-freq issues).

>=20
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.2-rc3 (Engines Of Creation) loaded.

Time to upgrade, 2.2 is out :). BTW, there is one potentially relevant
fix even post 2.2: if you have CONFIG_DEBUG_SPINLOCK on, switch it off
or upgrade to I-pipe 1.3-08.

> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
>=20
> The test program at /usr/xenomai/testsuite crashed my computer
> everytime i running it.
> May i know did i forget anything??

If you did use a vanilla kernel: any chance to grab the oops after the
crash? Or is it a hard lock-up? The best to get those oopses out are
serial console redirection or netconsole, see
linux/Documentation/serial-console.txt or
linux/Documentation/networking/netconsole.txt.

Jan


--------------enig675C9491D7C27FB9E5462476
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEyddcniDOoMHTA+kRAkemAJsGys0ZD5VhRLl9uSSnij9BearelgCfZ8bv
jM3ZrS5fszPSmKiT6iPY4RM=
=zRgz
-----END PGP SIGNATURE-----

--------------enig675C9491D7C27FB9E5462476--

