Message-ID: <4AF2911A.2050008@domain.hid>
Date: Thu, 05 Nov 2009 09:47:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <96eea0c80911042105r19d11a70w1d47de4427c00e58@domain.hid>
	<ddc6e05e0911042339i50e112c9x10e089206c7e9524@domain.hid>
In-Reply-To: <ddc6e05e0911042339i50e112c9x10e089206c7e9524@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE8BB9395DEFC7365FE14FE2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] real-time parallel port communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Remco den Breeje <remco@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor <peter.pastor@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE8BB9395DEFC7365FE14FE2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Remco den Breeje wrote:
> On Thu, Nov 5, 2009 at 6:05 AM, Peter Pastor <peter.pastor@domain.hid> w=
rote:
>> Hello there,
>>
>> I need to get real-time communication over a parallel port working. I =
got
>> the serial port to run in real-time using the drivers provided by xeno=
mai.
>> However, I haven't found similar drivers for the parallel port yet. Do=
es the
>> new analogy branch contain real-time drivers for the parallel port ??
>>
>> I would be happy for any hints. Also, would be cool if somebody could =
point
>> me to some example programs.
>>
>> Thanks,
>>  peter
>>
>=20
> outb(char, 0x378) works for me. Or do you need something more fancy?

Interrupt handling, I bet. User space drivers are feasible, but can have
poor re-use factors.

I think the key to a parallel port driver is an RTDM device profile that
matches more than one use case. Suggestions welcome.

Jan


--------------enigEE8BB9395DEFC7365FE14FE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrykRoACgkQitSsb3rl5xTedwCfY6hFV3tcF1JlmS4yCckaN79o
wbIAoLA2IYsiVwwAr81biYXoW0u/zho+
=1IDs
-----END PGP SIGNATURE-----

--------------enigEE8BB9395DEFC7365FE14FE2--

