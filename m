Message-ID: <46322255.6080504@domain.hid>
Date: Fri, 27 Apr 2007 18:18:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <cbe23c50704270912i1cdb1272hd700a8b83775a34a@domain.hid>
In-Reply-To: <cbe23c50704270912i1cdb1272hd700a8b83775a34a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Core Dump on possibly buggy signal
	handler	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Eric Noulard wrote:
> Hi all,
> 
> I've recently discovered a "possible" bug
> only occuring with a system running xenomai-patched kernel.
> 
> I have set up a machine (dual-core intel machine).
> The machine is installed with a Fedora Core 6 and
> may be booted (test purpose)  with different kernel:
> 
> 1) linux 2.6.20-0119.rt8
>     which is an Ingo Molnar precompiled preempt-rt patched kernel
>     you may find it there:
>      http://people.redhat.com/mingo/realtime-preempt/
> 
> 2) 2.6.20-xeno-2.3.1-ipipe-1.7-03
>     which is a xenomai enabled kernel I've configured and compiled.
> 
> My test application is a mixed C/C++ USER-land application
> which currently make no xenomai specific call.
> 
> The application core dumps at the end of its execution
> with the xenomai enabled kernel whereas it does not
> with the preempt-rt kernel.
> 
> I track down the problem to a misuse of sigaction calls
> which install SIGALARM handler with sa_flags not properly setup.
> 
> My code is definitely buggy but I let you know because in the first
> place it was puzzling to have different (but consistent and repeatable) behavior
> on different kernel, with core dump using the Xenomai-enabled kernel :((.
> 
> You may try it  yourself:
> 
> gcc -o BadTimerSigHandler TimerSigHandler.c
> 
> generates a the buggy binary, while
> 
> gcc -DGOOD_SIGHANDLING -o GoodTimerSigHandler TimerSigHandler.c
> 
> generates the good one.
> 
> I don't really know if it may indicates a xenomai bug or not
> but I would be glad to understand WHY is this.
> 
> I mean I know that uninitialized memory have unpredictable consequence
> but here the bug is persistent after rerun, reboot, power cycle etc...
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> #include <stdio.h>
> #include <sys/types.h>
> #include <signal.h>
> 
> static int stop = 0;
> 
> void
> SignalHandler(int Signal) {
>   int pid = getpid();
>   printf("Received signal %d. Stopping peacefully.\n", Signal);
>   stop = 1;
> }
> 
> 
> int
> main() {
> 
>   int i;
>   struct sigaction a ;
> 
>   signal(SIGINT , SignalHandler);
>   signal(SIGPIPE, SignalHandler);
>   
>   a.sa_handler = SignalHandler ;
>   sigemptyset(&a.sa_mask);
> #if defined(GOOD_SIGHANDLING)
>   a.sa_flags    = SA_RESTART;
> #endif

You should initialize sa_flags with the bugous value on your platform,
different platforms, different compilers may lead to a different value
of sa_flags here, possibly preventing us from seeing the bug.

-- 
                                                 Gilles Chanteperdrix

