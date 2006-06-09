From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17545.56216.331079.757180@domain.hid>
Date: Fri, 9 Jun 2006 22:35:36 +0200
Subject: Re: [Xenomai-core] 2 build error while compiling the revision >= 1180
In-Reply-To: <200606092127.38099.niklaus.giger@domain.hid>
References: <200606092127.38099.niklaus.giger@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
 > b) Running simulator check fail
 > -------------------------------
 > http://ngiger.dyndns.org/buildbot/sim/builds/80/step-check_sim/0
 > Some problems were reported in:
 > posix->tthread:tthread.c:129: TEST failed: pthread_attr_setschedparam(&attr, 
 > &p)== 0
 > posix->tthread: <b> tthread.c:162, test finished: 1 failures/ 46 tests

This one was due to the recent implementation of the SCHED_OTHER
scheduling policy by the posix skin, and is fixed by revision 1181. I
also made the verbosity of posix and vxworks tests configurable.

-- 


					    Gilles Chanteperdrix.

