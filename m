Message-ID: <45868547.6050304@domain.hid>
Date: Mon, 18 Dec 2006 13:10:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA3BBAA69FB870D2B32AA8B39"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [SMP-BUG?] inconsistent cpuid after dispatch_wired
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3BBAA69FB870D2B32AA8B39
Content-Type: multipart/mixed; boundary="------------050601030605090608090406"

This is a multi-part message in MIME format.
--------------050601030605090608090406
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

actually, I was trying to apply a micro-optimisation on
__ipipe_handle_irq, but I think I also found a bug on SMP systems (at
least on x86):

After __ipipe_handle_irq forwarded some IRQ to __ipipe_dispatch_wired
and the latter returned 1 (i.e. "not deferred"), a pipeline sync is
triggered using the cpuid read on IRQ entry. But I think that
__ipipe_dispatch_wired may very well have caused some CPU migration of
the current context so that reloading the cpuid is required here. This
is what the first attached patch does.

Jan


PS: The optimisation I was looking at deals with the assumption that a
wired IRQ may never be also a sticky one, correct? If yes, the second
(alternative) patch might be interesting as it avoids to touch the root
domain data structure and to test for stickiness in the wired case.
Should shorten the wired IRQ path by a few cycles (or more on cache
miss...).

--------------050601030605090608090406
Content-Type: text/plain;
 name="reload-cpuid-after-wired-dispatch.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="reload-cpuid-after-wired-dispatch.patch"

Index: linux-2.6.19/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.19/arch/i386/kernel/ipipe.c
@@ -790,9 +790,10 @@ int __ipipe_handle_irq(struct pt_regs re
 		if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control)=
)) {
 			if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
 				next_domain->irqs[irq].acknowledge(irq);
-			if (likely(__ipipe_dispatch_wired(next_domain, irq)))
+			if (likely(__ipipe_dispatch_wired(next_domain, irq))) {
+				ipipe_load_cpuid();
 				goto finalize;
-			else
+			} else
 				goto finalize_nosync;
 		}
 	}

--------------050601030605090608090406
Content-Type: text/plain;
 name="optimise-wired-irq-path.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-wired-irq-path.patch"

Index: linux-2.6.19/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.19/arch/i386/kernel/ipipe.c
@@ -772,30 +772,30 @@ int __ipipe_handle_irq(struct pt_regs re
 	ipipe_declare_cpuid;
 	int m_ack;
=20
-	ipipe_load_cpuid();
-
 	if (regs.orig_eax < 0) {
 		irq =3D ~irq;
 		m_ack =3D 0;
 	} else
 		m_ack =3D 1;
=20
+	head =3D __ipipe_pipeline.next;
+	next_domain =3D list_entry(head, struct ipipe_domain, p_link);
+	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))=
) {
+		if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
+			next_domain->irqs[irq].acknowledge(irq);
+		if (likely(__ipipe_dispatch_wired(next_domain, irq))) {
+			ipipe_load_cpuid();
+			goto finalize;
+		} else
+			goto finalize_nosync;
+	}
+
+	ipipe_load_cpuid();
+
 	this_domain =3D per_cpu(ipipe_percpu_domain, cpuid);
=20
 	if (test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control))
 		head =3D &this_domain->p_link;
-	else {
-		head =3D __ipipe_pipeline.next;
-		next_domain =3D list_entry(head, struct ipipe_domain, p_link);
-		if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control)=
)) {
-			if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
-				next_domain->irqs[irq].acknowledge(irq);
-			if (likely(__ipipe_dispatch_wired(next_domain, irq)))
-				goto finalize;
-			else
-				goto finalize_nosync;
-		}
-	}
=20
 	/* Ack the interrupt. */
=20

--------------050601030605090608090406--

--------------enigA3BBAA69FB870D2B32AA8B39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFhoVHniDOoMHTA+kRAmdsAJ9VK6U6wBhvMAWesDSxfo+4x+iuTQCdEuZ2
Wi3bmqMluszqEdX4ZZumui0=
=KboF
-----END PGP SIGNATURE-----

--------------enigA3BBAA69FB870D2B32AA8B39--

