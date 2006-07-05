Message-ID: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14D@kheops.clb.tcfr.thales>
From: Antoine.BRUGEAS@fr.thalesgroup.com
Subject: RE: [Xenomai-help] Modification of the PSOS skin. [update]
Date: Wed, 5 Jul 2006 13:46:37 +0200 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Content-Transfer-Encoding: quoted-printable
To: jan.kiszka@domain.hid
Cc: Xenomai-help@domain.hid

Result of the diff command :

*************************for psos.h

321a322
> #define ERR_SSFN     0x03     /* Illegal system service function number */
325a327
> #define ERR_OBJTFULL 0x08     /* Node's Object table full */
327a330
> #define ERR_RSTFS    0x0D     /* Informative; files may be corrupted */
338a342,345
> #define ERR_DELFS    0x18     /* pHILE+ resources in use */
> #define ERR_DELLC    0x19     /* pREPC+ resources in use */
> #define ERR_DELNS    0x1A     /* pNA+ resources in use */
>=20
343a351,352
>=20
> #define ERR_ZERO     0x20     /* Cannot getseg; request size of zero is */
359a369
> #define ERR_KISIZE   0x30     /* Message length exceeds KI maximum */
380a391
>=20
388a400,408
> #define ERR_ILLRSC   0x53     /* Object not created from this node */
> #define ERR_NOAGNT   0x54     /* Cannot wait; the remote node is out */
>                               /* of Agents */
> #define ERR_AGTBLKD  0x55     /* Agent blocked.  This is not an error. */
>=20
> #define ERR_STALEID  0x65     /* Object does not exist any more */
> #define ERR_NDKLD    0x66     /* Remote Node no longer in service */
> #define ERR_MASTER   0x67     /* Cannot terminate Master node */
>=20


*************************for task.c

177c177,189
<     task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
---
>     //task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>     if (tid =3D=3D 0)/*Add by AB*/
> 	task =3D psos_current_task();
>     else
> 	{
> 	task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>=20
> 	if (!task)
> 	    {
> 	    err =3D psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
> 	    goto unlock_and_exit;
> 	    }
> 	}
224c236,248
<     task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
---
> //    task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>     if (tid =3D=3D 0)/*Add by AB*/
> 	task =3D psos_current_task();
>     else
> 	{
> 	task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>=20
> 	if (!task)
> 	    {
> 	    err =3D psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
> 	    goto unlock_and_exit;
> 	    }
> 	}
264c288,300
<     task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
---
> //    task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>     if (tid =3D=3D 0)/*Add by AB*/
> 	task =3D psos_current_task();
>     else
> 	{
> 	task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>=20
> 	if (!task)
> 	    {
> 	    err =3D psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
> 	    goto unlock_and_exit;
> 	    }
> 	}
351c387,398
<     task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
---
>    if (tid =3D=3D 0)/*Add by AB*/
> 	task =3D psos_current_task();
>     else
> 	{
> 	task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>=20
> 	if (!task)
> 	    {
> 	    err =3D psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
> 	    goto unlock_and_exit;
> 	    }
> 	}
383c430,442
<     task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
---
> //    task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>     if (tid =3D=3D 0)/*Add by AB*/
> 	task =3D psos_current_task();
>     else
> 	{
> 	task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>=20
> 	if (!task)
> 	    {
> 	    err =3D psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
> 	    goto unlock_and_exit;
> 	    }
> 	}
424c483,495
<     task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
---
>     //    task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>     if (tid =3D=3D 0)/*Add by AB*/
> 	task =3D psos_current_task();
>     else
> 	{
> 	task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>=20
> 	if (!task)
> 	    {
> 	    err =3D psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
> 	    goto unlock_and_exit;
> 	    }
> 	}
505c576
<     spl_t s;
---
>     spl_t s;			=09
509c580,593
<     task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
---
>  =20
> //    task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>     if (tid =3D=3D 0)/*Add by AB*/
> 	task =3D psos_current_task();
>     else
> 	{
> 	task =3D psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
>=20
> 	if (!task)
> 	    {
> 	    err =3D psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
> 	    goto unlock_and_exit;
> 	    }
> 	}



-----Message d'origine-----
De : jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
Envoy=E9 : mardi 4 juillet 2006 15:46
=C0 : Antoine.BRUGEAS@fr.thalesgroup.com
Cc : Xenomai-help@domain.hid
Objet : Re: [Xenomai-help] Modification of the PSOS skin.


Antoine.BRUGEAS@fr.thalesgroup.com wrote:
> hello,
>=20
> Xenomai is under the GPL license, and I think that I have to
> redistribute the source code when I modify or add something on it.
> But, I don't know how to process to distribute the source code. Then,
> I give you modifications in this mailing list.
>=20

In general, publication of your patches is required when you give
binaries to some third party. In-house use doesn't require this by law.
Nevertheless, we can only encourage anyone to follow your good example
and send us improvements! You will gain feedback and make sure that
future versions will already contain your patches.

Just a hint on the preferred patch format: either generate a diff of
individual modified files by invoking "diff -up file file.orig >>
my.patch" or - even easier - check out the subversion repository (see
https://gna.org/svn/?group=3Dxenomai for details), change your files and
run "svn diff > my.patch". This makes it easier to review the
differences and integrate them in the tree.

Sorry, I cannot comment on code details, but I'm sure others will.

Thanks,
Jan


