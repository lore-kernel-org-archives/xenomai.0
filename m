Message-ID: <51830D98.7090309@xenomai.org>
Date: Fri, 03 May 2013 03:06:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>
In-Reply-To: <51826EEA.1090202@mitrol.it>
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

On 05/02/2013 03:49 PM, Paolo Minazzi wrote:

> I'm Paolo Minazzi and some time ago I write you for a problem
> related to xenomai and gdb.
> After a long time I think to be near to a solution.
> I'd like your help and opinions because maybe also other people
> have the same problem.
> 
> In short, if I debug a xenomai user-space application,
> sometimes after a rt_task_sleep the application seems locked.
> After this condition, I have to restart my arm processor
> because xenomai seems locked. Normal linux application instead
> continue to work correctly.
> 
> A solution that works for me is to comment some lines in
> xenomai-2.5.6/ksrc/nucleus/shadow.c:2620
> Please see my comments that begin with "// COMMENT"


The problem, if I understand it correctly, is that timers are locked
when you debug your application with gdb (which is correct), but do not
restart when they should. What you have done here is essentially restart
them upon any SIGSTOP or SIGINT, which means that the timers are in fact
not stopped.

What exactly do you do with gdb when the bug happens? Do you restart the
application with "continue", do you detach de debugger with "detach" or
something else?

What you should do to understand what happens, is to enable the I-pipe
tracer and trigger a trace freeze when you hit a point where you are
sure the timers should have been restarted but have not. With enough
backlog, you may have some luck finding back what happened.

Regards.

-- 
                                                                Gilles.

