MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18286.53276.972102.704126@domain.hid>
Date: Sun, 23 Dec 2007 22:16:12 +0100
In-Reply-To: <200712231747.35449.niklaus.giger@domain.hid>
References: <200712231747.35449.niklaus.giger@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Buildbot is back (and reporting errors)
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
 > a) The simulator fails in two tests with the vxworks skins. In
 > http://ngiger.dyndns.org/buildbot/builders/sim_f/builds/1/steps/check_sim/logs/stdio
 > you will find at the end the lines
 > > Some problems were reported in:
 > > vxworks->t010726-1::
 > > vxworks->t010823-2::
 > Going back one finds:
 > > starting VxWorks services.
 > > Xenoscope: lt-t010823-2: fatal in MvmIrq (time=30000718.974563):
 > > test interrupted by watchdog.
 > and
 > > starting VxWorks services.
 > > Xenoscope: lt-t010726-1: fatal in MvmIrq (time=30000718.974820):
 > > test interrupted by watchdog.

The problem is that the root task priority is 0, and that now, 0 is a
priority with a special meaning. However, VxWorks priority range is from
0 to 255, not from 1 to 255.

-- 


					    Gilles Chanteperdrix.

