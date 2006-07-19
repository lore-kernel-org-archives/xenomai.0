Subject: Re: [Xenomai-core] [PATCH 2/2] simplify xntimer_start
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44BD735B.2030502@domain.hid>
References: <44BD735B.2030502@domain.hid>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 10:28:48 +0200
Message-Id: <1153297728.5026.12.camel@domain.hid>
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

On Wed, 2006-07-19 at 01:48 +0200, Jan Kiszka wrote:
> Almost all callers of xntimer_start already run in nklock-protected
> context. Therefore, we can save the lock reacquisition in that function
> and turn it even into a trivial inliner. This patch also takes care of
> the two exceptions of the rule above in xnpod_start_timer and psos+'s
> tm_start_event_timer.

Applied, thanks.


> 
> Jan
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



