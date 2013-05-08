Message-ID: <518A648A.7010705@xenomai.org>
Date: Wed, 08 May 2013 16:43:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>	<51830D98.7090309@xenomai.org>	<5183CDD6.80400@mitrol.it>	<518A06C9.50204@mitrol.it>
	<518A4C09.8030906@xenomai.org>	<518A505C.2090207@mitrol.it>
	<518A52A7.5000801@xenomai.org>	<518A5600.20508@mitrol.it>
	<518A6195.7030206@mitrol.it>
In-Reply-To: <518A6195.7030206@mitrol.it>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 05/08/2013 04:30 PM, Paolo Minazzi wrote:

> I have a xenomai application with 70 real-time threads.
> Suppose that thread 1 deletes thread 70 with rt_task_delete().
> This is my case.
> 
> I put a breakpoint and run my xenomai application.
> When my breakpoint is reached gdb stops all my xenomai threads.
> 
> If I press "c" to continue, gdb restarts my application,
> that is every thread, one by one (thread 1, thread 2, thread 3,
> .... , thread 70).
> 
> If I press "c" on gdb, the following scenario could happens :
> 
> 1) gdb start thread 1
> 2) thread 1 starts immediately
> 3)   thread 1 delete thread 70 by rt_task_delete()
> ...
> 4) gdb start thread 2
> 5) gdb start thread 3
> 6) gdb start thread 4
> 7) gdb start thread 5
> 8) gdb start thread 6
> ...
> .) gdb start thread 68
> .) gdb start thread 69
> .) gdb start thread 70
> 
> The thread 1 finds thread 70 in debug mode !
> 
> My patch adjust this problem.
> 
> I realize that it is a very special case, but it is my case.
> 
> I'd like to know if the patch is valid or can be written in a different way.
> For example, I could insert my patch directly in xnpod_delete_thread().
> 
> The function unlock_timers() cannot be called from 
> xenomai-2.5.6/ksrc/skins/native/task.c
> because it is defined static. This is a detail. There are simple ways to 
> solve this.


Hi Paolo,

this explanation makes the condition under which you observe the bug
more clear, but this case is supposed to be already handled by Xenomai code.

If you look at do_taskexit_event() in ksrc/nucleus/shadow.c you will see
at the very beginning a test which does exactly the same thing as your
patch.

Normally, any deletion of a xenomai thread should cause this function to
be called. So, some more debugging is necessary to understand what
happens when rt_task_delete is called in your case. Please try to
trigger an I-pipe tracer freeze in xnpod_delete_thread, and have a large
number of points in /proc/ipipe/trace/post_trace_points.

Regard.

-- 
                                                                Gilles.

