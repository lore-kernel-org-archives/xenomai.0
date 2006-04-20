Message-ID: <4447C297.2020804@domain.hid>
Date: Thu, 20 Apr 2006 13:19:19 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] a couple test failures on svn-current
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


This morning, after svn up, make, make install,
I started getting this err.

latency: failed to call RTBNCH_RTIOC_INTERM_RESULT, code -25

I fixed it by rebuilding kernel, which pulled in the updated kernel 
bits, and it worked.
Is there any simple way to know apriori that a kernel-side make is needed ?
( I mean besides watching svn up for ksrc/* changes ;)   No is a fine 
answer.




Also, cyclictest is failing, not fixed by the kernel remake.

soekris:/usr/xenomai/testsuite/cyclic# ./run
*
*
* Type ^C to stop this application.
*
*
3.38 2.95 1.83 5/41 3590

T: 0 (    0) P: 0 I:    1000 C:       0 Min: 1000000 Act:       0 
Max:-1000000
pthread_setschedparam: Invalid argument
(modprobe xeno_posix?)
soekris:/usr/xenomai/testsuite/cyclic#

xeno-posix is in, so its something else.



