Message-ID: <518A4C09.8030906@xenomai.org>
Date: Wed, 08 May 2013 14:58:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>
	<51830D98.7090309@xenomai.org>	<5183CDD6.80400@mitrol.it>
	<518A06C9.50204@mitrol.it>
In-Reply-To: <518A06C9.50204@mitrol.it>
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

On 05/08/2013 10:03 AM, Paolo Minazzi wrote:

> Hi Gilles,
> I have added a check in
> 
> file          :   xenomai-2.5.6/ksrc/skins/native/task.c
> function      :   int rt_task_delete(RT_TASK *task)
> 
> See my code signed with =======>
> 
> It seems if I'm working with a gdb session, the rt_task_delete() keep 
> the lock of the killed thread.
> With my additional check, all seems ok.
> 
> I could also insert my check directly in xnpod_delete_thread().
> 
> What do you think about ?


That is a hack. You are working around the real bug. The real fix is to
get the timers unlocked at the time where they should be unlocked. In
order to do this, I suggest once more to enable the I-pipe tracer and
trigger a trace freeze at a point in the code where you are sure the
timers should be unlocked, but they are not, and with enough backlog,
try and understand what happened.

In the example you sent, they should be unlocked as soon as you type
"continue" in gdb console, not any time later.

-- 
                                                                Gilles.

