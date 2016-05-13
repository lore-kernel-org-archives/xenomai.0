References: <CAEMXjGyohbJkCzMDTGWfhbREdmbT7VWoHpinyvbLTdpyRkEw1Q@mail.gmail.com>
 <5735DB97.5080804@xenomai.org>
 <CAEMXjGws9VOasRJh2aV+bTXDvqFHTP4yuWD_T7hPp7BJCnM+bA@mail.gmail.com>
 <57361836.4090906@xenomai.org>
 <CAEMXjGxE8N9wv8N=HiVVinhMqLse72ozMC3_Gq5pBdeQNHjcDg@mail.gmail.com>
 <CAEMXjGxGaTo55=ibxL0DJwZ9eJmXrzQ7TYUxWbGoaTB8aUz81w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <573620E5.9050202@xenomai.org>
Date: Fri, 13 May 2016 20:45:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAEMXjGxGaTo55=ibxL0DJwZ9eJmXrzQ7TYUxWbGoaTB8aUz81w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] XDDP socket,
 any memory allocation when sendto() is called?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 05/13/2016 08:27 PM, Steve B wrote:
> 
> 
> On Fri, May 13, 2016 at 11:19 AM, Steve B <sbattazzo@gmail.com
> <mailto:sbattazzo@gmail.com>> wrote:
> 
> 
> 
>     On Fri, May 13, 2016 at 11:08 AM, Philippe Gerum <rpm@xenomai.org
>     <mailto:rpm@xenomai.org>> wrote:
> 
>         On 05/13/2016 07:53 PM, Steve B wrote:
>         > On Fri, May 13, 2016 at 6:50 AM, Philippe Gerum
>         <rpm@xenomai.org <mailto:rpm@xenomai.org>> wrote:
>         >
>         >> On 05/13/2016 01:42 AM, Steve B wrote:
>         >>> Hi guys,
>         >>> Does sendto() going into an XDDP socket involve any memory
>         allocation
>         >>> that's not automatically getting de-allocated each time it's
>         called?
>         >>>
>         >>> I have an application running where I am writing a few
>         different types of
>         >>> data packets to an XDDP socket on a fixed periodic basis,
>         and in a
>         >> separate
>         >>> console using "free" I see the memory usage increasing
>         steadily until I
>         >>> only have about 5MB left, at which point it doesn't
>         grow/shrink anymore.
>         >> I
>         >>> don't seem to be losing any data after this happens, though.
>         >>>
>         >>> I tried temporarily disabling my largest packet type, and
>         saw that the
>         >> rate
>         >>> of memory consumption decreases very significantly, which is
>         why I think
>         >> it
>         >>> has something to do with this.
>         >>>
>         >>> I may be able to live with this if it's not causing any real
>         problems but
>         >>> it is a little unsettling...
>         >>
>         >> The memory is freed upon read() on the other side. Do the
>         datagrams
>         >> linger somehow on the (non-rt) read-side?
>         >>
>         >> --
>         >> Philippe.
>         >>
>         >
>         > The non-rt side just reads the messages and writes them to
>         binary files. I
>         > have a slightly over 1k byte message coming across 100x per
>         second, and log
>         > files are saved off and new files are created every 60
>         seconds. The files
>         > are pretty consistently coming out at 6.5 MB give or take a
>         few percent (I
>         > think the slop is mostly in the time keeping in the non-RT
>         side). So I
>         > think all of my data is there, though I wonder if whatever
>         buffering there
>         > is between the RT and non-RT side may be overflowing. I would
>         think that I
>         > should be seeing failures in my writes if the buffer is full?
>         >
> 
>         Correct. If you don't get any error on the write side, then it's
>         fine.
> 
>         Giving your XDDP connection a private memory pool would allow
>         you to cap
>         the maximum consumption, and check how much is actually consumed by
>         looking at /proc/xenomai/heaps/xddp-pool@<port-number>. An XDDP
>         connection consumes memory from the pool it has been given
>         exclusively.
> 
>         XDDP_POOLSZ is the setsockopt() option you need to set for that.
> 
>         > That actually does bring me to the question, do I even need to be buffering
>         > my on board log files to the non-RT side via XDDP at all? Could I just
>         > write the files straight from my RT side?
>         >
> 
>         This would entail a switch to Linux mode, which is like demoting a
>         thread priority-wise, so you would lose RT guarantees doing so
>         from the
>         RT side. XDDP is there to prevent this, keeping the RT side in
>         primary
>         mode while sending out the data to the other end.
> 
>         --
>         Philippe.
> 
> 
>     Thanks! I just didn't know for sure if the write() function may have
>     been wrapped to work in an RT-safe fashion. I originally designed in
>     the scheme using XDDP for that reason though so glad to know I had
>     the right thought.
> 
>     I already did set XDDP_POOLSZ to something like 1MB so it's curious
>     that it would be consuming more than that... I will take a look at
>     /proc/xenomai/heaps though like you said, to possibly rule out the
>     XDDP as the offending consumer of memory. I was unaware of that feature!
> 
> 
> 
> OK, /proc/xenomai/heap shows a constant 1000448 for my xddp: 0 which is
> just over what I allocated using POOLSZ.
> If I look at "free" or "top" in the OS, I see available memory shrinking
> by about 100kB per second, but top does not attribute the memory usage
> to my process, which stays at a constant 0.6% memory usage. Does the
> memory usage on the RT side not get accounted for by the regular OS? I
> suppose the other option is that the memory usage is somewhere in the
> kernel (like the file I/O?).
> 
> 

Maybe. You should have a look at the vmstat output for a while (e.g.
vmstat -a 1).

Cobalt gets all the core memory it needs from __vmalloc() since 3.0.2
(was __get_free_pages() in earlier 3.x releases), then stacks its own
allocation scheme on top of this (cobalt/kernel/heap.c). So the memory
usage on the RT side appears as one shot allocations only for getting
the initial memory underlying the real-time heaps.

-- 
Philippe.

