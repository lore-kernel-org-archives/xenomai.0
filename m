Message-ID: <45623D01.9000404@domain.hid>
Date: Tue, 21 Nov 2006 00:40:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>	
	<455E022D.2000306@domain.hid>	
	<b647ffbd0611190255g11b79febhfa0619a2bf768b01@domain.hid>	
	<456171C7.2090006@domain.hid>
	<b647ffbd0611201209s9d2348bx9579b382b12c7780@domain.hid>
In-Reply-To: <b647ffbd0611201209s9d2348bx9579b382b12c7780@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB2DA093A5A17F6C40C52943D"
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
--------------enigB2DA093A5A17F6C40C52943D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 20/11/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>> > Ok, maybe it's just in theory. e.g. lock and unlock for x86 seem to
>> imply a
>> > full memory barrier (and, probably, all the rest systems does the
>> same).
>>
>> > Just look at definitions of mb() and spinlocks() for x86. asm("lock;=

>> some
>> > write ops") does the trick in both cases.
>> >
>>
>> Well, the essence is likely that we should put a real compiler barrier=

>> in spinunlock so that such /potential/ leaking of post-lock code into
>> the critical region can be excluded.
>=20
>=20
> But some CPUs still may reorder write ops. (the ones that have write-op=

> queues) and a compiler barrier doesn't help here. Moreover, a spinlock
> (here
> I'm referring to the linux one) does seem to include a compiler barrier=

> (any
> real memory barrier also implies it).
>=20
> Think about it : spinlocks act as "one-way permeable barriers" and less=
er
> (one-side) variants of compiler barriers do not exist (it's from the sa=
me
> document :) - just barrier().
> So if spinlock doesn't imply a compiler barrier by default (+ (one-way
> where
> it's available) CPU memory barrier), it's just broken.

As we learned, spin-unlock comes with a one-way barrier. I was referring
two a full compiler barrier to avoid reordering of post-lock with
in-lock code. Or is it even a memory barrier? I hate this. It confuses me=
=2E

Well, I guess it's best to leave xnlocks as they are (when they really
match Linux characteristics) and put the required but missing barrier
for xnintr_synchronize() explicitly into the code. To play save (and as
performance is not important in that path), we can use a memory barrier.

>=20
> Errr... in fact, xnlock_put() doesn't seem to be safe in this respect.
> Although, nobody uses it as is. xnlock_put_irqrestore() seems to be saf=
e
> though.
>=20
> xnlock_get() makes use of atomic_cmpxchg() which is mapped on linux's
> cmpxchg() which, in turn, is said to be smp_mb() alike.

My whole feeling on the xnlock is not that positive. Maybe it would be
good to go through all "home-made" locking primitives with barriers in
mind and an eye on the Linux implementation.

>=20
> Ok, I'm stopping further speculations here... Back to practice, so do w=
e go
> for smp_mb__before/after_atomic_* counterparts or live it as is? I gues=
s,
> those would be more optimal.
>=20

As I said, I'm still not sure if we finally need it when we may use
per-cpu counters for efficiency reasons on the long-term. If this will
add code or - even more important - an interface (of the system layer)
that will soon be removed again...

Jan


--------------enigB2DA093A5A17F6C40C52943D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYj0BniDOoMHTA+kRAslJAJ45OV1O5lhwDaCyeUL4xOIdnsuWvQCfWWZq
Gir/1ELd6KY6k9sfThKeg38=
=XNbp
-----END PGP SIGNATURE-----

--------------enigB2DA093A5A17F6C40C52943D--

