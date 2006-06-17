From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 17 Jun 2006 17:23:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606171723.59548.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Revision r1218 broke sim
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

See http://ngiger.dyndns.org/buildbot/sim/builds/108/step-check_sim/0
where it says:
Some problems were reported in:
posix->tsem:tsem.c:84: TEST failed: sem_unlink(SEM_NAME)== 0
posix->tsem: <b> tsem.c:170, test finished: 1 failures/ 55 tests

Best regards

-- 
Niklaus Giger

