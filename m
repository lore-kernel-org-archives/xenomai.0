From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTiky8ijwfEZ+6j9etMz1is20UNCyJm-d48NVwZR-@domain.hid>
References: <AANLkTiky8ijwfEZ+6j9etMz1is20UNCyJm-d48NVwZR-@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Sep 2010 07:38:39 +0200
Message-ID: <1285220319.1661.93.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pSOS+ skin: unique task names
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: Xenomai-help@domain.hid

On Wed, 2010-09-22 at 21:24 +0200, ronny meeus wrote:
> Hello
> 
> I have a question related to the pSOS+ skin. It might be relevant for
> other skins as well.
> 
> What I observe is that the taskname while creating a task should be
> unique.
> If I use the same taskname twice, I get a failure. I think this is not
> a restriction in the real pSOS+ implementation, so this means that
> some applications will not be portable.

That variation from pSOS is wanted; allowing duplicate names would make
the *_ident() calls basically useless like in the original
implementation. pSOS does not check for uniqueness to keep things simple
internally, but there would be no valid reason to prevent the emulator
from using the arbitrarily long labels Xenomai supports, provided this
does neither change the API nor the semantics. Even more importantly,
allowing duplicates would prevent the emulator from using a number of
built-in Xenomai features, such as accessing the pSOS object states via
reading /proc/xenomai/registry/psos/*. The same goes when reading the
output of /proc/xenomai/sched and so on. Generally speaking, using
different names to label different objects seems a reasonable idea.

> 
> I second issue I see is that since the main task is also registered
> under the name "MAIN". This means I can have only 1 process that makes
> use of the pSOS skin. If I start a second process, an error code is
> returned since the "MAIN" task already exists (it is automatically
> created during the initialization phase). 
> 

This is definitely a useless restriction from the emulator. You already
applied the fix, by tackling the pid to the MAIN label.

> I made a workaround for this by appending the PID to the task names
> created in the application.
> I also to the same for the "MAIN" task.
> 
> After applying the change and starting the same application 2 times, I
> get following result when I dump the scheduler information:
> # cat /proc/xenomai/sched
> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>   0  0      idle    -1      -         master     R          ROOT
>   0  1046   rt       0      5370t     psos       D          MAIN_1046
>   0  1048   rt      10      100t      psos       D          TST5_1046
>   0  1049   rt      64      0t        psos       Wl         TTT0_1048
>   0  1050   rt      64      0t        psos       Wl         TTT1_1048
>   0  1051   rt      64      0t        psos       Wl         TTT2_1048
>   0  1052   rt      64      0t        psos       Wl         TTT3_1048
>   0  1053   rt      64      0t        psos       Wl         TTT4_1048
>   0  1054   rt      64      0t        psos       Wl         TTT5_1048
>   0  1055   rt      64      0t        psos       Wl         TTT6_1048
>   0  1056   rt      64      0t        psos       Wl         TTT7_1048
>   0  1057   rt      64      0t        psos       Wl         TTT8_1048
>   0  1058   rt      64      0t        psos       Wl         TTT9_1048
>   0  1059   rt       0      6802t     psos       D          MAIN_1059
>   0  1061   rt      10      100t      psos       D          TST5_1059
>   0  1062   rt      64      0t        psos       Wl         TTT0_1061
>   0  1063   rt      64      0t        psos       Wl         TTT1_1061
>   0  1064   rt      64      0t        psos       Wl         TTT2_1061
>   0  1065   rt      64      0t        psos       Wl         TTT3_1061
>   0  1066   rt      64      0t        psos       Wl         TTT4_1061
>   0  1067   rt      64      0t        psos       Wl         TTT5_1061
>   0  1068   rt      64      0t        psos       Wl         TTT6_1061
>   0  1069   rt      64      0t        psos       Wl         TTT7_1061
>   0  1070   rt      64      0t        psos       Wl         TTT8_1061
>   0  1071   rt      64      0t        psos       Wl         TTT9_1061
> 
> Now the question is: is this the right technique or do other means
> exist to start multiple clients (processes) of the pSOS skin.

> It might be better to use a unique ID per "application" instead of the
> PID since now the full name depends on the actual thread that has
> created the new process. To be more clear: all tasks belonging to a
> certain process could be appended with the same unique number.

The only sane way to handle this issue is to expect the application code
to deal with name uniqueness internally. Having the emulator tackle any
"application ID" automatically to names would be a useless annoyance to
the applications which do name their objects uniquely, usually to be
able to refer to the objects unambiguously, later. Besides, this would
break the *_ident() calls, unless we assign two names to each object,
which would be massively overkill, only to solve an arguable corner
case.

It seems your code is running over the legacy linuxthreads support,
which would explain why you get different return values for getpid()
depending on the calling thread. An easy way to introduce unique naming
in your application would be to call getpid() once in the main thread
and save this value to some global variable, then use that variable to
format all other name labels within the application. This would work for
both linuxthreads and nptl implementations.

> Please comment.
> 
> Best regards,
> Ronny
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



