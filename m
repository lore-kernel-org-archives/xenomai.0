MIME-Version: 1.0
From: Rajesh Venkataraman <rajesh_venkataraman@trimble.com>
Date: Thu, 26 Aug 2021 18:15:15 -0700
Message-ID: <CAM4LU5LF4ShOpV9no1z884nvx4ezBO7zCnQZVxnJinow1K+Bfw@mail.gmail.com>
Subject: pthread_getcpuclockid() and clock_gettime() with Xenomai pthread
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
   For the linux pthreads we have used pthread_getcpuclockid() to get the
threads cpu time clock. Then periodically we do a clock_gettime() on this
timer to get all threads run time. Then do clock_gettime( CLOCK_MONOTONIC,
&ts ) to get the total system. Using the individual thread run time and
total run time, we calculate the percentage of CPU utilization for each
thread. Now we have moved the realtime thread to xenomai user space.
The clock_gettime() on a xenomai user thread returns an error.   How do we
calculate what percentage of the CPU is utilized by the xenomai thread in
our Application?

  We also get the idle time of the CPU from the /proc/stat and calculate
the reserve percentage based on the total system time. Does linux idle time
also include xenomai run time?

  Is this correct method for calculating the CPU utilization percentage per
thread in a system/application with xenomai and linux pthreads running in a
single process?

Rajesh
