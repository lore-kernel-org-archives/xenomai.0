From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] Buildbot: Errors building rtnet since at least
	r1834
Date: Mon, 20 Nov 2006 20:02:13 +0000
References: <200611181818.17629.niklaus.giger@domain.hid>
	<455F4A24.8060408@domain.hid>
	<200611182116.20647.niklaus.giger@domain.hid>
In-Reply-To: <200611182116.20647.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202002.13102.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, niklaus.giger@domain.hid
Cc: Jan Kiszka <jan.kiszka@domain.hid>


Hi Jan & Niklaus

On Saturday 18 November 2006 20:16, Niklaus Giger wrote:
> > DESTDIR issue? Are you compiling both Xenomai and RTnet with the same
> > DESTDIR?
>
> Calling manuall make install like the following line did not change the
> result:
> DESTDIR=/var/buildbot/install/tqm_q make prefix=/var/buildbot/install/tqm_q
> install

Just completed a test build here on the only box currently set up with 
Xenomai, and no install errors were reported. What I would expect from the 
quoted line above is everything installed in 
 /var/buildbot/install/tqm_q/var/buildbot/install/tqm_q (in other words, 
$DESTDIR/$prefix). The DESTDIR variable should only be used to specify a 
temporary staging area, for example, when building an RPM or Debian package 
where the binaries/libaries will be installed in /usr/xenomai but the package 
it's self is being generated in /tmp/build/.


Regards, Paul.

