MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18489.37401.679912.195018@domain.hid>
Date: Sun, 25 May 2008 18:21:45 +0200
In-Reply-To: <4839907C.4000102@domain.hid>
References: <480A4AF3.9010502@domain.hid>
	<18489.35854.502315.832894@domain.hid>
	<4839907C.4000102@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Debian package xenomai-2.4.3-4 available
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

Roland Stigge wrote:
 > Hi Gilles,
 > 
 > thanks for your response. ;-)))
 > 
 > Gilles Chanteperdrix wrote:
 > > I am trying to merge the debian changes back into Xenomai, however, I
 > > have two problems:
 > > - I can not find back the 2.4.3-4 patch, I only find 2.4.3-7;
 > 
 > No problem - always just take the latest one, currently 2.4.3-7.
 > 
 > > - I do not want to merge changes that replace /bin/sh with /bin/bash
 > >   since we fixed the bashism the right way (it is important for people
 > >   of the embedded world, that Xenomai does not require /bin/bash, since
 > >   embedded boxes may use other shells);
 > > - I do not want to include the manual pages in the debian/
 > >   sub-directory since I merged your patch adding manual pages to the
 > >   proper place.
 > 
 > Fine. Just do the changes the way you like it Xenomai ("upstream"):
 > Bashism fixes and man pages in the proper upstream place. On next merge
 > from Xenomai (e.g. 2.4.4 to Debian 2.4.4-1), I will synchronize it from
 > xenomai.org. For 2.4.3, the respective change would require maintainer
 > script regeneration due to changes in Makefile.am's, which I would like
 > to prevent.
 > 
 > So feel free to do a 2.4.4 (or whatever) release soon. :-)
 > 
 > (For integrating the Debian changes in addition to the respective
 > upstream changes, just remove the man pages in debian/,
 > debian/xenomai-runtime.manpages and the /bin/bash patch.)

I would have felt more comfortable if you could have done it (and more
importantly test it). Besides, the 2.4.4 release is coming, and I would
have liked to release it with all the changes that you made.

-- 


					    Gilles.

