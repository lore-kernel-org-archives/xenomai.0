From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 27 Dec 2007 12:33:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712271233.44101.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Still an error in the simulator for v2.3.x
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

Philippe fixed the error I reported in less than 6 minutes. Wonderful work!
But my buildbot machines are a lot slower and take almost one hour
for all builds.

But now the simulator gives on the v2.3 branch again one of (rather silly and
easily corrected errors) like this:
Some problems were reported in:
vxworks->t010823-2:../../../../xenomai/sim/skins/vxworks/testsuite/t010823-2.c:163: Expected sequence: SEQ("Test2",2004); got SEQ("Test2",1954)
vxworks->t010823-2: ../../../../xenomai/sim/skins/vxworks/testsuite/t010823-2.c:166, test finished: 1 failures/ 33 tests
For Details look at 
http://ngiger.dyndns.org/buildbot/builders/sim_q/builds/29/steps/check_sim/logs/stdio
and 
http://ngiger.dyndns.org/buildbot/builders/sim_q/builds/29

The other builds for the 2.3.x branch are okay.
The failures from i386 and tqm will be fixed by correcting the buildbot configuration.

Best regards

-- 
Niklaus Giger

