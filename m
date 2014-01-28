Message-ID: <52E77A43.3010706@xenomai.org>
Date: Tue, 28 Jan 2014 10:37:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1390856074.81966.YahooMailNeo@web171601.mail.ir2.yahoo.com>
In-Reply-To: <1390856074.81966.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segmentation fault in taskSpawn (xenomai-forge)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/27/2014 09:54 PM, Matthias Schneider wrote:
>
>
> Hi all,
>
> in case taskSpawn() fails due to lack of permissions in the current
> xenomai-forge checkout (tried with mercury), the following function
>
> ret = __bt(copperplate_create_thread(&cta, &task->thobj.tid));
>
> returns ret != 0 and I get the following segmentation fault:
>
> http://pastebin.ca/2591742

Confirmed using valgrind. It looks like portions of the task control 
block are dismantled although they were not initialized yet:

task-1...==11184== Memcheck, a memory error detector
==11184== Copyright (C) 2002-2012, and GNU GPL'd, by Julian Seward et al.
==11184== Using Valgrind-3.8.1 and LibVEX; rerun with -h for copyright info
==11184== Command: ./task-1 --cpu-affinity=0 --silent
==11184==
==11184== Invalid write of size 8
==11184==    at 0x4E28D1A: notifier_destroy (private-list.h:58)
==11184==    by 0x4E25A3F: destroy_thread (threadobj.c:483)
==11184==    by 0x4C1628B: __taskInit (taskLib.c:382)
==11184==    by 0x4C1661A: taskSpawn (taskLib.c:501)
==11184==    by 0x400C76: main (task-1.c:38)
==11184==  Address 0x7f1564f5dc90 is not stack'd, malloc'd or (recently) 
free'd
>
> holder->prev and holder->next seem to be nullptrs. I am not 100% sure how to fix
> this issue... I have a clone from the latest  xenomai-forge.git/next.


http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=d4db547e281e3d1efba32311ad3d5efd8d4dc16e

>
>
> Also, I would like to ask about the xenomai-forge style of resources handles
> (e.g. tasks, queues, semaphores, etc.), which are actually pointers converted
> with the mainheap_ref and mainheap_deref  macros.
>
> In the xenomai 2.6 implementation, handles were resolved via a registry,
> allowing the detection of handles on deleted objects. However, with the
> pointer-based approach in xenomai-forge, the result of a handle to a deleted
> object may either be gracefully detected (in case the memory is still readable
> and the magic does not match) or we will get a segmentation fault if the address
> has been freed. Obviously, since this happens in user mode, it will not have
> impact on kernel stability, and it indicates an improper use of a handle, but is
> still a different behaviour than xenomai 2.6.x. Is this desired or are there
> plans to solve this differently in the future (e.g. by using some sort of
> registry, etc.)?

It is (mostly) desired, at least this is a deliberate trade-off between 
bug detection and performance in the fast path. It would be possible to 
revalidate those pointers via some hash indexing when resolving handles 
when in debug mode though, but this is not high on the todo list at the 
moment.

The good news is that over mercury, valgrind may help a lot in detecting 
such kind of issues.

-- 
Philippe.

