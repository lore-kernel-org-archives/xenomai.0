Subject: Re: [Xenomai-core] Towards periodic mode over aperiodic timers
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44E46EDC.1000707@domain.hid>
References: <44E46EDC.1000707@domain.hid>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 13:13:39 +0200
Message-Id: <1155899619.4326.56.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-08-17 at 15:27 +0200, Jan Kiszka wrote:
> Hi,
> 
> the conflict between skins preferring aperiodic timing vs. skin
> requiring periodic mode popped up once again on xenomai-help. One way
> out of this, likely THE way, is to map such tick-driven skins on a
> periodic timer over aperiodic mode (and drop periodic low-level support
> completely at the same time).
> 
> Let's start some discussion how this can be done, specifically as Gilles
> and I are already turning the xntimer subsystem upside down (almost). If
> we want co-existence of high-res timing of, say, the posix skin while
> the vxworks skin runs over a tick-timer, we need some kind of "context"
> for timing related functions.
> 
> Simple example: xnpod_suspend_thread() expects a timeout as "xnticks",
> i.e. either in nanoseconds or in ticks of the underlying periodic timer.
> This depends on the global timer mode of the pod, and that's a no-go for
> concurrent modes as sketched above. Rather, the thread should encode
> which kind of timing mode to use, even better the threads timers.
> 
> We currently dispatch xntimer_start globally to the different timer
> subsystems (if periodic mode is enabled). What about deriving the start
> function from the timer itself in the future? If a timer was created as
> aperiodic, things happen as usual in aperiodic mode, and the timeout are
> interpreted as nanoseconds. If the timer is periodic, we interpret the
> timeout in ticks and map them on a second-level timing subsystem
> (probably a wheel) that itself is driven by a single periodic timer in
> the first-level system (just like the host tick).
> 
> Am I heading in the right direction? Is it feasible? Any other ideas?

I like this idea; it's simple and elegant, having only a low impact on
the existing interfaces.

The two-level timer handling moving the BSD wheel on top of the
aperiodic shot is definitely a clean approach, which adds no overhead to
the existing periodic timer management. This would also allow to get rid
of the specific Adeos support for periodic hw management.

-- 
Philippe.



