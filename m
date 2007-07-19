Message-ID: <469F5BA5.1030407@domain.hid>
Date: Thu, 19 Jul 2007 14:40:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>	
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>	
	<913919.1184311634860.JavaMail.ngmail@domain.hid>	
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>	
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>	
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>
In-Reply-To: <1184847549.28303.46.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4D6630C2ADB82755C82ABE08"
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
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>, "M. Koehrer" <mathias_koehrer@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D6630C2ADB82755C82ABE08
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
>> And when looking at the holders of rpilock, I think one issue could be=

>> that we hold that lock while calling into xnpod_renice_root [1], ie.
>> doing a potential context switch. Was this checked to be save?
>=20
> xnpod_renice_root() does no reschedule immediately on purpose, we would=

> never have been able to run any SMP config more than a couple of second=
s
> otherwise. (See the NOSWITCH bit).

OK, then it's not the cause.

>=20
>> Furthermore, that code path reveals that we take nklock nested into
>> rpilock [2]. I haven't found a spot for the other way around (and I ho=
pe
>> there is none)
>=20
> xnshadow_start().

Nope, that one is not holding nklock. But I found an offender...

>=20
>> , but such nesting is already evil per se...
>=20
> Well, nesting spinlocks only falls into evilness when you get a circula=
r
> graph, but since the rpilock is a rookie in the locking team, I'm going=

> to check this.

Take this one: gatekeeper_thread calls into rpi_pop with nklock
acquired. So we have a classic ABAB locking bug. Bang!

Jan


--------------enig4D6630C2ADB82755C82ABE08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGn1ulniDOoMHTA+kRAr9SAJ97rl5hcTq23lk4rum9f0t03H8KNACeNs9O
wt2FozR7xCAMwwX68GPz+Do=
=r2Pk
-----END PGP SIGNATURE-----

--------------enig4D6630C2ADB82755C82ABE08--

