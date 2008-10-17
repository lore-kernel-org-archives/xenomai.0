Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Oct 2008 11:58:31 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0155DA45@domain.hid>
In-Reply-To: <48F73680.8020103@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] how to build a Xenomai posix library ? solved
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Just for information :
in my new xenomai library I wraped shm_open (->__wrap_shm_open) =
shm_inlink (->__wrap_unlink) and so on (all symbols I=B4ve got a =
"unresolved" for). Unfortunatelly I did not get a "unresolved" for =
ftruncate and mmap, so I didn=B4t wraped them. Wrapping these symbols =
solved my problem (library is linkable without wrapers defined and the =
application linked with my new library works fine).
Thank you Gilles for your support !
Roderik


> -----Urspr=FCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Gesendet: Donnerstag, 16. Oktober 2008 14:42
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] how to build a Xenomai posix library ?
>=20
> roderik.wildenburg@domain.hid wrote:
> >>>> roderik.wildenburg@domain.hid wrote:
> >>> *shmfd =3D shm_open(LOGSHMNAME, oflags, 0);
> >> a shm name should contain one slash at the beginning and no=20
> >> other slash,
> >> for best portability.
> >=20
> > As I expected, reducing the number of slashes to one does=20
> not change the behavior.
>=20
> I never said it would.
>=20
> >=20
> >> If you want to create a shared memory, you should pass the=20
> >> O_CREAT flag.
> >=20
> > As mentioned above, an other process creates the shared memory.
>=20
> Is it also linked with xenomai posix skin?
>=20
> > What I still don=B4t understand is, what influence the=20
> wrapper defines have on linking.
> > With wrappers : aplication works fine. Without wrappers :=20
> application does not work !?
>=20
> I would say that with wrappers, you are in fact using the=20
> vanilla linux
> shared memory, by passing __wrap_shm_open, you really use=20
> xenomai posix
> skin services.
>=20
> If that is the case, when using the wrapped version, you=20
> should see the
> shared memory appear under /dev/shm.
>=20
> --=20
>                                                  Gilles.
>

Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address! =
roderik.wildenburg@domain.hid
--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

