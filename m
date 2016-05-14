Date: Sat, 14 May 2016 14:28:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160514122847.GA27354@hermes.click-hack.org>
References: <CAEMXjGyohbJkCzMDTGWfhbREdmbT7VWoHpinyvbLTdpyRkEw1Q@mail.gmail.com>
 <5735DB97.5080804@xenomai.org>
 <CAEMXjGws9VOasRJh2aV+bTXDvqFHTP4yuWD_T7hPp7BJCnM+bA@mail.gmail.com>
 <57361836.4090906@xenomai.org>
 <CAEMXjGxE8N9wv8N=HiVVinhMqLse72ozMC3_Gq5pBdeQNHjcDg@mail.gmail.com>
 <CAEMXjGxGaTo55=ibxL0DJwZ9eJmXrzQ7TYUxWbGoaTB8aUz81w@mail.gmail.com>
 <573620E5.9050202@xenomai.org>
 <CAEMXjGzCEdjwSKyTMbi3vq5inFsPQ7vqcuf-HojCKGDgPj5sTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGzCEdjwSKyTMbi3vq5inFsPQ7vqcuf-HojCKGDgPj5sTw@mail.gmail.com>
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

On Fri, May 13, 2016 at 12:42:04PM -0700, Steve B wrote:
> On Fri, May 13, 2016 at 11:45 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> 
> >
> > Maybe. You should have a look at the vmstat output for a while (e.g.
> > vmstat -a 1).
> >
> > Cobalt gets all the core memory it needs from __vmalloc() since 3.0.2
> > (was __get_free_pages() in earlier 3.x releases), then stacks its own
> > allocation scheme on top of this (cobalt/kernel/heap.c). So the memory
> > usage on the RT side appears as one shot allocations only for getting
> > the initial memory underlying the real-time heaps.
> >
> > --
> > Philippe.
> >
> 
> Thanks, this has been informative for me on a few more things to be looking
> at during development cycle, if a little off topic for this mailing list.
> I think I've actually found what's happening. I went ahead and wiped out
> all of the log files even while the process was still running, and found
> that the memory is freed up immediately! So the memory consumption is in
> the files I'm saving, even though they're supposed to go to the on board
> flash filesystem. I understand that they might be stored in RAM initially
> before getting synced over to flash, but kind of interesting that the upper
> bound on that is almost the entire RAM. There may be an OS setting
> somewhere that sets a bound, or an occasional "sync" system call might help
> free that memory up if I really need to for some reason.
> 
> Now that I've ruled out the XDDP and found what's actually happening, it
> becomes more of a Linux question than a Xenomai thing but thanks for
> helping me narrow it down!

That is probably Linux filesystem cache: Linux uses all the non
allocated kernel memory to keep copies of what is saved on disk, in
case it would be needed again. If your files are "write and forget",
you may want to use posix_fadvise(POSIX_FADV_DONTNEED) to ask the
kernel to free the memory in the filesystem cache. Note that this
only works for pages that have been written to disk, so a normal
process is to trigger an fsync before posix_fadvise. Also note that
the fsync operation may suspend the caller for some time, so you may
want to do this in a thread separate from the one calling write. I
had to implement this once, and simply used the size of what had
been written as the way of communicating between the two threads,
and had a threshold to trigger the flush + forget operation say,
every 4MiB. You also have to pay attention to force the operation
before you close the file, otherwise the few data that were written
between the last flush and the file closure may still occupy RAM.

Finally, note that for logging, if Xenomai does not wrap write, it
wraps fwrite, so may avoid using the XDDP socket by using Xenomai
stdio wrapping. In that case, of course, you have to use an fflush
before fsync before posix_fadvise. Also, the default buffer sizes of
the stdio wrapping may not suit high volumes logging, and that this
system does not use any synchronization, so may loose some data. You
can know it if you check fwrite return value. You may call
rt_print_init to choose the buffer size for a particular thread, or
use the global variable __cobalt_print_bufsz to override the default
buffer size (which is 16 KiB).

-- 
					    Gilles.
https://click-hack.org

