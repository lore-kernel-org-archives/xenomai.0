Date: Mon, 28 Jul 2008 16:39:50 +0200 (MEST)
Message-Id: <200807281439.m6SEdobe001469@domain.hid>
From: "Christian Volk" <linux.kernel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi all,

sry for my delayed answer.
So what We've actually done was to rewrite the gcc commands for compiling t=
he posix stuff in the testsuite:
Original:
powerpc-generic-linux-uclibc-gcc -Wl,@/home/develop/Download/xenomai-2.4.4/=
src/skins/posix/posix.wrappers --static -o switchtest switchtest-switchtest=
.o  ../../skins/posix/.libs/libpthread_rt.a -lpthread -lrt=20

Our fix:
powerpc-generic-linux-uclibc-gcc -Wl,@/home/develop/Download/xenomai-2.4.4/=
src/skins/posix/posix.wrappers --static -o switchtest -Wl,"-(" switchtest-s=
witchtest.o  ../../skins/posix/.libs/libpthread_rt.a -lpthread -lrt -Wl,"-)=
"

We inserted the  -Wl,"-(" ... -Wl,"-)" construct around the linker stuff, s=
o it trys to solve all dependencies in all directions.
The errors only occur while compiling the testsuite.
=20

regards,

Christian

----- original Nachricht --------

Betreff: Re: [Xenomai-help] Errors while static linking of Xenomai
Gesendet: Mo, 28. Jul 2008
Von: Gilles Chanteperdrix<gilles.chanteperdrix@xenomai.org>

> Christian Volk wrote:
> > During the day we found a "workaround" or maybe a fix.
> > I will post details tomorrow from work.
> > We used -Wl,"-(" archives -Wl,"-)" so we built a start-group - end-grou=
p
> > Construct which fixed all issues.
> >=20
> > Thanks for your answer Philippe, this will help me while creating my ow=
n
> > apps.
>=20
> It would be interesting if we could apply your fix to Xenomai makefiles.
> Could you give us a little bit more details ?
>=20
> --=20
>                                                  Gilles.
>=20

--- original Nachricht Ende ----


