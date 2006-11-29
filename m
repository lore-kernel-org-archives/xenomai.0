Message-ID: <456D58E7.7030807@domain.hid>
Date: Wed, 29 Nov 2006 10:54:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] measuring context switch primary<->secondary mode
References: <456D5075.1060905@domain.hid>
In-Reply-To: <456D5075.1060905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

Markus Franke wrote:
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
> 

You will observe some differences only if you put some load on your
system. The usual way of putting some load on your system is to use dd
or the cache calibrator. See TROUBLESHOOTING.

-- 
                                                 Gilles Chanteperdrix

