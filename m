Message-ID: <4C565F26.5090200@domain.hid>
Date: Mon, 02 Aug 2010 08:01:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C562838.8050000@domain.hid>
	<1280727778.6700.70.camel@domain.hid>
In-Reply-To: <1280727778.6700.70.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Shared memory between a Xenomai user task and a
 standard Linux process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Bob Feretich <bob.feretich@domain.hid>

Philippe Gerum wrote:
> On Sun, 2010-08-01 at 19:06 -0700, Bob Feretich wrote:
>> I understand that a RT_PIPE is the preferred way to move data between 
>> a rt user task and a standard Linux process, but I have a large amount 
>> of data to move per second and I would like to minimize the number of 
>> times that the data is copied.

Ok. I was writing my own answer, but Philippe was faster... So, I will
just add a few things.


>> My rt user task performs several tasks that need to be time 
>> deterministic. I also want to store a history of its activity in a 
>> standard Linux file. Adequate buffering is available so that the file 
>> writing and management does not need to be done in real time.
>>
>> Ideally, I would like to share a block of memory (~128KB) between the rt 
>> user task and a standard Linux process which performs the file activities.
>>
>> The documentation indicates that many API calls are available to "user 
>> tasks", but I assume that unless "Linux process" is explicitly mentioned 
>> (as in the case of "pipe") these references apply only to rt user tasks. 
>> Am I correct?
> 
> Actually, you have two kinds of Xenomai threads in userland which may
> access any Xenomai service, including blocking ones, and generally
> speaking, any service which requires the caller to be known from the
> Xenomai core:
> 
> - common rt threads. Those are assigned a runtime priority > 0 when you
> create them via rt_task_create/rt_task_shadow using the native API
> (1-99); they are mapped on the SCHED_FIFO policy when operating in
> secondary mode.
> 
> - non-rt threads, but still Xenomai threads. Those are assigned a zero
> priority value. They are mapped on the SCHED_NORMAL/OTHER policy when
> operating in secondary mode, but still have access to primary mode, just
> like any rt threads does. In primary mode, they do not compete for the
> CPU with Xenomai rt threads though, they are scheduled when no rt
> activity remains. However, because they may enter primary mode, they may
> do whatever a rt Xenomai thread does, like pending on a Xenomai
> synchronization object (RT_SEM, RT_QUEUE, ...), because they are known
> from the Xenomai core (in short: they have a thread control block and a
> scheduling slot there). The only difference is their lower (Xenomai)
> priority.

We also have the "rt_printf" service, from the rtdk header, which allows
an RT task to write to a FILE * from primary mode, without incuring a
switch to secondary mode. But this means a copy of the data.

> 
>> Is there a shared memory mechanism that works between a rt user task and 
>> a standard Linux process?
>>
> 
> RT_HEAP would do. Synchronization could be done between the rt and
> non-rt domains based on RT_SEM/RT_MUTEX, provided the Linux process is
> actually a non-rt Xenomai thread. This said, this would introduce a
> potential for priority inversion, since your non-rt thread could hold
> the critical section for an unbounded amount of time, while the rt
> thread attempts to enter it. Using RT_QUEUEs would avoid this.

Due to their limitations on ARM platform (they are uncached on pre-v6
ARMs), RT_HEAP should more be reserved to communications between
user-space tasks and kernel-space tasks on these platforms. For
communications between two user-space processes, using plain Linux
shared memories is recommended.

-- 
					    Gilles.

