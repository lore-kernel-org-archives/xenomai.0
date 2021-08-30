MIME-Version: 1.0
References: <CAM4LU5LF4ShOpV9no1z884nvx4ezBO7zCnQZVxnJinow1K+Bfw@mail.gmail.com>
 <d581fd9a-c0ac-57d1-ce0d-018ae661981a@siemens.com>
In-Reply-To: <d581fd9a-c0ac-57d1-ce0d-018ae661981a@siemens.com>
From: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>
Date: Sun, 29 Aug 2021 22:12:56 -0700
Message-ID: <CAM4LU5KMy77MgW+as0FT0b=RtcbVKpauWw2ZwWa09WhPumE3Bw@mail.gmail.com>
Subject: Re: pthread_getcpuclockid() and clock_gettime() with Xenomai pthread
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Hi Jan,
   We are currently getting the total system time and all linux pthread run
time using the clock_gettime(). Then we are getting the linux idle time
from /proc/stat. We are getting the xenomai thread times and total xenomai
time from /proc/xenomai/sched/acct. Subtract the total xenomai time from
linux ide. Then calculate as a percentage individual thread CPU utilization
and reserve percentage. We can do this in a Linux thread, but it would be
nice if we had a single interface/api for getting the per thread CPU
utilization for the whole system(Linux and Xenomai).

Rajesh


On Fri, Aug 27, 2021 at 5:40 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 27.08.21 03:15, Rajesh Venkataraman via Xenomai wrote:
> > Hi,
> >    For the linux pthreads we have used pthread_getcpuclockid() to get the
> > threads cpu time clock. Then periodically we do a clock_gettime() on this
> > timer to get all threads run time. Then do clock_gettime(
> CLOCK_MONOTONIC,
> > &ts ) to get the total system. Using the individual thread run time and
> > total run time, we calculate the percentage of CPU utilization for each
> > thread. Now we have moved the realtime thread to xenomai user space.
> > The clock_gettime() on a xenomai user thread returns an error.   How do
> we
> > calculate what percentage of the CPU is utilized by the xenomai thread in
> > our Application?
> >
> >   We also get the idle time of the CPU from the /proc/stat and calculate
> > the reserve percentage based on the total system time. Does linux idle
> time
> > also include xenomai run time?
> >
> >   Is this correct method for calculating the CPU utilization percentage
> per
> > thread in a system/application with xenomai and linux pthreads running
> in a
> > single process?
> >
>
> Xenomai does not support pthread_getcpuclockid for reading the consumed
> time of a thread. There are stats under /proc/xenomai/sched/acct, rtps
> uses them, but reading those require switching to Linux (if that is an
> issue for your use case). And there is an internal cobalt_thread_stat()
> syscall already, used only by some non-posix skins so far.
>
> I'm sitting on non-upstream changes to export the CPU usage of thread to
> userland without leaving RT, actually even without issuing a syscall.
> But those need rework in order to attach to some posix interface.
>
> What are your requirements on a statistic interface? Who is going to
> monitor who, and under which constraints?
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
