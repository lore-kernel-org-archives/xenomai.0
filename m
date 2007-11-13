Message-ID: <4739628F.8000100@domain.hid>
Date: Tue, 13 Nov 2007 09:38:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b054e88e0711090616r6376a8a6t81e9bc94b4290dea@domain.hid>	<473471FB.9010305@domain.hid>
	<4734736D.7060100@domain.hid>	<b054e88e0711090652h176ef99dx740a5c0deb333829@domain.hid>	<4734755F.2010301@domain.hid>
	<47347593.3040605@domain.hid>	<b054e88e0711090747m315c1ecdsa998c41653737046@domain.hid>	<47348393.5030202@domain.hid>
	<b054e88e0711091028v76750ff0jcf3b20aa12317d69@domain.hid>
In-Reply-To: <b054e88e0711091028v76750ff0jcf3b20aa12317d69@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1E84205C68D9872C18C9F3EB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel oops while trying first boot w/ Xenomai
 2.4rc5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E84205C68D9872C18C9F3EB
Content-Type: multipart/mixed;
 boundary="------------020901050509060900000504"

This is a multi-part message in MIME format.
--------------020901050509060900000504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Giammarco,

Giammarco Zacheo wrote:
> Ok, I hope this is what you asked for...
>=20
> I added printk in mask_ack_irq. Look at mask_ack_irq--> in the text
> below, those are the addresses of the function pointers.
> the printk related to mask_ack is printed once at the first pass in
> the function, otherwise the kernel would be choked by the output.

Yep, this pointed to the right spot. I still don't get why we didn't
stumble over this earlier (obviously, most x86_64 boxes take a different
code path here), but it is at least clear now what went wrong:

I-pipe ran into one of the remaining non-genirq code paths on x86_64.
More precisely, the IRQ chip of timer interrupt was changed from 8259 to
APIC without going through the generic API so that I-pipe was still
using the old ack handler, stepping later on the missing mask and
mack_ack handler.

This patch now updates irq_chip.ipipe_ack when it changes for IRQ0. This
is a temporary fix, I guess kernel people will refactor io_apic_*.c into
a shared variant soon, overcoming this "minor" variation between i386
and x86_64...

Please let us know if this helps!

Jan

--------------020901050509060900000504
Content-Type: text/x-patch;
 name="update-ipipe_ack_irq-for-irq0.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="update-ipipe_ack_irq-for-irq0.patch"

---
 arch/x86_64/kernel/io_apic.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6.23.1-xeno_64/arch/x86_64/kernel/io_apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/arch/x86_64/kernel/io_apic.c
+++ linux-2.6.23.1-xeno_64/arch/x86_64/kernel/io_apic.c
@@ -1659,6 +1659,8 @@ static inline void unlock_ExtINT_logic(v
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
+void __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc);
+
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate wit=
h
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ=

@@ -1752,6 +1754,9 @@ static inline void check_timer(void)
=20
 	disable_8259A_irq(0);
 	irq_desc[0].chip =3D &lapic_irq_type;
+#ifdef CONFIG_IPIPE
+	irq_desc[0].ipipe_ack =3D &__ipipe_ack_edge_irq;
+#endif
 	apic_write(APIC_LVT0, APIC_DM_FIXED | cfg->vector);	/* Fixed mode */
 	enable_8259A_irq(0);
=20

--------------020901050509060900000504--

--------------enig1E84205C68D9872C18C9F3EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHOWKPniDOoMHTA+kRAjmSAJ4pMnEG4iyDLal23CTvnqYGWdjf9ACfccIy
Bhr74ougepwT/Zrd9sKK12E=
=5qvP
-----END PGP SIGNATURE-----

--------------enig1E84205C68D9872C18C9F3EB--

