Message-ID: <45DEE670.30306@domain.hid>
Date: Fri, 23 Feb 2007 14:04:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBBCA44D3607F7D672BCCD0FB"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] 2.6.20-i386: fix collateral damage of regparm
	cleanup
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
--------------enigBBCA44D3607F7D672BCCD0FB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Index: linux-2.6.20.1/arch/i386/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.1.orig/arch/i386/kernel/entry.S
+++ linux-2.6.20.1/arch/i386/kernel/entry.S
@@ -108,7 +108,7 @@ VM_MASK		=3D 0x00020000
 # define IPIPE_TRACE_IRQ_ENTER \
 	lea PT_EIP-4(%esp), %ebp; \
 	movl PT_ORIG_EAX(%esp), %eax; \
-	call ipipe_trace_begin; \
+	call ipipe_trace_begin
 # define IPIPE_TRACE_IRQ_EXIT \
 	pushl %eax; \
 	movl PT_ORIG_EAX+4(%esp), %eax; \


--------------enigBBCA44D3607F7D672BCCD0FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3uZwniDOoMHTA+kRAmHmAJoCQy5X8rTXqDwWvhATKJqaRZMrIgCaAl2S
UPwD8omWiZytqaP/ayH5UqY=
=iosX
-----END PGP SIGNATURE-----

--------------enigBBCA44D3607F7D672BCCD0FB--

