MIME-Version: 1.0
Date: Thu, 8 Oct 2015 11:37:59 -0700
Message-ID: <CAEMXjGwRGn2DQYxinAaCzqLXbqhrG6RsNVODsDO9SGF=a60ccg@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Question about RT serial and SCHED_FIFO vs. SCHED_OTHER
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello all,
In working with an application I have using RT serial, I have noticed the
following:

It seems like if I try rt_dev_open and/or rt_dev_ioctl from a SCHED_FIFO
task, my application hangs requiring a hard reboot, and if I try
rt_dev_write when my task is set up as SCHED_OTHER, I get "CPU time limit
exceeded" and the application dies (but at least I don't have to do a hard
reboot at this point).

Does this behavior make sense?
It seems now that everything is in order when I apply the workaround of
having my UART listening task switch itself to SCHED_FIFO or SCHED_OTHER at
the appropriate times during port initialization, but I'm still curious if
this is the expected behavior.

Thanks,

Steve
