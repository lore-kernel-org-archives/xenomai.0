From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45CAE190.6020404@domain.hid>
References: <45CAE190.6020404@domain.hid>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 10:18:04 +0100
Message-Id: <1170926285.20614.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: Fixed two timer base regressions
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

On Thu, 2007-02-08 at 09:38 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> the "trivial" bugs are fixed already: see #2152 for the reason why
> rt_dev_read timeouts took too long (the timer mode was ignored by
> xnsynch_sleep_on),

Ok.

>  and I also found a yet invisible bug in
> rtdm_toseq_init that would have picked the wrong time base (#2153).
> 

Using xnpod_current_thread()'s time base in rtdm_toseq_init() will
always pick the master one when called over a secondary mode context,
which according to the doc, is allowed. Is this intended?

> Now just that rtcanrecv issue remains...
> 
> Jan
> 
-- 
Philippe.



