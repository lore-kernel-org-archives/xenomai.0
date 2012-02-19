Message-ID: <4F4150C8.7040104@domain.hid>
Date: Sun, 19 Feb 2012 20:43:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>


Hi,

restarting the ipipe-core is the good opportunity to look a bit at our
current state and think about what we could improve. On ARM, at least,
the thing we could improve is the timer subsystem. A long time ago,
linux has switched to a system allowing to select at run-time which
timer to use, and we do not really benefit from this, what timer we use
is selected at compile time, resulting in a massive ifdefery on arm, and
even on x86, we have to select at compile time whether using the 8254 or
APIC, whereas we could decide to use whatever linux is using, even say
HPET, without any compilation option. That is assuming we want to move
the x86 timer-specific code from xenomai to I-pipe.

The idea to reach this goal would be to add some ipipe specific members
to the struct clock_event_device, the way we do for the interrupt
controller:
- a CLOCK_EVT_FEAT_IPIPE would signal that the clockevent device is
ipipe capable, meaning that it implements the following callback
- ipipe_steal would be called when stealing the timer, we could decide
to call this callback either as part of ipipe_request_timer, or with a
specific ipipe_steal_timer call, currently we simply set
__ipipe_mach_timerstolen to 1, but it is pure luck that we never needed
something more complicated, besides, we may want to start a timer that
was not started by linux so, we would put its initialization here;
- ipipe_stolen would record whether the timer is stolen
- ipipe_min_delta_ticks, ipipe_max_delta_ticks would be used by the
ipipe_set_next_event callback
- ipipe_ack would be called to ack the timer interrupt the way we
currently do it currently on arm with __ipipe_mach_acktimer
- ipipe_set_next_event would program the next timer shot, the way it is
currently done in __ipipe_mach_set_dec.

All this is pretty straightforward, but there is still a question: how
does ipipe_request_timer select a timer. The idea is that on platform
without PIC muting, it is probably more efficient to use the same timer
for linux and xenomai. But on platforms with PIC muting, we could want
to select a different timer for linux and xenomai, but how do we find
it, what if linux has not selected a timer because it is unusable on
that platform?

Please feel free to comment these sketchy ideas.

-- 
                                                                Gilles.

