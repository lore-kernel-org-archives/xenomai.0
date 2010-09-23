From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100923071501.04028B7480C@mail3-117.sinamail.sina.com.cn>
References: <20100923071501.04028B7480C@mail3-117.sinamail.sina.com.cn>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Sep 2010 10:21:04 +0200
Message-ID: <1285230064.1661.125.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help]
 =?utf-8?b?5Zue5aSN77yaUmU6ICBIb3cgdG8gYWRkICJ0X3Jl?=
 =?utf-8?q?start=22_to_pSoS_emulator?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gwysu@domain.hid
Cc: Xenomai-help <Xenomai-help@domain.hid>

On Thu, 2010-09-23 at 15:15 +0800, gwysu@domain.hid wrote:
> Yes, the t_restart have been available, but it doesn't work and will
> crash. Below is the code of t_restart

> 
>  
> 
> u_long t_restart(u_long tid, u_long targs[])
> {
>  u_long err = SUCCESS;
>  psostask_t *task;
>  spl_t s;
>  int n;
> 

<snip>

Well, thanks. But I think I have a copy of this one somewhere on my
laptop...

>  
> 
> The t_restart will call xnpod_restart_thread and furthermore call
> "xnarch_init_thread" in the /asm-powerpc/bit/pod.h for powerpc arch.
> And will crash when " memset(childregs, 0, sizeof(*childregs));" is
> excuted. which because the value of the tcb->stackbase  is NULL. We
> can explain the reasion by analysis of the "t_create" later.
> 
>  
> 
>  
> 
>  
> 
> static inline void xnarch_init_thread(xnarchtcb_t * tcb,
>           void (*entry) (void *),
>           void *cookie,
>           int imask,
>           struct xnthread *thread, char *name)
> {
>  struct pt_regs *childregs;
>  unsigned long flags;
> 

Oh, yep. I have this one too...

>  
> 
> Below is the code of t_create:
> 
>  
> 
>  
> 
>  
> 
> u_long t_create(const char *name,
>   u_long prio,
>   u_long sstack, u_long ustack, u_long flags, u_long *tid_r)
> {
>  union xnsched_policy_param param;
>  struct xnthread_init_attr attr;
>  xnflags_t bflags = 0;
>  psostask_t *task;
>  u_long err;
>  spl_t s;
>  int n;
> 

And I can find this one in the Xenomai tree as well. Good.

> 
> Let's analysize the code of "t_create":
> 

Sure, let's do this.

> Because CONFIG_XENO_OPT_PERVASIVE must be defined for pSoS mulator,
> the "t_create" will call "xnpod_init_thread" defined in
> the /nucleus/pod.c, and furthermore call "xnthread_init" defined
> in /nucleus/thread.c,
> 

Any pSOS task would call xnpod_init_thread actually. Any task running in
a Xenomai system in fact. That is how a Xenomai thread is created,
regardless of the skin being used, or user-space/pervasive support being
enabled or not.

> 
> Because "if (flags & (XNSHADOW|XNROOT))"  is true, the stacksize is 0
> and so  tcb->stackbase  is NULL. So "t_restart" will crash.
> 

Yes, it will, precisely because t_restart() is not currently supported
for user-space tasks. So you are observing a crash while using
t_restart() in kernel space, called from an invalid context. Hence my
comment below:

> The
> t_restart() call already available from kernel space does most of the
> first part, but the second one would require some work.
> 

Meaning: t_restart() currently illustrates how to reset a TCB, which is
most of what you need to implement the kernel-side of that feature.
Most, not all. Handling shadow threads is what is missing.

It seems you did not care that much about my observation regarding
whether you really want to emulate a call like t_restart(). Maybe you
should consider it.

PS: please, don't top post.

-- 
Philippe.



