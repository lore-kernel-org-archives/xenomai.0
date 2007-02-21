Message-ID: <45DC2381.2020108@domain.hid>
Date: Wed, 21 Feb 2007 11:48:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Enhanced RTDM device closure
References: <45DC0623.3080706@domain.hid> <45DC0939.6070207@domain.hid>
	<45DC0CAA.2050001@domain.hid> <45DC139A.6020302@domain.hid>
	<45DC1773.1080803@domain.hid> <45DC1F14.4030300@domain.hid>
In-Reply-To: <45DC1F14.4030300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54087872D43333C87F6444EC"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig54087872D43333C87F6444EC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> I have to have a closer look at the code. But you are right, since th=
e
>>> ppd cannot vanish under our feet, maybe is it possible to call
>>> xnshadow_ppd_get without holding the nklock at all. We "only" have to=

>>> suppose that the lists manipulation routines will never set the list =
to
>>> an inconsistent state.
>>
>> As long as process A's ppd can take a place in the same list as proces=
s
>> B's one, you need locking (or RCU :-/). That's my point about the hash=

>> chain approach.
>>
>> I can only advertise the idea again to maintain the ppd pointers as an=

>> I-pipe task_struct key. On fork/clone, you just have to make sure that=

>> the child either gets a copy of the parent's pointer when it will shar=
e
>> the mm, or its key is NULL'ified, or automatic Xenomai skin binding is=

>> triggered to generate in a new ppd.
>=20
> I agree with the idea of the ptd. Nevertheless, I think it is possible
> to access an xnqueue in a lockless fashion. Concurrent insertions and
> deletions only matter if they take place before (in list order) the
> target. When we are walking the list, only the "next" pointers matters.=

> Now, if we look at the "next" pointers in the insertion routine, we see=
:
>=20
>    holder->next =3D head->next;
>    head->next =3D holder;
>=20
> So, maybe we just need to add a compiler barrier, but it looks like we
> can never see a wrong pointer when walking the list.
>=20

But not having to walk some chain, even if it's lock-less then, can also
save us from potential cache misses on accessing those memory chunks... :=
)


--------------enig54087872D43333C87F6444EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3COBniDOoMHTA+kRAqStAJ4uku7YSe2cSJRCzn2koGyGH42OBACgg21Q
QnHgVY0GZUQxx5X0AAlX+WU=
=2t6a
-----END PGP SIGNATURE-----

--------------enig54087872D43333C87F6444EC--

