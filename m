MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17995.26328.303873.229987@domain.hid>
Date: Wed, 16 May 2007 22:17:28 +0200
In-Reply-To: <cbe23c50705151326v5ce31bcbie877828121059de9@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D1@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2198@domain.hid>
	<17993.62961.195987.37407@domain.hid>
	<cbe23c50705151326v5ce31bcbie877828121059de9@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

Eric Noulard wrote:
 > 2007/5/15, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
 > > Daniel Schnell wrote:
 > >  > The reason I was looking at the memcpy native performance was because I found Xenomai Posix message queues somewhat slow:
 > >  > In two tasks where one is receiving a 32 kBytes msg and the other sending to this task 32 kbytes of data, I have an average cycle time of more than 1 ms.
 > >  > Looking at the memcpy performance of my system tells me something:
 > >  > Memcpy(32 KB) ->  400 us
 > >  > Two msg_send(32KB) cannot be less than 2x400 us + 2 ctx switch away, probably even more because we have to write first to Kernel memory, then the ctx switch, then copying from Kernel memory to user buffer, than ctx switch. This simply means I cannot use msg queues for anything bigger than 1K, which means I have to use shared memory for that.
 > 
 > Are your 2 tasks in user-space or 1 in user 1 in kernel?
 > 
 > > so it is probably better to use message queues to pass pointers to a
 > > shared memory region, allowing zero copies.
 > 
 > I was about to say just the same but before developing my idea
 > I have xenomai question:
 > Are the share memory region obtained by shm_open
 > shareable between kernel task and user task just like
 > rt_heap_create/rt_heap_alloc does (read from the doc).

Well, if you found rt_heaps doc, it would have been easy to have a look
at posix shared memory doc as well... Anyway, yes, on platforms where
sharing a memory area between kernel space and user-space is not a
problem, posix shared memory are shareable. On ARM, it is a no go
because of the cache architecture.

-- 


					    Gilles Chanteperdrix.

