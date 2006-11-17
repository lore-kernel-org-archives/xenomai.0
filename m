Message-ID: <434646.1163765689576.JavaMail.ngmail@domain.hid>
Date: Fri, 17 Nov 2006 13:14:49 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: Re: What happens if task entry function returns?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,=20

I found out, that is issue seems to be related to the NPTL (native posix th=
read library).
The pthread library in use was=20
/lib/tls/i686/cmov/libpthread.so.0
which is part of the Debian (testing) package libc6-i686.
(see http://packages.debian.org/testing/libs/libc6-i686)

When renaming the lib/tls to lib/tls.disabled the pthread library in use is
/lib/libpthread.so.0
and then it is working perfectly!

It seems that the i686 optimized libc is not fully compatible with Xenomai.
I read about this library at Romain Lenglet's web page:
http://www.csg.is.titech.ac.jp/~lenglet/howtos/realtimelinuxhowto/index.htm=
l
I think this library uses the NPTL (Native Posix Thread Lib).
The i686 optimized library shows the value
NPTL 2.3.6 =20
at=20
getconf GNU_LIBPTHREAD_VERSION
The "old" pthread lib shows the value:
linuxthreads-0.10

Now, I tried to reconfigure Xenomai with --enable-x86-sep to use
the NPTL but this did not help either.
When I rename now  /lib/tls to /lib/tls.disabled, the application complains
about the missing NPTL support in the library.
Well, I have now a solution that works:
I can use the standard pthread lib and not the i686 optimized NPTL.
However, as NPTL seems to be a performance benefit, I think it could be
worth to get this combination up and running.

Is there anybody out there that uses a Debian based system with the i686
optimized libc that works perfectly?

BTW: I am using xenomai 2.2.4 from end of October.

Thanks for any feedback on this

Mathias
> > I am just playing around with Xenomai to understand it.
> > And I have one question concerning the entry function that will be call=
ed
> from
> > rt_task_start (Native API).
> > What happens if this entry function reaches its end or a return within =
the
> function is
> > called?
> >=20
> > I have made a simple example that lead to strange effects.
> > In my example (see complete C Code in attachement) I create to tasks
> > that do the same.
> > The entry functions look like:
> >=20
> > void taska(void *cookie)
> > {
> >     RTIME delay;
> >     int i;
> >     printf("Hi, I am task A %s\n", (char*)cookie);
> >     delay =3D 100000;
> >=20
> >     for (i=3D0; i<200; i++)
> >     {
> >         rt_task_sleep(delay);
> >     }
> >=20
> >     printf("This is the end of A\n");
> >     // rt_task_delete(0);
> > }
> > When I do not place the rt_task_delete(0) at the end of the function
> > my second task will never reach the end with the second printf.
> > Whenever I use rt_task_delete(0) at the end of the function it works
> perfectly.
>=20
> Quite inconsistent, sounds like a bug. Does the second rt_task_join just
> rush through and main terminates?
>=20
> >=20
> > My question is now: What happens if the task's entry function returns?
>=20
> pthread_exit() is invoked implicitly, which implies rt_task_delete(NULL).
>=20
> >=20
> > Thanks for any feedback on that question.
>=20
> Is this issue SMP-related? What happens if you force all your tasks to
> the same CPU? Or if you run on a !CONFIG_SMP box?
>=20
> Jan
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

