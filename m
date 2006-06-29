From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17571.63940.929691.356210@domain.hid>
Date: Thu, 29 Jun 2006 18:03:16 +0200
Subject: Re: [Xenomai-core] Prio-inversion on cleanup?
In-Reply-To: <1151587492.5291.72.camel@domain.hid>
References: <44A1608B.3090605@domain.hid> <44A295ED.2080306@domain.hid>
	<44A39C3C.1080508@domain.hid> <1151576082.5291.41.camel@domain.hid>
	<44A3ACA8.6070201@domain.hid> <1151578090.5291.49.camel@domain.hid>
	<1151587492.5291.72.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > On Thu, 2006-06-29 at 12:48 +0200, Philippe Gerum wrote:
 > > > > Switching off priority adjustment for the root thread before moving a
 > > > > SCHED_FIFO shadow to SCHED_OTHER would prevent this side-effect. We'd
 > > > > need to add a per-thread status bit to check whether we should run
 > > > > xnpod_renice_root() or not for any given thread, and switch it on/off
 > > > > from __wrap_pthread_setschedparam.
 > > > > 
 > > > 
 > > > This doesn't sound bad and would probably help low-prio threads also in
 > > > some other scenarios.
 > > > 
 > > 
 > > I'm currently implementing that at nucleus level.
 > 
 > The priority coupling switch is in place now, the static config one is
 > called CONFIG_XENO_OPT_RPIDISABLE, and a dynamic flag as been added to
 > the xnthread status mask, namely XNRPIOFF (Root [thread] PI off). I've
 > only added the required support to control priority coupling between
 > both Xenomai and Linux schedulers, but refrained from choosing any
 > policy regarding how we are going to use it in the POSIX skin to solve
 > the pthread_setschedpram issue. I guess that more brain cycles are need
 > there, and I'm cowardly leaving this to Gilles.

I have changed __wrap_pthread_setschedparam so that it no longer uses
__real_pthread_setschedparam, and added a wrapper for
pthread_getschedparam. I will add support for this XNRPIOFF bit to
pthread_set_mode_np. This avoid the need for brain cycles.

-- 


					    Gilles Chanteperdrix.

