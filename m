MIME-Version: 1.0
In-Reply-To: <4D9494B6.6040304@domain.hid>
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>
	<1301412534.2109.24.camel@domain.hid> <4D922EF5.8020808@domain.hid>
	<1301426227.2109.35.camel@domain.hid> <4D9230C5.7050007@domain.hid>
	<1301426830.2109.41.camel@domain.hid> <4D923306.60409@domain.hid>
	<1301461081.2092.14.camel@domain.hid>
	<AANLkTim=xKo51rErYUN9+h2MONaAg9BJ5E_dJuRCwYg_@domain.hid>
	<1301472945.2092.21.camel@domain.hid>
	<AANLkTikNq2r+wjC0z+mkczjq8F67ztmXRDBMnHQ4-a9E@mail.gmail.com>
	<AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>
	<4D948F87.9010109@domain.hid> <4D9494B6.6040304@domain.hid>
Date: Fri, 1 Apr 2011 11:36:01 +0200
Message-ID: <AANLkTimsAJMuamJsuEZ8p=OOHEt+oSyUzDr7OAsugewh@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Priority coupling broken?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Mar 31, 2011 at 4:50 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Henri Roosen wrote:
>>> Did some more tracing to see why the lower priority thread is
>>> scheduled before the higher prio thread is ended.
>>>
>>> The highest priority task makes a system call and gets relaxed by
>>> xnshadow_relax. The rpi is pushed here and a Linux call with
>>> LO_WAKEUP_REQ is scheduled. Then I see the scheduler scheduling to the
>>> ROOT task. So far so good!
>>>
>>> In the Linux domain, we run into the lostage_handler, where the
>>> scheduled LO_WAKEUP_REQ is executed. Here there is a call to
>>> xnpod_schedule() which actually causes a switch back to the primary
>>> domain and the lower priority Xenomai task to be scheduled in, even
>>> before the wanted process is woken up.
>>>
>>> Now, I am unsure what is faulty here and maybe Philippe or someone can
>>> answer that. Personally I would have expected the xnpod_schedule (or
>>> xnsched_pick_next) to know about the rpi list and not schedule a lower
>>> priority task than of any on that list. I was unable to find such
>>> code.
>>>
>>
>> Unless I am wrong, what happens is whait is intended, at least if we
>> read the comment:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case LO_WAKEUP_REQ:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We need to downgrade th=
e root thread
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* priority whenever the A=
PC runs over a
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* non-shadow, so that the=
 temporary boost we
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* applied in xnshadow_rel=
ax() is not
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* spuriously inherited by=
 the latter until
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the relaxed shadow actu=
ally resumes in
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* secondary mode.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rpi_clear_local(xnshadow_thr=
ead(current));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnpod_schedule();
>>
>> Which means that we do not want other Linux kernel code than the
>> real-time thread itself to inherit from this thread priority. Except
>> that all the code from the switch to root thread to the lostage_handler
>> (which means any Linux currently preempted critical section) already
>> inherited the priority.
>
> The problem is that calling wake_up_process (a bit below that code) does
> not guarantee that the next thread scheduled is the shadow running in
> secondary mode. There may be other Linux threads with higher priorities,
> and we do not want them to inherit this priority. The idea is that if
> the next process scheduled is indeed the real-time shadow running in
> secondary mode, the RPI will be applied in do_schedule_event. But of
> course, this leaves a window for another real-time thread to preempt. At
> least it is the way I would understand this, but I am not sure I
> understand RPI all that well, so, I will shut up and let Philippe answer.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

Thanks Gilles for your input. This Priority Coupling stuff is a little
complex and input about the corner cases is always welcome and
helpful!

I did a little more tests with xnpod_schedule() commented out on
LO_WAKEUP_REQ. Scheduling shows as expected to me: the lower and level
primary tasks don't interrupt the migrated thread while higher
priority tasks do interrupt that task. I have not seen any deadlocks
yet or ran into corner cases, but of course I don't know all.

Now, looking back in the history of shadow.c I see that
xnpod_schedule() was introduced when the xnsched_renice_root() was
introduced, which is now part of rpi_clear_local. In my point of view,
the xnpod_schedule() call is only needed when the
xnsched_renice_root() has been done, so should be moved inside the if
of rpi_clear_local. But again, it is my point of view and don't know
all the corner cases.

In our case the scheduled task after the switch to secondary is
actually mostly the IDLE task, thus calling the xnsched_renice_root
and xnpod_schedule() for doing exactly that what is in the comment. So
my main question remains: is the call to xnpod_schedule really needed
here after xnsched_renice_root()? And if so, why doesn't the
xnpod_schedule not take the priorities on the rpi list into account?

Thanks,
Henri.

