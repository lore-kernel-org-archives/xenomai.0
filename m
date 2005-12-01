Message-ID: <438EABE1.2010207@domain.hid>
Date: Thu, 01 Dec 2005 08:53:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] minor doc clarification
References: <438E42B7.5080808@domain.hid>
In-Reply-To: <438E42B7.5080808@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
>=20
> this patch clarifies the usage of rtdm_task_join_nrt.

Applied, thanks.

>=20
> Typically, rtdm_task_join_nrt + target task wakeup should be preferred
> over rtdm_task_destroy during cleanup of drivers. It's now intensively
> used in RTnet.
>=20
> Jan
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: ChangeLog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ChangeLog	(Revision 219)
> +++ ChangeLog	(Arbeitskopie)
> @@ -1,3 +1,7 @@
> +2005-12-01  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* ksrc/skins/rtdm/drvlib.c (rtdm_task_join_nrt): Clarify doc.
> +
>  2005-11-30  Philippe Gerum  <rpm@xenomai.org>
> =20
>  	* ksrc/nucleus/pod.c (xnpod_delete_thread): Prevent double-deletion.
> @@ -10,7 +14,7 @@
>  	* ksrc/arch/powerpc/patches: Upgrade to Adeos
>  	2.4.25-denx-0.9-04, 2.6.10-ppc64-r3.patch.
> =20
> -2005-11-30  Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid>
> +2005-11-30  Ignacio Garcia Perez <iggarpe@domain.hid>
> =20
>  	* ksrc/nucleus/timer.c: Make internal routines static.
> =20
> Index: ksrc/skins/rtdm/drvlib.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/skins/rtdm/drvlib.c	(Revision 219)
> +++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
> @@ -250,6 +250,11 @@
>   * @param[in,out] task Task handle as returned by rtdm_task_init()
>   * @param[in] poll_delay Polling delay in milliseconds
>   *
> + * @note It is not required to call rtdm_task_destroy() for a task whi=
ch has
> + * been passed to rtdm_task_join_nrt(). Moreover, don't forget to info=
rm the
> + * targeted task that it has to terminate. Otherwise, this function wi=
ll never
> + * return.
> + *
>   * Environments:
>   *
>   * This service can be called from:
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20

Philippe.

