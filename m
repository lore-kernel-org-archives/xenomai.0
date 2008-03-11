From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 11 Mar 2008 21:26:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803112126.42235.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Errors running simulator test tmq
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

Since quite some time there is a error running the simulator test:
The daily build reports (e.g. http://ngiger.dyndns.org/buildbot/builders/sim_f/builds/80/steps/check_sim/logs/stdio)
> Will call tmq
> Xenomai/sim: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> starting POSIX services.
> Xenoscope: lt-tmq: fatal in MvmIrq (time=400000838.314452):
> test interrupted by watchdog.

I have no ideas why the builds after each check-in give me also
errors like (e.g. http://ngiger.dyndns.org/buildbot/builders/sim_q/builds/170/steps/check_sim/logs/stdio)
> vxworks->trestart:: starting VxWorks services.
> vxworks->t010726-2:: starting VxWorks services.
> vxworks->t010820-1:: starting VxWorks services.
> vxworks->t010823-2:: starting VxWorks services.

I will investigate this problem later 

Best regard

Niklaus

