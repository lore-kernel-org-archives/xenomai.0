Message-ID: <441C2574.4030901@domain.hid>
Date: Sat, 18 Mar 2006 16:21:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC85EA80B53828A49A00915F2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] get the simulator running...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC85EA80B53828A49A00915F2
Content-Type: multipart/mixed; boundary="------------020404050107090103010401"

This is a multi-part message in MIME format.
--------------020404050107090103010401
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe,

here are some patches and comments on the simulator "quick"-start
process. I guess the patches are due to latest changes in trunk, and I
cannot guarantee that they are clean - but the simulator compiles now.

Regarding the rest of its build and start process: There are two hidden
requirements, namely gcc < 4 (due to -fwritable-strings) and gdb 5.x. A
note in sim/README about them would be great. Or do you have a fix for
those issues scheduled?

Well, once you got this far (i.e. the xenoscope is built and an ancient
gdb has been prepared), the next step is to produce a test program. Am I
overseeing some example? Fortunately, I had that demo I once produced
(last year), but that one was easier to build. I first had to drag in
the libs and includes of both the simulator and a regular xenomai
installation (I think to remember this once worked without this
add-ons). Then I need this additional trick in the simulators include dir=
:

mkdir asm
ln -s <xeno-inst-dir>/include/asm-sim asm/xenomai

This maps #include <asm/xenomai/system.h> to the correct "arch".
Shouldn't this be created automatically during the simulator
installation? Or is something else broken on my box?

In case there is no demo prepared, I could pack my own tiny stuff and
submit it.

Jan

--------------020404050107090103010401
Content-Type: text/x-patch;
 name="sim-fixes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="sim-fixes.patch"

Index: ksrc/skins/vxworks/msgQLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vxworks/msgQLib.c	(Revision 742)
+++ ksrc/skins/vxworks/msgQLib.c	(Arbeitskopie)
@@ -199,7 +199,7 @@
     appendq(&wind_msgq_q, &queue->link);
     xnlock_put_irqrestore(&nklock, s);
    =20
-#ifdef CONFIG_XENO_OPT_REGISTRY
+#ifdef CONFIG_XENO_EXPORT_REGISTRY
     sprintf(queue->name,"mq%lu",msgq_ids++);
=20
     if (xnregistry_enter(queue->name,queue,&queue->handle,&msgq_pnode))
@@ -208,7 +208,7 @@
 	msgQDelete((MSG_Q_ID)queue);
 	return 0;
 	}
-#endif /* CONFIG_XENO_OPT_REGISTRY */
+#endif /* CONFIG_XENO_EXPORT_REGISTRY */
=20
     return (MSG_Q_ID) queue;
 }
Index: ksrc/skins/vxworks/wdLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vxworks/wdLib.c	(Revision 742)
+++ ksrc/skins/vxworks/wdLib.c	(Arbeitskopie)
@@ -123,7 +123,7 @@
     appendq(&wind_wd_q,&wd->link);
     xnlock_put_irqrestore(&nklock, s);
=20
-#ifdef CONFIG_XENO_OPT_REGISTRY
+#ifdef CONFIG_XENO_EXPORT_REGISTRY
     sprintf(wd->name,"wd%lu",wd_ids++);
=20
     if (xnregistry_enter(wd->name,wd,&wd->handle,&wd_pnode))
@@ -132,7 +132,7 @@
 	wdDelete((WDOG_ID)wd);
 	return 0;
 	}
-#endif /* CONFIG_XENO_OPT_REGISTRY */
+#endif /* CONFIG_XENO_EXPORT_REGISTRY */
=20
     return (WDOG_ID) wd;
 }
Index: ksrc/skins/vxworks/semLib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/vxworks/semLib.c	(Revision 742)
+++ ksrc/skins/vxworks/semLib.c	(Arbeitskopie)
@@ -479,7 +479,7 @@
     xnlock_get_irqsave(&nklock, s);
     appendq(&wind_sem_q,&sem->link);
     xnlock_put_irqrestore(&nklock, s);
-#ifdef CONFIG_XENO_OPT_REGISTRY
+#ifdef CONFIG_XENO_EXPORT_REGISTRY
     sprintf(sem->name,"sem%lu",sem_ids++);
=20
     if (xnregistry_enter(sem->name,sem,&sem->handle,&sem_pnode))
@@ -488,7 +488,7 @@
 	semDelete((SEM_ID)sem);
 	return 0;
 	}
-#endif /* CONFIG_XENO_OPT_REGISTRY */
+#endif /* CONFIG_XENO_EXPORT_REGISTRY */
=20
     return (SEM_ID) sem;
 }
Index: include/asm-sim/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-sim/system.h	(Revision 742)
+++ include/asm-sim/system.h	(Arbeitskopie)
@@ -80,6 +80,7 @@
=20
 #define XNARCH_DEFAULT_TICK         10000000 /* ns, i.e. 10ms */
 #define XNARCH_HOST_TICK            0 /* No host ticking service. */
+#define HZ                          0 /* dummy define for HZ */
=20
 #define XNARCH_THREAD_STACKSZ 0 /* Let the simulator choose. */
 #define XNARCH_ROOT_STACKSZ   0	/* Only a placeholder -- no stack */

--------------020404050107090103010401--

--------------enigC85EA80B53828A49A00915F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHCV5niDOoMHTA+kRAg9HAJ9OvY5tOSrofrwWmDqVl1j7AJ44UACeL76c
0UCj3tKsLHEiqkJj32lVjNk=
=k5n6
-----END PGP SIGNATURE-----

--------------enigC85EA80B53828A49A00915F2--

