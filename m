From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18370.28637.712187.701463@domain.hid>
Date: Mon, 25 Feb 2008 08:35:57 +0100
In-Reply-To: <18369.59855.128681.821895@domain.hid>
References: <18369.40812.619977.597263@domain.hid>
	<47C1A85D.9030409@domain.hid>
	<18369.59855.128681.821895@domain.hid>
Subject: Re: [Xenomai-core] Clockevent/clocksource.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > Philippe Gerum wrote:
 >  > Gilles Chanteperdrix wrote:
 >  > > Hi,
 >  > > 
 >  > > I would like to implement the (I-pipe) AT91 timer management as
 >  > > clocksource/clockevent, however, I have a question, how does one choose
 >  > > the "shift" value in struct clocksource and struct clock_event_device ?
 >  > > 
 >  > 
 >  > http://ixlabs.cs.pub.ro/category/projects/linux-kernel-library/
 > 
 > Looks like the thing is working. A concern though: the hardware timer
 > used on AT91 wraps fast, so if we want the tsc to work correctly, the
 > timer needs to tick every 20ms (which makes using the clock events
 > framework pretty useless, but it is mostly useful for other reasons: it
 > allows me to test Xenomai on ARM in the clock events case). I have set
 > the clock event max_delta_ns member to these 20ms, however when
 > inserting the nucleus module, the max_delta_ns member is set to
 > ULONG_MAX, so my question is: will the nucleus take care of ticking
 > every 20ms ?

Ok. This is now how max_delta_ns is supposed to be used anyway: enabling
NO_HZ breaks the tsc, even if max_delta_ns is not set to ULONG_MAX.

-- 


					    Gilles Chanteperdrix.

