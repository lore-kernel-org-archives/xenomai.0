Subject: Re: Waking up a linux thread from a xenomai thread, without mode
 switch
References: <9716cf94f871edebb580b4010a5c24465299514f.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <53dd5690-8997-6434-549d-fdb4a2b2a8b8@xenomai.org>
Date: Fri, 14 Dec 2018 12:07:11 +0100
MIME-Version: 1.0
In-Reply-To: <9716cf94f871edebb580b4010a5c24465299514f.camel@sprinte.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 12/14/18 11:48 AM, Julien Blanc via Xenomai wrote:
> Hi,
> 
> We’re currently using semaphores and a shared buffer to allow
> communication between a xenomai cobalt thread and a linux regular
> thread (the xddp interface has been tested and does not perform well
> for our use case, which is exchanging a lot a very small messages).
> 
> While this works fine most of the time, we’ve noticed that this incurs
> a mode switch when the xenomai rt-thread calls real_sem_post, and,
> under heavy load, it can results in that specific thread being
> suspended for too long.
>

Which is expected.

> I couldn’t find in the documentation how to do this properly :
> * waiting on a xenomai semaphore from a linux thread is forbidden
> * posting a linux semaphore from a xenomai thread incurs a mode switch
> 
> I’d like each thread to stay in its mode. I can live with the linux
> thread entering the primary mode for a small amount of time, but not
> the xenomai thread entering the secondary mode.
> 

You could use non-rt Xenomai threads on the linux side with policies
SCHED_FIFO+prio=0 or SCHED_WEAK, allowing the thread to issue blocking
Xenomai syscalls (such as waiting on a Cobalt sema4).

But, since this would incur two mode switches for the caller - one to
switch to primary, then a converse switch to relax when returning from
the blocking syscall - you certainly don't want to use that method in
high-frequency loops, because this would be very costly CPU-wise.

-- 
Philippe.

