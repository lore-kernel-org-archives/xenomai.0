From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 26 Aug 2006 11:33:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608261133.36605.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot: Small glitch in simulator
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

http://ngiger.dyndns.org/buildbot/sim/builds/18/step-check_sim/0
reports a small error in the simulator.

>Some problems were reported in:
>posix->tmq:: starting POSIX services.
>vxworks->t010823-2:t010823-2.c:163: Expected sequence: SEQ("Test2",2003); got 
>SEQ("Test2",2004)
>vxworks->t010823-2: t010823-2.c:166, test finished: 1 failures/ 33 tests
>program finished with exit code 3

-- 
Niklaus Giger

