From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikHyianvhgO7bbe9RGkgCJsNjPXsFt1J_pvtWOc@domain.hid>
References: <8659178.81831292179675169.JavaMail.defaultUser@domain.hid>
	<1292191450.1837.22.camel@domain.hid>
	<AANLkTikHyianvhgO7bbe9RGkgCJsNjPXsFt1J_pvtWOc@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Dec 2010 21:26:06 +0100
Message-ID: <1292358366.1837.152.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt handling vs. scheduler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro <mau.salvi@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-12-14 at 20:37 +0100, Mauro wrote:
> 2010/12/12 Philippe Gerum <rpm@xenomai.org>
>         
>         
>         
>         What is the return value of rt_intr_wait() in both the valid
>         and
>         spurious cases?
>         
>         
>         --
>         Philippe.
>         
>         
> 
> 
> Return value is 1 in both cases.
> 
> 
> I forgot to mention that periodic task was a Xenomai RT task with
> priority less than interrupt task priority.
> 

I see no way for a timer expiration to wake up the wrong thread (each
thread has its own private periodic timer). However I see a scenario
where your low priority thread could trigger a subsequent IRQ early
enough in the time frame to let you think of a spurious return of
rt_intr_wait(), albeit you did receive two different IRQs as
rt_intr_wait() indicates.

Maybe you should try instrumenting rt_intr_handler()
(ksrc/skins/native.syscall.c) to issue a spot on your oscilloscope, so
as to observe whether you actually get the following sequence:

- rt_intr_handler
- IRQ server wakeup and block back in rt_intr_wait
- periodic task wakeup, trigger IRQ via mmio of some sort
- rt_intr_handler
- second IRQ server wakeup

all in a short time frame.

Please keep the list Cced.

> 
> Thank you, bye.
> 
> 
> Mauro

-- 
Philippe.



