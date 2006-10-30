Message-ID: <4545E457.2080103@domain.hid>
Date: Mon, 30 Oct 2006 12:39:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
	latency
References: <4545D257.3000602@domain.hid>
	<21364954.1162202747823.JavaMail.ngmail@domain.hid>
	<33139598.1162206356611.JavaMail.ngmail@domain.hid>
In-Reply-To: <33139598.1162206356611.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig141363BD3DC2179DEEFEB704"
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
--------------enig141363BD3DC2179DEEFEB704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> thanks for your reply.
>=20
>>> I am currently checking XENOMAI (V2.2.3 on a 2.6.17.7 kernel P4) to s=
ee if
>> I can use it
>>> as replacement for a RTAI 3.3-cv application.
>>> The first thing I did was to run the latency test in the the xenomai'=
s
>> testsuite directory.
>>> The results of the worst time latency are really ugly - about 40=B5s!=

>>> On the very same PC I got a value of about 5=B5s using RTAI 3.3-cv ru=
nning
>> the RTAI's
>>> user/latency test.
>> I'm _very_ sceptical about your 5 us. Could you elaborate on how you
>> load your box and how long those tests ran? See also TROUBLESHOOTING i=
n
>> the Xenomai source tree on appropriate load for triggering the worst c=
ase.
>=20
> My test setup was the same in both cases.
> I connect to the RTAI/Xenomai PC via telnet and let the latency test ru=
n for about 5 minutes.

5 min. are far too short.

It takes a while to "arrange" the worst case, i.e. a dirty cache, one
unrelated IRQ or atomic section running while the timer (or any other
event of interest) occurs, and then one or more further IRQs right after
the woken-up task re-enabled interrupts. If you hit such scenario can be
observed via the latency tracer (which has some impact on the numbers,
but not on the structuring).

> No other activity happens (well, there are a couple of services running=
 like
> apache, ... - but they should not cause any load).
> The strange thing, is that in Xenomai even after a few seconds a latenc=
y in the range of the
> maximum latency is shown.

Such a test on an unloaded system says almost nothing about a hard
real-time system.

>=20
> I can retry the tests using a background stress situation.

Jan


--------------enig141363BD3DC2179DEEFEB704
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFReRXniDOoMHTA+kRAtApAJ9comIK8iBFudCMO/HS+q1wqhCJDgCeNowe
uaWU6YUJm8ZSW5n8p+QUrCU=
=e8sY
-----END PGP SIGNATURE-----

--------------enig141363BD3DC2179DEEFEB704--

