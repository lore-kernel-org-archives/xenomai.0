From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 18 Sep 2006 22:57:32 +0200
Message-Id: <1158613052.31164.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PATCH] pthread_attr_getinheritsched() doc fix
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

The attached patchlet fixes the documentation of
pthread_attr_getinheritsched() (PTHREAD_INHERIT_SCHED and
PTHREAD_EXPLICIT_SCHED were reversed).

Stelian.

Index: ksrc/skins/posix/thread_attr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/thread_attr.c	(r=E9vision 1648)
+++ ksrc/skins/posix/thread_attr.c	(copie de travail)
@@ -305,10 +305,10 @@
  * This service returns at the address @a inheritsched the value of the =
@a
  * inheritsched attribute in the attribute object @a attr.
  *
- * Threads created with this attribute set to PTHREAD_EXPLICIT_SCHED wil=
l use
+ * Threads created with this attribute set to PTHREAD_INHERIT_SCHED will=
 use
  * the same scheduling policy and priority as the thread calling
  * pthread_create(). Threads created with this attribute set to
- * PTHREAD_INHERIT_SCHED will use the value of the @a schedpolicy attrib=
ute as
+ * PTHREAD_EXPLICIT_SCHED will use the value of the @a schedpolicy attri=
bute as
  * scheduling policy, and the value of the @a schedparam  attribute as s=
cheduling
  * priority.
  *

--=20
Stelian Pop <stelian.pop@domain.hid>


