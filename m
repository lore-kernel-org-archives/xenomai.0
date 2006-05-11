From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 11 May 2006 18:23:50 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XU2YE9oEhHE1D7l"
Message-Id: <200605111823.51650.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Errors running sim testsuite for vxWorks
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

--Boundary-00=_XU2YE9oEhHE1D7l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Running the sim testsuite vxworks (revision 1078) (using the attached script) 
I get the following a few failures and memory corruption:

trestart.c:46, taskSpawn("nop", 19, 0, 32768, nopTask, 0,0,0,0,0,0,0,0,0,0) != 
ERROR
*** glibc detected *** malloc(): memory corruption: 0x100bf000 ***

t010726-1.log:t010726-1.c:106, test finished: 4 failures/ 15 tests
t010726-2.log:t010726-2.c:224, test finished: 0 failures/ 82 tests
t010728.log:t010728.c:119, test finished: 0 failures/ 4 tests
t010820-1.log:t010820-1.c:90, test finished: 0 failures/ 23 tests
t010820-2.log:t010820-2.c:81, test finished: 0 failures/ 11 tests
t010823-1.log:t010823-1.c:114, test finished: 0 failures/ 16 tests
t010823-2.log:t010823-2.c:166, test finished: 1 failures/ 33 tests

Is this normal or a powerpc specific error of the Xenomai simulator?

How do I debug trestart as it is not a fully linked executable?

Is it normal that a "make check" only works, if one builds the simulator 
inside the source code?

Thanks for any suggestion.

Best regards

-- 
Niklaus Giger

--Boundary-00=_XU2YE9oEhHE1D7l
Content-Type: application/x-shellscript;
  name="test_sim"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test_sim"

#!/bin/bash
cd ~/buildbot/quick-sim/build/sim/skins/vxworks/testsuite
LANGUAGE=C
LANG=C
make check
for j in t* 
do
  if test -x $j 
  then
     echo $j is executable
     ./$j 2>&1 | tee $j.log
  fi
done
grep failures *.log

--Boundary-00=_XU2YE9oEhHE1D7l--

