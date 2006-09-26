Subject: Re: [Xenomai-help] Help on debugger gdb
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45188502.4060209@domain.hid>
References: <45188502.4060209@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 11:08:51 +0200
Message-Id: <1159261731.5084.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-09-25 at 22:40 -0300, Rodrigo Rosenfeld Rosas wrote:
> Hi, it's me again, after a long while :)
> 
> I'll present my Master thesis this Friday and I would like to comment 
> about the debugger. Since I'm in hurry with a lot other issues, I do not 
> have to time to test what I'm going to ask.
> 
> I've never used a debugger with Xenomai (or RTAI). I mean, not GDB. I 
> used other techniques to debug, such as logging, etc. My doubt is:
> 
> Suppose I have a user-space program with 3 independent Xenomai RT-tasks. 
> If I put a breakpoint in one of them, will the other two keep running? I 
> guess yes, but I'm not sure and that is why I'm asking.
> 

Actually, they would not. The kernel would stop all of them as a
consequence of ptracing, and Xenomai would switch them back to secondary
mode if needed, to let them handle the new situation properly.

> Another thing. I think that the scheduler will keep counting the time 
> when the debugger stopped the task. So, the next call to 
> rt_task_wait_period() will return -ETIMEDOUT immediately, with the 
> overruns set accordly, if this was the case, right?
> 

No, the outstanding RT timers are globally frozen whenever a ptraced
user-space task is stopped by the debugger, exactely to prevent the case
you described, so that you can step into your application without
causing such annoying side-effect. Since we are breakpointing/stepping
into the code, real-time accuracy doesn't matter anyway, so we act as if
the timeline was being frozen each time the debugger holds the
application. 

> Thank you all again for all the support I had while researching for my 
> master thesis. :) After concluding it, it will be time for starting 
> looking for a job. If anyone of you knows about some company that could 
> employ a brazilian to work with Linux based real-time systems, 
> preferently Xenomai, please, let me know.
> 
> Best regards,
> 
> Rodrigo.
> 
> 
> 		
> _______________________________________________________ 
> Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
> http://br.mobile.yahoo.com/mailalertas/ 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



