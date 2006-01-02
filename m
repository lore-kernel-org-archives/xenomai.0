Message-ID: <43B970CD.4020005@domain.hid>
Date: Mon, 02 Jan 2006 19:28:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31656A1BF1869B1DA83EB650"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix ipipe for !CONFIG_PRINTK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31656A1BF1869B1DA83EB650
Content-Type: multipart/mixed; boundary="------------050705050000070906040800"

This is a multi-part message in MIME format.
--------------050705050000070906040800
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this patch lets ipipe compile even if someone is annoyed of all the
babbling on the kernel console. ;)

Jan

--------------050705050000070906040800
Content-Type: text/x-patch;
 name="no_printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no_printk.patch"

--- linux-2.6.14.3/kernel/ipipe/core.c.orig	2005-12-17 14:08:23.000000000 +0100
+++ linux-2.6.14.3/kernel/ipipe/core.c	2006-01-01 18:58:18.000000000 +0100
@@ -43,7 +43,9 @@
 
 unsigned long __ipipe_virtual_irq_map = 0;
 
+#ifdef CONFIG_PRINTK
 unsigned __ipipe_printk_virq;
+#endif /* CONFIG_PRINTK */
 
 int __ipipe_event_monitors[IPIPE_NR_EVENTS];
 
@@ -76,10 +78,12 @@
 
 	__ipipe_init_platform();
 
+#ifdef CONFIG_PRINTK
 	__ipipe_printk_virq = ipipe_alloc_virq();	/* Cannot fail here. */
 	ipd->irqs[__ipipe_printk_virq].handler = &__ipipe_flush_printk;
 	ipd->irqs[__ipipe_printk_virq].acknowledge = NULL;
 	ipd->irqs[__ipipe_printk_virq].control = IPIPE_HANDLE_MASK;
+#endif /* CONFIG_PRINTK */
 
 	__ipipe_enable_pipeline();
 

--------------050705050000070906040800--

--------------enig31656A1BF1869B1DA83EB650
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDuXDNniDOoMHTA+kRAmboAJ4z7E3T2tl83fo0wJRNJxR6IsPDPACcD58U
7SKtUzUPD7IFJ8uHCZmg1m4=
=nQKe
-----END PGP SIGNATURE-----

--------------enig31656A1BF1869B1DA83EB650--

