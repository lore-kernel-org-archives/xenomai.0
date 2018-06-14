References: <C2EC5BA46D13CD44B5915A8FEEB4C44E9BFA1EED@DDCEXCH.ddc-ny.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d5eec08d-2820-7406-ba3d-42df26ebf3fe@xenomai.org>
Date: Thu, 14 Jun 2018 08:10:17 +0200
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44E9BFA1EED@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] thread executing udd_register_device() is not
 rescheduled again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>

On 06/13/2018 10:26 PM, Pham, Phong wrote:
> 
> Hi,
> 
> I currently have a bunch of rtdm devices.  One of the devices, from userspace, I use ioctl() to get to kernel space.  When in kernel space, I create anther rtdm device (using udd_register_device() API).  The API returns success without any issue.  However, upon exiting the kernel space, in handle_root_syscall (), execute xnthread_relax(),xnthread_suspend(),
> 
>               /*
>               * If the current thread is being relaxed, we must have been
>               * called from xnthread_relax(), in which case we introduce an
>               * opportunity for interrupt delivery right before switching
>               * context, which shortens the uninterruptible code path.
>               *
>               * We have to shut irqs off before __xnsched_run() though: if
>               * an interrupt could preempt us in ___xnsched_run() right
>               * after the call to xnarch_escalate() but before we grab the
>               * nklock, we would enter the critical section in
>               * xnsched_run() while running in secondary mode, which would
>               * defeat the purpose of xnarch_escalate().
>               */
>               if (likely(thread == sched->curr)) {
>                              xnsched_set_resched(sched);
>                              if (unlikely(mask & XNRELAX)) {
>                                            xnlock_clear_irqon(&nklock);
>                                            splmax();
>                                            __xnsched_run(sched);
>                                            return;
>                              }
>                              /*
>                              * If the thread is runnning on another CPU,
>                              * xnsched_run will trigger the IPI as required.
>                              */
>                              __xnsched_run(sched);
>                              goto out;
>               }
> 
> and the current thread never runs again (ie. never exits xnthread_suspend()).
> 
> I noticed that  udd_register_device() eventually uses device_create() Linux API to create the files.  If I do not call device_create() and execute everything else, then my current thread does not hang (ie. runs til completion).  Any insight into Xenomai implementation causes the Xenomai scheduler to behave this way when Linux device_create() API is invoked?
> 

You are basically looking at your thread running in secondary mode -
therefore suspended Xenomai-wise - caused by the non-rt ioctl() call it
just issued. It still runs, but under the control of the Linux
scheduler. I'm unsure to understand which problem you would like to report.

-- 
Philippe.

