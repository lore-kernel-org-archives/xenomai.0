From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17663.14570.927213.273804@domain.hid>
Date: Wed, 6 Sep 2006 23:08:58 +0200
Subject: Re: [Xenomai-core] Best way to determine sudo in xeno-load?
In-Reply-To: <200609062137.04256.niklaus.giger@domain.hid>
References: <200609062137.04256.niklaus.giger@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
 > Hi
 > 
 > Since the last checkin in xeno-load.in by gpm on the 17 of July my PPC HCU3 
 > target does not run the xeno-tests correctly.
 > E.g. in http://ngiger.dyndns.org/buildbot/hcu3_q/builds/26/step-xenotest/0
 > you find lines like
 > /usr/xenomai/bin/xeno-load: /usr/xenomai/bin/xeno-load: 249: sudo: not found
 > 
 > My earlier solution was:
 > if test -n "`which sudo`"; then
 >   sudo=`which sudo`
 > fi
 > 
 > This was corrected by Gilles to
 > >if test -n "`which sudo 2>/dev/null`"; then
 > >  sudo=`which sudo`
 > >elif test -n "`type -t sudo 2>/dev/null`"; then
 > >  sudo=sudo
 > >fi
 > 
 > Unfortunately my busybox version 1.1.3 behaves like this:
 > >~ $ type -t sudo 2>/dev/null
 > >-t: not found
 > >sudo: not found

What about:

if type sudo > /dev/null 2>&1; then
    sudo=sudo
fi

-- 


					    Gilles Chanteperdrix.

