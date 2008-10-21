Message-ID: <48FE01D1.3070805@domain.hid>
Date: Tue, 21 Oct 2008 18:22:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <loom.20081016T124807-588@domain.hid>
	<1224605536.10407.15.camel@domain.hid>
In-Reply-To: <1224605536.10407.15.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Reducing Kernel Mode Interrupt Latency
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Henry Bausley wrote:
> Is there any way the kernel mode interrupt handling maximum times can be
> decreased.  I very much need to reduce my kernel mode interrupt
> latencies.  I know my hardware is capable of better performance based
> upon measurements done with RT Linux.  Below is our timing comparison,
> all times are the maximums.
> 
> 
> Xenomai 2.4.5 interrupt handler  w/ Kernel 2.6.26 powerpc, gcc 4.2
> -------------------------------------------------------------------
> AMCC 440EP - 24.5 usec
> AMCC 460EX - 16.5 usec
> 
> 
> FSM Labs RT-Linux 2.2 w/ Kernel 2.6.14 ppc, gcc 3.3
> ---------------------------------------------------
> AMCC 440EP - 10.0 usec
> AMCC 460EX - Not Available, would require 10's of thousands of dollars
> to WindRiver
> 

It would be interesting to know the figures for 2.6.14 ppc w/o RTLinux + Xenomai
2.4.5.

Aside of this, I'm working on an experimental patch which implements unmasked
context switches on the Linux side. I stole this idea from Gilles, who
drastically decreased latency on ARM this way. This will not decrease the
user-space latency on powerpc, but this might help in-kernel interrupt latency,
by allowing interrupts to be taken while changing the MMU context.

I'll post that stuff this week if it happens to decrease the in-kernel latency
significantly.

> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

