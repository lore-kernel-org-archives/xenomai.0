Subject: Re: [Xenomai-core] [patch, minor] xnpipe_recv and
	xntimer_get_timeout_periodic()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
References: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 11:49:11 +0200
Message-Id: <1156153751.4402.28.camel@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 10:36 +0200, Dmitry Adamushko wrote:

> [ timer.c.patch] xnticks_t is unsigned while (as I understand)
> "xntlholder_date(&timer->plink) - nkpod->jiffies" can be negative.

Well, normally, it should not. In periodic mode, each and every tick is
processed by the timer handler which also maintains the time base
(nkpod->jiffies), and as such, no timer should remain outstanding after
its wakeup time has elapsed, otherwise, something is broken in the timer
wheel management in the first place.

IOW, we should never miss a tick, and consequently, negative timeouts
cannot exist, since a timer is either running (= 0), or scheduled to
elapse in the future (> 0). On the contrary, aperiodic mode is based on
some free running TSC value not controlled by the nucleus, and as such,
we might well ask for the timeout value slightly before the related
timer elapses, and end up reading the TSC a bit later than its timeout
date.

-- 
Philippe.



