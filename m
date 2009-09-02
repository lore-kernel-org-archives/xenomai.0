From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0909021441160.22914@domain.hid>
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
	<Pine.LNX.4.64.0909021359060.22914@domain.hid>
	<4A9E5424.9070500@domain.hid>
	<Pine.LNX.4.64.0909021418300.22914@domain.hid>
	<4A9E5917.8060200@domain.hid>
	<Pine.LNX.4.64.0909021441160.22914@domain.hid>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 14:41:18 +0200
Message-Id: <1251895278.3205.190.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deprecated kernel system calls in xenomai-head
 and new application development paradigm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, 2009-09-02 at 15:00 +0300, Rus V. Brushkoff wrote:
> On Wed, 2 Sep 2009, Gilles Chanteperdrix wrote:
> 
> :> :> :For instance, you would implement the "write" method of the driver to
> :> :> :pass data between the user-space task and the driver.
> :> :>  This is RT driver not simply Linux driver. The previous rt_pipe_read() 
> :> :> call was running in RT task context. Now it is not clear how this can be 
> :> :> achieved with new RTDM driver model in kernel space.
> :> :The write method of an RTDM driver can run in rt context too. If the
> :> :task which issues the call to "write" is a Xenomai user-space task
> :> :running in primary mode.
> :>  Please note - I do not have any Xenomai user-space tasks running - only 
> :> normal user space programs. The Xenomai-2.4 allows developing of RT driver 
> :> in kernel space - leaving untouchable user space processes. If such new 
> :> paradigm need to write the intermediate user-space RT task proxy - than 
> :> it is wrong. Simply because its adds unneeded complexity to developing RT 
> :> kernel hardware drivers.
> :
> :You do not need a proxy. What you need to do is to create the previous
> :non real-time task as a Xenomai task, using rt_task_create, or the
> :Xenomai posix skin's pthread_create. Then you would change this task to
> :use RTDM's write instead of write. That is all. Everything else stays
> :the same. And as an additonal benefit, you have one less task running if
> 
>  No, this means I need to change the previous non-rt user-space software 
> to RT one. Problem is that exists some projects that can't be simply 
> changed in this way, for example we use asterisk as non-rt user space 
> process - it changing means creating and supporting previously unneeded 
> patches.
> 

This has been answered in a previous mail.

> :Separating clearly the driver code running in kernel-space from the
> :application code running in user-space is clear win. It leads to a code
> :easier to maintain, and avoid taking risks of running too many code in
> :the unprotected kernel-space.
> 
>  I do not see the win in decreasing number of the API functions. So I see 
> the problem with porting Xenomai-2.4 apps, written by provided pipe.c 
> example from the docs, to Xenomai-2.5 and later.

No, 2.5 still has the in-kernel APIs. Only Xenomai v3 will change this.

>  Next - I do not 
> understand why the previous model lets the _developer_ itself decide 
> which of the application tasks will be running in kernel and which will 
> be running in user space. The current model left the people without any 
> choice. So the current model itself decided instead of developer what is 
> better - I think this is wrong.

With that kind of reasoning, you would keep on coding your RT
application fully in kernel space, but we made some progress since 1997,
fortunately.

The point of Xenomai has always been about keeping the RT programming
model as close as possible to the one we would use to code common
applications not depending on any dual kernel support. Now we want to
break the last wall, which means enforcing a cleaner and safer
application / device driver split model. This will allow people to pick
the best option between dual kernel and PREEMPT_RT configurations,
depending on their requirements.

To sum up, the point is not about losing any freedom to develop kernel
code at all, it is about being discouraged from perpetuating legacy
_application_ designs (not driver) that were only there to mitigate
restrictions  on legacy dual kernel systems which did not provide any
userland interface to applications.

Said differently, implementing a complete application (RT or not) in
kernel space has always been sub-optimal with respect to the common
programming model. It just happened to be the only possible way to work
in the stone age of real-time Linux, when one had to trade separate
address spaces and tool availability off against better latencies. This
is no more required, and since we do have a sane and normalized
real-time driver model with RTDM, and the incentive to enforce a correct
application / driver split, the time has come to evolve.

Even if Xenomai-wise, that evolution will only start with Xenomai v3,
application designers may want to integrate this fact as early as
possible, or disable CONFIG_XENO_OPT_NOWARN_DEPRECATED and stick with
v2.5.

> 
> 
> 		Rus
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



