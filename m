Message-ID: <47B08CBF.4080209@domain.hid>
Date: Mon, 11 Feb 2008 18:58:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>
	<47B053A2.9010503@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>
	<2ff1a98a0802110810r297a639ej5a061b823a4d551d@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376AED@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376AED@slcmail.slc.mew.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] overhead
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
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Well one of my 8khz tasks in kernel space seems to require T_FPU despite
> me never using it. I've been able to reproduce my bug within a minute
> several times without that flag, but if the flag is set, it can run for
> an hour without a single value being corrupted into NaN. 
> 
> I also am getting a lot of page faults with ipipe_handle_irq() in the
> back trace. I'm also noticing if I have T_WARNSW on for a primary mode
> only thread, it will receive the signal if I create a Linux-only thread
> with pthread_create() and that's just weird.

Hmm? You call pthread_create() from the primary-mode-only thread? Or
from some third, unrelated one?

> 
> I don't think the problem is IO time. It's definitely context switching
> and things. IRQ0 handler uses up to 20% of the cpu, and that just seems
> wrong. It gets worse if I try the other scalability options (tree or
> hash.) It uses a lot of CPU time even when the tasks are delayed on
> conditional variables. I don't have periodic timing on, either.

What CPU configuration are you using / do you have to use with your
board? If your selection enforces PIC/PIT, that could explain noticeable
overhead of the timer. Do you have TSC support on your platform? Is it
enabled and usable? Check the .config (or post it), have a look at
/proc/xenomai/timer (latest versions should report clock/timer
settings), check the TSC clock stability with clocktest from the testsuite.

> 
> I never used to notice such high CPU usage with older versions of
> Xenomai. I even had an application written that ran all these threads
> and didn't have a problem with it. 

Older means before 2.4? Or even older than 2.3?

> 
> I'll hopefully find some time soon to write isolated tests and try to
> figure out what's going on. The page fault problems (there are more than
> the one I posted earlier) are really getting annoying, too.
> 
> Sadly my contractor is on the verge of scrapping Xenomai for their
> project because of these problems. :( I really believe in it, but I'm
> basically working two jobs and don't have all the time I wish I did to
> help test.

Do they have an alternative ready at hand? Blindly swapping the problems
rarely helps, first understand, then decide what to do (I know I'm
barking at the wrong tree... ;) ).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

