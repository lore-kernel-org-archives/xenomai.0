Message-ID: <43BA4349.1030102@domain.hid>
Date: Tue, 03 Jan 2006 10:26:33 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM interrupt programming practice
References: <1135950474.43b53a8a070f6@domain.hid>	<43B54A89.1010808@domain.hid>
	<43B5635B.9050706@domain.hid>
	<1136243980.43b9b50c10e17@domain.hid>
In-Reply-To: <1136243980.43b9b50c10e17@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: vdkeybus <Jeroen.VandenKeybus@domain.hid>
Cc: xenomai@xenomai.org

vdkeybus wrote:
> Ok. I've applied the patches (kernel is now also 2.6.14-5).
> 
> 1. I've also upgraded the kernel from 2.6.14 to 2.6.14-5, because 
> Xenomai's make ...config was complaining about not finding 
> CONFIG_IPIPE_EXTENDED after application of Adeos patch 1.1-00 to 
> a 'vanilla' 2.6.14-5 Linux kernel. Eventually I added the CONFIG line 
> myself, but I'm now consequently working with a newer kernel than the 
> one in my previous report.

Which is wrong. Xeno 2.0.x is not expected to work with the Adeos 1.1 
series. The fact that it still does with -00 is pure luck, and won't be 
true anymore with the next 1.1 releases. You should stick with the 
patches available from arch/i386/patches which have been validated 
against the Xeno version that ships them, at least until you have a 
working configuration. I know that the tracer is a very desirable tool, 
but the workforce is not infinite here, and backporting every 
significant improvement to each Xenomai version on every platform is not 
possible.

> 
> 2. While compiling kernels (I'm still far from enjoying this 
> activity...), I accidentally turned back on SMP (2 CPUs) with 
> multithreading (SMT). Everything worked fine (as opposed to my first 
> 2.6.14 SMP venture some weeks ago, which gave tons of smp_processor_id
> () bugwarnings and forced me to turn of SMP), but I was getting massive 
> delays with ./latency (about 20 times normal values with lots of 
> overruns). I turned SMP+SMT back off, and all values are normal again. 
> Is this a known issue ? Or should I just not try to push things...
> 

It's hard to answer this until you explain which things you are trying 
to push... Xeno version? Adeos patch version? Kind of hw?

> 3. Three things concerning interrupt programming:
> 
> 3a - I _did_ disable the card's interrupt lines, but I _forgot_ to 
> enable interrupts with rtdm_irq_enable(). Nevertheless, I still _got_ 
> the interrupts, until I placed the PCI card in a slot without interrupt 
> sharing. BTW the return value of the rtdm_irq_request() and 
> rtdm_irq_free() funtions was 0.
> 

Linux was likely re-enabling the channel after the interrupt hit its 
pipeline stage.

> 3b - Is it ok to return from the ISR with RTDM_IRQ_ENABLE if the 
> interrupt is for the card and to return with RTDM_IRQ_PROPAGATE if it 
> is not ?

If Linux is not expected to care for the interrupt, yes.

  Should I logically OR them together ?
> 

You would relay interrupts Linux does not care for uselessly.

> 3c - ipipe_trace() indeed seems to be a very powerful tool for finding 
> out the source of excessive latencies. Thanks for pointing it out.
> 
> 4. What is the test one has to perform to 'load' a Linux machine and 
> verify proper operation of Xenomai ?

Resilience to cache trashing is a significant aspect; running the 
latency test + dd loop + some compilation in the background would be 
meaningful.

  I've tried running 'latency' while
> my RT program is running, but it causes a missed deadline in my RT 
> program and latency won't run.
> 

Did you look at the the code in latency.c? What it does very likely 
conflicts with what your program does wrt configuration and deadlines 
(timer setup, task priorities...).

> 5. While X is running, the computer becomes very sluggish during 
> execution of an RT-program. I'm getting processing times of around 30 
> us between interrupt generation and PCI register updates and a 
> repetition rate of 100 us (all measured with a hardware timer on the 
> PCI board). I'm wondering what could be the reason for this 
> disproportional degradation of the user interface (it certainly doesn't 
> seem the computer is only 30 % slower. Rather, it feels like 95 % and 
> bringing up e.g. Firefox takes more than 30 s.).
>

X acceleration often leads to surprising results, since nowadays graphic 
cards are not that RT friendly when they "optimize" things.

> 
>>>Hmm, is that IRQ line shared with non-RT hardware BTW? This is
>>
>>typically
>>
>>>a no-go for hard-RT scenarios. Already tried to disable that sound
>>>interface (e.g. in the BIOS if on-chip)?
> 
> 
> It was. And in fact, it still is, because if I removed the sound in 
> BIOS, it got replaced by USB. Touch the mouse in RT and...
> 
> 
>>>>4. How can I verify the status of running xenomai processes (and
>>
>>the 
>>
>>>>driver). I would like to find out why I'm not meeting my interrupt
>>>>deadlines.
>>>
>>$ cat /proc/xenomai/sched
>>$ cat /proc/xenomai/stat
> 

Stats requires the proper option to be selected in the Nucleus menu.

> 
> I could not find stat. (Xenomai 2.0.2) But sched also shows the status. 
> I found the symbol explanations in thread.h.
> 
> Anyway, the system is now working at interrupt rates between 4,000 and 
> 20,000 per second. There is still an occasional overrun, which I'll try 
> to trace with my new toy (ipipe_trace).
> 
> Thanks for all your help,
> 
> 
> Jeroen.
> 
> Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

