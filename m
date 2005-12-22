Message-ID: <43AA5FBE.2070501@domain.hid>
Date: Thu, 22 Dec 2005 09:11:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Shared Memory, check. Fifos...
References: <20051221151012.W16178@domain.hid>
In-Reply-To: <20051221151012.W16178@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kent Borg <kentborg@domain.hid>
Cc: xenomai@xenomai.org

Kent Borg wrote:
> Thanks to help from the list, I now know how to use shared memory
> between a realtime userland process and a regular userland process.
> Way cool!
> 
> Next, how do I do a fifo that gets written from RT userland and read
> from regular userland?  Just a regular Linux mkfifo, opens, writes,
> etc?  (Any special locking issues?  How do I control and deal with
> buffer limits?)
> 

It depends what your prerequisites are. If you want a RT task to 
send/receive data to another task (RT or not) while remaining in the 
most deterministic execution mode (i.e. primary), you will likely prefer 
using the Xenomai message pipes [1].

Basic usage:

RT-side: rt_pipe_create(&pipe,"this_pipe",0)
	opens the RT side, and creates /proc/xenomai/registry/pipes/this_pipe
	use rt_pipe_write()/rt_pipe_read() to exchange data through this channel.

non RT-side: open("/proc/xenomai/registry/pipes/this_pipe",...)
	use write()/read() to exchange data with the RT-side.

In v2.0.x, the buffer memory is always obtained from Xeno's system heap. 
This heap is 128Kb large by default; you may want to increase it at 
configuration time (Nucleus menu, CONFIG_XENO_OPT_SYS_HEAPSZ) if it's 
not enough. In any case, keep in mind that the system heap is used for 
various internal allocations, such as thread stacks and TCBs, so it's 
better to avoid any starvation here.
Upon memory exhaustion, send/receive calls return -ENOMEM, there is no 
blocking state enforced while reclaiming memory, it's up to the 
application code to define its own policy in such circumstances.

In v2.1, pipe channels can be given their own heap to get memory from, 
and the rt_pipe_create() call takes an additional argument specifying an 
initial buffer pool size. This reduces the odds of exhausting the system 
heap memory.

The point to keep in mind is that having a RT-side and a non-RT side at 
both ends of the communication path means that the former must make sure
to leave enough processing time to the latter for reading the messages 
and thus flushing the internal buffers, since the RT-side always has 
higher priority than the non RT-side.

[1] 
http://download.gna.org/xenomai/documentation/tags/v2.0.1/html/api/group__pipe.html

PS: make sure to see the /dev/rtp* files; those are the message pipe 
device entries. "make install" when building Xeno builds them appropriately.

> 
> Thanks,
> 
> -kb, the Kent who is getting the hang of it.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

