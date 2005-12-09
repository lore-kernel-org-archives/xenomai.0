Message-ID: <4399E194.6020403@domain.hid>
Date: Fri, 09 Dec 2005 20:57:08 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] fix rt_task_delete for cancellable
	rt-threads
References: <43987EA2.9000504@domain.hid>
In-Reply-To: <43987EA2.9000504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1917A26DFD7FCC624397515F"
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
--------------enig1917A26DFD7FCC624397515F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi,
> 
> no, this is not the fix for the issue I described earlier. This just
> improves the behaviour of rt_task_delete in case the target is blocking
> at a cancellation point (tested with standard sem_wait). With the
> current version, rt_task_deletes the rt-shadow and just wakes up the
> linux pthread even if the target is cancellable at that moment. With the
> reordering, this is fixed and the target is actually terminated. No
> major issue, though.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: src/skins/native/task.c
> ===================================================================
> --- src/skins/native/task.c	(revision 243)
> +++ src/skins/native/task.c	(working copy)
> @@ -203,12 +203,18 @@
>  int rt_task_delete (RT_TASK *task)
>  
>  {
> -    int err = XENOMAI_SKINCALL1(__native_muxid,
> -				__native_task_delete,
> -				task);
> -    if (!err)
> -	pthread_cancel((pthread_t)task->opaque2);
> +    int err;
>  
> +    err = pthread_cancel((pthread_t)task->opaque2)
> +    if (err)
> +        return -err;
> +
> +    err = XENOMAI_SKINCALL1(__native_muxid,
> +			    __native_task_delete,
> +			    task);
> +    if (err == -ESRCH)
> +	return 0;
> +
>      return err;
>  }
>  

Oops, fix for my patch:

--- ../src/skins/native/task.c  (Revision 251)
+++ ../src/skins/native/task.c  (Arbeitskopie)
@@ -206,7 +206,7 @@
 {
     int err;

-    err = pthread_cancel((pthread_t)task->opaque2)
+    err = pthread_cancel((pthread_t)task->opaque2);
     if (err)
         return -err;


I reorganised the code without a compiler run before posting.

Jan

--------------enig1917A26DFD7FCC624397515F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmeGUncNeS9Q0k+IRAhk5AJ9A3lwJNqXWzBG0Nb4VHJEThw9t+gCfcO0N
K4Yx0JxRM9bq9WdstAc0lhs=
=HjLp
-----END PGP SIGNATURE-----

--------------enig1917A26DFD7FCC624397515F--

