References: <E1ahDS5-0004G9-QW@sd-51317.xenomai.org>
 <56ED227B.2040309@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56EEC8BC.1060606@xenomai.org>
Date: Sun, 20 Mar 2016 16:58:52 +0100
MIME-Version: 1.0
In-Reply-To: <56ED227B.2040309@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Philippe Gerum : cobalt/thread: add schedparam lazy
	propagation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 03/19/2016 10:57 AM, Jan Kiszka wrote:
> On 2016-03-19 10:45, git repository hosting wrote:
>> Module: xenomai-3
>> Branch: next
>> Commit: 4eee0136b4bcb744b9dfdc195f18dd839b3e2198
>> URL:    http://git.xenomai.org/?p=3Dxenomai-3.git;a=3Dcommit;h=3D4eee013=
6b4bcb744b9dfdc195f18dd839b3e2198
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Fri Mar 18 12:12:50 2016 +0100
>>
>> cobalt/thread: add schedparam lazy propagation
>>
>> Provide a mechanism for carrying out a lazy propagation of schedparam
>> updates to the regular kernel, so that userland does not have to
>> switch to secondary mode for this.
>>
>> When userland issues sc_cobalt_thread_setschedparam_ex for updating
>> the scheduling parameters of a Xenomai thread, a request for
>> propagating this change to the regular kernel is made pending. Such
>> request will be committed later, either when:
>>
>> - the thread relaxes if it is running in primary mode when the update
>>   request is received;
>>
>> - next time the thread calls back into the Cobalt core as a result of
>>   receiving a HOME action from a SIGSHADOW notification, which is sent
>>   if such thread was relaxed at the time of the update request.
>>
>> As a result, the target thread will have propagated the schedparams
>> update to the regular kernel as soon as it resumes (relaxed) execution
>> in user-space.
> =

> More light-weight than my approach with the kernel helper task - but
> doesn't this create a prio inversion window on the Linux side?
> =

> Consider a relaxed thread that received a prio raising while in primary
> mode. It will now start off with its old, lower Linux prio in secondary
> mode, potentially being starved by a higher prio Linux task because it
> cannot update its own priority.
> =


I considered it just like I considered the prio inversion with the
kthread option too, but let's face it, we trade a mode switch in
pthread_setschedparam*() to favor the RT side for a general
inconsistency with the nptl-to-kernel interface on the non-RT side, due
to the priority cache.

Enabling lazy schedparam updates means:

- inability to mix the glibc and Cobalt calls for managing a thread's
scheduling parameters, and POSIX standard assumptions made invalid (see
the illustration attached).
- inability to use standard prioceiling mutexes from the glibc from
threads receiving Cobalt's pthread_setschedparam*() call.

With that in mind, I see no strong point in guaranteeing anything with
respect to priority inversion for relaxing threads when the lazy
schedparam propagation scheme is enabled, given the significant
restrictions introduced for the non-RT side. For the most part, those
threads receiving Cobalt's pthread_setschedparam*() calls should be RT
threads, which normally don't expect much from the regular kernel with
respect to RT behavior. Those can cope with a priority inversion that
might exist when they relax, which is supposed to be a rare event
anyway, and not time-critical by definition.

The only non-covered case that remains would be setting the scheduling
parameters of SCHED_WEAK threads with non-zero priorities from
SCHED_FIFO threads via Cobalt, expecting strict real-time behavior from
the former. I've been wrapping my head around this, and this very idea
still makes no sense to me.

The patch merged in -next does have the restriction you mentioned, but
is much simpler and raceless compared to the kthread approach, and
cheaper CPU wise too (kthread potentially means a double context switch
at each pthread_setschedparam*() call, compared to no overhead for the
other approach if the thread is not relaxed, which should be the common
case for RT threads).

In short, it's definitely not perfect, but it should fit the bill for
the corner case when relaxing in pthread_setschedparam() is a problem.
If you have any use case in mind for which this restriction would be a
showstopper, please let me know.

-- =

Philippe.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lazy.c
Type: text/x-csrc
Size: 3211 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160320/54ec83a1/at=
tachment.c>
