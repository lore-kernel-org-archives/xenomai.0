Date: Tue, 13 Mar 2007 20:03:42 +0100
Message-Id: <448834650@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Hello Gilles,

> Jochen Behnke wrote:
> > Hello Gilles,
> >=20
> > thanks for your response.=20
> > At the moment I try to cut down my application to the minimum.
> > I also will install the latest version of the xenomai 2.2.x branch (2.=
2.5) and check whether I can reproduce the fault.  As I noticed that some =
functions have been changed (rt=5Fmutex=5Flock/unlock no longer exist in Xenom=
ai 2.3.x, they obviously have been renamed for some reason) I would rather=
 stick to the 2.2.x branch. Is that reasonable in your opinion =3F
> > Will the 2.2.x branch be maintained in the future =3F
> >=20
> > Thanks again.
> >=20
> > Jochen
>=20
> Please do not forget to CC the list.
I'm sorry. I just used the wrong reply button.

>=20
> rt=5Fmutex=5Flock/rt=5Fmutex=5Funlock were renamed
> rt=5Fmutex=5Facquire/rt=5Fmutex=5Frelease to avoid a conflict, as documented in
> API.CHANGES
I will have a look at this.

>=20
> Please try with Xenomai 2.3.0, or better with trunk. The aim of this
> check is for us to avoid chasing bugs that were already solved. For
> example if you are using fork() in your application, only I-pipe patches=

> in the trunk will solve your problem.
At the moment I don't use fork() but I can try using 2.3.x.
I hope that I don't have to change too much code on my side.

As soon as I have results, I'll post them here.

Jochen

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Viren-Scan f=FCr Ihren PC! Jetzt f=FCr jeden. Sofort, online und kostenlos.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/=3Fmc=3D022222


