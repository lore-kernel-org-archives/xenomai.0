Message-ID: <4631E3D8.4070400@domain.hid>
Date: Fri, 27 Apr 2007 13:51:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4630F274.5090605@domain.hid>
	<b647ffbd0704270439h2a6e7ba2hee14be3a7a84e449@domain.hid>
In-Reply-To: <b647ffbd0704270439h2a6e7ba2hee14be3a7a84e449@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig584A11937CA9D8D63053C881"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 5/7] Introduce ipipe_base.h (i386/x86_64)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig584A11937CA9D8D63053C881
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 26/04/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> These patches introduce minimalistic ipipe_base.h to be included by
>> every header out there in the kernel without any dependencies. That is=

>> exploited here to move all *stall_root() related prototypes out off
>> irqflags.h, to following patches need ipipe_base.h as well.
>=20
> So this file is supposed to extend with another generic stuff, isn't
> it? At the moment it's completely about the root domain, so one would
> think of ipipe_root.h as a more appropriate name.

Yes, when just looking at this particular patch. But then patch #7
extends the scope.

>=20
> And this "minimalistic" and "without any dependencies" is due to the
> heaviness of linux/pipe.h?

Yep. Originally, I tried hard to drag central parts of struct
ipipe_domain into it. The goal was to work on a known root domain
structure instead of poking half-blind into it for the domain state. But
I already failed due to struct list_entry and IPIPE_NR_IRQS (would have
required something like asm/ipipe_base.h :-/). Not to speak of struct mut=
ex.

Jan


--------------enig584A11937CA9D8D63053C881
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMePZniDOoMHTA+kRAuvWAJ9gArKT27xy1rbPc83mJ0SVCcPBkACfZgcC
wHDzvrFpU10XGGYRf1ktuik=
=9in7
-----END PGP SIGNATURE-----

--------------enig584A11937CA9D8D63053C881--

