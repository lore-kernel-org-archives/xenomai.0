Message-ID: <47D7C5F9.4030203@domain.hid>
Date: Wed, 12 Mar 2008 13:00:57 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47D6CD29.4020700@domain.hid>	<2ff1a98a0803111127p7868350axa976c68714cf4f05@domain.hid>	<47D6DD05.2040007@domain.hid>
	<18391.3867.521099.955604@domain.hid>
In-Reply-To: <18391.3867.521099.955604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] What have I misunderstood about condition
	variables
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Anders Blomdell wrote:
>  > Gilles Chanteperdrix wrote:
>  > > On Tue, Mar 11, 2008 at 7:19 PM, Anders Blomdell
>  > >>  To me the symptoms indicate that the high priority producer gets the mutex and
>  > >>  signals it before the consumer has properly started to wait on the condition.
>  > > 
>  > > I have not read your program in detail, but what may be your problem
>  > > is that condition variables are not semaphores: if you signal a
>  > > condition variable when nobody is waiting the signal is lost. 
>  > I know this, but the problem is that the program loses signals when it is
>  > waiting. In the consumer:
> 
> Sorry for the noise (and thanks for the patch).
You are welcome.

Small afterthought/question. In the following code:

        xnlock_get_irqsave(&nklock, s);

	...

        mutex->lockcnt = 0;

        if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
                mutex->lockcnt = 1;
                /* Scheduling deferred */
        }

        thread = xnpod_current_thread();

        xnsynch_sleep_on(&cond->synch_base, timeout, XN_RELATIVE);


Am I correct in assuming that no other task (even on a multiprocessor) can claim
the mutex until xnsynch_sleep_on has done its rescheduling?

/Anders


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

