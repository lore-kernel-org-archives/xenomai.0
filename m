Message-ID: <46384E4B.2050200@domain.hid>
Date: Wed, 02 May 2007 10:39:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1177947596.32698.47.camel@domain.hid>
	<1177686318.5010.106.camel@domain.hid>	
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>	
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>	
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>	
	<784082.1177682909759.JavaMail.ngmail@domain.hid>	
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>	
	<1177685762.5010.104.camel@domain.hid>	
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>	
	<1177706363.5010.158.camel@domain.hid>
	<33288775.1178089500362.JavaMail.ngmail@domain.hid>
In-Reply-To: <33288775.1178089500362.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDDD4AD9A5BAC69D6976A1D2E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDD4AD9A5BAC69D6976A1D2E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Philippe,
>=20
> I have applied the patches as proposed.
> However, the kernel still freezes.

:(

> Here is the corresponding message.
>=20

OK, here is another instrumentation, hoping that the bug will not move
again and that we can nail down what piece of memory contains nonsense.

The next step would then be to narrow down the corruption window (or to
find the reason for filling in nonsense during initialisation).

Jan


Index: linux-2.6.20/arch/i386/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.20/arch/i386/kernel/ipipe.c
@@ -782,6 +782,13 @@ int __ipipe_handle_irq(struct pt_regs re
=20
 	head =3D __ipipe_pipeline.next;
 	next_domain =3D list_entry(head, struct ipipe_domain, p_link);
+	if (irq=3D=3D219) {
+		ipipe_set_printk_sync(next_domain);
+		printk("%s:%d\n", __FUNCTION__, __LINE__);
+		printk("%s:%d %lx %p %p\n", __FUNCTION__, __LINE__,
+			ipipe_root.irqs[irq].control, ipipe_root.irqs[irq].acknowledge,
+			ipipe_root.irqs[irq].handler);
+	}
 	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))=
) {
 		if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
 			next_domain->irqs[irq].acknowledge(irq);
@@ -865,6 +872,10 @@ finalize:
 	 * current domain in the pipeline.
 	 */
=20
+	if (irq=3D=3D219)
+		printk("%s:%d %lx %p %p\n", __FUNCTION__, __LINE__,
+			ipipe_root.irqs[irq].control, ipipe_root.irqs[irq].acknowledge,
+			ipipe_root.irqs[irq].handler);
 	__ipipe_walk_pipeline(head, cpuid);
=20
 	ipipe_load_cpuid();
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -791,6 +791,11 @@ void fastcall __ipipe_sync_stage(unsigne
 			rank =3D __ipipe_ffnz(submask);
 			irq =3D (level << IPIPE_IRQ_ISHIFT) + rank;
=20
+			if (irq=3D=3D219)
+				printk("%s:%d %lx %p %p\n", __FUNCTION__, __LINE__,
+					ipipe_root.irqs[irq].control,
+					ipipe_root.irqs[irq].acknowledge,
+					ipipe_root.irqs[irq].handler);
 			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
 				__clear_bit(rank, &cpudata->irq_pending_lo[level]);
 				continue;
@@ -807,6 +812,8 @@ void fastcall __ipipe_sync_stage(unsigne
 			if (ipd =3D=3D ipipe_root_domain)
 				trace_hardirqs_off();
=20
+			if (irq=3D=3D219)
+				printk("%s:%d\n", __FUNCTION__, __LINE__);
 			__ipipe_run_isr(ipd, irq, cpuid);
 #ifdef CONFIG_SMP
 			{



--------------enigDDD4AD9A5BAC69D6976A1D2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOE5OniDOoMHTA+kRAiSbAJ9zktTG1RnhtyB/3uFBrEtVHi6yGQCfb2zO
aAFTc1vyDsQ2JlJW0c3+m18=
=Mkwf
-----END PGP SIGNATURE-----

--------------enigDDD4AD9A5BAC69D6976A1D2E--

