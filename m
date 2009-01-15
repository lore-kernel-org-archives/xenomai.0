Message-ID: <496F12DD.40500@domain.hid>
Date: Thu, 15 Jan 2009 11:41:33 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] State of the Xenomai/ia64 port
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
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


It has been 2.5 years since we saw an update to the Xenomai/ia64 port, and there
is still no sign of life coming from ia64 users (do we actually have any
Xenomai/ia64 users? maybe one, a single one?). To sum up the situation:

- our ia64 port stalled in 2.6.16.
- we had zero feedback from anyone regarding the Xenomai/ia64 port since it was
introduced in 2005 (no, I won't buy the "there was no bug to report" explanation
for this; it has been a while since Santa Claus told me he was a fake).
- there is no incentive to rejuvenate the ia64 port on my side, given that I
would definitely use PREEMPT_RT to gain real-time guarantees instead of a
co-kernel on this particular architecture.
- We did not hear of anyone having such incentive yet.

Letting an architecture port bit rot in Xenomai is not an option, and
maintaining a useless port makes no sense. 2.5 brings in a number of new
features, and it is crucial that all of the Xenomai ports support them properly.

If you think I'm badly wrong, utterly misinformed, or just nuts (whichever comes
first), you may want to speak up now. 2.5-rc1 is due for the first week of
February, and I plan to remove the ia64 support before our first release
candidate is out, unless somebody convinces me that I should not do that.

-- 
Philippe.

