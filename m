Message-ID: <44B4EA3B.1010109@domain.hid>
Date: Wed, 12 Jul 2006 14:25:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
References: <44B4C09F.209@domain.hid>
	<b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>
In-Reply-To: <b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB089D6D1E97E596808B14B28"
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
--------------enigB089D6D1E97E596808B14B28
Content-Type: multipart/mixed; boundary="------------030603000103030900060604"

This is a multi-part message in MIME format.
--------------030603000103030900060604
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi,
>=20
>=20
> given the existing doc of rt_task_suspend about allowed environments an=
d
>> also when thinking about the logic behind it, I see no reason why
>> xnpod_unblockable_p() is also applied to task !=3D NULL.
>=20
>=20
>=20
> XNLOCK is set? anyway, I don't see how the patch makes current logic
> different...
>=20
> in both cases xnpod_unblockable_p() has a chance to be executed only wh=
en
> task !=3D NULL (thanks to goto). and -EPERM is returned when task !=3D =
NULL &&
> xnpod_unblockable_p() =3D=3D true.
>=20
>=20
>        if (!task) {
>>                 err =3D xeno_handle_error(task, XENO_TASK_MAGIC, RT_TA=
SK);
>>                 goto unlock_and_exit;
>> -       }
>> -
>> -       if (xnpod_unblockable_p()) {
>> +       } else if (xnpod_unblockable_p()) {
>>                 err =3D -EPERM;
>>                 goto unlock_and_exit;
>>         }
>>
>>
>>
>=20
>=20

Oh, my dear. I should stop hacking patches while talking to colleagues.
Does this one make more sense?

Jan

--------------030603000103030900060604
Content-Type: text/plain; name="suspend-foreign-task-from-any-context-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="suspend-foreign-task-from-any-context-v2.patch"

Index: ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/task.c	(revision 1323)
+++ ksrc/skins/native/task.c	(working copy)
@@ -391,9 +391,9 @@ int rt_task_start(RT_TASK *task, void (*
  *
  * - -EINVAL is returned if @a task is not a task descriptor.
  *
- * - -EPERM is returned if @a task is NULL but not called from a task
- * context, or this service was called from a context which cannot
- * sleep (e.g. interrupt, non-realtime or scheduler locked).
+ * - -EPERM is returned if @a task is NULL and this service was called
+ * from a context which cannot sleep (e.g. interrupt, non-realtime or
+ * scheduler locked).
  *
  * - -EIDRM is returned if @a task is a deleted task descriptor.
  *
@@ -432,7 +432,7 @@ int rt_task_suspend(RT_TASK *task)
 		goto unlock_and_exit;
 	}
=20
-	if (xnpod_unblockable_p()) {
+	if (xnpod_locked_p()) {
 		err =3D -EPERM;
 		goto unlock_and_exit;
 	}

--------------030603000103030900060604--

--------------enigB089D6D1E97E596808B14B28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtOo7niDOoMHTA+kRAqRLAJ4zP/0vVjGsQDWakCrtfqvaw6D0PACcCDcK
HiI2606NGvotyVBfMhn8TA0=
=eZZO
-----END PGP SIGNATURE-----

--------------enigB089D6D1E97E596808B14B28--

