Message-ID: <440F3A8A.9030501@domain.hid>
Date: Wed, 08 Mar 2006 21:11:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-core] Fundamental Questions
References: <003501c642e1$b1050990$a10a10ac@domain.hid>
In-Reply-To: <003501c642e1$b1050990$a10a10ac@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1C13BCC39B7B115D3B9038FA"
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
To: Christopher Stone <chris@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C13BCC39B7B115D3B9038FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Stone wrote:
> I do not have specific plans.=20
>=20
> I am working on something I am currently calling the Xen Loadable Modul=
e or
> XLM. It is an Xenomai application that when loaded, turns the Linux ker=
nel
> into a Xen compatible hypervisor. For the rationale behind it see here:=

> http://www.openembedded.biz/content/view/36/27.
>=20
> When it is ready, in 6 to 8 weeks, I am prepared to contribute it. It i=
s a
> significant work, but, is an Xenomai application, so I don't know if yo=
u
> guys want it. It does fit with your goals with respect to industrial gr=
ade
> Linux.=20
>=20
> I think that XLM actually illustrates a key point that people forget wh=
en
> they compare rt-preempt to Xenomai. I believe that in the industrial gr=
ade
> Linux world, the ability to support multiple OS's is key, especially in=

> light of the emerging dual core CPU's. Due to ADEOS, Xenomai has the
> infrastructure to support doing things like running eCos on one core an=
d
> Linux on the other, or eCos and Linux, side by side, on the same CPU. X=
LM is
> designed to make this easy. Rt-preempt has no such capability.=20

Sounds interesting, especially when considering future systems with
hardware support for virtualisation, thus removing the need to patch the
guest OS (there are still people with the desire to run Windows aside
the RTOS core for visualisation etc.). And if your approach have real
advantages over Xen, specifically on embedded systems or in combination
with hard real-time, this could become really great.

>=20
> I am not trying to discredit rt-preempt. It is a significant and useful=

> piece of work and contains some pretty smart coding. However, in my vie=
w,
> rt-preempt is just part of the solution required for industrial grade l=
inux.
> Things like rt-preempt, Xenomai, and hopefully XLM will all be pieces o=
f a
> comprehensive industrial grade linux solution.
>=20
> If XLM is not a suitable contribution to Xenomai, then, I can contribut=
e

Let's wait for some code first so that things like intrusiveness etc.
can be analysed.

> other ways such as other feature development or bug fixing. I would nee=
d
> some direction from the leaders in order to contribute in that way.

It's often best to pick a domain you are interested in on your own. This
can drive the overall development application-oriented in a very
constructive way. When you are using Xenomai for some projects, you may
happen to stumble over rough edges or lacking features.

Jan


--------------enig1C13BCC39B7B115D3B9038FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDzqKniDOoMHTA+kRArwDAJ4pqaH+2fpS2yNfKDCebuEnQs28DwCdF3lr
+SgKJBFqpb9v//5klCLpn3M=
=deAr
-----END PGP SIGNATURE-----

--------------enig1C13BCC39B7B115D3B9038FA--

