Message-ID: <43CCF1FF.5040709@domain.hid>
Date: Tue, 17 Jan 2006 14:32:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] shared irqs v.3
References: <b647ffbd0601150050k573ef53fu@domain.hid>
In-Reply-To: <b647ffbd0601150050k573ef53fu@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF8BBE73644DACB0B822320B9"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8BBE73644DACB0B822320B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Dmitry Adamushko wrote:
> Hi,
>=20
> here goes another implementation of shared irqs on the nucleus layer.
> I have conducted a few tests and it seems to work. The test example is
> attached.
>=20
> There were 2 main issues concerning synchronization:
>=20
> 1)  xnintr_attach() vs. xnintr_detach() (and each of them vs. itself)
>=20
>     The problem is that we can't use the "nklock" (nor any other lock +=
 irq
> off) as Gilles pointed out.
>=20
>     A possible solution:
>=20
>     o  something lick xnlock_get/put()
>=20
>     There is no irqsave/restore -less interface of xnlock_get/put avail=
able.
> For pure locking scheme
>     (without touching the irqs) the concept of _preemption_ (to prevent=
 a
> thread from being preempted
>     while in a locked section) must be introduced and, at the first gla=
nce,
> that would be quite difficult
>     since it must be consistent across all domains (if only for the pri=
mary
> - that's easy).
>=20
>     o  rthal_critical_enter/exit()
>=20
>     This one is used currently.
>=20
>=20
> 2)  xnintr_attach/detach() vs. xnintr_irq_handler()
>=20
>     The problem here is how to be sure that 1) the "xnintr_shirq_t" obj=
ect
> is valid (when dynamically allocated)
>     and 2) to be safe while iterating through the handlers list.
>=20
>     Currently, 1) is allowed by the static xnintr_shirq_t
> xnshirqs[IPIPE_NR_IRQS]. Ok, it can be done lighter
>     when a one-way-list is used instead of xnqueue_t.

As lighter may mean that reducing the structure size also reduces the
number of used cache lines, it might be a good idea. The additional
complexity for entry removal is negligible.

>=20
>     Beleive it or not, I have considered different ways to guarantee th=
at a
> passed "cookie" param is valid
>     (xnintr_detach() has not deleted it) and remains to be so while the=

> xnintr_irq_handler() is running.
>     And there are some obstacles there... I'll post them later if someo=
ne is
> interested since I'm short of time now :)
>     ...

I'm interested...

>=20
>=20
> There are a few ugly things in code, namely __IPIPE_NR_IRQS and definit=
ions
> of rthal_critical_enter/exit().

I do understand the first issue but not what you mean with the second one=
=2E

> That code is compiled for the user-mode code also and the originals are=
 not
> available. So consider it a temp
> solution for test purposes, I guess it's easily fixable.
>=20
> test/shirq.c - is a test module.
>=20
> SHIRQ_VECTOR must be the one used by Linux, e.g. I have used 12 that's =
used
> by the trackball device.
>=20

I haven't tried your code yet, but in the preparation of a real scenario
I stumbled over a problem in my serial driver regarding IRQ sharing: In
case you want to use xeno_16550A for ISA devices with shared IRQs, an
iteration over the list of registered handlers would be required /until/
no device reported that it handled something. This is required so that
the IRQ line gets released for a while and system obtains a chance to
detect a new /edge/ triggered IRQ - ISA oddity.

That's the way most serial drivers work, but they do it internally. So
the question arose for me if this edge-specific handling shouldn't be
moved to the nucleus as well (so that I don't have to fix my 16550A ;)).

Another optimisation idea, which I once also realised in my own shared
IRQ wrapper, is to use specialised trampolines at the nucleus level,
i.e. to not apply the full sharing logic with its locking and list
iterations for non-shared IRQs. What do you think? Worth it? Might be
when the ISA/edge handling adds further otherwise unneeded overhead.

Jan


--------------enigF8BBE73644DACB0B822320B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzPH/niDOoMHTA+kRAgoKAJ98mTb1SApvBccP4TIyLXVMEC+UyACePmuh
yCwKkeAVKUvaD5HiwhIrhHg=
=h98D
-----END PGP SIGNATURE-----

--------------enigF8BBE73644DACB0B822320B9--

