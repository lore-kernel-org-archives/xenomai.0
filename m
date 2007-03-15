Date: Thu, 15 Mar 2007 17:17:21 +0100
Message-Id: <451199191@domain.hid>
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
To: Jochen Behnke <JK.Behnke@domain.hid>
Cc: xenomai@xenomai.org

Hello,

after hours of searching, I have finally found the problem.=20
It was a bug in my "SimpleRPC" library. The thread function, responsible f=
or the "lockup", mainly constists of an endless loop ( while(pObj->nRun) )=
 that polls a request queue. This was not a problem as long as this thread=
 was a standard pthread. Turning this thread into a real-time task by addi=
ng a call to rt=5Ftask=5Fshadow at the beginning of the thread function (befor=
e the while loop) resulted in a frozen linux system.

I used to work with the following system
Gentoo Linux
Linux Kernel 2.6.17 (IPIPE 1.4)
Xenomai 2.2.3

Now that I know, that upgrading to Xenomai 2.3.0 is not a problem, I plan =
to upgrade to the 2.3.x branch.


Regards

Jochen


>=20
> Hello Gilles,
>=20
> > Jochen Behnke wrote:
> > > Hello Gilles,
> > >=20
> > > thanks for your response.=20
> > > At the moment I try to cut down my application to the minimum.
> > > I also will install the latest version of the xenomai 2.2.x branch (=
2.2.5) and check whether I can reproduce the fault.  As I noticed that som=
e functions have been changed (rt=5Fmutex=5Flock/unlock no longer exist in Xen=
omai 2.3.x, they obviously have been renamed for some reason) I would rath=
er stick to the 2.2.x branch. Is that reasonable in your opinion =3F
> > > Will the 2.2.x branch be maintained in the future =3F
> > >=20
> > > Thanks again.
> > >=20
> > > Jochen
> >=20
> > Please do not forget to CC the list.
> I'm sorry. I just used the wrong reply button.
>=20
> >=20
> > rt=5Fmutex=5Flock/rt=5Fmutex=5Funlock were renamed
> > rt=5Fmutex=5Facquire/rt=5Fmutex=5Frelease to avoid a conflict, as documented i=
n
> > API.CHANGES
> I will have a look at this.
>=20
> >=20
> > Please try with Xenomai 2.3.0, or better with trunk. The aim of this
> > check is for us to avoid chasing bugs that were already solved. For
> > example if you are using fork() in your application, only I-pipe patch=
es
> > in the trunk will solve your problem.
> At the moment I don't use fork() but I can try using 2.3.x.
> I hope that I don't have to change too much code on my side.
>=20
> As soon as I have results, I'll post them here.
>=20
> Jochen
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Viren-Scan f=FCr Ihren PC! Jetzt f=FCr jeden. Sofort, online und kostenlos.
> Gleich testen! http://www.pc-sicherheit.web.de/freescan/=3Fmc=3D022222
>=20
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/=3Fmc=3D100071&distributionid=3D000000000066


