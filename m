Message-ID: <4694ED98.6000000@domain.hid>
Date: Wed, 11 Jul 2007 16:47:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>
In-Reply-To: <4693A702.1010604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8497D7DCEE0BAB1278218B4F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
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
--------------enig8497D7DCEE0BAB1278218B4F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> M. Koehrer wrote:
>> Hi Jan,
>>
>> yes, it terminates nicely.
>> I have attached my config.
>=20
> Nothing obvious. Leaves us with probable timing differences or the
> different versions of our setups (I found this over 2.3.2 and trunk).

My posted issue is a classic race of self-terminating the native task on
CPU1 vs. remote-terminating it from CPU0. When the latter wins, things
fall apart. Some solution needs more thoughts.

Anyway, this issues is most probably unrelated to your bug.

>=20
> OK, further analysis on your side would be appreciated. E.g. trying the=

> latest release, switching on debug features in Xenomai like the NMI
> watchdog or nucleus debugging. Also, nailing down what service call
> precisely locks up (the join, the termination of the task, etc.) would
> be good to reduce the search space.
>=20

As you posted in a different mail, recent versions make no difference.
Could you now switch on the watchdog and nucleus debugging?

Thanks,
Jan


--------------enig8497D7DCEE0BAB1278218B4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGlO2YniDOoMHTA+kRAkSsAJ0avparkkJITWn+EPB+K4V95KX1iQCfVDvf
mOKVRLe6jx+Qnja2oJWfwYo=
=qJER
-----END PGP SIGNATURE-----

--------------enig8497D7DCEE0BAB1278218B4F--

