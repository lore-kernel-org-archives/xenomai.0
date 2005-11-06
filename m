Message-ID: <436E5D17.6010405@domain.hid>
Date: Sun, 06 Nov 2005 20:44:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] number-crunching execution jitter
References: <2F8EE677D406514ABE53EF9C0934A666017CAF3E@anubis2.clb.tcfr.thales>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666017CAF3E@anubis2.clb.tcfr.thales>
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
To: Dominique.RAGOT@fr.thalesgroup.com
Cc: xenomai@xenomai.org

Dominique.RAGOT@fr.thalesgroup.com wrote:
> Stephane Fillod wrote:
> 
>>-----Message d'origine-----
>>De : Fillod Stephane [mailto:stephane.fillod@domain.hid]
>>Envoye : vendredi 4 novembre 2005 13:30
>>A : Dominique.RAGOT@fr.thalesgroup.com; xenomai@xenomai.org
>>Objet : RE: [Xenomai-help] number-crunching execution jitter
>>
>>
>>Dominique.RAGOT wrote:
>>
>>>I am using Xenomai 2.0 for a number-crunching application on
>>
>>bi-processor x86 SMP and using the Posix skin.
>>
>>>There are 2 tasks on each processor that are awaken every 20ms and
>>
>>execute for 16ms.
>>
>>>When there are no perturbations on the machine, the jitter on tasks
>>
>>wakeup and execution time is acceptable (approx. 5%).
>>
>>>However, when adding a simple load such as find / -print 
>>
>>redirected to
>>/dev/null, the execution jitter is much worse (more than 100% in some
>>cases), whereas wakeup jitter remains good. My conclusion is that the
>>tasks are preempted when running. Is it right ?
>>
>>IMHO, there are plenty of other possible reasons.
>>What *measurement* result makes you conclude it is preemption which
>>induces
>>execution jitter?
> 
> 
> The system is not connected to anything else than keyboard, mouse and display screen and is booted in single-user mode. The only visible userland tasks are init, udevd and the current shell. When the tests are running I do not touch anything and display output is redirected to /dev/null. What are the other possible reasons remaining in this case ?
> 
> In the meantime I modified the benchmark with a call to the routine pthread_set_mode_np(0, PTHREAD_SHIELD) immediately after thread is created, and observes a huge reduction in execution jitter, but at the expense of wakeup jitter. So I concluded the interrupt shield was definitely not doing much without this call. Am I wrong ?
> 

You've basically demonstrated that the interrupt shield works by preventing 
Linux-targeted interrupts from preempting your number crunching thread. However, 
interrupt shielding induces the overhead of filtering events through an 
additional intermediate Adeos domain. The tradeoff between shielding overhead 
and execution jitter might be in favour of the latter for intensive computing 
tasks that need deterministic execution times, but it's clearly the other way 
around for event-driven tasks that are bound to the shortest possible wake up 
latencies.

Since Ice Nine (v0.9), latency-bound tasks are explicitely favoured by default, 
which means that the interrupt shield support is off at build-time unless 
otherwise specified, and threads need to explicitely activate it when such 
support is compiled in. It's quite not like saying that the support is not there 
anymore, it just happens to not be the default.

> 
>>Rem: I assume your RT tasks are free of non-RT Linux syscalls.
>>
> 
> 
> RT tasks are doing mathematical operations and calls to Xenomai POSIX skin routines. How can I make sure no non-RT Linux syscall is ever called ?
> 

Search the various list archives for SIGXCPU and the T_WARNSW bit of the native 
interface. The POSIX skin exports the same support called PTHREAD_WARNSW.

> 
>>>I suspect the interrupt shield to be inactive (although I see it in
>>
>>/proc/adeos). How could it be activated with Posix skin ? How could it
>>be monitored ?
>>
>>Subtract the number of interrupts handlers processed when 
>>leaving your 
>>RT task by the number when entering. This measurement will 
>>tell you if 
>>the interrupt shield works as expected or not.
> 
> 
> How do you obtain these numbers ? Is there any system call usable or shall I use the information in /proc.
> 

/proc/xenomai/sched. A 's' bit in the status field of a thread tells you that 
the shield is operating for such thread.

> 
>>A tool like LTT (not available now with Xenomai?) would have been able
>>to tell what's happening during the 20ms period.
>>
>>My random guess is you're maybe in the need of a "cache-shield", 
>>a "tlb-shield" and/or a "DMA-shield". All those shields (tm) :-).
> 
> 
> Sorry, I do not understand your point here. If this stuff is trademark, (tm) as you write it, I doubt it has ever been incorporated in any Xenomai or Fusion release. Where can I get it anyway ? Google was not my friend on this !
> 
> 
>>Measurements can be done using OProfile, with appropriate event
>>selection.
>>
> 
> 
> OK, I will try it.
> 
> 
>>>PS: too bad the cruncher will not survive 2.0. Would you consider
>>
>>including POSIX tests in the new 2.1 release ? I did not see 
>>any in the
>>2.0.
>>
>>I'm sure the Xenomai committer team will enjoy your patches ;-)
>>
> 
> 
> This is why I asked. If number crunching is no longer in the scope it is worth knowing. Are you a member of this team ?
> 

Why would you want to limit the scope of a real-time framework by one of its 
possible applications? Not everyone is interested in number crunching, which 
does not mean that Xeno does not provide support for it, it still does. The 
point is that it's not the defaut setup because it's by far an uncommon use 
which induces a performance tradeoff, that's all.

> 
>>Best Regards,
>>-- 
>>Stephane
>>
> 
> 
> Best Regards,
> --
> Dominique
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

