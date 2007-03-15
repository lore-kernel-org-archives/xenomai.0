Subject: Re: [Xenomai-help] App with pthreads using rt_task_shadow locks up
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451199191@domain.hid>
References: <451199191@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 15 Mar 2007 17:47:28 +0100
Message-Id: <1173977248.8193.43.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
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

On Thu, 2007-03-15 at 17:17 +0100, Jochen Behnke wrote:
> Hello,
>=20
> after hours of searching, I have finally found the problem.=20
> It was a bug in my "SimpleRPC" library. The thread function, responsible =
for the "lockup", mainly constists of an endless loop ( while(pObj->nRun) )=
 that polls a request queue. This was not a problem as long as this thread =
was a standard pthread. Turning this thread into a real-time task by adding=
 a call to rt_task_shadow at the beginning of the thread function (before t=
he while loop) resulted in a frozen linux system.
>=20
> I used to work with the following system
> Gentoo Linux
> Linux Kernel 2.6.17 (IPIPE 1.4)
> Xenomai 2.2.3
>=20
> Now that I know, that upgrading to Xenomai 2.3.0 is not a problem, I plan=
 to upgrade to the 2.3.x branch.
>=20

You may detect such kind of issues switching on the
CONFIG_XENO_OPT_WATCHDOG option in the kernel configuration. Normally,
this would pull the brake after more than 4 seconds of uninterrupted
real-time activity in primary mode (i.e. without yielding control to the
regular Linux activities).

>=20
> Regards
>=20
> Jochen
>=20
>=20
> >=20
> > Hello Gilles,
> >=20
> > > Jochen Behnke wrote:
> > > > Hello Gilles,
> > > >=20
> > > > thanks for your response.=20
> > > > At the moment I try to cut down my application to the minimum.
> > > > I also will install the latest version of the xenomai 2.2.x branch =
(2.2.5) and check whether I can reproduce the fault.  As I noticed that som=
e functions have been changed (rt_mutex_lock/unlock no longer exist in Xeno=
mai 2.3.x, they obviously have been renamed for some reason) I would rather=
 stick to the 2.2.x branch. Is that reasonable in your opinion ?
> > > > Will the 2.2.x branch be maintained in the future ?
> > > >=20
> > > > Thanks again.
> > > >=20
> > > > Jochen
> > >=20
> > > Please do not forget to CC the list.
> > I'm sorry. I just used the wrong reply button.
> >=20
> > >=20
> > > rt_mutex_lock/rt_mutex_unlock were renamed
> > > rt_mutex_acquire/rt_mutex_release to avoid a conflict, as documented =
in
> > > API.CHANGES
> > I will have a look at this.
> >=20
> > >=20
> > > Please try with Xenomai 2.3.0, or better with trunk. The aim of this
> > > check is for us to avoid chasing bugs that were already solved. For
> > > example if you are using fork() in your application, only I-pipe patc=
hes
> > > in the trunk will solve your problem.
> > At the moment I don't use fork() but I can try using 2.3.x.
> > I hope that I don't have to change too much code on my side.
> >=20
> > As soon as I have results, I'll post them here.
> >=20
> > Jochen
> >=20
> > _______________________________________________________________________
> > Viren-Scan f=FCr Ihren PC! Jetzt f=FCr jeden. Sofort, online und kosten=
los.
> > Gleich testen! http://www.pc-sicherheit.web.de/freescan/?mc=3D022222
> >=20
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >=20
>=20
>=20
> _____________________________________________________________________
> Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
> http://smartsurfer.web.de/?mc=3D100071&distributionid=3D000000000066
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



