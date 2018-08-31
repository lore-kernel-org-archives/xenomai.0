References: <d3673e3b3ef541a59dc6df0e9f884558@boschrexroth.nl>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bebaaee4-36e8-9796-7ac0-8420b12658cc@xenomai.org>
Date: Fri, 31 Aug 2018 13:15:10 +0200
MIME-Version: 1.0
In-Reply-To: <d3673e3b3ef541a59dc6df0e9f884558@boschrexroth.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IPC between RT and nRT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bradley Valdenebro Peter (DC-AE/EHP2)" <Peter.BradleyValdenebro@boschrexroth.nl>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/30/2018 11:49 AM, Bradley Valdenebro Peter (DC-AE/EHP2) wrote:
> Hello all,
> We work in motion control. We execute our system on a zynq-7020. We are doing some redesign on our system.
> 
> We have our control loop executing as a Xenomai RT thread at 8kHz. This is our highest priority thread.
> We have the need to transfer around 512 bytes every sample from the Xenomai RT task to a Linux NR task that will later send that info through Ethernet using UDP.
> We are currently using RT pipes to transfer that data but we would like to reduce the processing time of the data  as much as possible.
> 
> We see RT pipes as the only mechanism for RT-nRT communication. Is there a reason for this?

Nobody came up with a better way which would entail no mode switch, no
explicit synchronization between the peers, I guess. The send-and-forget
scheme makes this possible, keeping the message boundaries also makes it
easier on the receiver side.

Clearly, things like arinc653's blackboards, or a mailbox mechanism
could be provided off-the-shelf, but the semantics there do not fit the
most common use case of exchanging data between rt and non-rt domains.

You could still have a non-RT Cobalt thread (SCHED_OTHER or SCHED_WEAK
policies) synchronizing with a RT one for dealing with a buffer queue
(all other policies including SCHED_FIFO) using some Cobalt-enabled
POSIX IPC (e.g. mutexes, condvars, sema4s), but that would cause a round
of mode switches back and forth each time the non-RT thread goes
sleeping on them, waiting for the next event to be posted from the RT
side. This would entail even more CPU consumption, especially at 8khz.

> Is using shared memory between RT and nRT or other kind of IPC better suited for this?

Shared memory would require peers to agree on some sort of explicit
synchronization scheme. Factoring in the co-kernel requirements, this
would make common serialization IPCs not usable for switch-less
execution, so a lockless scheme would have to be involved for preventing
mode switches.

Still no showstopper here, but considering all the specifics the peers
would have to agree on to make this work (should we poll locklessly for
data on the reader side?, how do we queue data whether it is single-byte
or represents longer messages? etc.), we would end up with something
resembling the existing solution, reimplemented in user-space, or maybe
with fairly similar message-based mechanism exporting a different
API/window dressing.

> By using shared memory I guess we would force some secondary switches but it might be worthwhile, right?
> 

Shared memory would be just fine, and would not entail any mode switch
but as mentioned, it would come with more logic to be shared directly
between peers - from the application code - on the way to synchronize
accesses. It may be possible to abstract some of it into a set of
generic lockless services, but getting 1) high frequency transactions +
2) sleep-waiting for input + 3) low CPU consumption, may be quite tricky.

Do you have other cross-domain IPC semantics we should consider in mind?

-- 
Philippe.

