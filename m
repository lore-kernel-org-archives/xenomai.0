Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma: rtcanconfig
	refences pthread_kill
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200608152056.51541.niklaus.giger@domain.hid>
References: <200608150949.30029.niklaus.giger@domain.hid>
	<44E20EEF.7000705@domain.hid>
	<200608152056.51541.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 23:29:44 +0200
Message-Id: <1155677384.4327.88.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Tue, 2006-08-15 at 20:56 +0200, Niklaus Giger wrote:
> > o The run test on the hcu_vx seems to cause a hang after the nucleus
> >   being loaded:
> >   http://ngiger.dyndns.org/buildbot/hcu_vx/builds/128/step-xeno-test/0
> This is a long standing problem, where Philippe needs to get hand on a PPC40x 
> system to find the error. I tried to give it a look
> > hcu3 is fine, a rebuild of "ppc" is currently pending.
> hcu3 is the most important target (at least for me), as it is the only target 
> which runs xeno-test.

This one is spotted in the timer activation sequence during startup, but
I need to put my hands back on a 40x board (likely by September) to
solve it. This is high on the must-fix list for me too.

-- 
Philippe.



