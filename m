Message-ID: <43F0D374.7010801@domain.hid>
Date: Mon, 13 Feb 2006 19:44:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [shirq] first test results
References: <43ECD570.5000704@domain.hid>	<b647ffbd0602110331i400d7ff5k@domain.hid>	<43EDDF9E.4030309@domain.hid>
	<b647ffbd0602111058v3e8c6790w@domain.hid>
In-Reply-To: <b647ffbd0602111058v3e8c6790w@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD9DF53025051CE5CA0D5F42"
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
--------------enigBD9DF53025051CE5CA0D5F42
Content-Type: multipart/mixed; boundary="------------070206080401070806060607"

This is a multi-part message in MIME format.
--------------070206080401070806060607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 11/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Dmitry Adamushko wrote:
>>> And as an additional option,
>>> it could be interesting to print out to the log if not all "counter"
>> values
>>> then min,max,average (the same like for the latency :) per second or =
per
>>> 1000 interrupts; so to see whether tweaking the MAX_EDGEIRQ_COUNTER m=
ay
>> make
>>> the things better.
>> Yes, maybe it's too small. But this also depends on the absolute time
>> required for so many loops, something we should see in the traces then=
=2E
>> I'm afraid that we will finally have to move the UART's read-from-fifo=

>> to task context to reduce the time spent in IRQ context.
>=20
> Good. Keep me informed as before.
>=20

We got it working. :)

First, we had to fix our own stupidity: the reception fifo depth of the
serial ports were set to one, thus we basically got one IRQ every 20 us.
Of course the CPU was too slow for this storm and therefore we got the
overruns. After increasing this threshold to 14, things improved
significantly - but also the worst-case IRQ-off time. Well, that's a
trade-off we likely have to make somehow between low IRQ load and long
IRQ-off times. Reducing the threshold to 4 e.g. gives shorter IRQ-off
times and still no overruns but also causes higher system load. This all
requires some more thoughts on the xeno_16550 design (IRQ handler vs.
user task for receiving and sending), will see when I find time for it.

Anyway, this works now. But we also found a bug, as usual, a clean-up
bug: You released the IRQ line based on the wrong test, see attached
patch. With this fix applied and the IRQ flags as well as the
/proc/xenomai/irq output cleaned up, I would say you great work is ready
for merge!

Thanks,
Jan

--------------070206080401070806060607
Content-Type: text/plain;
 name="shirq-detach.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="shirq-detach.patch"

--- ksrc/nucleus/intr.c.orig	2006-02-13 11:15:45.000000000 +0100
+++ ksrc/nucleus/intr.c	2006-02-13 19:22:57.000000000 +0100
@@ -393,9 +393,12 @@ int xnintr_detach (xnintr_t *intr)
 	if (e =3D=3D intr)
 	    {
 	    /* Remove a given interrupt object from the list. */
-	    if ((*p =3D e->next) =3D=3D NULL)
+	    *p =3D e->next;
+
+	    /* Release IRQ line if this was the last user */
+	    if (shirq->handlers =3D=3D NULL)
 		err =3D xnarch_release_irq(intr->irq);
-   =20
+
 	    xnarch_critical_exit(flags);
=20
 	    /* The idea here is to keep a detached interrupt object valid as lo=
ng

--------------070206080401070806060607--

--------------enigBD9DF53025051CE5CA0D5F42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8NN0niDOoMHTA+kRAp6xAJ48uGSY0vX+Ub0Vbfc+Yo9JgHcNlACeP8Gd
XNBF3g/u3x+tzPPsHI4XMcM=
=A7jB
-----END PGP SIGNATURE-----

--------------enigBD9DF53025051CE5CA0D5F42--

