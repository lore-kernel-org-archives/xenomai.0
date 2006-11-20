Message-ID: <1827213.1164009158538.JavaMail.ngmail@domain.hid>
Date: Mon, 20 Nov 2006 08:52:38 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Re: Re: What happens if task entry function
In-Reply-To: <1163865143.4990.47.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1163865143.4990.47.camel@domain.hid> <455DC001.2040001@domain.hid>
	<434646.1163765689576.JavaMail.ngmail@domain.hid>
	<16178634.1163773048304.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Philppe,

thanks for the patch. Using this patch, my test application is working now!
I have also update to the latest SVN version (1882) of Xenomai.
Using this version, the application works perfectly, too.

Regards

Mathias

> > First, I give you some more information about the error.
> > The output is the following:
> > Hi, I am task A Hello
> > Hi, I am task B World
> > Main waits for A
> > This is the end of A
> > Main waits for B
> >=20
> > Then the system hangs.
> >=20
>=20
> Confirmed here on a two-way PIII. Well, _this_ was a nice one.
> Basically, the softlock was due to a missing rescheduling call after
> task A has exited, leaving task B in ready state, somewhere in the
> Twilight Zone. The patch below fixes it on my setup:
>=20
> --- ksrc/nucleus/shadow.c=09(revision 1854)
> +++ ksrc/nucleus/shadow.c=09(working copy)
> @@ -1631,7 +1631,8 @@
> =20
>  static inline void do_taskexit_event(struct task_struct *p)
>  {
> -=09xnthread_t *thread =3D xnshadow_thread(p);=09/* p =3D=3D current */
> +=09xnthread_t *thread =3D xnshadow_thread(p); /* p =3D=3D current */
> +=09spl_t s;
> =20
>  =09if (!thread)
>  =09=09return;
> @@ -1639,12 +1640,15 @@
>  =09if (xnpod_shadow_p())
>  =09=09xnshadow_relax(0);
> =20
> -=09/* So that we won't attempt to further wakeup the exiting task in
> -=09   xnshadow_unmap(). */
> -
> +=09xnlock_get_irqsave(&nklock, s);
> +=09/* Prevent wakeup call from xnshadow_unmap(). */
>  =09xnshadow_thrptd(p) =3D NULL;
>  =09xnthread_archtcb(thread)->user_task =3D NULL;
> -=09xnpod_delete_thread(thread);=09/* Should indirectly call xnshadow_unm=
ap().
> */
> +=09/* xnpod_delete_thread() -> hook -> xnshadow_unmap(). */
> +=09xnpod_delete_thread(thread);
> +=09xnsched_set_resched(thread->sched);
> +=09xnpod_schedule();
> +=09xnlock_put_irqrestore(&nklock, s);
> =20
>  =09xnltt_log_event(xeno_ev_shadowexit, thread->name);
>  }
>=20
> --=20
> Philippe.
>=20
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

