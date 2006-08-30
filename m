Message-ID: <44F5DDF1.3030006@domain.hid>
Date: Wed, 30 Aug 2006 20:50:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>	<44F49A6C.5050603@domain.hid>	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>	<44F592AD.2000900@domain.hid>
	<1156960547.4323.68.camel@domain.hid>
In-Reply-To: <1156960547.4323.68.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF3BE3B4D1FB6DFC8C4E26F9"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF3BE3B4D1FB6DFC8C4E26F9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:

> On Wed, 2006-08-30 at 15:29 +0200, Jan Kiszka wrote:
>  =20
>> Dmitry Adamushko wrote:
>>    =20
>>> On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>      =20
>>>> Dmitry Adamushko wrote:
>>>>
>>>> I think the additional costs of maintaining an error counter are alm=
ost
>>>> negligible. The test is in the unlikely path, and the first conditio=
n
>>>> already keeps us away from touching the counter.
>>>>        =20
>>> But it's updated (unhandled =3D 0) any time the ISR(s) report somethi=
ng
>>> different from XN_ISR_NONE.  Hence, it's at the beginning of the xnin=
tr_t
>>> structure, hopefully, at the same cache line with other highly-used m=
embers
>>> (i.e. isr, cookie and hits).
>>>      =20
>> Mmh, considering this and also the existing code I wonder if we could
>> optimise this a bit. I'm only looking at xnintr_irq_handler now (shari=
ng
>> is slow anyway): currently the intr object is touched both before
>> (naturally...) and after the call to the ISR handler. Maybe we can pus=
h
>> all accesses before the handler for the fast path. E.g.:
>>
>> int unhandled =3D intr->unhandled;
>>
>> intr->unhandled =3D 0;
>> ++intr->hits;
>> s =3D intr->isr(...);
>>
>> if (s =3D=3D XN_ISR_NONE) {
>> 	intr->unhandled =3D ++unhandled;
>> 	if (unhandled =3D=3D XNINTR_MAX_UNHANDLED)
>> 		ALARM!
>> }
>>
>>    =20
>
> Without speculating whether this could actually reduce cache misses or
> not when the branch is taken, the main issue I see here is that we woul=
d
> optimize the error case, at the expense of an additional memory fetchin=
g

No, it's the common path. Otherwise, I would have stopped already. I don'=
t
expect further memory access because the head of intr should be cached
already.

> in the common case, and perhaps one CPU register available less for
> processing the normal path in the worst scenario, which would not be
> particularly efficient on x86.
>
>  =20
At least on x86 it looks good: all local variables are in registers
anyway, unhandled now too. Is someone able to test this? Maybe also
on a non-x86 arch?

Jan


--- ksrc/nucleus/intr.c	(revision 1527)
+++ ksrc/nucleus/intr.c	(working copy)
@@ -374,6 +374,7 @@ void xnintr_clock_handler(void)
 	xnintr_irq_handler(nkclock.irq, &nkclock);
 }
=20
+#define XNINTR_MAX_UNHANDLED	1000
 /*
  * Low-level interrupt handler dispatching the ISRs -- Called with
  * interrupts off.
@@ -383,15 +384,28 @@ static void xnintr_irq_handler(unsigned=20
 {
 	xnsched_t *sched =3D xnpod_current_sched();
 	xnintr_t *intr =3D (xnintr_t *)cookie;
+	unsigned int unhandled =3D intr->unhandled;
 	int s;
=20
 	xnarch_memory_barrier();
=20
 	xnltt_log_event(xeno_ev_ienter, irq);
=20
+	intr->unhandled =3D 0;
+	++intr->hits;
+
 	++sched->inesting;
 	s =3D intr->isr(intr);
-	++intr->hits;
+
+	if (unlikely(s =3D=3D XN_ISR_NONE)) {
+		intr->unhandled =3D ++unhandled;
+		if (unlikely(unhandled =3D=3D XNINTR_MAX_UNHANDLED)) {
+			xnlogerr("xnintr_check_status: %d of unhandled "
+				 " consequent interrupts. Disabling the IRQ "
+				 "line #%d\n", XNINTR_MAX_UNHANDLED, irq);
+			s |=3D XN_ISR_NOENABLE;
+		}
+	}
=20
 	if (s & XN_ISR_PROPAGATE)
 		xnarch_chain_irq(irq);




--------------enigAF3BE3B4D1FB6DFC8C4E26F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9d3xniDOoMHTA+kRAvhIAJ9ddthnRawHMWU4XecGNrFw/84EDQCeNtOR
Xdv7cx8XziGMTf5RLA4AGHA=
=JiPG
-----END PGP SIGNATURE-----

--------------enigAF3BE3B4D1FB6DFC8C4E26F9--

