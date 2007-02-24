From: Paul <paul_c@domain.hid>
Date: Sat, 24 Feb 2007 15:26:22 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702241526.22786.paul_c@domain.hid>
Subject: [Xenomai-core] x86_64 - Initial results.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hi Philippe

 First off, thanks for all your hard work and late nights (and the rest of the 
team) for the x86_64.

 Initial results look promising with the latency test reporting figures in the 
0.5 to 4 uSec range under light load. A kernel compile bumps the wost up to 
9-14uSec. Firing up X,KDE, and a gamut of desktop apps really kills the 
numbers though - ~267uSec being the worst recorded so far, however, once 
X/KDE has started up, latencies are generally <30uSec.

One small problem to report from the compile... With 
CONFIG_XENO_OPT_NUCLEUS=m, the build fails with:

WARNING: "cpu_gdt_descr" [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!
make[1]: *** [__modpost] Error 1

What would the preferred solution be - Export cpu_gdt_descr as it is with 
i386, or force xeno_nucleus to be built in ?


Regards, Paul.

