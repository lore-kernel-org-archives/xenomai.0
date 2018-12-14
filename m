Message-ID: <825e119a24df931fec5e9938006abe921637195f.camel@sprinte.eu>
Subject: Re: Waking up a linux thread from a xenomai thread, without mode
 switch
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Fri, 14 Dec 2018 14:16:29 +0100
In-Reply-To: <53dd5690-8997-6434-549d-fdb4a2b2a8b8@xenomai.org>
References: <9716cf94f871edebb580b4010a5c24465299514f.camel@sprinte.eu>
 <53dd5690-8997-6434-549d-fdb4a2b2a8b8@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Le vendredi 14 décembre 2018 à 12:07 +0100, Philippe Gerum a écrit :
> 
> You could use non-rt Xenomai threads on the linux side with policies
> SCHED_FIFO+prio=0 or SCHED_WEAK, allowing the thread to issue
> blocking
> Xenomai syscalls (such as waiting on a Cobalt sema4).
> 
> But, since this would incur two mode switches for the caller - one to
> switch to primary, then a converse switch to relax when returning
> from
> the blocking syscall - you certainly don't want to use that method in
> high-frequency loops, because this would be very costly CPU-wise.

Do you mean, using a third thread acting as a proxy, so that the
xenomai thread never leaves the primary domain ? This is something i
identified as a « possible solution », but yes, the overhead seems
pretty high. At this rate it may be cheaper to just use an active
waiting loop (in the linux domain) with a ~5ms period in the linux
domain, instead of waiting on a semaphore.

> Did you try the streaming output mode with MSG_MORE as illustrated in
> demo/posix/cobalt/xddp-stream.c? The streaming mode attempts to pack
> multiple messages from the rt-side into a single message delivered to
> the read() side, until the latter eventually resumes.

> IOW, if the rt-side is able to send N messages before the linux side
> eventually wakes up, then the latter will receive all the streamed
> output packed into a single read().

I don’t remember having tried that, thanks for the pointer.

Regards,

Julien


