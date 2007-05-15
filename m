From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17993.62961.195987.37407@domain.hid>
Date: Tue, 15 May 2007 20:03:29 +0200
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB2198@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D1@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2198@domain.hid>
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
 > Hi,
 > 
 > 
 > To 1.)
 > doing memset() on the buffers makes a change ... Now the performance is as bad as with mlockall() :(
 > Which means the Linux VM without mlockall makes somehow an optimization for uninitialized heap buffers.
 > Actually nothing to blame on Xenomai here.
 > 
 > The reason I was looking at the memcpy native performance was because I found Xenomai Posix message queues somewhat slow:
 > In two tasks where one is receiving a 32 kBytes msg and the other sending to this task 32 kbytes of data, I have an average cycle time of more than 1 ms.
 > Looking at the memcpy performance of my system tells me something:
 > Memcpy(32 KB) ->  400 us
 > Two msg_send(32KB) cannot be less than 2x400 us + 2 ctx switch away, probably even more because we have to write first to Kernel memory, then the ctx switch, then copying from Kernel memory to user buffer, than ctx switch. This simply means I cannot use msg queues for anything bigger than 1K, which means I have to use shared memory for that.

Actually, when using message queues in user-space, there are two more
copies of the messages, plus the allocation of a temporary buffer for
messages larger than 64 bytes. Using shared memory in the implementation
of messages queues would allow to have two copies as well in user-space,
this is another optimization that has been in my todo list for some
time. But the cost of posix message queues is already high by design
(at least two copies when user-space, maybe one copy in kernel-space),
so it is probably better to use message queues to pass pointers to a
shared memory region, allowing zero copies.

 > As you proposed in another mail maybe it makes a difference to use an own memcpy implementation for ppc which does no read on write.
 > 
 > 
 > To 2.)
 > I don't have a recent glibc, so that is no option. I can wait however for the new clock_gettime() of Xenomai and use in between the rt_timer_tsc function.

Changing glibc for an embedded Linux project is not that traumatic, and
is probably a good idea when there were so much improvements.

-- 


					    Gilles Chanteperdrix.

