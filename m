Message-ID: <48F64BD6.6050803@domain.hid>
Date: Wed, 15 Oct 2008 22:00:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F6195C.7070801@domain.hid> <48F6492C.4090500@domain.hid>
In-Reply-To: <48F6492C.4090500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_info.status encoding
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> the documentation refers to the Native Task Status (T_*) when it comes
>> to documenting rt_task_info.status. That is not correct. That field
>> contains far more flags than T_* is describing and, even worse, comes
>> with two collisions: T_PRIMARY and T_JOINABLE are not reported by
>> rt_task_inquire, rather T_RELAX (!T_PRIMARY, arrrg...) and T_HELD.
>>
> 
> T_PRIMARY is NOT meant to be reported by rt_task_inquire(), and actually, its
> value was picked to collide, to reflect the fact that it was a one-way
> specifier. You can't use T_RELAX because what is needed is a bit to force a
> transition to primary mode using rt_task_set_mode(), which is the actual source
> of all uglinesses. Aside of this, the nucleus naturally wants a "relaxed state"
> bit, and would not get any help from a "primary mode" bit for threads.
> 
> We could have used a T_RELAX bit to clear in rt_task_set_mode() instead of
> T_PRIMARY to set, but unfortunately, such a negative logic would have been
> somewhat confusing to users, since what is provided is the secondary -> primary
> mode switch.
> 
> Sending back the current mode in rt_task_inquire() would lead to two additional
> issues:
> 1) if for some reason, we would like to switch the caller to secondary mode at
> some point to be able to provide a more complete status, the primary/secondary
> status returned would make no sense at all. The fact that we don't do it now
> does not preclude the need to do it in future releases.
> 2) rt_task_set_mode(..., T_PRIMARY) is already vastly misused in a number of
> applications, sometimes uselessly, most of the time in a way that event kills
> performances. Giving an interface to get back the current mode would close the
> loop, triggering a whole set of new terminally silly usage of that hack.
> Applications should NEVER use that feature, it was initially designed for
> internal code (i.e. RTDM if my memory serves me well). Actually, the more I
> think of it, the more I convinced that I'm going to slaughter this crap in 2.5,
> providing an internal syscall from the XENOMAI_SYS class instead for use only in
> proper contexts.
> 
> T_JOINABLE might be reported, though, that is a different story.
> 
>> I see two ways out of this:
>>
>>  a) Redirect the documentation to the nucleus thread state flags.
>>
> 
> Which means that the documentation of the skin depends on the implementation of
> the core. Bad idea.

We also have a difficulty: when pdf documentations are generated, the
nucleus and native skin documentation end up in different documents. So,
we can not redirect the native skin documentation to nucleus.

> 
>>  b) Redefine the numerical values of T_PRIMARY and T_JOINABLE (the spare
>>     bits are unused with the native skin), add missing but possibly
>>     interesting flags as T_-constants and ensure that T_PRIMARY and
>>     T_JOINABLE are correctly injected on rt_task_inquire from user
>>     space.
> 
> Maybe for T_JOINABLE. Gilles?

Ok for me.

As a side note, I happen to use pthread_set_mode_np to trigger manual
mode transitions: I do this before calling the "socket" service to
trigger rtnet socket creation in secondary mode, where it can call
safely the kernel allocation methods. So, I am not really in favor of
removing this service.

However, if this usage disappears, and if we fix the issue with mode
switches and mutexes, I am Ok with removing the voluntary mode switches,
as I agree that they can be misused.

-- 
					    Gilles.

