From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Fri, 9 Jun 2006 21:27:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606092127.38099.niklaus.giger@domain.hid>
Subject: [Xenomai-core] 2 build error while compiling the revision >= 1180
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
To: xenomai-core <xenomai@xenomai.org>

Hi

My buildbot had no problems compiling revision 1167. Because of a 
configuration error (svn_watcher process died), revision 1168 to 1178 did not 
get built. Sorry.

Since revision 1179 I have the following two regression:
a) Compiling for tqm860 with rtnet fails, 
but not for hcu3 and for ppc
-------------------------------
see http://ngiger.dyndns.org/buildbot/tqm860/builds/80/step-mk_kernel/0
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I/home/buildslave/buildbot/quick-tqm860/build/linuxppc_2_4_devel-2006-04-06-1735/arch/ppc -o 
scripts/split-include scripts/split-include.c
make: *** No rule to make target `include/linux/autoconf.h', needed by 
`include/config/MARKER'.  Stop.

b) Running simulator check fail
-------------------------------
http://ngiger.dyndns.org/buildbot/sim/builds/80/step-check_sim/0
Some problems were reported in:
posix->tthread:tthread.c:129: TEST failed: pthread_attr_setschedparam(&attr, 
&p)== 0
posix->tthread: <b> tthread.c:162, test finished: 1 failures/ 46 tests

Best regards
-- 
Niklaus Giger

