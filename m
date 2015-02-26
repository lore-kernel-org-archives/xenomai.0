From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
 <20150220225712.GE2356@hermes.click-hack.org>
 <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org>
Date: Thu, 26 Feb 2015 11:38:30 -0500
In-Reply-To: <54EF014A.9000902@xenomai.org> (Philippe Gerum's message of "Thu, 
 26 Feb 2015 12:19:38 +0100")
Message-ID: <447fv4sk55.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Your test code in user-space seems to enable the timing IRQ only for a
> very short time, between the write and read calls to the driver which
> happen in sequence.
>
> Those two interrupts are very close in the time line, i.e. 42 us:
>
> :|   +begin   0x90000000   -68	  0.960  __irq_svc+0x44
> (ipipe_unstall_root+0x88)
> ...
> :|  + begin   0x90000000   -26+   1.006  __irq_svc+0x44
> (__ipipe_restore_head+0xec)

My actual interrupts are (typically) 10 us apart. There are some
calculations that need to be made before writing the results into
hardware. Until now, my code had been doing all of that work in the ISR
itself to meet this timing requirement, but the non-real-time part of
the application was unable to keep up with filling the FIFOs into the
real-time portion, presumably because so much time was being spent with
interrupts disabled.

The CPU is a dual-core ARM (Cortex A-9) of which I have reserved one CPU
for the real-time operations. 

> The trace also reveals a proper wake up and rescheduling sequence from
> timestamp -51 and on:
>
> :|  # func                 -51+   1.178  top_half_isr+0x10
> [tut02_skeleton_drv] (xnintr_irq_handler+0x158)~
> :|  # func                 -50+   1.920  rtdm_event_signal+0x14
> (top_half_isr+0x2c [tut02_skeleton_drv])
> :|  # func                 -48+   2.139  xnsynch_flush+0x14
> (rtdm_event_signal+0x13c)
> :|  # func                 -46+   1.324  xnpod_resume_thread+0x14
> (xnsynch_flush+0x178)
> :|  # [    0] -<?>-    0   -44+   3.774  xnpod_resume_thread+0x140
> (xnsynch_flush+0x178)
>
> <snip>
>
> :|  # func                 -32+   1.523  __xnpod_schedule+0x14
> (xnintr_irq_handler+0x3a4)
> :|  # [    0] -<?>-   -1   -30	  0.953  __xnpod_schedule+0x1d4
> (xnintr_irq_handler+0x3a4)
>
> Then a second interrupt, which happens before the RTDM task had a chance
> to block on rtdm_event_wait() again, therefore no rescheduling has to
> take place since the RTDM task is still in ready state:
>
> :|  # func                 -12	  0.894  top_half_isr+0x10
> [tut02_skeleton_drv] (xnintr_irq_handler+0x158)
> :|  # func                 -11+   1.251  rtdm_event_signal+0x14
> (top_half_isr+0x2c [tut02_skeleton_drv])
> :|  # func                 -10+   1.860  xnsynch_flush+0x14
> (rtdm_event_signal+0x13c)
>
> Raising the debug flag we have added in the test driver right after
> simple_rtdm_read() shuts down the timing interrupt source instead, may
> confirm this assumption by looking at the generated traces.

Not quite; there were actually hundreds of interrupts (and corresponding
calls to the top half routine) registered in the short period of time
that the interrupt was enabled.

Having the task busy-wait (for example, with a spinlock) would be
reasonable, but in that case I might as well mask the interrupt entirely
and poll the hardware status. Perhaps I should try that; it would at
least tell me whether locking out interrupts for too long is really my
underlying problem (or not).

> Wouldn't this change make sense in the user code?
>
> --- attachment-0001.c~	2015-02-25 09:17:43.496445640 +0100
> +++ attachment-0001.c	2015-02-26 11:43:09.795191765 +0100
> @@ -70,8 +70,8 @@
>  	}
>
>          rt_dev_write(device, "h", 2);
> -        size = rt_dev_read (device, (void *)buf, 1024);
>          sleep(1);
> +        size = rt_dev_read (device, (void *)buf, 1024);
>          printf("%s: '%s'\n", __func__, buf);

That was the original code for that routine, in fact. The length of the
delay doesn't matter; I never see *any* wakeups of the task.

I had used a counting semaphore (to account for possibly missed
interrupts) in an earlier version of this code before changing it to an
event when I found that the semaphore didn't work. I also tried a direct
call to rtdm_task_unblock(), and that failed also.

Be well.
        Lowell


