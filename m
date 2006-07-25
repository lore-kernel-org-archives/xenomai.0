Message-ID: <44C6929C.5030804@domain.hid>
Date: Tue, 25 Jul 2006 23:52:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How can I now when it will be next periodic task
	release point?
References: <200607251735.35500.lbocseg@domain.hid>
In-Reply-To: <200607251735.35500.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2AE8BFB83F868E8D3D5505BE"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AE8BFB83F868E8D3D5505BE
Content-Type: multipart/mixed; boundary="------------060908030504070409010504"

This is a multi-part message in MIME format.
--------------060908030504070409010504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> I want to capture and process images each 300 ms. The processing routin=
es take=20
> a (fixed, but unknown) time. I'd like to request a new image about 50 m=
s=20
> before next release point, like this:
>=20
> for(;;)
> {
> 	rt_task_wait_period(NULL);
> 	ProcessImage();
> 	rt_task_sleep(XXX); // until 50 ms before next release point
> 	RequestNewImage();
> }
>=20
> I could use rt_task_inquire() if RT_TASK_INFO was documented. From=20
> source-code:
>   RTIME relpoint;             /* !< Periodic release point. */
>=20
> The question is which release point? Next or the last reached?

Looks like you managed to dig out dead/broken code here: RT_TASK.timer,
the timer returned in relpoint, is nowhere else used than in
rt_task_inquire.

> Anyway, a new function like rt_task_getnextrelpoint() would be very wel=
come...
>=20
> rt_task_sleep(rt_task_getnextrelpoint() - 50*1000*1000);

See my attached patch. It should fix rt_task_inquire in a way that meets
your requirements. It also clarifies the doc. Only compile tested.

Philippe, is it correct?

Jan

--------------060908030504070409010504
Content-Type: text/plain;
 name="return-ptimer-in-rt_task_inquire.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="return-ptimer-in-rt_task_inquire.patch"

Index: include/native/task.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/native/task.h	(Revision 1374)
+++ include/native/task.h	(Arbeitskopie)
@@ -76,7 +76,7 @@ typedef struct rt_task_info {
=20
     unsigned status;		/* !< Status. */
=20
-    RTIME relpoint;		/* !< Periodic release point. */
+    RTIME relpoint;		/* !< Next periodic release point. */
=20
     char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
=20
@@ -109,8 +109,6 @@ typedef struct rt_task {
 #define link2rtask(laddr) \
 ((RT_TASK *)(((char *)laddr) - (int)(&((RT_TASK *)0)->link)))
=20
-    xntimer_t timer;
-
     xnthread_t thread_base;
=20
     char rname[XNOBJECT_NAME_LEN]; /* !< Name in registry. Not the same =
as
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 1374)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2006-07-25  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/native/task.h, ksrc/native/task.c: Kill unused timer field
+	in RT_TASK. Return ptimer of the underlying thread on rt_task_inquire.
+
 2006-07-23  Jan Kiszka  <jan.kiszka@domain.hid>
=20
 	* ksrc/skins/native/Makefile: Fixed typo that messed up modularised
Index: ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/task.c	(Revision 1374)
+++ ksrc/skins/native/task.c	(Arbeitskopie)
@@ -1118,7 +1118,7 @@ int rt_task_inquire(RT_TASK *task, RT_TA
 	info->bprio =3D xnthread_base_priority(&task->thread_base);
 	info->cprio =3D xnthread_current_priority(&task->thread_base);
 	info->status =3D xnthread_status_flags(&task->thread_base);
-	info->relpoint =3D xntimer_get_date(&task->timer);
+	info->relpoint =3D xntimer_get_date(&task->thread_base.ptimer);
=20
       unlock_and_exit:
=20

--------------060908030504070409010504--

--------------enig2AE8BFB83F868E8D3D5505BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFExpKdniDOoMHTA+kRAo81AJ0f3qwOENKimqd275lXcH5bu0cw0ACfYAY7
h6xMmBhMNmwqCLp1RaOtHBo=
=1vaf
-----END PGP SIGNATURE-----

--------------enig2AE8BFB83F868E8D3D5505BE--

