From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17479.51011.244967.911705@domain.hid>
Date: Thu, 20 Apr 2006 19:39:15 +0200
Subject: Re: [Xenomai-core] a couple test failures on svn-current
In-Reply-To: <4447C297.2020804@domain.hid>
References: <4447C297.2020804@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
 > soekris:/usr/xenomai/testsuite/cyclic# ./run
 > *
 > *
 > * Type ^C to stop this application.
 > *
 > *
 > 3.38 2.95 1.83 5/41 3590
 > 
 > T: 0 (    0) P: 0 I:    1000 C:       0 Min: 1000000 Act:       0 
 > Max:-1000000
 > pthread_setschedparam: Invalid argument
 > (modprobe xeno_posix?)
 > soekris:/usr/xenomai/testsuite/cyclic#
 > 
 > xeno-posix is in, so its something else.

You need to pass at least the -p and -n options to cyclictest in order
to make it work with Xenomai posix skin.

-- 


					    Gilles Chanteperdrix.

