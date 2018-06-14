References: <5AD4F8A8.70604@freyder.net>
 <c89016d3-862d-1424-5bab-b7f658a425b5@xenomai.org>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5B22B1A2.9060300@freyder.net>
Date: Thu, 14 Jun 2018 13:19:14 -0500
MIME-Version: 1.0
In-Reply-To: <c89016d3-862d-1424-5bab-b7f658a425b5@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Queue status files/FUSE issue -- part two
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 6/14/2018 11:45 AM, Philippe Gerum wrote:
> On 04/16/2018 09:25 PM, Steve Freyder wrote:
>> Greetings again,
>>
>> There seems to be an issue with the RT queue status file formatting and
>> perhaps
>> the way in which the [WAITERS] list is managed, and/or maybe the way the
>> output
>> string termination is done.
>>
>> I can't be sure and thought I should simply submit the test
>> program/scripts and
>> document the results.  I am attaching them as a compressed tar file, I hope
>> that is acceptable form for the forum.
>>
>> I noticed that the 32768 length in this area of the code:
>>
>> ./xenomai-3/lib/copperplate/registry.c-317-             case O_RDWR:
>> ./xenomai-3/lib/copperplate/registry.c-318- sbuf->st_mode |= 0666;
>> ./xenomai-3/lib/copperplate/registry.c-319- break;
>> ./xenomai-3/lib/copperplate/registry.c-320-             }
>> ./xenomai-3/lib/copperplate/registry.c-321- sbuf->st_nlink = 1;
>> ./xenomai-3/lib/copperplate/registry.c:322: sbuf->st_size = 32768; /*
>> XXX: this should be dynamic. */
>> ./xenomai-3/lib/copperplate/registry.c-323- sbuf->st_atim = fsobj->mtime;
>> ./xenomai-3/lib/copperplate/registry.c-324- sbuf->st_ctim = fsobj->ctime;
>> ./xenomai-3/lib/copperplate/registry.c-325- sbuf->st_mtim = fsobj->mtime;
>>
>> sometimes is altered, before the FUSE read request is satisfied, and
>> sometimes not.  I didn't try to trace it too far.
>>
>> The script "qtest.sh" runs a program called "qx" (Queue eXerciser) to
>> create a
>> queue, and post a read on the queue.  Two copies are launched in the
>> background
>> then the first is killed.  The queue status file is displayed in the
>> process.
>>
>> Note what happens to the queue status output as you run "sh qtest.sh"
>> repeatedly.  On my system, I see something like what is shown below.
>>
>> The included "killtask.sh" can be used to get rid of all of the
>> lingering tasks
>> after the testing is over.
>>
>> I use a lingering sysregd launched in sr.sh before starting
>> the testing, looks like this:
> [snip]
>
> Assuming this has been observed with applications running in a common
> session, a process that dies unexpectedly in that session won't get its
> threads properly removed from a shared wait list (e.g. the queue's one),
> as the per-thread destructor won't have a chance to run.
>
> Therefore killing the first process may be the cause of the behavior you
> observed, because there is no general provision for being resilient to
> such an event in a shared session, where it is assumed that either every
> process which belongs to the session is present and functional, or the
> whole session is deemed broken anyway.
>
> Arguably, this may be an over-simplification, but that is the current
> basic assumption of the whole pshared support.
>
I'm very disapppointed to hear that, it's the first I've ever heard that
documented.

The unfortunate problem with that is that it goes against the paradigms
that were present in the 2.6.x version of Xenomai, where resources owned
by threads inside a dying process were always cleaned up properly, or at
least that is what we always observed, and counted on.

It seems then that I have only two options, 1) abandon the use of pshared
and registry completely, or 2) create some kind of application layer
signal catcher that performs all of the thread cleanup.  #1 is potentially
alot of work, and #2 won't completely guarantee that the session can't be
compromised if something dies in a way the signal catcher can't clean up
after.  So I'm pretty much forced to go with #1.  I believe that means
that I have to change from using RT_QUEUE's for IPC to something like
IDDP sockets, or another facility that doesn't rely on pshared/registry
to make the required resources available cross-process.

Can RT_TASK, RT_QUEUE, RT_MUTEX, RT_SEM, etc objects be shared
cross-process using shared memory where task A calls rt_queue_create()
targetting an RT_QUEUE object in shared memory and task B uses that
object to perform an rt_queue_write() operation to that same queue?
If that worked I wouldn't need pshared/registry to share the objects
and the pshared cleanup issue would disappear.

If the answer to the above is "no", then there needs to be support for
the same kind of resource sharing that can be done using Unix Domain
Sockets on a standard Linux system that allows one process to send a
file descriptor that then becomes valid in the process receiving the
message.

Of course this all assumes that the storage tracking for an RT_QUEUE's
heap is immune to corruption when a process with that RT_QUEUE open dies,
regardless of where/how it dies.


