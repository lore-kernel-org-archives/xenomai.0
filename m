Message-ID: <4BB5C032.1020808@domain.hid>
Date: Fri, 02 Apr 2010 12:00:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>	
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>	
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>	
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>	
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
In-Reply-To: <4BB5BA2D.1080604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig84E8D3E7A153DE6DD818070E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig84E8D3E7A153DE6DD818070E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Henri Roosen wrote:
>> Ok, I might give Jan's proposal a try and could be sufficient for us:a=

>> Xenomai thread with non-RT scheduling class (didn't know that was
>> possible).
>>
>> We just need the thread in the Xenomai domain for being able to access=

>> Xenomai resources, but want it to be scheduled together with the Linux=

>> nice levels. A near IDLE nice level should be ok. We just don't want
>> that our Xenomai 'idle' thread with a while(1) would prevent Linux to
>> run.
>=20
> That will happen with SCHED_OTHER if while(1) occurs while running in
> primary mode.
>=20

Indeed. But that's in fact a deficit of our mapping of non-RT sched
policies on the Xenomai scheduler. We should not leave, e.g., a
SCHED_OTHER thread migrated in primary as long as it does not hold any
resources. We can't perform SCHED_OTHER scheduling in Xenomai, we have
to push this to Linux.

Jan


--------------enig84E8D3E7A153DE6DD818070E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1wDUACgkQitSsb3rl5xTVXQCeKw/xmvS9oLkYp38yUnT2Mt2j
bxoAoOJX2YPJLGbef0+n1b71UFIoD/dh
=HnVH
-----END PGP SIGNATURE-----

--------------enig84E8D3E7A153DE6DD818070E--

