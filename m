Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Dec 2009 13:34:12 +0100
Message-ID: <EA8B423DB69FD24FA233008019A052AE01668DD6@domain.hid>
In-Reply-To: <4B20D066.5070904@domain.hid>
References: <EA8B423DB69FD24FA233008019A052AE016689FC@zue-s-15.zue.zwick.de>
	<4B20D066.5070904@domain.hid>
From: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>
Subject: Re: [Xenomai-help] Problem with gettimeofday
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

=20

> -----Urspr=FCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Gesendet: Donnerstag, 10. Dezember 2009 11:42
> An: Soboljew, Patrick
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Problem with gettimeofday
>=20
> Soboljew, Patrick wrote:
> > Hello all,
> >=20
> > I have a problem concering the system time in xenomai=20
> 2.4.9.1 kernel=20
> > 2.6.30. The framework I use calls gettimeofday() to get the=20
> absolute=20
> > system time which is then passed to pthread_cond_timedwait. The=20
> > problem is that when I add for example 1ms wait time the=20
> > pthread_cond_timedwait waits much longer. I've checked=20
> > /proc/xenomai/sched and I can see that the timeout is far=20
> too large.=20
> > So I wrote a small test program to isolate the problem. I=20
> compared the=20
> > results (only the seconds which is enough to show the=20
> problem) and there is a huge difference.
> >=20
> > On my system (Intel Core2, 1,6 GHz) the output of the test program=20
> > shows the following output:
> > Time1: 1260437136
> > Time2: 1145908535
> >=20
> > The curious thing is: I have a vmware image with a xenomai kernel=20
> > (same version). The problem cannot be reproduced here.
> >=20
> > Anybody an idea?
>=20
> You should be using clock_gettime(CLOCK_REALTIME). In case=20
> you insist on using gettimeofday, see:
>=20
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to
> _Xenomai#Timing_services.

It's not me who insists on that call but this framework :). But thanks =
for your help. The solution thats provided with the link would help I =
think. I was also interested what things can cause the difference =
between both functions on real hardware and in the vmware image e.g. =
kernel config parameters.

