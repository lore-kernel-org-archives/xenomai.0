From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot: Errors building rtnet since at least
	r1834
Date: Tue, 21 Nov 2006 08:25:19 +0100
References: <200611181818.17629.niklaus.giger@domain.hid>
	<200611182116.20647.niklaus.giger@domain.hid>
	<200611202002.13102.paul_c@domain.hid>
In-Reply-To: <200611202002.13102.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611210825.20046.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Am Montag, 20. November 2006 21:02 schrieb Paul:
> Hi Jan & Niklaus
>
> On Saturday 18 November 2006 20:16, Niklaus Giger wrote:
> > > DESTDIR issue? Are you compiling both Xenomai and RTnet with the same
> > > DESTDIR?
> >
> > Calling manuall make install like the following line did not change the
> > result:
> > DESTDIR=/var/buildbot/install/tqm_q make
> > prefix=/var/buildbot/install/tqm_q install
>
> Just completed a test build here on the only box currently set up with
> Xenomai, and no install errors were reported. What I would expect from the
> quoted line above is everything installed in
>  /var/buildbot/install/tqm_q/var/buildbot/install/tqm_q (in other words,
> $DESTDIR/$prefix). The DESTDIR variable should only be used to specify a
> temporary staging area, for example, when building an RPM or Debian package
> where the binaries/libaries will be installed in /usr/xenomai but the
> package it's self is being generated in /tmp/build/.
Thanks everybody for their hints. I could correct now my errors (not yet 
propagated to the buildbot because of lack of time).

I however use the DESTDIR quite often to install the output of my different 
build (cross-compiling) slaves into different directories to be able to 
switch between them easily. Also I use the DESTDIR to specify the nfs root 
directory which the test boards will use to boot from. I know of nothing more 
appropriate for this purpose or did I miss something?

To be able to test more easily regressions between different version I wanted 
now to make my install directories to include the revision.

A part of my confusion stemmed from the fact that something which is very easy 
in a script proved to be quite complicated in my buildbot. My idea was that 
after the first build step (the svn checkout) I wanted to evaluats 
`svnversion` to help me point DESTDIR to something 
like "/home/hcu/rootfs/revision-1986". Unfortunately I did not yet found out 
how  buildbot step can propagate this property easily to all of it 
successors. I have to dig further there.

Best regards

-- 
Niklaus Giger

