Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jan 2009 13:11:51 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D5908A8@domain.hid>
In-Reply-To: <497A2344.8060605@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D5908A3@domain.hid>
	<497A1963.8030902@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5908A4@domain.hid>
	<497A1E95.4080805@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5908A5@domain.hid>
	<497A2344.8060605@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] shadow task and rt_task_self()
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
Cc: xenomai@xenomai.org

That worked perfectly. Or at the very least, did not return NULL. :)=20

Thank you!

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Friday, January 23, 2009 1:06 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] shadow task and rt_task_self()
>=20
> Steven Seeger wrote:
> > Gilles,
> >
> > Attached is my simple test that repeats this problem.
> >
> > Output is:
> >
> > 0
> > 0 0
> >
> > This is using latest xenomai trunk.
> >
>=20
> Ok. Try this:
>=20
> Index: src/skins/native/task.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/skins/native/task.c	(revision 4570)
> +++ src/skins/native/task.c	(working copy)
> @@ -210,8 +210,12 @@ int rt_task_shadow(RT_TASK *task, const
>  	err =3D XENOMAI_SKINCALL2(__native_muxid, __native_task_create,
> &bulk,
>  				NULL);
>=20
> -	if (!err)
> +	if (!err) {
> +#ifdef HAVE___THREAD
> +		__native_self =3D *task;
> +#endif /* HAVE___THREAD */
>  		xeno_set_current();
> +	}
>=20
>  	return err;
>  }
>=20
>=20
> --
> 					    Gilles.

