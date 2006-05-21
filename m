From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
Date: Sun, 21 May 2006 16:50:11 +0200
References: <446F852B.7090400@domain.hid>
In-Reply-To: <446F852B.7090400@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605211650.12451.niklaus.giger@domain.hid>
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

Am Samstag, 20. Mai 2006 23:07 schrieb Philippe Gerum:
> Here is the second release candidate for the v2.2 branch. Short log
The trunks builds fine on my four targets on 
http://ngiger.dyndns.org/buildbot/

I have however still the following errors running the posix simulators
(see http://ngiger.dyndns.org/buildbot/sim/builds/59/step-check_sim/0). All 
others posix and vxworks test pass.
The output is:

Some problems were reported in:
posix->tthread:tthread.c:141: Expected sequence: SEQ("slicer1",1); got 
SEQ("slicer1",4)
posix->tthread:tthread.c:142: Expected sequence: SEQ("slicer2",1); got 
SEQ("slicer2",4)
posix->tthread:tthread.c:143: Expected sequence: SEQ("slicer1",1); got 
SEQ("root",1)
posix->tthread:tthread.c:144: Expected sequence: SEQ("slicer2",1); reached end 
of recorded sequence.
posix->tthread:tthread.c:145: Expected sequence: SEQ("slicer1",1); reached end 
of recorded sequence.
posix->tthread:tthread.c:146: Expected sequence: SEQ("slicer2",1); reached end 
of recorded sequence.
posix->tthread:tthread.c:147: Expected sequence: SEQ("slicer1",1); reached end 
of recorded sequence.
posix->tthread:tthread.c:148: Expected sequence: SEQ("slicer2",1); reached end 
of recorded sequence.
posix->tthread:tthread.c:149: Expected sequence: SEQ("root",1); reached end of 
recorded sequence.
posix->tthread:tthread.c:153, test finished: 9 failures/ 46 tests

I have however no time to try to fix them, as I am investing more time into 
making xeno-test run automatically on my PPC 405GPr target board.

Best regards

-- 
Niklaus Giger

