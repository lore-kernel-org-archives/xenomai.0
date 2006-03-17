From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17434.64265.83096.598165@domain.hid>
Date: Fri, 17 Mar 2006 19:08:09 +0100
Subject: Re: [Xenomai-help] Re: [Xenomai-core] VxWorks skin improvement
In-Reply-To: <441ACB7E.5080309@domain.hid>
References: <44196DD8.8040500@domain.hid>
	<200603171304.22679.niklaus.giger@domain.hid>
	<441ACB7E.5080309@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
 > Niklaus Giger wrote:
 > > What about a vxWorks test suite? I would like to contribute to it.
 > 
 > You would be most welcome doing so.
 > 
 >   (At least
 > > as soon as I have a working Xenomai environment again.)
 >   And I would be much
 > > more confident to recommend Xenomai if it had test suites for its various 
 > > skins. I hope to be able to make some contributions once I get approval to 
 > > put a few of our internal test routines available under a free license.
 > > 
 > 
 > The most useful way to help would be to develop the testsuite for validating the 
 > recent evolution of the VxWorks skin, which now has a fully native call interface 
 > from user-space, i.e. it does not need the UVM layer anymore, albeit the former 
 > way will still be available. Let me know whenever you want to help this way, so 
 > that we could synchronize, for a better efficiency in fixing the potential issues.
 > 

In the hope that it could complement other contributions, I have
unburied vxworks tests running over Xenomai discrete events
simulator. They are adapted from CarbonKernel vxworks
testsuite.

-- 


					    Gilles Chanteperdrix.

