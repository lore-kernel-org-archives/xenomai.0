Message-ID: <43F3C4EA.7050303@domain.hid>
Date: Thu, 16 Feb 2006 01:18:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0602150939g59256b2bx@domain.hid>
In-Reply-To: <b647ffbd0602150939g59256b2bx@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig133712627828A20C50812FD2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
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
--------------enig133712627828A20C50812FD2
Content-Type: multipart/mixed; boundary="------------080006020606010904060900"

This is a multi-part message in MIME format.
--------------080006020606010904060900
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hello everybody,
>=20
> being inspired by successful results of tests conducted recently by Jan=
 &
> team,
> I'm presenting the final (yep, yet another final :) combo-patch.
>=20
> The shirq support now is optional, so that
>=20
> CONFIG_XENO_OPT_SHIRQ_LEVEL -    enables shirq for level-triggered
> interrupts;
>=20
> CONFIG_XENO_OPT_SHIRQ_EDGE  -    -//- for edge-triggered ones.
>=20
> I addressed all the remarks and now, IMHO, it's (hopefully) ready for m=
erge.
>=20

Hmm, I still find XN_ISR_NOINT in the patch. Shouldn't we solve this
before merging (i.e. make XN_ISR_HANDLED non-zero)?

Moreover, I attached an add-on patch to overcome the name buffer in
xnintr_t. Note that this patch is only compile-tested, I have no native
interrupt test-case at hand.

Jan

--------------080006020606010904060900
Content-Type: text/x-patch;
 name="shirq-name.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="shirq-name.patch"

diff -u include/nucleus/intr.h include/nucleus/intr.h
--- include/nucleus/intr.h	(Arbeitskopie)
+++ include/nucleus/intr.h	(Arbeitskopie)
@@ -54,7 +54,7 @@
=20
     xniack_t iack;	/* !< Interrupt acknowledge routine. */
=20
-    char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
+    const char *name; /* !< Symbolic name. */
=20
 } xnintr_t;
=20
diff -u ksrc/skins/native/syscall.c ksrc/skins/native/syscall.c
--- ksrc/skins/native/syscall.c	(Arbeitskopie)
+++ ksrc/skins/native/syscall.c	(Arbeitskopie)
@@ -2883,23 +2883,15 @@
     char name[XNOBJECT_NAME_LEN];
     RT_INTR_PLACEHOLDER ph;
     int err, mode;
-    RT_INTR *intr;
+    struct {
+	RT_INTR intr;
+	char name[XNOBJECT_NAME_LEN];
+    } *intr_buf;
     unsigned irq;
=20
     if (!__xn_access_ok(curr,VERIFY_WRITE,__xn_reg_arg1(regs),sizeof(ph)=
))
 	return -EFAULT;
=20
-    if (__xn_reg_arg2(regs))
-	{
-	if (!__xn_access_ok(curr,VERIFY_READ,__xn_reg_arg2(regs),sizeof(name)))=

-	    return -EFAULT;
-
-	__xn_strncpy_from_user(curr,name,(const char __user *)__xn_reg_arg2(reg=
s),sizeof(name) - 1);
-	name[sizeof(name) - 1] =3D '\0';
-	}
-    else
-	*name =3D '\0';
-
     /* Interrupt line number. */
     irq =3D (unsigned)__xn_reg_arg3(regs);
=20
@@ -2909,23 +2901,41 @@
     if (mode & ~(I_AUTOENA|I_PROPAGATE))
 	return -EINVAL;
=20
-    intr =3D (RT_INTR *)xnmalloc(sizeof(*intr));
+    intr_buf =3D (typeof(intr_buf))xnmalloc(sizeof(*intr_buf));
=20
-    if (!intr)
+    if (!intr_buf)
 	return -ENOMEM;
=20
-    err =3D rt_intr_create(intr,name,irq,&rt_intr_handler,NULL,0);
+    if (__xn_reg_arg2(regs))
+	{
+	if (!__xn_access_ok(curr,VERIFY_READ,__xn_reg_arg2(regs),sizeof(name)))=

+	    {
+	    xnfree(intr_buf);
+	    return -EFAULT;
+	    }
+
+	__xn_strncpy_from_user(curr,
+	                       intr_buf->name,
+	                       (const char __user *)__xn_reg_arg2(regs),
+	                       sizeof(intr_buf->name) - 1);
+	intr_buf->name[sizeof(intr_buf->name) - 1] =3D '\0';
+	}
+    else
+	intr_buf->name[0] =3D '\0';
+
+
+    err =3D rt_intr_create(&intr_buf->intr,intr_buf->name,irq,&rt_intr_h=
andler,NULL,0);
=20
     if (err =3D=3D 0)
 	{
-	intr->mode =3D mode;
-	intr->cpid =3D curr->pid;
+	intr_buf->intr.mode =3D mode;
+	intr_buf->intr.cpid =3D curr->pid;
 	/* Copy back the registry handle to the ph struct. */
-	ph.opaque =3D intr->handle;
+	ph.opaque =3D intr_buf->intr.handle;
 	__xn_copy_to_user(curr,(void __user *)__xn_reg_arg1(regs),&ph,sizeof(ph=
));
 	}
     else
-	xnfree(intr);
+	xnfree(intr_buf);
=20
     return err;
 }
diff -u ksrc/nucleus/intr.c ksrc/nucleus/intr.c
--- ksrc/nucleus/intr.c	(Arbeitskopie)
+++ ksrc/nucleus/intr.c	(Arbeitskopie)
@@ -148,7 +148,7 @@
     intr->cookie =3D NULL;
     intr->hits =3D 0;
     intr->flags =3D flags;
-    xnobject_copy_name(intr->name,name);
+    intr->name =3D name;
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
     intr->next =3D NULL;
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */

--------------080006020606010904060900--

--------------enig133712627828A20C50812FD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD88TuniDOoMHTA+kRAh8iAJ9+FwCiTMZNbxh96lqp7l5lHHckvwCeKYYv
cVTPEqcTPr4uYmmvirzz83U=
=6mLO
-----END PGP SIGNATURE-----

--------------enig133712627828A20C50812FD2--

