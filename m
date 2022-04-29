References: <6a50f4cf-4f2a-542a-c332-4d98975e36a6@bela.io>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Thread's CPU time
Date: Fri, 29 Apr 2022 17:29:28 +0200
In-reply-to: <6a50f4cf-4f2a-542a-c332-4d98975e36a6@bela.io>
Message-ID: <87fslvzyxa.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@xenomai.org


Giulio Moro via Xenomai <xenomai@xenomai.org> writes:

> Hi everyone,
> From /proc/xenomai/sched/stat I infer there must be an internal struct
> somewhere keeping track of how much CPU time is actually used by each
> thread. Is there any way to access this kind of statistics from a
> running Xenomai user space program without leaving primary mode and
> without attempting to read this file? I am implementing an
> infrastructure to measure the CPU time of a given block of
> code. Currently I am using Cobalt's clock_gettime(), but this only
> works reliably if the task does not get preempted or otherwise
> rescheduled between the two calls.
>
> I have run this kind of tests offline before and that's all nice and good, but I am looking for a lightweight and non invasive way of benchmarking particular sections of large-ish programs with minimal modifications.
>
> Thanks,
> Giulio

For xenomai3, you may want to have a look at cobalt_thread_stat() from
the internal API (sys/cobalt.h). The field of interest returned in
struct cobalt_threadstat would be 'xtime' (nsecs).

-- 
Philippe.

