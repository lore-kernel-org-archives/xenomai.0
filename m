From: "Pham, Phong" <phamp@ddc-web.com>
Date: Wed, 13 Jun 2018 20:26:28 +0000
Message-ID: <C2EC5BA46D13CD44B5915A8FEEB4C44E9BFA1EED@DDCEXCH.ddc-ny.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] thread executing udd_register_device() is not rescheduled
	again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>


Hi,

I currently have a bunch of rtdm devices.  One of the devices, from userspa=
ce, I use ioctl() to get to kernel space.  When in kernel space, I create a=
nther rtdm device (using udd_register_device() API).  The API returns succe=
ss without any issue.  However, upon exiting the kernel space, in handle_ro=
ot_syscall (), execute xnthread_relax(),xnthread_suspend(),

              /*
              * If the current thread is being relaxed, we must have been
              * called from xnthread_relax(), in which case we introduce an
              * opportunity for interrupt delivery right before switching
              * context, which shortens the uninterruptible code path.
              *
              * We have to shut irqs off before __xnsched_run() though: if
              * an interrupt could preempt us in ___xnsched_run() right
              * after the call to xnarch_escalate() but before we grab the
              * nklock, we would enter the critical section in
              * xnsched_run() while running in secondary mode, which would
              * defeat the purpose of xnarch_escalate().
              */
              if (likely(thread =3D=3D sched->curr)) {
                             xnsched_set_resched(sched);
                             if (unlikely(mask & XNRELAX)) {
                                           xnlock_clear_irqon(&nklock);
                                           splmax();
                                           __xnsched_run(sched);
                                           return;
                             }
                             /*
                             * If the thread is runnning on another CPU,
                             * xnsched_run will trigger the IPI as required=
.
                             */
                             __xnsched_run(sched);
                             goto out;
              }

and the current thread never runs again (ie. never exits xnthread_suspend()=
).

I noticed that  udd_register_device() eventually uses device_create() Linux=
 API to create the files.  If I do not call device_create() and execute eve=
rything else, then my current thread does not hang (ie. runs til completion=
).  Any insight into Xenomai implementation causes the Xenomai scheduler to=
 behave this way when Linux device_create() API is invoked?

Thanks,
Phong.

Notice: This e-mail and any files transmitted with it may contain Data Devi=
ce Corporation's and its subsidiaries privileged and proprietary informatio=
n. It is intended solely for the use of the individual or entity to whom it=
 is addressed. If you are not the named recipient of this transmission, any=
 disclosure, copying, distribution or reliance on the contents of this mess=
age is prohibited. If you received this e-mail in error, please destroy it =
and any attached files and notify me immediately.

Click Here<http://www.ddc-web.com/Profile/EmailPrivacy.aspx> to view our pr=
ivacy statement.
