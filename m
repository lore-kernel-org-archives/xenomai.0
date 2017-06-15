References: <CAPEB8kXw=D=WOV2VgVncK_12k8YdkoOy3SXiQ5zywMYkTdt5UA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <efb346c0-a1be-2168-00a1-c783db957433@xenomai.org>
Date: Thu, 15 Jun 2017 10:39:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAPEB8kXw=D=WOV2VgVncK_12k8YdkoOy3SXiQ5zywMYkTdt5UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mysterious Mode Switches (Xenomai 2.6.2.1)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robbert van der Bijl <rvanderbijl@seuratech.com>, xenomai@xenomai.org

On 06/15/2017 01:51 AM, Robbert van der Bijl wrote:
> All,
> 
> I'm fairly new when it comes to Linux & Xenomai, but I've been able to
> successfully put together the majority of our fairly large application on
> our Delta Tau PMAC board (PowerPC 465, dual core) in C++ so far.
>

An important piece of information is missing, i.e. the kernel version
and the I-pipe patch release Xenomai runs on.

Xenomai 2.6.2.1 is known to have several (read: many) nasty bugs (read:
critical), especially in SMP mode (read: certainly). You should really
consider switching to 2.6.5, whose API is backward-compatible with
earlier 2.6.x releases.

> The one thing that stumps me though, is the mode switches that happen with
> certain memory accesses.
> 
> Take this chunk of code for instance:
> for (int i=0; i<10000; i++)
>    memset(m_pClientSendData+(32*i), 0, 32);
> 
> This does NOT cause mode switches when run on a chunk of memory that's been
> malloc'ed.
> 
> However, this code DOES cause a mode switch (same memory):
> memset(m_pClientSendData, 0, 320000);
> 
> The for loop is obviously crazy slow compared to the single memset and not
> very practical. But I'm at a loss to explain this behavior. Similar
> problems with memcpy as well.

This is most likely due to minor MMU faults caused by TLB misses for
memory that is valid, but whose virtual address has no entry in the
hardware TLB. Since the latter is a scarce resource and the application
treads over a large piece of memory continuously, the kernel receives
requests from the MMU via the fault mechanism for bolting missing
entries to the hardware TLB.

Now the ugly part: when those faults happen over a real-time context, we
may not always be able to handle them directly from there (i.e. doing
the bolting quickly then returning from the fault trap right after), but
we may have to channel the fault to the regular Linux kernel handler for
fixing them up instead. In that case, a mode switch must happen to
resync the current execution context with the regular kernel logic
(otherwise, really bad things would happen).

If I'm right, you should see the 'PF' counter increase over time for
your rt task in /proc/xenomai/stats.

This is really an arch-specific issue. For instance, on armv6/v7/v8, we
can manage to handle the so-called "translation faults" (data and
prefetch aborts) directly from the real-time context, without having to
downgrade to the regular Linux mode. x86 is done a bit differently, but
does not have issues with TLB misses either. The situation with ppc
depends on the core, but the 4xx series is known to be sensitive to this
issue when large bulks of memory are moved around.

> 
> Bottom line, what I'm trying to accomplish is getting around 400k of shared
> memory pumped out through a pipe to a TCP/IP task that runs in secondary
> mode only, as to avoid having the main task flip back and forth between
> primary and secondary modes. I tried to do this with just plain shared
> memory initially, but then found out that the mutexes I was using would
> force my TCP/IP thread into primary mode when I grabbed the mutex....
> 
> Does anyone have any ideas?
> 

I would try to reduce the amount of memory that your application needs
to tread on for this specific task at each iteration, which should
reduce the pressure on the hardware TLB in the first place.

IIUC, you need to share a large bulk of data between a rt task and a
purely non-rt context, synchronizing the latter on update events sent by
the former, then pushing the contents of the shared segment to a TCP
stream. If you went for sending the whole bulk of data, I assume that
you need the rt side to keep acquiring new data while the TCP streaming
takes place on the other end, hence the memory copy through the pipe.

If so, the Xenomai message pipe still looks like the right option, since
it does not require the non-rt part to be a Xenomai task, eliminating
the need for switching modes when synchronizing with the rt portion.
However, I would use the pipe only to send a short update event to the
TCP task, not the whole memory, basically telling it to transmit the
contents of the shared memory.

To allow the rt portion to keep acquiring data without having to
synchronize with the non-rt TCP worker, using an array of buffers comes
to mind, so that the acquisition and the TCP streaming can be fully
asynchronous operations under normal circumstances (i.e. the non-rt side
does not lag for too long consuming the data).

The update message could also convey the index of the last completed
output buffer, and you would only have to deal with the overflow
situation when no buffer is available on the rt side, due to the non-rt
side lagging too much.

-- 
Philippe.

