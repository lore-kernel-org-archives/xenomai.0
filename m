Message-ID: <469F84B3.6070104@domain.hid>
Date: Thu, 19 Jul 2007 17:35:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>	
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>	
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>	
	<913919.1184311634860.JavaMail.ngmail@domain.hid>	
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>	
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>	
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>	
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>
In-Reply-To: <1184858093.28303.85.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0933C121537CB80C69F3660C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze after
	rt_task_start
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0933C121537CB80C69F3660C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-07-19 at 14:40 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>>> And when looking at the holders of rpilock, I think one issue could =
be
>>>> that we hold that lock while calling into xnpod_renice_root [1], ie.=

>>>> doing a potential context switch. Was this checked to be save?
>>> xnpod_renice_root() does no reschedule immediately on purpose, we wou=
ld
>>> never have been able to run any SMP config more than a couple of seco=
nds
>>> otherwise. (See the NOSWITCH bit).
>> OK, then it's not the cause.
>>
>>>> Furthermore, that code path reveals that we take nklock nested into
>>>> rpilock [2]. I haven't found a spot for the other way around (and I =
hope
>>>> there is none)
>>> xnshadow_start().
>> Nope, that one is not holding nklock. But I found an offender...
>=20
> Gasp. xnshadow_renice() kills us too.

Looks like we are approaching mainline "qualities" here - but they have
at least lockdep (and still face nasty races regularly).

As long as you can't avoid nesting or the inner lock only protects
really, really trivial code (list manipulation etc.), I would say there
is one lock too much... Did I mention that I consider nesting to be
evil? :-> Besides correctness, there is also an increasing worst-case
behaviour issue with each additional nesting level.

Jan


--------------enig0933C121537CB80C69F3660C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGn4SzniDOoMHTA+kRAnIBAJ0baFu9FzYxn8KZMdhwzB0qoH3+GgCfVCEj
IuYUqH0PuRkXsnwoZa8ux7A=
=pxas
-----END PGP SIGNATURE-----

--------------enig0933C121537CB80C69F3660C--

