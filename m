MIME-Version: 1.0
In-Reply-To: <573620E5.9050202@xenomai.org>
References: <CAEMXjGyohbJkCzMDTGWfhbREdmbT7VWoHpinyvbLTdpyRkEw1Q@mail.gmail.com>
 <5735DB97.5080804@xenomai.org>
 <CAEMXjGws9VOasRJh2aV+bTXDvqFHTP4yuWD_T7hPp7BJCnM+bA@mail.gmail.com>
 <57361836.4090906@xenomai.org>
 <CAEMXjGxE8N9wv8N=HiVVinhMqLse72ozMC3_Gq5pBdeQNHjcDg@mail.gmail.com>
 <CAEMXjGxGaTo55=ibxL0DJwZ9eJmXrzQ7TYUxWbGoaTB8aUz81w@mail.gmail.com>
 <573620E5.9050202@xenomai.org>
Date: Fri, 13 May 2016 12:42:04 -0700
Message-ID: <CAEMXjGzCEdjwSKyTMbi3vq5inFsPQ7vqcuf-HojCKGDgPj5sTw@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On Fri, May 13, 2016 at 11:45 AM, Philippe Gerum <rpm@xenomai.org> wrote:

>
> Maybe. You should have a look at the vmstat output for a while (e.g.
> vmstat -a 1).
>
> Cobalt gets all the core memory it needs from __vmalloc() since 3.0.2
> (was __get_free_pages() in earlier 3.x releases), then stacks its own
> allocation scheme on top of this (cobalt/kernel/heap.c). So the memory
> usage on the RT side appears as one shot allocations only for getting
> the initial memory underlying the real-time heaps.
>
> --
> Philippe.
>

Thanks, this has been informative for me on a few more things to be looking
at during development cycle, if a little off topic for this mailing list.
I think I've actually found what's happening. I went ahead and wiped out
all of the log files even while the process was still running, and found
that the memory is freed up immediately! So the memory consumption is in
the files I'm saving, even though they're supposed to go to the on board
flash filesystem. I understand that they might be stored in RAM initially
before getting synced over to flash, but kind of interesting that the upper
bound on that is almost the entire RAM. There may be an OS setting
somewhere that sets a bound, or an occasional "sync" system call might help
free that memory up if I really need to for some reason.

Now that I've ruled out the XDDP and found what's actually happening, it
becomes more of a Linux question than a Xenomai thing but thanks for
helping me narrow it down!

Steve
