Message-ID: <cbe23c50705151326v5ce31bcbie877828121059de9@domain.hid>
Date: Tue, 15 May 2007 22:26:08 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <17993.62961.195987.37407@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D1@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2198@domain.hid>
	<17993.62961.195987.37407@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2007/5/15, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Daniel Schnell wrote:
>  > The reason I was looking at the memcpy native performance was because I found Xenomai Posix message queues somewhat slow:
>  > In two tasks where one is receiving a 32 kBytes msg and the other sending to this task 32 kbytes of data, I have an average cycle time of more than 1 ms.
>  > Looking at the memcpy performance of my system tells me something:
>  > Memcpy(32 KB) ->  400 us
>  > Two msg_send(32KB) cannot be less than 2x400 us + 2 ctx switch away, probably even more because we have to write first to Kernel memory, then the ctx switch, then copying from Kernel memory to user buffer, than ctx switch. This simply means I cannot use msg queues for anything bigger than 1K, which means I have to use shared memory for that.

Are your 2 tasks in user-space or 1 in user 1 in kernel?

> so it is probably better to use message queues to pass pointers to a
> shared memory region, allowing zero copies.

I was about to say just the same but before developing my idea
I have xenomai question:
Are the share memory region obtained by shm_open
shareable between kernel task and user task just like
rt_heap_create/rt_heap_alloc does (read from the doc).

And back to shared memory design ideas.
May be you can create a shared memory region on which
you map a RINGBUFFER structure
(ringbuffer is simple and efficient if you only have 1 writer and 1 reader)
Since ringbuffer is non-blocking you may add a semaphore in order
get the implicit synchro the message queue gives you when RINGBUF
is empty (I think the full case may be forbidden by design).

It may (? to be confirmed ?) cost you less than
SHM  + MESSAGE QUEUE if sem_wait/sem_post is faster
moreover with a ringbuf you only have to sem_wait if it is empty.

The ringbuf element may contain offset in the SHM where you can find the data
or if your data has fixed size you may set up ringbuf which contains
the effective data as element.

We use in-memory ringbuf for a sampling protocol designed and used
in test environment: https://savannah.nongnu.org/projects/tsp

The ringbuf code is implemented with C MACRO (for efficiency):
http://cvs.savannah.nongnu.org/viewvc/tsp/src/core/misc_utils/tsp_ringbuf.h?root=tsp&view=markup

-- 
Erk

