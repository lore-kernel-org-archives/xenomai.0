Message-ID: <456171C7.2090006@domain.hid>
Date: Mon, 20 Nov 2006 10:13:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>	
	<455E022D.2000306@domain.hid>
	<b647ffbd0611190255g11b79febhfa0619a2bf768b01@domain.hid>
In-Reply-To: <b647ffbd0611190255g11b79febhfa0619a2bf768b01@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77A6761A5FAE58C89E5963C7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch] memory barriers in intr.c ::
	xnintr_lock/unlock()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77A6761A5FAE58C89E5963C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>> I see two paths now:
>>
>> A) If we go for atomic_inc/dec with such locking service,
>> xnarch_memory_barrier__after_atomic_inc & friends will be needed anywa=
y
>> and could be already introduced now.
>=20
>=20
> Yes, this would be better.
>=20
>=20
>=20
>> Any thoughts?
>=20
>=20
> I have already sent once to you the message, but I do it now once more.=


Ah, I remember. Got lost somehow.

> Just
> to give some more stuff to think about (although, nobody seems to be
> inetersted in memory-barriers :) and maybe, if I'm wrong, someone will
> point
> it out.
>=20
> **********************************************************
>=20
> I just noticed that probably the code is still, at least very
> theoretically,
> not perfectly safe.
>=20
> let's consider the following scenario:
>=20
> op1;
>=20
> lock();
> op2;
> unlock();
>=20
> op3;
>=20
> from the Documentation/memory-barriers.txt follows that the only guaran=
tee
> here is that "b =3D c" is executed inside the lock-unlock section (of c=
ourse,
> that's what locks are up too).
>=20
> But the funny thing is that non of the ops are ordered in respect to ea=
ch
> other!
>=20
> iow, e.g. the following sequences are possible :
>=20
> lock(); op1; op2; op3; lock();
> or
> lock(); op3; op2; op1; lock();
>=20
> and moreover, pure lock/unlock (without irq disable/enable) doesn't eve=
n
> imply a compiler barrier for UP.
>=20
> [ read starting from the line 1150 in the above mentioned doc ]
>=20
> And now apply all the said above to xnintr_detach() or even linux's
> synchronize_irq(). IOW, spin_unlock() doesn't guarantee we have a mb
> between
> element deletion and checking the active flag :)

Well, I must agree with you that there is a potential issue even in the
Linux code. I can't imagine that there is a real one, because this
should have triggered already on some box, but following the theory it
is possible.

>=20
> Ok, maybe it's just in theory. e.g. lock and unlock for x86 seem to imp=
ly a
> full memory barrier (and, probably, all the rest systems does the same)=
=2E
> Just look at definitions of mb() and spinlocks() for x86. asm("lock; so=
me
> write ops") does the trick in both cases.
>=20

Well, the essence is likely that we should put a real compiler barrier
in spinunlock so that such /potential/ leaking of post-lock code into
the critical region can be excluded. Shouldn't cost anything, should it?

Jan


--------------enig77A6761A5FAE58C89E5963C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYXHHniDOoMHTA+kRAqv2AJ9zC/Nvvx+Keev3fdxiCmhS0znV1wCfWklw
5IvyScUsxbD/CiL2IhN4SzM=
=D2eG
-----END PGP SIGNATURE-----

--------------enig77A6761A5FAE58C89E5963C7--

