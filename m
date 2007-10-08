Message-ID: <470AB8DA.5000408@domain.hid>
Date: Tue, 09 Oct 2007 01:10:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>	<470A6B28.7020009@domain.hid>
	<bc4264770710081116n5d49911ah6aa0831ebd9023ae@domain.hid>
In-Reply-To: <bc4264770710081116n5d49911ah6aa0831ebd9023ae@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58146A602EBA44CDAF2B6C4B"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58146A602EBA44CDAF2B6C4B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
>>> which adeos patch must I use?
>> There is none for this kernel on i386 (assuming this is your arch). Th=
e
>> easiest thing is to move forward to 2.6.22 - or you would have to
>> back-port that patch... ;)
> Ouch. How is that for bad luck.
>=20
>> Xenomai 2.4 is required for kernels beyond 2.6.20 anyway.
> Great.
>=20
>> But note that we are still sweeping out remaining bugs around this
>> kernel, see "Fix __ipipe_pin_range_globally" and "IO-APIC stall due to=

>> broken fasteoi handling" on Xenomai-core / Adeos-main. Moreover, today=
's
>> SVN breaks at least my test box. So you may want to wait a few days at=

>> least, until the dust (hopefully) settled down again.
> Not so great. But then, this at least gives me some time to upgrade to =
2.6.22

Just checked again: The problem is still limited to kernels with
CONFIG_HIGH_RES_TIMERS or CONFIG_NO_HZ. So you can already do your tests
with those features disabled and the two mentioned patches applied.

Jan


--------------enig58146A602EBA44CDAF2B6C4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHCrjeniDOoMHTA+kRAjX7AKCCUC30pbA2jMvmS1A7n8XX8Vq2iwCfY46J
oN39cqnU/4y8rNArGwZWDNU=
=ht9D
-----END PGP SIGNATURE-----

--------------enig58146A602EBA44CDAF2B6C4B--

