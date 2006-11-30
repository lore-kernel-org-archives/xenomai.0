From: Ulrich Schwab <schwab@domain.hid>
Subject: Re: [Xenomai-help] measuring context switch primary<->secondary mode
Date: Thu, 30 Nov 2006 11:19:01 +0100
References: <456D5075.1060905@domain.hid>
In-Reply-To: <456D5075.1060905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301119.01173.schwab@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Markus.Franke@domain.hid

On Wednesday 29 November 2006 10:18, Markus Franke wrote:
> Dear Xenomai Users,
>
> I want to measure the context switch times between primary and secondary
>  execution modes. Therefore I made some small modifications to the
> already present Latency-Test located in
> $(XENOMAI_ROOT)/src/testsuite/latency
>
> Basically I just changed few things in the latency-Task:
>
> ---snip---
>
> err = rt_task_wait_period(&ov);
> before_tsc = rt_timer_tsc();
> printf("This is a teststring for entering in secondary mode!\n");
> after_tsc = rt_timer_tsc();
>
> dt = after_tsc - before_tsc;
>
>
> if (dt > maxj)
>     maxj = dt;
> if (dt < minj)
>     minj = dt;
> sumj += dt;
>
> ---snap---
>
> After that I configured a kernel with CONFIG_PREEMPT and one without. In
> theory I should resolve much lower switch-times when I am running the
> kernel with CONFIG_PREEMPT, right? However, I can't prove this theory.
> The Switch-Times in the non-CONFIG_PREEMPT case are a bit lower than in
> the CONFIG_PREEMPT - Case.
I think that CONFIG_PREEMPT should reduce the jitter of Your measurement, most 
importantly the worst case switch time, for wich You need a long test run 
under heavy load.
CONFIG_PREEMPT is there to provide more determinism, which usually has a price 
in performance.
Realtime is about determinism not performance (or speed).
Its not maximum speed but guaranteed minimum speed.

Since the probability of a preemption during the mode switch without 
CONFIG_PREEMPT is lower, it might take a long time until the worst case mode 
switch time is observed. This probability might be very close to zero.

Ulrich
-- 
====================================================
  inmess GmbH
  Frankfurter Str. 74
  D - 64521 Gross-Gerau
  Phone: +49 6152 97790
  Fax  : +49 6152 977920
  mail : info@domain.hid
  web:   www.inmess.de
====================================================

