MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18491.4848.804078.354303@domain.hid>
Date: Mon, 26 May 2008 21:43:44 +0200
In-Reply-To: <483AA731.8050404@domain.hid>
References: <480A4AF3.9010502@domain.hid>
	<18489.35854.502315.832894@domain.hid>
	<4839907C.4000102@domain.hid>
	<18489.37401.679912.195018@domain.hid>
	<483AA731.8050404@domain.hid>
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
 > Hi,
 > 
 > Gilles Chanteperdrix wrote:
 > >  > So feel free to do a 2.4.4 (or whatever) release soon. :-)
 > >  > 
 > >  > (For integrating the Debian changes in addition to the respective
 > >  > upstream changes, just remove the man pages in debian/,
 > >  > debian/xenomai-runtime.manpages and the /bin/bash patch.)
 > > 
 > > I would have felt more comfortable if you could have done it (and more
 > > importantly test it). Besides, the 2.4.4 release is coming, and I would
 > > have liked to release it with all the changes that you made.
 > 
 > I'm attaching a patch that I would apply to branches/v2.4.x if it would
 > be considered as 2.4.4.
 > 
 > Please note that on integrating Xenomai 2.4.4 (or whatever) upstream in
 > Debian, I will strip debian/* from the original tarball to separate the
 > Debian part from "upstream". For the same reason, please consider to
 > remove it from the tarball. (It can stay in SVN, though.)

Your patch is merged, thank you very much. I just removed the changelog
entry about the 2.4.4 release, since, well, 2.4.4 is not released yet.

Shipping the xenomai tarball with the debian directory has a real added
value: it allows people to build debian package without anything else,
this is an unofficial package, of course, but it can be built before the
Debian patch is generated.

IMO, it would make your life easier if you considered the debian
directory part of the Xenomai package, and start working from this
directory. If you ask for it, we can probably even give you write
access to the repository, so that the debian packaging effort is fully
integrated to Xenomai.

-- 


					    Gilles.

