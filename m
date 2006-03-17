Message-ID: <441A6C7E.5000603@domain.hid>
Date: Fri, 17 Mar 2006 08:59:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_catch and rt_hook in user space?
References: <200603162115.20077.xpit@domain.hid>
In-Reply-To: <200603162115.20077.xpit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alessandro Pittaluga <xpit@domain.hid>
Cc: xenomai@xenomai.org

Alessandro Pittaluga wrote:
> Hi to everybody,
> 
> Anyone knows why the rt_task_catch and rt_hook is not available in the native
> library?

These routines are registering user callouts the nucleus invokes from kernel 
space, so we cannot make them available from user-space at the moment. Maybe this 
situation will improve when asynchronous calls of user-space routines are made 
available in the future, e.g. for dealing with real-time signals without resorting 
to switching to Linux first.

> 
> rt_task_catch seems to me the only clean way to define signal handlers on 
> per-thread basis, but it is not included in the user space lib, although the 
> doc states that the service should be available to user space tasks.
> 

The doc is wrong regarding rt_task_catch(). Only rt_task_notify() is accessible 
from user-space.

> The hooks (registered on context switch) are very useful to calculate number 
> of switches, consumed cpu time and so on..
> 
> Is there any plan to implement them in user space?
>

Yes; no ETA though.

>  
> Many Thanks
> 
> Alessandro
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

