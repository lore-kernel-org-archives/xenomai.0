From: Ulrich Schwab <schwab@domain.hid>
Subject: Re: [Xenomai-help] measuring context switch primary<->secondary mode
Date: Thu, 30 Nov 2006 15:30:10 +0100
References: <456D5075.1060905@domain.hid>
	<200611301119.01173.schwab@domain.hid>
	<456EE120.5060003@domain.hid>
In-Reply-To: <456EE120.5060003@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301530.10283.schwab@domain.hid>
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

On Thursday 30 November 2006 14:48, Markus Franke wrote:
> Ulrich Schwab wrote:
> > I think that CONFIG_PREEMPT should reduce the jitter of Your measurement,
> > most importantly the worst case switch time, for wich You need a long
> > test run under heavy load.
> > CONFIG_PREEMPT is there to provide more determinism, which usually has a
> > price in performance.
> > Realtime is about determinism not performance (or speed).
> > Its not maximum speed but guaranteed minimum speed.
>
> You are absolutely right. I put my system under some load (dd) and made
> two tests. One was with CONFIG_PREEMPT and one without. The worst case
> switch time jitter was about 30% lower in the CONFIG_PREEMPT case, so
> your prediction was right.
>
> > Since the probability of a preemption during the mode switch without
> > CONFIG_PREEMPT is lower, it might take a long time until the worst case
> > mode switch time is observed.
>
> Sorry but I don't understand what you are meaning. Let me explain my
> point of view. When a realtime task in the Xenomai-Domain makes a
> linux-systemcall the task is migrated fully automatically to the
> Linux-Domain as soon as we reach the next preemption point in the
> Linux-Kernel. Due to the fact that preemptability of the linux-kernel
> increase when using CONFIG_PREEMPT, the time to the next preemption
> point should decrease, right?
Correct.
But I wrote:  "  without CONFIG_PREEMPT " 
meaning: the time to the next preemption point is bigger, which might get the 
requested system call done before the preemption is actually happening.

> I don't get the point of your last sentence.

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

