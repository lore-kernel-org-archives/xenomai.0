From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17521.41639.712387.446087@domain.hid>
Date: Mon, 22 May 2006 13:38:15 +0200
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
In-Reply-To: <200605211650.12451.niklaus.giger@domain.hid>
References: <446F852B.7090400@domain.hid>
	<200605211650.12451.niklaus.giger@domain.hid>
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
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Niklaus Giger wrote:
 > Am Samstag, 20. Mai 2006 23:07 schrieb Philippe Gerum:
 > > Here is the second release candidate for the v2.2 branch. Short log
 > The trunks builds fine on my four targets on 
 > http://ngiger.dyndns.org/buildbot/
 > 
 > I have however still the following errors running the posix simulators
 > (see http://ngiger.dyndns.org/buildbot/sim/builds/59/step-check_sim/0). All 
 > others posix and vxworks test pass.
 > The output is:

The tested feature is round-robin scheduling, which only works when the
system timer is configured in periodic mode; so, when the system timer
is configured in periodic mode, the test should pass.

-- 


					    Gilles Chanteperdrix.

