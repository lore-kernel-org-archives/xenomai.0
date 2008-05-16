Message-ID: <482DCA2F.9010609@domain.hid>
Date: Fri, 16 May 2008 13:53:51 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <482DBABA.9010408@domain.hid>
	<18477.50111.565572.591277@domain.hid>
In-Reply-To: <18477.50111.565572.591277@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] runaway secondary tasks lock up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Gilles Chanteperdrix wrote:
> Tomas Kalibera wrote:
>  > 
>  > Hi,
>  > 
>  > I've noticed an interesting difference regarding primary and secondary 
>  > domain runaway tasks. The primary domain ones are detected by Xenomai 
>  > watchdog and terminated. The secondary domain ones are not terminated, 
>  > but cause a system lockup, because a secondary domain task is always run 
>  > in preference of other tasks  (kernel complains by  BUG: soft lockup - 
>  > CPU#0 stuck for 11s!). Would there be a way to also detect the secondary 
>  > domain runaway threads ? Since the kernel itself can do it, it should be 
>  > possible, right ?
>
> Yes, but if the Linux kernel does it, why would Xenomai reinvent the wheel ?
>   
Because the wheels behave differently. Xenomai watchdog kills the app 
after 4 seconds, kernel just writes a message. This is not nice for 
debugging large Xenomai applications. You add a debug printf somewhere 
and it makes the system freeze because it switches to secondary domain.  
And when the application just does not have full control over when it 
runs in primary or secondary domain (i.e. a JVM), this is  somewhat 
painful.
>  > 
>  > Now, I've discovered that if I assign the secondary domain task priority 
>  > 0, it would not lock up the system. 1 would, 99 would as well. What is 
>  > the semantics ? Any secondary domain task with priority above zero runs 
>  > in preference of any (non-Xenomai) Linux thread ?
>
> This is not related to Xenomai, that is the semantic of SCHED_FIFO, also
> called fixed priority scheduling.
>   
Thank you for explaining this. It would be nice if the Xenomai API 
documentation could say that the priorities are directly mapped to Linux 
priorities and that SCHED_FIFO is used.
>  > 
>  > And asking from the other end, how to write polling (secondary domain) 
>  > applications in Xenomai ? Should it have priority 0 ?
>
> The best way to write polling applications with Xenomai is not to write
> polling applications at all. Polling makes your processor burning hot,
> does not scale well, and is a really poor programming style, really.
>   

Well, there are some issues with interrupts & realtime too.. But, 
indeed, polling makes little sense when the app must be preemptible by 
Linux.

Tomas


