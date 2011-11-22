Message-ID: <4ECB74C1.3030508@domain.hid>
Date: Tue, 22 Nov 2011 11:09:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A55C63E538AA1E458EE4D75BD99595630694E939@domain.hid>
In-Reply-To: <A55C63E538AA1E458EE4D75BD99595630694E939@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread creation with native api
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Enric Bel Prim <e.bel@domain.hid>
Cc: xenomai@xenomai.org

On 11/22/2011 09:51 AM, Enric Bel Prim wrote:
> Hi,
> I have some questions regarding pthread and NATIVE API...
> 
> I use xenomai 2.4.8 with native API and RTDM services in a linux 2.6.28
> lite5200 embedded platform.
> My application creates several realtime tasks (rt_task) using native
> api, inside a linux environment with other applications.  All worked
> fine, till I need to create, from any of this rt_task, some nonrealtime
> tasks to do a long and not priority jobs (parse huge xml files, compress
> / uncompress them...).
> To do that, I use pthread_create(), to create a non realtime task with
> the "default attributes".
> I expected that this pthread would share the remaining CPU time with the
> other linux applications.   
> But it seems that this new pthread created has higher priority than any
> of the other non-RT linux apps.  The feeling is that the CPU is shared
> only between the realtime tasks and this pthread: for instance, one of
> the other non-RT apps controls the watchdog, and it resets the system
> some seconds after the pthread is created.
> If I call pthread_getschedparam inside the pthread I get thread prio =
> 0, and SCHED_OTHER.

Up to here, it makes sense if you are passing flags to compile for the
posix skin.

> I tried using __real_pthread_create as well, and had the same result.

This does not make sense.

> 
> Is correct to use pthread_create to create a new non-RT task from a
> rt_task?
> Which are the attributes/priority of that pthread? Does it inherit some
> of the RT parent "privileges"?

When compiling for the posix skin, threads created with pthread_create
are the same kind of tasks as the ones created with rt_task_create. The
SCHED_OTHER/0 priority is simply the lowest priority for these tasks. If
you do not want that, you should not pass the flags to compile for the
posix skin.

However, even when using the posix skin compilation flags, this should
not happen when using __real_pthread_create. Could you try xenomai
2.4.10 and see if it has the same behaviour?

Could you post an example program?

-- 
					    Gilles.

