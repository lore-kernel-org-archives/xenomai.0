Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Oct 2008 14:34:18 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0155D80B@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <48F7302D.8050105@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] how to build a Xenomai posix library ?
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

> >> roderik.wildenburg@domain.hid wrote:
> >>> I did so and called, within the library, every=20
> >> posix_rt-function with
> >>> the prefix __wrap_ : e.g. __wrap_shm_open then I compiled my
> >>> application, which does not use any Xenomai-function, and=20
> linked it
> >>> with pthread_rt an rt (-lpthread_rt -lrt) and my new=20
> Xenomai-library
> >>> (linking without any wrapping defined). Linking and=20
> >> compiling did not
> >>> produce any error. But, when I call a function in my=20
> library, which
> >>> in turn calls __wrap_shm_open, then shm_open fails. When I link my
> >>> application with wrapping (as provided by the XENO_CONFIG-script)
> >>> then everything is fine. Do you have an explanation for=20
> >> this behavior
> >>> or even better a solution ?
> >> __wrap_shm_open only works if you have the=20
> CONFIG_XENO_OPT_POSIX_SHM
> >> option enabled. Is it enabled?
> >=20
> > yes it is :=20
> > CONFIG_XENO_OPT_POSIX_SHM=3Dy
> > otherwise, I think, my application linked with wrappings=20
> defined wouldn=B4t work ? But it does.
> >=20
> >> Note that xenomai posix skin shm support
> >> is mainly useful for sharing memory between kernel and=20
> >> user-space.=20
> > O.k., I just want to share SHM between applications. What=20
> SHM construct should I use instead ?
> >=20
> >> If it is enabled, then please tell us what is the value of=20
> errno when
> >> __wrap_shm_open fails.
> >>
> >=20
> > shm_open fails. errno=3D2
> > shm_open fails : : No such file or directory
> >=20
> > I don=B4t know what this should mean ??
>=20
> Well, it means that the shared memory does not exist.

I am quite shure that it exist. It is created by an other process.
Is there a /proc-entry or something else which lists existing shared =
memories ?

>=20
> > I call shm_open in the following way :
> > #define LOGSHMNAME   "/var/logshm"
> > oflags=3DO_RDWR;
> > *shmfd =3D shm_open(LOGSHMNAME, oflags, 0);
>=20
> a shm name should contain one slash at the beginning and no=20
> other slash,
> for best portability.

As I expected, reducing the number of slashes to one does not change the =
behavior.

> If you want to create a shared memory, you should pass the=20
> O_CREAT flag.

As mentioned above, an other process creates the shared memory.
What I still don=B4t understand is, what influence the wrapper defines =
have on linking.
With wrappers : aplication works fine. Without wrappers : application =
does not work !?

Roderik

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

