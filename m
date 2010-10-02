Message-ID: <4CA6F849.3060301@domain.hid>
Date: Sat, 02 Oct 2010 11:15:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CA6D3C0.4010900@domain.hid> <4CA6F124.3090006@domain.hid>
In-Reply-To: <4CA6F124.3090006@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92E4113BB84EB42655B1916F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [git pull] Patch queue for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92E4113BB84EB42655B1916F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 02.10.2010 10:45, Daniele Nicolodi wrote:
> On 02/10/10 08:40, Jan Kiszka wrote:
>> The following changes since commit 5e7cfa5c25672e4478a721eadbd6f6c5b4f=
88a2f:
>>
>>   nucleus/sched: fix rescheduling bit test macros (2010-09-30 02:34:27=
 +0200)
>>
>> are available in the git repository at:
>>   git://git.xenomai.org/xenomai-jki.git for-2.5.x
>>
>> Jan Kiszka (8):
>>       RTDM: Protect xnshadow_ppd_get via nklock
>>       Fix symbolic status ouput of root threads
>>       Create watchdog as non-blockable timer
>>       native: Improve documentation of rt_task_join and rt_task_delete=

>>       x86: Add PCI ID of Series 5/3400 Intel chipset to SMI workaround=

>>       x86: Add PCI ID of 631xESB/632xESB/3100 Intel chipset to SMI wor=
karound
>>       x86: Add PCI ID of Intel ICH9M-E chipset to SMI workaround
>=20
> This patch reads:
>=20
> +#ifdef PCI_DEVICE_ID_INTEL_ICH9_1
> +#define PCI_DEVICE_ID_INTEL_ICH9_1 0x2917
> +#endif
>=20
> shouldn't it be #ifndef ... #define ... #endif instead?
>=20
>>       x86: Add PCI ID of Intel ICH9M chipset to SMI workaround
>=20
> Same for this one.

Indeed. Fixed in both branches, and I also cleaned up a typo in some
patch description. Updates pushed.

Thanks,
Jan


--------------enig92E4113BB84EB42655B1916F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkym+EsACgkQitSsb3rl5xQbyQCgo1dpH5QLItYNEk8yilxZ/jik
XgUAoJmFN6m5YIG9RsNpnTz2mKhEVjo2
=rYzW
-----END PGP SIGNATURE-----

--------------enig92E4113BB84EB42655B1916F--

