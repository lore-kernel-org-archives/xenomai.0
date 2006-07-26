From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 26 Jul 2006 06:52:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607260652.58806.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot running again. rtnet does not compile,
	small error in sim testsuite.
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
To: xenomai@xenomai.org

Hi

Back from my vacation I discovered that the buildbot did not run during my 
absence as I had added a (debugging) printf some time before vacation. This 
printf did not harm as long as the session was alive. But before leaving I 
cleanup my desktop and bang the xenomai repository watcher got killed. Sorry!

I fixed the error and now the buildbot is running again.

RTnet seems to have a compile problem: see
http://ngiger.dyndns.org/buildbot/tqm860/builds/227/step-mk_RTnet/0
In file included from rtnet_ifs.c:30:
../../../stack/include/rtnet.h:29:23: rtdm/rtdm.h: No such file or directory
rtnet_ifs.c: In function `main':
<..>

The timing behaviour seems to have changed a little bit as the simulator 
testsuite reports in:
http://ngiger.dyndns.org/buildbot/sim/builds/213/step-check_sim/0
vxworks->t010823-2:t010823-2.c:163: Expected sequence: SEQ("Test2",2009); got 
SEQ("Test2",2002)
vxworks->t010823-2: t010823-2.c:166, test finished: 1 failures/ 33 tests

Best regards

-- 
Niklaus Giger

