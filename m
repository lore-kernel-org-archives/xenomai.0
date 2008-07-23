From: "Christian Volk" <linux.kernel@domain.hid>
References: <200807230917.m6N9H0tZ028205@domain.hid>
	<48876738.2020403@domain.hid>
In-Reply-To: <48876738.2020403@domain.hid>
Date: Wed, 23 Jul 2008 19:40:03 +0200
Message-ID: <62F740A83B064CF6B1494D0A12EFFBF6@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Errors while static linking of Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

During the day we found a "workaround" or maybe a fix.
I will post details tomorrow from work.
We used -Wl,"-(" archives -Wl,"-)" so we built a start-group - end-group
Construct which fixed all issues.

Thanks for your answer Philippe, this will help me while creating my own
apps.

Christian

-----Urspr=FCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org
Gesendet: Mittwoch, 23. Juli 2008 19:16
An: Christian Volk
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] Errors while static linking of Xenomai

Christian Volk wrote:
> Hi,
>=20
> when I try to compile Xenomai and link it satically i get some =
'undefined
reference' errors while compiling the cyclictest programm from the
testsuite.
> I'm using Xenomai 2.4.4 with uclibc and try to compile for a ppc-arch
board (Freescale MPC8343 processor).
>=20
> Heres the line which I use to configure Xenomai:
> ./configure --host=3Dpowerpc-generic-linux-uclibc
CC=3D/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-gcc
CXX=3D/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-g++
LD=3D/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-ld
--enable-shared=3Dno LDFLAGS=3D--static=20
>

Fully static builds will likely not work with the current Makefiles, I'm
afraid.
To achieve that, one would have to follow a two-stage linking approach,
partial
linking with the application and wrappers first, then final linking of =
the
previous object with the standard libs - like libpthread - without =
wrapping.
This has already be done for certain applications and is known to work.

Due to static linking, what happens here is that the linker sees =
therefore
binds
pthread_* calls issued from the standard pthread library to Xenomai
symbols...
which are wrappers shadowing the standard pthread_* calls... Bad idea. =
The
point
is that the -Wl,<wrappers> directive should not appear on the link =
command
line
for static builds when standard glibc/libpthread are listed here as =
well.

This said, those errors compiling the Xenomai stack should only happen =
with
POSIX apps from the testsuite because the Makefiles there do not account =
for
fully static builds and wrapping woes, but you can safely ignore them,
provided
you do two-stage linking for your own apps. This is one of the rare =
cases
where
make -k may help...

--=20
Philippe.


