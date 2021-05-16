References: <CAK6DXL3JYzvoz9tnMQJ+FBqUarS7DNh_06oLzfBoSF5gQBYNXw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Feedback on sched_quota modification
In-reply-to: <CAK6DXL3JYzvoz9tnMQJ+FBqUarS7DNh_06oLzfBoSF5gQBYNXw@mail.gmail.com>
Date: Sun, 16 May 2021 16:01:13 +0200
Message-ID: <87fsymok0m.fsf@xenomai.org>
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
To: Marco Barletta <barlettamarco8@gmail.com>
Cc: xenomai@xenomai.org


Hi,

Marco Barletta via Xenomai <xenomai@xenomai.org> writes:

> Hi everyone;
> you can find attached the modification I made to sched_quota in order to
> have a hierarchical scheduler. Actually original sched_quota wasn't truly
> hierarchical since when a group expires and has a lot of thread ready to
> run, it considers one by one threads and on the go flushes them to the
> expired list. In this there's a problem since this operation could not be
> bounded in time since it's O(n) and could be nasty for theoretical analysis
> in hard-real-time systems.
> If you are interested in such modification in order to add it as a sched
> modification or to add it as a new scheduler, I'd be delighted to have a
> feedback from you.
> I had some problems to handle kick function because of the double runnable
> queue. Moreover I want to specify that I choose to implement the runnable
> list of groups with a linked list and not xnsched_queue_t since we expect
> just a few goups and anyway their number is bounded by compile time macro,
> so is still O(1).
> Best regards.

Introducing a dedicated SCHED_QUOTA runqueue instead of piggybacking on
the SCHED_FIFO class simplifies some portions of the code elegantly and
indeed solves the O(N) issue upon re-arming threads from groups which
have their runtime budget replenished.

However this also introduces a significant change to SCHED_QUOTA: a new
group priority property needs to be defined, for ordering groups in the
per-CPU runqueue for the quota policy if I got that correctly. Threads
are then picked by group priority, then thread priority within that
group, instead of competing solely on thread priority globally. I guess
this denotes the hierarchical view you mentioned. In other words, this
is no more SCHED_QUOTA as we currently define its behavior.

A couple of nitpicks now:

- it seems that any new active group would have to wait for the next
  replenishment tick to happen via quota_refill_handler(), where it can
  be queued as runnable into the per-CPU runqueue. Practically this
  might not make much of a difference, but in theory, this might cause
  some unexpected delay before its thread can be scheduled.

- we tend to assume that list_get_*() means 'consume the item at head',
  meaning the item is unlinked from the list if present then returned to
  the caller. So list_get_entry_group() may be confusing with that in
  mind, list_first_entry_group() would better describe what this does if
  we were to follow the common convention.

- the handling of kicked threads must be restored at some point,
  otherwise this scheduling policy could cause soft hangs in some
  runtime situations. This said, this is clearly not a fundamental issue
  wrt mere scheduling.

- C-style comments, English only. Generally speaking, we follow the
  kernel coding style
  (https://www.kernel.org/doc/html/latest/process/coding-style.html),
  some fixes here and there may be due in this dept.

PS: please post your patches inline instead of attached, this is easier
for commenting on them.

-- 
Philippe.

