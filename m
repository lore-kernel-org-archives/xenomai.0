Message-ID: <454206EB.1050807@domain.hid>
Date: Fri, 27 Oct 2006 15:17:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai & Xen
References: <1161874282.7650.7.camel@domain.hid> <4540DEA8.4090006@domain.hid>
	<1161936364.5241.33.camel@domain.hid>
In-Reply-To: <1161936364.5241.33.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2FD0F1F26E7138E392628AB9"
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
To: Alessio Igor Bogani <abogani@domain.hid>
Cc: "Xenomai (help)" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FD0F1F26E7138E392628AB9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi,
>=20
> [...]
>>> Can Xenomai cohabit with Xen in the same kernel?
>>> Someone have already tried?
>> As paravirtualised host of Xen or by driving Xen in real-time via

s/host/guest/, of course.

> Xenomai?
>=20
> The second one:
>=20
> HW -> Adeos-ipipe -> Xen-Domai0 ---> Xen unprivileged domain A
>                                 |--> Xen unprivileged domain B
>                                 |--> ....
>                                 ---> Xen unprivileged domain N
>=20
> It is possible?

Well, nothing is impossible. But what do you want to achieve?

If we are now just talking about Adeos/I-pipe (which is a project of its
own), it will help you to dispatch hardware IRQs, faults, and specific
events generated inside the I-pipe root domain to multiple prioritised
users (i.e. "pipelined"). In your scenario above there is only one user
so far, Xen.

Or do you plan to attach Xenomai as an I-pipe domain and push it before
Xen? The point about Xenomai is then that it tightly cooperates with
Linux (even if you keep your applications only in kernel space). But
what Linux to use in a Xen-virtualised Environment? One of the
unprivileged Xen domains? That's something one has to consider
carefully, and I cannot give you a quick answer about potential traps
and pitfalls (there are always some...).

Jan


--------------enig2FD0F1F26E7138E392628AB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQgbrniDOoMHTA+kRAh4iAJ4jRTSWyhFUr84aRVGuCM2w8uYEjgCeNpi8
rqGuwn7o0ipqQRVW6P44KWI=
=GkBc
-----END PGP SIGNATURE-----

--------------enig2FD0F1F26E7138E392628AB9--

