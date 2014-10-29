Message-ID: <54512440.3000806@xenomai.org>
Date: Wed, 29 Oct 2014 18:30:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <94331816.zv1NYeHro4@riemann>
In-Reply-To: <94331816.zv1NYeHro4@riemann>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Message Pipe services behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Steve M. Robbins" <steve@sumost.ca>, Xenomai@xenomai.org

On 10/29/2014 05:11 PM, Steve M. Robbins wrote:

> In the old FIFO-based code, we had a suspicion of the similar problem.  Since 
> the linux process is not real time, we expect multiple messages to be waiting.  
> To avoid running through the select/read loop once for each message, our old 
> FIFO-based code opened the file in nonblocking mode and did a read into a buffer 
> that could hold up to 100 messages.  We generally would read 5-7 at a time, 
> not 100, so this proved that the reader could keep up when reading in batches.
> 
> Using this same technique with the /dev/rtpN end of a Message Pipe never reads 
> more than 1 message.  I tried both blocking and non-blocking modes but got the 
> same result.  So this is my main question: knowing that there are likely many 
> messages in the pipe, how do I read them in a batch?
> 

Reading with O_NONBLOCK set on /dev/rtp should do the trick. If it does
not, this could mean that your rt side is filling up the pool too fast
compared to the scheduling opportunities for the nrt side. The latter
won't run until the rt activity becomes quiescent long enough.

You can track how many bytes are readable on the nrt side by using
ioctl(.., FIONREAD, &some_int), to make sure this value does increase
over time until ENOMEM is received. Otherwise there must be a leak of
consumed message buffers.

[snip]

> When I created the pipes with poolsize=0, all three queues would eventually 
> begin to return -ENOMEM.  After switching to poolsize=1000*sizeof(message), it 
> seems to be only the middle-sized message that fails to allocate.  That's not 
> a conclusive observation, but if the other two are failing to allocate it is 
> much less often than the middle one which eventally gets stuffed up and always 
> fails.  This is quite surprising to me.

poolsize=0 means to pull the buffer memory from the main Xenomai heap,
the size of which is given by CONFIG_XENO_OPT_SYS_HEAPSZ in your
Kconfig. Otherwise, some kernel memory is pulled from the regular linux
allocator for this purpose.

So if ENOMEM is received with poolsize=0, this means that a memory
shortage happens due to the pressure on the Xenomai main/system heap,
which is always bad news. I would recommend to use a local pool (i.e.
poolsz > 0) to prevent a consumption peak on the pipe from affecting the
whole Xenomai system.

You can read /proc/xenomai/heap while your test runs, to observe how
heaps behave.

Also, a memory leak was fixed in the 2.6 time frame, but it would bite
only when closing the file descriptor to the pipe. This said, you may
want to patch it in, to save some hair pulling sessions in the future:
http://git.xenomai.org/xenomai-2.6.git/commit/?id=ef8be4e4e58489479c2245a87b1dbd04d331dca9

-- 
Philippe.

