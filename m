References: <trinity-f80d2905-650a-40fe-868e-5e8b383b367c-1612976082333@3c-app-gmx-bap21>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Effective way to stream data from xenomai task to linux domain
 task
In-reply-to: <trinity-f80d2905-650a-40fe-868e-5e8b383b367c-1612976082333@3c-app-gmx-bap21>
Date: Wed, 10 Feb 2021 18:08:48 +0100
Message-ID: <87y2fvlujj.fsf@xenomai.org>
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
To: Jan Holtz <jan5697@gmx.net>
Cc: xenomai@xenomai.org


Jan Holtz via Xenomai <xenomai@xenomai.org> writes:

>    Hello,
>
>    i am running a xenomai 3 on a SMP cobalt kernel using the alchemy skin.
>
>    I have a rt task running in a 10kHz period which has to transfer every
>    40ms a amount of data (30.000 byte)  to the linux domain task.
>
>    At moment i am using a rt_pipe with the file backend on linux side.
>    In my setup the rt_pipe_write call takes upto 60 microseconds .
>    Measured using rt_timer_read.
>
>    I expected that writing to the pipe is the bottleneck, so i created a
>    second task and used a queue to push data to this task, which is
>    feeding the pipe.
>    The runtime for the rt_queue_write is like the same, which i measured
>    bevore using the rt_pipe_write.
>
>    My questions:
>    Is the amout of time i need for this action expectable, or may i have
>    another issue?
>    Is there a more effective way to communicate/stream data to the linux
>    task? Are the xddp sockets faster on the xenomai side (i iam correct
>    the pipe is based on this?)
>
>
>    Hope you have s suggestion or a tip.
>

rt_pipe is based on xddp, which involves a user->kernel->user data
roundtrip via Cobalt's xnpipe mechanism, this is likely what is time
consuming for the most part. Using xddp should not give you better
figures.

rt_queue_write may be costly because it first allocates a buffer to
write your data to, before queuing it. The allocation + copy ops are
likely the outstanding ones in the benchmark figures.

If the implementation allows this, you may want to pre-allocate a number
of queue buffers using rt_queue_alloc, pushing them to the receiver by
calling rt_queue_send. That would mimic rt_queue_write, but moving out
the buffer allocation to a non time-sensitive place. You would simply
have to manage a free list of pre-allocated buffers.

Based on the previous optimization, you may want to prep your data in
place, directly into a pre-allocated buffer if possible. That would save
you one data copy.

-- 
Philippe.

