References: <003a01d7a10d$9268d6b0$b73a8410$@ecler.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Using oob GPIO on RPi4B and evl_poll
In-reply-to: <003a01d7a10d$9268d6b0$b73a8410$@ecler.com>
Date: Sat, 04 Sep 2021 09:36:58 +0200
Message-ID: <87sfyk7pwl.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: j.villena@ecler.com
Cc: xenomai@xenomai.org


j.villena--- via Xenomai <xenomai@xenomai.org> writes:

> Hi all,
>
>  
>
> I am using the EVL Raspberry-PI-4 GPIO driver in oob mode for waiting for 4
> GPI signals changes by monitoring raising and falling edges continuously.
>
>  
>
> The first version uses 4 diferent oob threads and it works as expected when
> waiting forever in oob_read on each thread.
>
>  
>
> To optimize resources, I want to avoid to use the 4 threads approach, and I
> want to create only one thread to handle all GPI functionality. Thus I have
> added polling capabilities with evl_poll and related API to GPIO file
> descriptors in only one thread.
>
>  
>
> At first it seems to work, but when I added another file descriptor to the
> same polliing set (from an event flag group) the program freezes, and system
> becomes unstable.
>
>  
>
> Then I noticed that in the "Polling file descriptors
> <https://evlproject.org/core/user-api/poll/> " section of the EVL online
> documentation, the GPIO real-time I/O driver is not listed in the
> enumeration of pollable elements.
>
>  
>
> Is this true and the cause of the wrong behavior when using polled wait? If
> yes, could it be easily fixed?
>

The documentation only mentions EVL elements directly available from
user-space as individual resources, however this does not preclude other
resources created by drivers to be polled as well, which is the case for
GPIO lines. IOW, GPIO lines can be polled with evl_poll(), along with
any data source/sink which invokes evl_signal_poll_events() in the
kernel-side implementation.

A couple of questions:

- is there any message on the kernel console when the issue happens?

- does the system freeze entirely? If so, did you enable
  CONFIG_EVL_WATCHDOG to catch runaway threads?

Can you share a simple test code illustrating the issue? I would
definitely have a look at it.

[1] https://evlproject.org/core/build-steps/#core-kconfig

-- 
Philippe.

