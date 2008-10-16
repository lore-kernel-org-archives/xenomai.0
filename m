Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Oct 2008 12:14:43 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0155D72A@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <48F70DE3.7000801@domain.hid>
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

> -----Urspr=FCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Gesendet: Donnerstag, 16. Oktober 2008 11:48
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] how to build a Xenomai posix library ?
>=20
> roderik.wildenburg@domain.hid wrote:
> > I did so and called, within the library, every=20
> posix_rt-function with
> > the prefix __wrap_ : e.g. __wrap_shm_open then I compiled my
> > application, which does not use any Xenomai-function, and linked it
> > with pthread_rt an rt (-lpthread_rt -lrt) and my new Xenomai-library
> > (linking without any wrapping defined). Linking and=20
> compiling did not
> > produce any error. But, when I call a function in my library, which
> > in turn calls __wrap_shm_open, then shm_open fails. When I link my
> > application with wrapping (as provided by the XENO_CONFIG-script)
> > then everything is fine. Do you have an explanation for=20
> this behavior
> > or even better a solution ?
>=20
> __wrap_shm_open only works if you have the CONFIG_XENO_OPT_POSIX_SHM
> option enabled. Is it enabled?

yes it is :=20
CONFIG_XENO_OPT_POSIX_SHM=3Dy
otherwise, I think, my application linked with wrappings defined =
wouldn=B4t work ? But it does.

> Note that xenomai posix skin shm support
> is mainly useful for sharing memory between kernel and=20
> user-space.=20
O.k., I just want to share SHM between applications. What SHM construct =
should I use instead ?

> If it is enabled, then please tell us what is the value of errno when
> __wrap_shm_open fails.
>=20

shm_open fails. errno=3D2
shm_open fails : : No such file or directory

I don=B4t know what this should mean ??
I call shm_open in the following way :
#define LOGSHMNAME   "/var/logshm"
oflags=3DO_RDWR;
*shmfd =3D shm_open(LOGSHMNAME, oflags, 0);

Again, linking my application with all the wrappers defined builds a =
well working application. So, for me, the SHM-constructs are o.K., but =
linking builds different applications, depending on the wrappers.

Here is the console output of linking without wrappers:
ppc-linux-gcc -I/opt/eldk/xenomai/include =
-I/opt/eldk/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__ =
-g -Wall  pecomlog.c -c -o pecomlog.o
ppc-linux-gcc   -L/opt/eldk/xenomai/lib -lpthread_rt -lrt -Wall -o =
pecomlog  pecomlog.o loglib.a

where loglib.a is my new Xenomay library and pecomlog is my application.

many thanks for your help !

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

