Date: Fri, 16 Mar 2007 08:12:22 +0100
Message-Id: <452619176@domain.hid>
MIME-Version: 1.0
From: Jochen Behnke <JK.Behnke@domain.hid>
Subject: Re: [Xenomai-help] App with pthreads using rt_task_shadow locks up
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
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

Philippe,

the workaround for the native skin is OK for me.
Thanks for your help :-)

Regards

Jochen


> On Thu, 2007-03-15 at 19:34 +0100, Jochen Behnke wrote:
> > Hello Philippe,
> >=20
> > thanks for your response.
> >=20
> > > On Thu, 2007-03-15 at 17:17 +0100, Jochen Behnke wrote:
> > > > Hello,
> > > >=20
> > > > after hours of searching, I have finally found the problem.=20
> > > > It was a bug in my "SimpleRPC" library. The thread function, respo=
nsible for the "lockup", mainly constists of an endless loop ( while(pObj-=
>nRun) ) that polls a request queue. This was not a problem as long as thi=
s thread was a standard pthread. Turning this thread into a real-time task=
 by adding a call to rt=5Ftask=5Fshadow at the beginning of the thread functio=
n (before the while loop) resulted in a frozen linux system.
> > > >=20
> > > > I used to work with the following system
> > > > Gentoo Linux
> > > > Linux Kernel 2.6.17 (IPIPE 1.4)
> > > > Xenomai 2.2.3
> > > >=20
> > > > Now that I know, that upgrading to Xenomai 2.3.0 is not a problem,=
 I plan to upgrade to the 2.3.x branch.
> > > >=20
> > >=20
> > > You may detect such kind of issues switching on the
> > > CONFIG=5FXENO=5FOPT=5FWATCHDOG option in the kernel configuration. Normall=
y,
> > > this would pull the brake after more than 4 seconds of uninterrupted=

> > > real-time activity in primary mode (i.e. without yielding control to=
 the
> > > regular Linux activities).
> >=20
> > That's great. I will check this out.
> >=20
> > BTW, is there an easy way, other than reboot,  to release xenomai ress=
ources (mutexes,...) that have not been freed after an application crash =3F=
=20
> >=20
>=20
> This depends on the skin being used. The native one does not free the
> resources upon application exit yet (this feature is on the todo list
> for the upcoming 2.4 though), OTOH the POSIX skin does. A work-around
> with the native skin is to use constructs like the following one in your=

> app to recycle the left overs; not pretty, but works, until we provide
> an automated support:
>=20
> if (rt=5Fmutex=5Fbind("some=5Fmutex", &mutex=5Fdesc, ...) =3D=3D 0) {
> 	rt=5Fmutex=5Fdelete(&mutex=5Fdesc);
> }
> err =3D rt=5Fmutex=5Fcreate("some=5Fmutex", &mutex=5Fdesc);
>=20
> --=20
> Philippe.
>=20
>=20
>=20


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Viren-Scan f=FCr Ihren PC! Jetzt f=FCr jeden. Sofort, online und kostenlos.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/=3Fmc=3D022222


