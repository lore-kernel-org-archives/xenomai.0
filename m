Message-ID: <48D34D46.7050207@domain.hid>
Date: Fri, 19 Sep 2008 08:57:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>		<48D176F0.7060805@domain.hid>	<7ed3bc8b0809181700qdcaa43dpd78d020b13afe306@domain.hid>
	<48D34A49.5090202@domain.hid>
In-Reply-To: <48D34A49.5090202@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE63011959166D8C5AED4DE01"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai IRQ Disable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stuart O Anderson <soa@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE63011959166D8C5AED4DE01
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Stuart O Anderson wrote:
>> Oh - I forgot to mention - when I boot the machine, about 50% of the
>> time it comes up with the keyboard and mouse locked by the time it
>> gets to a login screen.  The rest of the time it's fine until I run my=

>> rtnet program.  I suspect this is because some interrupt is randomly
>> getting assigned on boot to one processor or the other, and when it's
>> the wrong one things break?
>>
>> ipipe version: 2.0-08
>> kernel config: attached
>> varying versions: will try this when I have more time
>> playing with affinities: I'm trying to find documentation for
>> /proc/xenomai/affinity - do you know where it is located?
>=20
> Don't think we have any, however the usage is straightforward: This is =
a
> bitmask describing the CPUs on which Xenomai threads and IRQs that will=

> be created in the future shall be bound to. Just set it before firing u=
p
> RTnet and your application.
>=20
> BTW, I found a hint on an "IRQ19 issue" in my archive, but I still need=

> to interview my colleague on details.
>=20
> Jan
>=20
> PS: Please keep the list in CC.

Which should have been xenomai-help, of course. Still too early for me...=


Jan


--------------enigE63011959166D8C5AED4DE01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjTTUYACgkQniDOoMHTA+kbwACdE2g7UeFngUVtJqIeObQUkZMh
M+IAnRGuAn+UTeToDVl8UEg3+MB3Xdfn
=/dIK
-----END PGP SIGNATURE-----

--------------enigE63011959166D8C5AED4DE01--

