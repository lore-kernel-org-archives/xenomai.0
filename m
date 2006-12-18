From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45868547.6050304@domain.hid>
References: <45868547.6050304@domain.hid>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 22:12:34 +0100
Message-Id: <1166476355.17298.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: [SMP-BUG?] inconsistent cpuid after dispatch_wired
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Mon, 2006-12-18 at 13:10 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> actually, I was trying to apply a micro-optimisation on
> __ipipe_handle_irq, but I think I also found a bug on SMP systems (at
> least on x86):
> 
> After __ipipe_handle_irq forwarded some IRQ to __ipipe_dispatch_wired
> and the latter returned 1 (i.e. "not deferred"), a pipeline sync is
> triggered using the cpuid read on IRQ entry. But I think that
> __ipipe_dispatch_wired may very well have caused some CPU migration of
> the current context so that reloading the cpuid is required here. This
> is what the first attached patch does.
> 

Correct. Applied, thanks.

> Jan
> 
> 
> PS: The optimisation I was looking at deals with the assumption that a
> wired IRQ may never be also a sticky one, correct?

Correct.

>  If yes, the second
> (alternative) patch might be interesting as it avoids to touch the root
> domain data structure and to test for stickiness in the wired case.
> Should shorten the wired IRQ path by a few cycles (or more on cache
> miss...).

Applied, thanks.

-- 
Philippe.



