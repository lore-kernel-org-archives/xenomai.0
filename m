Message-ID: <44B50771.9080003@domain.hid>
Date: Wed, 12 Jul 2006 16:30:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
References: <44B4C09F.209@domain.hid>	
	<b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>	
	<44B4EA3B.1010109@domain.hid>
	<b647ffbd0607120645n69a20805rfb9e62c8cfb3061f@domain.hid>
In-Reply-To: <b647ffbd0607120645n69a20805rfb9e62c8cfb3061f@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig61CEB8D69BDBA12BAAC9C638"
Sender: jan.kiszka@domain.hid
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
--------------enig61CEB8D69BDBA12BAAC9C638
Content-Type: multipart/mixed; boundary="------------040004000106030809080709"

This is a multi-part message in MIME format.
--------------040004000106030809080709
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> --- task.c      2006-05-19 18:25:19.000000000 +0200
> +++ task-my.c   2006-07-12 15:40:16.549170000 +0200
> @@ -426,7 +426,8 @@ int rt_task_suspend(RT_TASK *task)
>         goto unlock_and_exit;
>     }
>=20
>=20
> -    if (xnpod_unblockable_p()) {
> +    /* we are about to suspend a task, let's check wehther it may slee=
p */
> +    if (xnthread_test_flags(task, XNLOCK|XNROOT)) {
>         err =3D -EPERM;
>         goto unlock_and_exit;
>     }
>=20
>=20
>=20
> See the difference? :) it was slightly broken indeed, meaning it just
> bailed
> out all the calls from the interrupt context which is wrong according t=
o
> spec.

Fine, now I achieved what I always wanted: someone really thought about
it! :)

I tried to bundle your approach with appropriate documentation update
and a minor fix in the attached patch. Credits go to you then.

>=20
> maybe something like xnthread_task_unblockable/blockable(task)  would b=
e
> also of avail.
>=20
>=20
> Oh, my dear. I should stop hacking patches while talking to colleagues.=

>> Does this one make more sense?
>>
>=20
> maybe it's better that the other way around? I mean, writting good code=
 and
> saying nonsense to your collegues... :o>

Who said I was talking witted stuff to them?

Jan

--------------040004000106030809080709
Content-Type: text/plain; name="suspend-foreign-task-from-any-context-v3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="suspend-foreign-task-from-any-context-v3.patch"

Index: ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/task.c	(revision 1323)
+++ ksrc/skins/native/task.c	(working copy)
@@ -391,9 +391,8 @@ int rt_task_start(RT_TASK *task, void (*
  *
  * - -EINVAL is returned if @a task is not a task descriptor.
  *
- * - -EPERM is returned if @a task is NULL but not called from a task
- * context, or this service was called from a context which cannot
- * sleep (e.g. interrupt, non-realtime or scheduler locked).
+ * - -EPERM is returned if the addressed @a task is not allowed to sleep=

+ * (e.g. in interrupt context, non-realtime task, or scheduler locked).
  *
  * - -EIDRM is returned if @a task is a deleted task descriptor.
  *
@@ -432,7 +431,8 @@ int rt_task_suspend(RT_TASK *task)
 		goto unlock_and_exit;
 	}
=20
-	if (xnpod_unblockable_p()) {
+	/* We are about to suspend a task, let's check whether it may sleep */
+	if (xnthread_test_flags(&task->thread_base, XNLOCK|XNROOT)) {
 		err =3D -EPERM;
 		goto unlock_and_exit;
 	}

--------------040004000106030809080709--

--------------enig61CEB8D69BDBA12BAAC9C638
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtQdxniDOoMHTA+kRAsKSAJ9amHQG6zgh9mHO0yE474pYluyDsQCggm/e
a7x9j+1lSDzOK9mQr4dZSnA=
=uNtZ
-----END PGP SIGNATURE-----

--------------enig61CEB8D69BDBA12BAAC9C638--

