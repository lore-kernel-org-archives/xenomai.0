From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17556.14604.951151.904140@domain.hid>
Date: Sat, 17 Jun 2006 19:17:00 +0200
Subject: Re: [Xenomai-core] Revision r1218 broke sim
In-Reply-To: <200606171723.59548.niklaus.giger@domain.hid>
References: <200606171723.59548.niklaus.giger@domain.hid>
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
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
 > Hi
 > 
 > See http://ngiger.dyndns.org/buildbot/sim/builds/108/step-check_sim/0
 > where it says:
 > Some problems were reported in:
 > posix->tsem:tsem.c:84: TEST failed: sem_unlink(SEM_NAME)== 0
 > posix->tsem: <b> tsem.c:170, test finished: 1 failures/ 55 tests

Commit 1221 fix it. Thanks for reporting (and running the testsuite).

-- 


					    Gilles Chanteperdrix.

