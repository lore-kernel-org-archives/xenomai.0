Subject: Re: pthread_getcpuclockid() and clock_gettime() with Xenomai pthread
References: <CAM4LU5LF4ShOpV9no1z884nvx4ezBO7zCnQZVxnJinow1K+Bfw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d581fd9a-c0ac-57d1-ce0d-018ae661981a@siemens.com>
Date: Fri, 27 Aug 2021 14:40:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAM4LU5LF4ShOpV9no1z884nvx4ezBO7zCnQZVxnJinow1K+Bfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>, xenomai@xenomai.org

On 27.08.21 03:15, Rajesh Venkataraman via Xenomai wrote:
> Hi,
>    For the linux pthreads we have used pthread_getcpuclockid() to get the
> threads cpu time clock. Then periodically we do a clock_gettime() on this
> timer to get all threads run time. Then do clock_gettime( CLOCK_MONOTONIC,
> &ts ) to get the total system. Using the individual thread run time and
> total run time, we calculate the percentage of CPU utilization for each
> thread. Now we have moved the realtime thread to xenomai user space.
> The clock_gettime() on a xenomai user thread returns an error.   How do we
> calculate what percentage of the CPU is utilized by the xenomai thread in
> our Application?
> 
>   We also get the idle time of the CPU from the /proc/stat and calculate
> the reserve percentage based on the total system time. Does linux idle time
> also include xenomai run time?
> 
>   Is this correct method for calculating the CPU utilization percentage per
> thread in a system/application with xenomai and linux pthreads running in a
> single process?
> 

Xenomai does not support pthread_getcpuclockid for reading the consumed
time of a thread. There are stats under /proc/xenomai/sched/acct, rtps
uses them, but reading those require switching to Linux (if that is an
issue for your use case). And there is an internal cobalt_thread_stat()
syscall already, used only by some non-posix skins so far.

I'm sitting on non-upstream changes to export the CPU usage of thread to
userland without leaving RT, actually even without issuing a syscall.
But those need rework in order to attach to some posix interface.

What are your requirements on a statistic interface? Who is going to
monitor who, and under which constraints?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

