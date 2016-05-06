Date: Sat, 7 May 2016 01:10:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160506231034.GK13285@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
 <20160504210030.GK1761@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
 <20160506151720.GH3264@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160506151720.GH3264@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] mmap a file in rtdm moudle without switching the mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, May 06, 2016 at 11:17:20AM -0400, Lennart Sorensen wrote:
> On Fri, May 06, 2016 at 03:04:03PM +0000, Umair Ali wrote:
> > Hello gilles,
> > 
> > Thanks for the patience and the reply. I am sorry for asking such questions. I am newbie so need some guidance. I have searched for linux device drivers on the internet and I found the book (https://lwn.net/Kernel/LDD3/) . Can you recommend me which chapter will be very helpful for me. I want to read a big file of size 600MB in kernel space and need to read it periodically by timers. I think the answers lies in the using functions rtdm_malloc, rtdm_safe_copy_from _user. I know the good way to is open the file in the userspace and send the address to kernel space. Any example will help me a lot. 
> 
> Well my understanding is that you do NOT ever read files from kernel
> space.  You let user space do that and pass the data.
> 
> This doesn't mean it can't be done, just that the kernel maintainers
> seem quite insistent that you don't do file access from kernel space.
> 
> Certainly doing file access sounds like something you would not want to
> try and do from the realtime side of things.  You probably can't.

I believe I was the one who suggested doing things in kernel-space,
but not to read the file. Though there is an API to read files from
kernel-space:
https://lwn.net/Articles/676101/

The idea with doing it in kernel-space is to reduce the latency.

What Ali is trying to do is essentially to do what "tcpreplay" does,
but using Xenomai and RTnet: play back recorded packets including
playing them back at the time given by their timestamps. Since the
sending is timed, you can not really benefit from the hardware
queueing to reduce the latencies, you have to set up a timer, and
when the timer ticks, trigger the send. So, the send may be delayed
by the user-space scheduling latency. Doing the send in a kernel
thread, on the other hand, replaces the user-space scheduling
latency with a kernel-space scheduling latency. It would be nice if
we could do it from a kernel timer, to reduce even more the latency,
but RTnet send involves a mutex, so requires a thread, whether
kernel or user.

For this to work, however, the next packet must be available to the
kernel thread doing the sends, when the timer ticks. So, what you
want to do is to implement a message queue between the user-space
thread reading the file, somehow, and the kernel-space thread doing
the send, passing the user-space message address and its timestamp.
You are not going to cut down on message copies: every message will
be copied three times, once from the disk to user-space memory, the
second time from the user-space memory to the kernel-space memory,
then from kernel-space memory to the rtnet packet structure, because
the rtnet API in kernel-space follows the POSIX API, and the
kernel-space "send" function expects a kernel-space address. Whereas
you would get only two copies when sending from user-space. You can
use malloc + read to set up the messages for the kernel thread, or
mmap, it does not really matter, though malloc + read implies one
more copy, but the copy is done ahead of time so has no influence on
the replay timings precision.

As for the laziness of mmap, it is not a problem: Xenomai programs
run with mlockall anyway. There will be a problem if the mmaped file
is larger than the available RAM though.

All of this however, only makes sense if benchmarks have showed that
sending from user-space does not yield precise enough replays, and
all other potential bugs have been removed, like for instance taking
into account the fact that the tcpdump capture timestamps are
packets arrival times, not departure times.

Regards.

-- 
					    Gilles.
https://click-hack.org

