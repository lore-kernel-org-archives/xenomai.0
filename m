From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot failure for sim since r1758
Date: Sat, 28 Oct 2006 14:41:03 +0200
References: <200610280031.57642.niklaus.giger@domain.hid>
In-Reply-To: <200610280031.57642.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281441.03817.niklaus.giger@domain.hid>
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

Hi Philippe

Thanks for fixing the compilation issue, but there is now a small error 
running the testsuite, see at the end of 
http://ngiger.dyndns.org/buildbot/sim_q/builds/140/step-check_sim/0
Some problems were reported in:

vxworks/testsuite/t010823-2.c:163: Expected sequence: SEQ("Test2",2004); got 
SEQ("Test2",1999)
vxworks/testsuite/t010823-2.c:166, test finished: 1 failures/ 33 tests

I think that usually Gilles just corrected it by changing the expected value.
But I am not sure about it.

Best regards

-- 
Niklaus Giger

