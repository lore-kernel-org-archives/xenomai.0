Message-ID: <48CE9714.8080702@domain.hid>
Date: Mon, 15 Sep 2008 19:10:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid>
In-Reply-To: <48CE7BD7.6060504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
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

Jan Kiszka wrote:
> Slowly moving on toward generic fast mutex support for Xenomai, this
> patch is a proposal to address the increasing divergence of
> owner-tracking vs. owner-less xnsynch objects.
> 
> The services dealing with the former will likely include a new, lockless
> prologues for the mutex fastpath. At the the same time, this additional
> code should not disturb too much in those cases where we do not track
> ownership (condition variables, events, semaphores etc.). Moreover, I
> noticed that some of the existing code assumes XNSYNCH_NOPIP means no
> ownership, which is surely not true. The already visible effect is that
> lock stealing is needlessly restricted to XNSYNCH_PIP.
> 
> Going through the API, I dug out three diverging services and replaced
> them with two new ones:
> 
> Owner-less xnsynch objects:
> - xnsynch_sleep_on
> - xnsynch_wakeup_one_sleeper
> - xnsynch_wakeup_this_sleeper
> 
> Owner-tracking xnsynch objects:
> - xnsynch_acquire
> - xnsynch_release
> 
> The latter type of objects are marked with the new flag XNSYNCH_OWNER,
> used only for debugging and code documentation purposes in the current
> implementation.
> 
> Find a first draft of this approach attached (compile-tested). Before
> going down this round, I would like to collect opinions and finally an
> Ack on this (or and alternative approach). I also briefly thought about
> branching two xnsynch sub-objects for owner/no-owner. But that would
> likely make the changes far more complicated and invasive.

Forgot to mention that the patch applies on top of the first 4 patches
of my "fast mutex rework" series (conflicts in posix only).

Jan

PS: gna.org is dead. Hope it will recover soon...

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

