Message-ID: <48F79AF9.6030303@domain.hid>
Date: Thu, 16 Oct 2008 21:50:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48F6195C.7070801@domain.hid> <48F6492C.4090500@domain.hid>
	<48F660E7.8090906@domain.hid>
In-Reply-To: <48F660E7.8090906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_info.status encoding
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Hi,
>>>
>>> the documentation refers to the Native Task Status (T_*) when it comes
>>> to documenting rt_task_info.status. That is not correct. That field
>>> contains far more flags than T_* is describing and, even worse, comes
>>> with two collisions: T_PRIMARY and T_JOINABLE are not reported by
>>> rt_task_inquire, rather T_RELAX (!T_PRIMARY, arrrg...) and T_HELD.
>>>
>> T_PRIMARY is NOT meant to be reported by rt_task_inquire(), and actually, its
>> value was picked to collide, to reflect the fact that it was a one-way
> 
> So you preferred to break rt_task_inquire instead of letting it return a
> consistent value? Not really?

As explained earlier, the thing you have to understand is that rt_task_inquire()
is not broken, it just does not work your way, which is a different issue.

> 
>> specifier. You can't use T_RELAX because what is needed is a bit to force a
>> transition to primary mode using rt_task_set_mode(), which is the actual source
>> of all uglinesses. Aside of this, the nucleus naturally wants a "relaxed state"
>> bit, and would not get any help from a "primary mode" bit for threads.
> 
> I'm not arguing for removing T_PRIMARY, I was just struggling with the
> confusing values rt_task_inquire reported to me.
> 

This is because you want T_PRIMARY to be part of the rt_task_inquire() return
values. It must not, really. When apps start playing with the current mode,
things start falling apart. I don't want to make T_PRIMARY a first-class citizen
of the interface; considering it as a legitimate value of an inquiry service
would do that. So that is a NAK.

>> We could have used a T_RELAX bit to clear in rt_task_set_mode() instead of
>> T_PRIMARY to set, but unfortunately, such a negative logic would have been
>> somewhat confusing to users, since what is provided is the secondary -> primary
>> mode switch.
>>
>> Sending back the current mode in rt_task_inquire() would lead to two additional
>> issues:
>> 1) if for some reason, we would like to switch the caller to secondary mode at
>> some point to be able to provide a more complete status, the primary/secondary
>> status returned would make no sense at all. The fact that we don't do it now
>> does not preclude the need to do it in future releases.
> 
> Sorry, but this is very far fetched.
> 

Sorry, you are wrong. rt_task_inquire() is currently marked as __xn_exec_any,
which means that it is processed in the current thread mode, but always from the
Xenomai stage in the pipeline. If at some point, we extend rt_task_inquire() to
return information from the Linux realm (e.g. protected by a RCU construct), we
would have to move that call to __xn_exec_lostage. Conversely, if at some point
the rt_task_inquire() service is changed so that getting information from the
nucleus involves blocking, then we would have to make that call __xn_exec_primary.

Far fetched, even impossible that we would need that? Not that much actually. A
number of people have native Xenomai kernel modules interacting with native
Xenomai apps in userland; those modules maintain a significant portion of the
application logic, and some did reimplement some kind of rt_task_inquire() for
debugging and logging purposes. Instead of that, we could allow the in-kernel
part to be asked for additional information via a callback from the
rt_task_inquire() implementation, using the RT_TASK_INFO struct as a common
return header, that could be completed with more data.
In that case, rt_task_inquire() would have to be flexible when it comes to the
thread mode, currently it is not, because you may only fetch information that is
immediately available from the Xenomai stage, without blocking.

Therefore, in both cases, T_PRIMARY would become meaningless as a return value.

>> 2) rt_task_set_mode(..., T_PRIMARY) is already vastly misused in a number of
>> applications, sometimes uselessly, most of the time in a way that event kills
>> performances. Giving an interface to get back the current mode would close the
>> loop, triggering a whole set of new terminally silly usage of that hack.
>> Applications should NEVER use that feature, it was initially designed for
>> internal code (i.e. RTDM if my memory serves me well). Actually, the more I
>> think of it, the more I convinced that I'm going to slaughter this crap in 2.5,
>> providing an internal syscall from the XENOMAI_SYS class instead for use only in
>> proper contexts.
> 
> This is a different issue.
> 
> See, I needed rt_task_inquire for precisely the purpose it is (mostly)
> designed for: tracing / debugging. And for that purpose, a valid
> T_PRIMARY bit is of very high importance. I even implemented the same
> inquire service for POSIX in the meantime so that I was able to
> implement all functional tests I needed for the fast mutexes.
>

See, the point is that T_PRIMARY is often misused because it belongs to the
mainline interface whilst it should only be used in very limited situations. I
did acknowledge a long time ago that skin developers may need it badly though,
this is why I provided this service to you in the first place. The point is: the
interface to that service should make perfectly clear that it is internal stuff
that should not be part of the toolbox for writing applications.
I.e. direct XENOMAI_SYS() call.

> If you really argue for removing a T_PRIMARY-equivalent from
> RT_TASK_INFO, you may also argue for removing the SIGXCPU helper - the
> user should better not know in which context some of his threads
> currently runs.
> 

You are missing the point: SIGXCPU is about helping users to find a bug when
they messed up mode management involuntarily. Moving T_PRIMARY out of the
mainline interface is about preventing users to mess up mode management voluntarily.

Said differently, is there any situation where an application has no other
choice than requiring a transition from secondary to primary explicitly? As far
as I understand Xenomai properly, the answer is no, because the underlying skin
interface should deal with that issue when needed (i.e. direct XENOMAI_SYS call
again). In last resort, if the application guy badly needs it, it must be for
debugging/logging purposes the same way you did need that as well for RTDM,
therefore he may still use the XENOMAI_SYS interface directly. If he does so,
then he must know what he does, since the call he uses is part of the low-level
Xenomai layer. If that breaks or makes something terribly inefficient, then no
complaints.

>> T_JOINABLE might be reported, though, that is a different story.
>>
>>> I see two ways out of this:
>>>
>>>  a) Redirect the documentation to the nucleus thread state flags.
>>>
>> Which means that the documentation of the skin depends on the implementation of
>> the core. Bad idea.
> 
> OK, for the sake of API cleanness, I'm fine with wrapped state flags.
> Will prepare the required patch to add missing (but also sufficiently
> abstract) states and mask the rest from rt_task_inquire.
> 
> Jan
> 


-- 
Philippe.




