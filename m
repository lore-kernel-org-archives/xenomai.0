Subject: Re: [Xenomai-help] POSIX headers and PTHREAD_IPROPAGATE
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4549B048.8070607@domain.hid>
References: <454931B9.3070304@domain.hid>  <4549B048.8070607@domain.hid>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Nov 2006 10:10:04 +0100
Message-Id: <1162458604.4984.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2006-11-02 at 09:46 +0100, Gilles Chanteperdrix wrote:
> Jeff Webb wrote:
> > If I attempt to use PTHREAD_IPROPAGATE in my userspace POSIX skin=20
> > Xenomai program, I get the following:
> >=20
> > irqtest.c: In function =E2=80=98main=E2=80=99:
> > irqtest.c:278: error: =E2=80=98XN_ISR_PROPAGATE=E2=80=99 undeclared (=
first use in this=20
> > function)irqtest.c:278: error: (Each undeclared identifier is reporte=
d=20
> > only once
> > irqtest.c:278: error: for each function it appears in.)
> >=20
> > Including <nucleus/intr.h> fixes the problem.  I assume there should =
be=20
> > a #include in one of the POSIX header files.
>=20
> I checked the trunk and the v2.2.x branch, and pthread.h includes
> nucleus/xenomai.h which includes nucleus/intr.h, so including directly
> nucleus/intr.h should not be necessary.
>=20

The main header is not included in the user-space case. The patch below
should fix this:

--- include/posix/pthread.h	(revision 1786)
+++ include/posix/pthread.h	(working copy)
@@ -147,10 +147,11 @@
 #include <sched.h>
 #include_next <pthread.h>
 #include <nucleus/thread.h>
+#include <nucleus/intr.h>
=20
 struct timespec;
=20
-#endif /* !(__KERNEL__ || __XENO_SIM__) */
+#endif /* __KERNEL__ || __XENO_SIM__ */
=20
 #define PTHREAD_PRIO_NONE    0
 #define PTHREAD_PRIO_INHERIT 1
@@ -497,6 +498,6 @@
 }
 #endif
=20
-#endif /* !(__KERNEL__ || __XENO_SIM__) */
+#endif /* __KERNEL__ || __XENO_SIM__ */
=20
 #endif /* _XENO_POSIX_PTHREAD_H */


--=20
Philippe.



