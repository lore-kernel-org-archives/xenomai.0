Message-ID: <45478C78.7050007@domain.hid>
Date: Tue, 31 Oct 2006 18:48:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel OOps large appl.
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D7C8@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D7C8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig98F8F9CB2486A0B43E08A567"
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
To: xenomai@xenomai.org, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98F8F9CB2486A0B43E08A567
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> jan.kiszka@domain.hid wrote:
>>> ./cyclictest -c 1 -d 500 -i 500 -l 10000 -n
>>> 0.06 0.03 0.01 1/21 354
>>>
>>> T: 0 (  354) P: 0 I:     500 C:   10000 Min:       7 Act:       7
>>> Avg: 10 Max:     201 (needs a relatively short time)
> =20
>> False positive of the test: only the -n mode is supported over
>> Xenomai, which is unfortunately not default. The default mode seems
>> to cause a busy loop in cyclictest, effectively locking up the box
>> (the Xenomai watchdog would have detected this).  =20
>>
>> Anyway, the test needs fixing to avoid misunderstandings.
>=20
> Au ja !
>=20
> So should I enable the watchdog ? What is the principle behind it ? Can=

> I somehow configure its behaviour ?

It can help here to tell "normal" RT-thread lock-ups apart from real
kernel deadlocks.

>=20
> If I look on my reliable mechanical stopwatch and would activate the
> cylictest with the above parameters: how long actually should the test
> take ?
>=20

5 seconds. Do you get different runtimes for -c0 vs. -c1?

>=20
> Next: the min, avg and max results mean latency in us ? Are these value=
s
> sane ? Any other test results I should give ? Other parameters ?

Yes, microseconds. The maximum numbers (for the -n cases) appeared a
"bit" high to me, even for low-end embedded. Wolfgang? Anyone else? What
are normal numbers for that board category? Some table on the wiki would
be nice as reference, not only for poor x86'ers like me...

Jan


--------------enig98F8F9CB2486A0B43E08A567
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFR4x4niDOoMHTA+kRAkoRAJ9YimU9NZGvGzQJoyFmm1Xqsyf3jgCdGE/w
yNSOT4qEgfTEcBFPfNuhZD8=
=3dAv
-----END PGP SIGNATURE-----

--------------enig98F8F9CB2486A0B43E08A567--

