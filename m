Message-ID: <44184CEA.2000901@domain.hid>
Date: Wed, 15 Mar 2006 18:20:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <1CFEB358338412458B21FAA0D78FE86D02CABF1C@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D02CABF1C@rennsmail02.eu.thmulti.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig440CA6F5E6EA052D7F99C7BD"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig440CA6F5E6EA052D7F99C7BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Fillod Stephane wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>  > Likely too simple: The periodic IRQ seems to pop up on every CPU
> so that
>>>  > the TSC could be recorded, but will this happen synchronously? At
> least
>>>  > we will see (IRQ) jitters, and those jitters could already create
> in the
>>>  > single-CPU case a non-monotonic clock...
>>>
>>> I do not know how this issue is solved in Linux, but there seem to be=

> a
>>> simple solution: before adding the tsc offset to the last tick time,
>>> this tsc offset should be compared with the tick duration in tsc
>>> counts; if it is greater, then replace with the tick duration in tsc.=

>>>
>> Hmm, I would rather express it in absolute tsc values, i.e. always sav=
e
>> the tuple (absolute_tsc, jiffies):
>>
>> [timer IRQ]
>> new_tsc =3D read_rsc() - old_tsc;
>> if (new_tsc < old_tsc + period_in_tsc_ticks)
>> 	new_tsc =3D old_tsc + period_in_tsc;
>> old_tsc =3D new_tsc;
>>
>> Disclaimer: I haven't thought about potential accuracy side effects of=

>> this implementation, e.g. what would happen over the long term if the
>> condition is always fulfilled and executed...
>=20
> Aha! the wonderful world of PLL's :-)
>=20

Yes! I was waiting for someone to throw this in ;). But do we really
need them, or are there so cheap implementations that the overhead
doesn't matter?

Jan


--------------enig440CA6F5E6EA052D7F99C7BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGEzqniDOoMHTA+kRAp3pAJ4gwbVHac3yruhDfnk+sccJ5QEoqwCfT5fF
94W/PLn0XiT+RXVTjuIpU2Y=
=Hou0
-----END PGP SIGNATURE-----

--------------enig440CA6F5E6EA052D7F99C7BD--

