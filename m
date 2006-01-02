Message-ID: <1136243980.43b9b50c10e17@domain.hid>
Date: Tue, 03 Jan 2006 00:19:40 +0100
From: vdkeybus <Jeroen.VandenKeybus@domain.hid>
Subject: Re: [Xenomai-help] RTDM interrupt programming practice
References: <1135950474.43b53a8a070f6@domain.hid>
	<43B54A89.1010808@domain.hid> <43B5635B.9050706@domain.hid>
In-Reply-To: <43B5635B.9050706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Ok. I've applied the patches (kernel is now also 2.6.14-5).

1. I've also upgraded the kernel from 2.6.14 to 2.6.14-5, because 
Xenomai's make ...config was complaining about not finding 
CONFIG_IPIPE_EXTENDED after application of Adeos patch 1.1-00 to 
a 'vanilla' 2.6.14-5 Linux kernel. Eventually I added the CONFIG line 
myself, but I'm now consequently working with a newer kernel than the 
one in my previous report.

2. While compiling kernels (I'm still far from enjoying this 
activity...), I accidentally turned back on SMP (2 CPUs) with 
multithreading (SMT). Everything worked fine (as opposed to my first 
2.6.14 SMP venture some weeks ago, which gave tons of smp_processor_id
() bugwarnings and forced me to turn of SMP), but I was getting massive 
delays with ./latency (about 20 times normal values with lots of 
overruns). I turned SMP+SMT back off, and all values are normal again. 
Is this a known issue ? Or should I just not try to push things...

3. Three things concerning interrupt programming:

3a - I _did_ disable the card's interrupt lines, but I _forgot_ to 
enable interrupts with rtdm_irq_enable(). Nevertheless, I still _got_ 
the interrupts, until I placed the PCI card in a slot without interrupt 
sharing. BTW the return value of the rtdm_irq_request() and 
rtdm_irq_free() funtions was 0.

3b - Is it ok to return from the ISR with RTDM_IRQ_ENABLE if the 
interrupt is for the card and to return with RTDM_IRQ_PROPAGATE if it 
is not ? Should I logically OR them together ?

3c - ipipe_trace() indeed seems to be a very powerful tool for finding 
out the source of excessive latencies. Thanks for pointing it out.

4. What is the test one has to perform to 'load' a Linux machine and 
verify proper operation of Xenomai ? I've tried running 'latency' while 
my RT program is running, but it causes a missed deadline in my RT 
program and latency won't run.

5. While X is running, the computer becomes very sluggish during 
execution of an RT-program. I'm getting processing times of around 30 
us between interrupt generation and PCI register updates and a 
repetition rate of 100 us (all measured with a hardware timer on the 
PCI board). I'm wondering what could be the reason for this 
disproportional degradation of the user interface (it certainly doesn't 
seem the computer is only 30 % slower. Rather, it feels like 95 % and 
bringing up e.g. Firefox takes more than 30 s.).

> > Hmm, is that IRQ line shared with non-RT hardware BTW? This is
> typically
> > a no-go for hard-RT scenarios. Already tried to disable that sound
> > interface (e.g. in the BIOS if on-chip)?

It was. And in fact, it still is, because if I removed the sound in 
BIOS, it got replaced by USB. Touch the mouse in RT and...

> >>4. How can I verify the status of running xenomai processes (and
> the 
> >>driver). I would like to find out why I'm not meeting my interrupt
> >>deadlines.
> > 
> 
> $ cat /proc/xenomai/sched
> $ cat /proc/xenomai/stat

I could not find stat. (Xenomai 2.0.2) But sched also shows the status. 
I found the symbol explanations in thread.h.

Anyway, the system is now working at interrupt rates between 4,000 and 
20,000 per second. There is still an occasional overrun, which I'll try 
to trace with my new toy (ipipe_trace).

Thanks for all your help,


Jeroen.

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm


