Message-ID: <4710FE9F.6090103@domain.hid>
Date: Sat, 13 Oct 2007 19:21:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>	
	<470A6B28.7020009@domain.hid>	
	<bc4264770710081116n5d49911ah6aa0831ebd9023ae@domain.hid>	
	<470AB8DA.5000408@domain.hid> <470B1CA2.8070509@domain.hid>	
	<470B247B.6060805@domain.hid> <1192225336.6499.170.camel@domain.hid>
	<4710FCAF.9060306@domain.hid>
In-Reply-To: <4710FCAF.9060306@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6328BB09FF55AA33FEA90383"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] adeos patch for 2.6.21
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6328BB09FF55AA33FEA90383
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
>>>
>>> http://search.gmane.org/?query=3DFix+__ipipe_pin_range_globally&group=
=3Dgmane.linux.real-time.xenomai.devel
>>>
>>>
>>> Alternatively, I attached both for you, adding a third one which is
>>> relevant if you use Xenomai with --enable-x86-sep.
>>
>> Warning: the fasteoi patch as inlined is incomplete, and has been fixe=
d
>> in the latest I-pipe release (i.e. 2.6.22-1.10-07, 2.6.20-1.10-06) --
>> spinlocking around the IO-APIC manipulation is missing.
>=20
> Is the adeos patch for 2.6.23 on its way? I believe the 2.6.23 kernel i=
s
> released as stable.

Check my posting to xenomai-core. This is not yet the official ipipe
release for that kernel, but that shall not stop you from testing and
reporting.

Jan


--------------enig6328BB09FF55AA33FEA90383
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHEP6iniDOoMHTA+kRArveAJ4rSoopg/RgvHBV+oo4S1PHLxObVgCfaXrP
ARpCVNAuqyAclv6soBdHHQc=
=pREy
-----END PGP SIGNATURE-----

--------------enig6328BB09FF55AA33FEA90383--

