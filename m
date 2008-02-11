Message-ID: <47B09B10.5090200@domain.hid>
Date: Mon, 11 Feb 2008 19:59:28 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>	<47B053A2.9010503@domain.hid>	<51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>	<2ff1a98a0802110810r297a639ej5a061b823a4d551d@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376AED@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376AED@slcmail.slc.mew.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] overhead
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Steven Seeger wrote:
> Well one of my 8khz tasks in kernel space seems to require T_FPU despite
> me never using it. I've been able to reproduce my bug within a minute
> several times without that flag, but if the flag is set, it can run for
> an hour without a single value being corrupted into NaN. 
> 
> I also am getting a lot of page faults with ipipe_handle_irq() in the
> back trace.

Send those backtraces, please, and a disassembly of your running kernel
privately to me.

 I'm also noticing if I have T_WARNSW on for a primary mode
> only thread, it will receive the signal if I create a Linux-only thread
> with pthread_create() and that's just weird.
>

Sorry, I just don't understand where the problem is, or maybe I did not
understand what you are exactly doing/expecting here.

> I don't think the problem is IO time. It's definitely context switching
> and things. IRQ0 handler uses up to 20% of the cpu, and that just seems
> wrong. It gets worse if I try the other scalability options (tree or
> hash.) It uses a lot of CPU time even when the tasks are delayed on
> conditional variables. I don't have periodic timing on, either.
> 

If you actually take faults on behalf of the tick timer handler, then no
wonder why the CPU figures explode.

> I never used to notice such high CPU usage with older versions of
> Xenomai.

Older versions, or older kernels?

 I even had an application written that ran all these threads
> and didn't have a problem with it. 
> 
> I'll hopefully find some time soon to write isolated tests and try to
> figure out what's going on. The page fault problems (there are more than
> the one I posted earlier) are really getting annoying, too.
> 
> Sadly my contractor is on the verge of scrapping Xenomai for their
> project because of these problems. :( I really believe in it, but I'm
> basically working two jobs and don't have all the time I wish I did to
> help test.
> 
> And Paul, it is only on x86. 
> 
> Steven
> 
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Monday, February 11, 2008 9:10 AM
>> To: Steven Seeger
>> Cc: Jan Kiszka; xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] overhead
>>
>> On Mon, Feb 11, 2008 at 4:20 PM, Steven Seeger
>> <sseeger@domain.hid> wrote:
>>> The overhead was measured by only comparing cpu usage between tasks
> from
>>>  the statistics collection stuff. There are some userland tasks
> running
>>>  at 8khz, so apparently this is a problem for Xenomai on this board.
> I
>>>  had no problem at all with these tasks in kernel space under rtai.
>> user-space adds some overhead compared to kernel-space. Enabling the
>> T_FPU bis for a task which does not need also adds the useless
>> overhead of saving/restoring FPU upon context switch.
>>
>> --
>>                                                Gilles Chanteperdrix
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

