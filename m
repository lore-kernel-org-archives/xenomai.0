From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467F72C1.5050306@domain.hid>
References: <467F72C1.5050306@domain.hid>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 10:04:46 +0200
Message-Id: <1182758686.25449.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Getting the current RT-state of a task
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On Mon, 2007-06-25 at 09:46 +0200, Johan Borkhuis wrote:
> I am building an OS-abstraction layer for our application, and for this 
> I would like to know the RT-status of a task.
> Using the rt_task_set_mode function it is possible to switch between RT 
> and non-RT (using T_PRIMARY). But I would like to know what the state is 
> of the current task. I did not find a function to retrieve the RT-state 
> of a task; is a function available that will return the status of a task?
> 

rt_task_inquire(), check the status field for XNRELAX; if set, your task
runs in secondary mode. Note: this method is currently an ugly hack,
because you should be allowed to check for something like T_SECONDARY
there instead, but unfortunately, you can't for obscure historical
reasons. Cleanup of that mess is pending.

> For the moment I am using the code shown below. Does this code work:
> 

Not as you would expect, because rt_task_set_mode() will send the caller
to the primary domain, but a current glitch in the implementation even
forgets to set the T_PRIMARY bit in the returned mask.

>     rt_task_set_mode(0,0, &var);
>     if(var&T_PRIMARY)
>     {   /* Primary mode */
>         ....
>     }
>     else
>     {   /* Secondary mode */
>         ....
>     }
> 
> I would like to use this for a printf-implementation, where the text is 
> printed if the task is non-RT or send to a logging task is the task is 
> RT. I would like to call this code from Xenomai tasks, but also from 
> plain Linux tasks. Is this possible?
> 

A library doing exactly this is pending, and due for merge before -rc1
is out. If you want to use it on top of 2.3.x, you may want to adapt it
locally:
http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/librtutils.patch

> Kind regards,
>     Johan Borkhuis
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



