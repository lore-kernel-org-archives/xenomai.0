MIME-Version: 1.0
Date: Sun, 7 Jun 2015 14:39:26 +0200
Message-ID: <CADvZd9YUCnLcuwndRrsEY=Po1AL7nm_3Z+7daBOaCucRAJgT0w@mail.gmail.com>
From: Michael Haberler <haberlerm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Q on scheduling - rt_task_wait_period vs rtdm_wait_event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

so far  we had multiple periodic RT threads of different priority, so a
lower-priority thread would not preempt a higher-priority one

we are switching the scheduling of a low-priority thread from periodic to
event-based - instead of rt_task_wait_period(), this task will now wait in
an RTDM driver ioctl in rtdm_event_wait()

I assume the following to be true:

even if the rtdm_even_wait() terminates while a higher priority thread is
running, the lower priority thread will not be scheduled until all
higher-priority threads have entered rt_task_wait_period().

correct?

thanks in advance,

Michael

background: we're synchronizing an RT thread to an external timing
reference, for now a GPIO interrupt, starting from here:
https://github.com/mhaberler/gpio-irq-rtdm
