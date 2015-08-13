References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hHS2QS1td6mUiWid-unDrMDZaQMo3vkYsDynNze5YsaSw@mail.gmail.com>
 <55C326C5.4070608@xenomai.org>
 <CAHoW4hHityc2RSznYrqr4BHnTNSwjgYH7265jyqrjawmbXZKQQ@mail.gmail.com>
 <55C37BF3.2070609@xenomai.org>
 <CAHoW4hGq02Me+TuKVdvLi4W3GseeBA7DgFFajue-_D-gUh1wtg@mail.gmail.com>
 <55C8BCDD.5000501@xenomai.org>
 <CAHoW4hFio_SG9knzKD5AG_3UOiNCf5KhrioZOAHOd0jVGVOrMA@mail.gmail.com>
 <55CC7C2F.5040805@xenomai.org>
 <CAHoW4hFqOT=o10R8w-qxoHti1=aE5HLOohQvk7xk-PGD+_=XKQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55CCC40C.3060105@xenomai.org>
Date: Thu, 13 Aug 2015 18:21:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAHoW4hFqOT=o10R8w-qxoHti1=aE5HLOohQvk7xk-PGD+_=XKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On 08/13/2015 01:39 PM, Charles Kiorpes wrote:
> Hello Philippe,
> I have spent the past few days stressing my application and trying to
> get the problem to reproduce, so that I could better debug it and
> provide more information.  However, my current configuration seems to
> be fixed.
> 
> I made three changes (still using rc6):
> 1 - Fixed the small bug mentioned in your first patch in this thread
> 2 - Reordered event creation logic so that rt_event_bind() is used to
> check existence before rt_event_create() is called
> 3 - Increased the heap sizes in the kernel configuration again
> (system=1024, shared=256, private=256)
> 

I'd be interested to know whether the bug re-appears when this latter
increase is not done, only keeping #1 and #2.

> These changes have me up and running on an x86 system.
> 
>> You should retry with the current head of the -next branch with Cobalt.
> I'll switch to the -next branch and continue testing.  I'm also doing
> an ARM port of the app, and was having some small problems with shared
> heap initialization, so maybe I can resume work there.

It's great that you made some progress. Meanwhile, I reviewed the shared
heap management lately and some stuff there wasn't quite right. This is
the list of recent commits in the -next tree that may/might concern your
application, with some notes:

{rpm@raven} git log --reverse --oneline -13
23bb315 lib/cobalt: fix private event state accessor

This commit contains the patch mentioned in #1.

fab0540 kernel/cobalt: Add reason to gorelax trace point
6dfdc69 cobalt/arm: Detect software breakpoints

Unrelated stuff.

033976a lib/cobalt/heapobj: pshared: allow group access to heap

You need this one to bind several processes with different euids to a
single session, provided they all belong to a common gid.

fa3092a copperplate/semobj: add uninit cleanup helper
824d831 copperplate/eventobj: add uninit cleanup helper
9e3cbdb alchemy/event: prevent double-free on error path
ac6fb1c alchemy/sem: prevent double-free on error path

The four commits above fix the double deletion bug occurring upon an
attempt to create a sema4 or an event with a conflicting name, using the
Alchemy API. This may certainly have caused havoc in the heap when
happening. This should allow you to drop the work around based on
rt_event_bind() mentioned in #2.

f333317 vxworks/memPartLib: fix invalid status from addToPool
f928e4d vxworks/memPartLib: do not account for failed alloc

Some fixups for the Vxworks API users who depend on memory partitions.

65f16f4 copperplate/heapobj-pshared: fix and sanitize extent management

This one is addresses several issues in the shared heap management,
particularly when extending embedded heaps (like the VxWorks API does).
Alchemy did not use the extension service, but I would recommend to pull
those sanitizing changes nevertheless.

0da6b0d boilerplate/ancillaries: add routine to parse mem size
b151d3b copperplate/init: disambiguate --mem-pool-size argument

Not directly related. This said, this commit clarifies the argument to
--mem-pool-size. You probably want to pass --mem-pool-size=400k with
this patch in.

> 
> Thanks for all your help!
> 
> -Charles
> 


-- 
Philippe.

