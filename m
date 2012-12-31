Date: Mon, 31 Dec 2012 20:14:20 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50e1e40c413df8.28309699@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai] Odp: Re:  SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: peter@thesourceworks.com
Cc: Xenomai <xenomai@xenomai.org>

Thank you Gilles, I my opinion Peter is right that we should start debuging=
 from OROCOS side. If it will be Xenomai issue I will let you know.=20

Mariusz

PS. Orocos related topic is following=20

http://www.orocos.org/forum/orocos/orocos-users/orocos-26-xenomai-262-and-s=
igxcpu-cpu-time-limit-exceeded

=20
Dnia Poniedzia=B3ek, 31 Grudnia 2012 18:52 Peter Soetens <peter@thesourcewo=
rks.com> napisa=B3(a)
> Hi all,
> Thanks for the analysis. I'd propose to move this to bugs.orocos.org wher=
e we can try to reproduce and track this bug in orocos.
> We've been testing in our buildfarm against xenomai 2.5, so this might be=
 something we did not notice until now...
> Peter
> Op maandag 31 december 2012 schreef Gilles Chanteperdrix (gilles.chantepe=
rdrix@xenomai.org) het volgende:
> > On 12/31/2012 06:32 PM, Mariusz Janiak wrote:
> > =20
> >  > Hi,
> >  >
> >  > I have met problem when I run OROCOS helloWord example. Xenomai
> >  > generate SIGXCPU signal when rt_mutex_release(...) is called. I have
> >  > installed signal handler for each realtime thread created by OROCOS
> >  > and I get following result
> >  >
> >  > SIGDEBUG received, reason 4: affected by priority inversion
> > =20
> > =20
> >  There is a problem in your application, namely a mutex owned by a thre=
ad
> >  running with the SCHED_OTHER scheduling policy, released while Xenomai
> >  did not notice that the same thread had taken the mutex. This could
> >  happen if for instance you change the scheduling policy while holding a
> >  mutex.
> > =20
> >  Please try reducing the error to a simple testcase which will allow us
> >  to investigate this issue.
> > =20
> >  > There is much bigger mess during exiting from application. I am not
> >  > pretty sure this is a Xenomai problem, if not sorry for bothering. I
> >  > haven check it with previous Xenomai release yet.
> > =20
> > =20
> >  We need facts to start working, again, please write a simple test case
> >  to help investigating the issue.
> > =20
> >  --
> >                                                                  Gilles.
> > =20
> >  _______________________________________________
> >  Xenomai mailing list
> >  Xenomai@xenomai.org
> >  http://www.xenomai.org/mailman/listinfo/xenomai


=20




