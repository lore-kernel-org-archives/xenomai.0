From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
Date: Wed, 24 May 2006 07:21:24 +0200
References: <446F852B.7090400@domain.hid>
	<200605211650.12451.niklaus.giger@domain.hid>
	<17521.41639.712387.446087@domain.hid>
In-Reply-To: <17521.41639.712387.446087@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605240721.24897.niklaus.giger@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Am Montag, 22. Mai 2006 13:38 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > Am Samstag, 20. Mai 2006 23:07 schrieb Philippe Gerum:
>  > > Here is the second release candidate for the v2.2 branch. Short log
>  >
>  > The trunks builds fine on my four targets on
>  > http://ngiger.dyndns.org/buildbot/
>  >
>  > I have however still the following errors running the posix simulators
>  > (see http://ngiger.dyndns.org/buildbot/sim/builds/59/step-check_sim/0).
>  > All others posix and vxworks test pass.
>  > The output is:
>
> The tested feature is round-robin scheduling, which only works when the
> system timer is configured in periodic mode; so, when the system timer
> is configured in periodic mode, the test should pass.
Where does the simulator get this configuration from? Can it be changed to run 
tests in periodic and aperiodic mode? 

Would  the test be adapedt to emit a "skipping: periodic mode not configured" 
if it is not properly configured?

Best regards

-- 
Niklaus Giger

