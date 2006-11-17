Message-ID: <16178634.1163773048304.JavaMail.ngmail@domain.hid>
Date: Fri, 17 Nov 2006 15:17:28 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <455DC001.2040001@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <455DC001.2040001@domain.hid>
	<434646.1163765689576.JavaMail.ngmail@domain.hid>
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

First, I give you some more information about the error.
The output is the following:
Hi, I am task A Hello
Hi, I am task B World
Main waits for A
This is the end of A
Main waits for B

Then the system hangs.

I have done two tests to verify if there is an SMP issue.
First, I have set all CPUs in use with the application to CPU 0.
There was no change. However, I am able to stop the application with CTRL-C
and everything is cleaned up fine.

Then, I have modified the BIOS settings of the PC to disable Hyperthreading=
.
Again, no change. The same effect as with the test before.

The strange thing here is, when I use the original test (main on CPU 0, rt =
tasks on CPU 1)
on a SMP machine, I am not able to terminate the application with CTRL-C.
I have to reboot the PC.

That means, there seems to be a relation to SMP...

Another thing I have detected:
When I modify the program to replace the final rt_task_delete by
a sleep(1) call everything runs perfectly again.

Mathias

> > I found out, that is issue seems to be related to the NPTL (native posi=
x
> thread library).
> > The pthread library in use was=20
> > /lib/tls/i686/cmov/libpthread.so.0
> > which is part of the Debian (testing) package libc6-i686.
> > (see http://packages.debian.org/testing/libs/libc6-i686)
> >=20
> > When renaming the lib/tls to lib/tls.disabled the pthread library in us=
e
> is
> > /lib/libpthread.so.0
> > and then it is working perfectly!
>=20
> ...which does not yet explain WHY the other scenario fails.
>=20
> >=20
> > It seems that the i686 optimized libc is not fully compatible with
> Xenomai.
>=20
> That's not true in such a common form. We are using NTPL libs for i586
> and i686 (SuSE builds) without /general/ issues. Still, specific
> problems like this may sleep somewhere.
>=20
> > I read about this library at Romain Lenglet's web page:
> >
> http://www.csg.is.titech.ac.jp/~lenglet/howtos/realtimelinuxhowto/index.h=
tml
>=20
> > I think this library uses the NPTL (Native Posix Thread Lib).
> > The i686 optimized library shows the value
> > NPTL 2.3.6 =20
> > at=20
> > getconf GNU_LIBPTHREAD_VERSION
> > The "old" pthread lib shows the value:
> > linuxthreads-0.10
> >=20
> > Now, I tried to reconfigure Xenomai with --enable-x86-sep to use
> > the NPTL but this did not help either.
>=20
> That only influences the way syscalls are passed down into the kernel.
>=20
> > When I rename now  /lib/tls to /lib/tls.disabled, the application
> complains
> > about the missing NPTL support in the library.
> > Well, I have now a solution that works:
> > I can use the standard pthread lib and not the i686 optimized NPTL.
> > However, as NPTL seems to be a performance benefit, I think it could be
> > worth to get this combination up and running.
> >=20
> > Is there anybody out there that uses a Debian based system with the i68=
6
> > optimized libc that works perfectly?
> >=20
> > BTW: I am using xenomai 2.2.4 from end of October.
> >=20
>=20
> Again my question: is the issue SMP related?
>=20
> Reproducing your problem over a qemu box (with or without SMP) failed so
> far for me. But I'm not on your glibc.
>=20
> Jan


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

