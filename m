Message-ID: <458ABB47.1070600@domain.hid>
Date: Thu, 21 Dec 2006 17:50:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Re: Re: Re: Re: A fairly small rtnet/Xenomai
References: <1166710393.4960.13.camel@domain.hid>	<b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>	<b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>	<2579704.1166520394117.JavaMail.ngmail@domain.hid>	<4383100.1166529856857.JavaMail.ngmail@domain.hid>	<13529671.1166621136153.JavaMail.ngmail@domain.hid>	<15069404.1166690889417.JavaMail.ngmail@domain.hid>	<458A4DE0.5030005@domain.hid>	<2890274.1166696466862.JavaMail.ngmail@domain.hid>	<16382545.1166699974895.JavaMail.ngmail@domain.hid>	<1166700491.4936.5.camel@domain.hid>	<25528819.1166701882755.JavaMail.ngmail@domain.hid>	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<3878120.1166714345679.JavaMail.ngmail@domain.hid>
In-Reply-To: <3878120.1166714345679.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F53C03B3ADE3EAB680EB569"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F53C03B3ADE3EAB680EB569
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Philippe,
>=20
>> - does enabling CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP =
in
>> the kernel hacking section cause Linux warnings to appear while the te=
st
>> code runs over 2.6.19, before the box crashes?
>=20
> Unfortunately, I am not able to get the xeno_nucleus compiled when I ha=
ve the=20
> kernel hacking configuration set as proposed.=20
> The kernel linker complains about an undefined "tasklist_lock" in xeno_=
nucleus.ko
> Thus, I am not able to perform this test.

Since 2.6.18, tasklist_lock is no longer exported. Either i-pipe has to
take care for this or some other wakeup/locking mechanism in
xnshadow_signal_completion needs to be found. Building the nucleus
non-modular works around this.

Jan


--------------enig0F53C03B3ADE3EAB680EB569
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFirtHniDOoMHTA+kRAobFAJ9qRTf+RgA7VnclYrP1uIGzFsGuqgCfcjVy
w7jmSM0L6mS7x3TEMRZqxnM=
=f0NR
-----END PGP SIGNATURE-----

--------------enig0F53C03B3ADE3EAB680EB569--

