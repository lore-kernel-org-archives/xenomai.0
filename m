Message-ID: <5183CDD6.80400@mitrol.it>
Date: Fri, 03 May 2013 16:46:46 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it> <51830D98.7090309@xenomai.org>
In-Reply-To: <51830D98.7090309@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Re : Sporadic problem : rt_task_sleep locked after
 debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 03/05/2013 3.06, Gilles Chanteperdrix ha scritto:
> The problem, if I understand it correctly, is that timers are locked 
> when you debug your application with gdb (which is correct), but do 
> not restart when they should. What you have done here is essentially 
> restart them upon any SIGSTOP or SIGINT, which means that the timers 
> are in fact not stopped.

Hi Gilles, you understand correctly.

This is an other test that show that timer are locked.
I have also printed the following number :

xnarch_atomic_get(&nkpod->timerlck)

xnarch_atomic_get(&nkpod->timerlck) == 0    means     unlocked
xnarch_atomic_get(&nkpod->timerlck) > 0     means     locked

If I'm stopped with gdb I see 70 (ok, timers locked).
When I restart and all is OK I see 0 (zero, that is timer unlocked).
When I restart ad I have the bug I see 1(bug, I should see zero).

Sometimes, for some reason, timer remains locked.
This is the problem.

>
> What exactly do you do with gdb when the bug happens? Do you restart the
> application with "continue", do you detach de debugger with "detach" or
> something else?
To see the bug I have to

-1- start gdbserver
-2- start gdbclient
-3- handle SIG32 nostop noprint
-4- set brk point #1
-5- set brk point #2
-6- set brk point #3
-7- c to continue (start the program)
-8- it stops on brk point #3
-9- c to continue
-10- it stops on brk point #1
-11- c to continue
-12- it stops on brk point #2
-13- disable brk point #2
-14- c to continue
====> now timers are locked !


Maybe it is interesting that if I remove command -3-

-3- handle SIG32 nostop noprint

at point -12- I begin to receive SIG32 signals.
The SIG32 messages seems be due to detection of a new threads. In this 
moment infact some thread are create.
Maybe these SIG32 signals make confusion.

> What you should do to understand what happens, is to enable the I-pipe
> tracer and trigger a trace freeze when you hit a point where you are
> sure the timers should have been restarted but have not. With enough
> backlog, you may have some luck finding back what happened.
>
> Regards.
>
I have tried but for me for now it is difficult to make a log at the bug 
point.

Thanks
Paolo


