Message-ID: <54EF014A.9000902@xenomai.org>
Date: Thu, 26 Feb 2015 12:19:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
 <20150220225712.GE2356@hermes.click-hack.org>
 <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
In-Reply-To: <44vbipk8m9.fsf@be-well.ilk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 02/25/2015 10:02 PM, Lowell Gilbert wrote:
> Lowell Gilbert <kludge@be-well.ilk.org> writes:
> 
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> # echo 1024 > /proc/ipipe/trace/back_trace_points
>>>
>>> Then run the test. The output of /proc/ipipe/trace/frozen may help in
>>> figuring out what happens.
>>
>> I haven't had a chance to look at it yet, but it's in:
>>
>>   http://be-well.ilk.org/~lowell/projects/ipipe.trace.output.txt
> 
> I've got another one that seems more helpful:
> http://be-well.ilk.org/~lowell/projects/xenomai/ipipe.trace2.output.txt
> 

Your test code in user-space seems to enable the timing IRQ only for a
very short time, between the write and read calls to the driver which
happen in sequence.

Those two interrupts are very close in the time line, i.e. 42 us:

:|   +begin   0x90000000   -68	  0.960  __irq_svc+0x44
(ipipe_unstall_root+0x88)
...
:|  + begin   0x90000000   -26+   1.006  __irq_svc+0x44
(__ipipe_restore_head+0xec)

The trace also reveals a proper wake up and rescheduling sequence from
timestamp -51 and on:

:|  # func                 -51+   1.178  top_half_isr+0x10
[tut02_skeleton_drv] (xnintr_irq_handler+0x158)~
:|  # func                 -50+   1.920  rtdm_event_signal+0x14
(top_half_isr+0x2c [tut02_skeleton_drv])
:|  # func                 -48+   2.139  xnsynch_flush+0x14
(rtdm_event_signal+0x13c)
:|  # func                 -46+   1.324  xnpod_resume_thread+0x14
(xnsynch_flush+0x178)
:|  # [    0] -<?>-    0   -44+   3.774  xnpod_resume_thread+0x140
(xnsynch_flush+0x178)

<snip>

:|  # func                 -32+   1.523  __xnpod_schedule+0x14
(xnintr_irq_handler+0x3a4)
:|  # [    0] -<?>-   -1   -30	  0.953  __xnpod_schedule+0x1d4
(xnintr_irq_handler+0x3a4)

Then a second interrupt, which happens before the RTDM task had a chance
to block on rtdm_event_wait() again, therefore no rescheduling has to
take place since the RTDM task is still in ready state:

:|  # func                 -12	  0.894  top_half_isr+0x10
[tut02_skeleton_drv] (xnintr_irq_handler+0x158)
:|  # func                 -11+   1.251  rtdm_event_signal+0x14
(top_half_isr+0x2c [tut02_skeleton_drv])
:|  # func                 -10+   1.860  xnsynch_flush+0x14
(rtdm_event_signal+0x13c)

Raising the debug flag we have added in the test driver right after
simple_rtdm_read() shuts down the timing interrupt source instead, may
confirm this assumption by looking at the generated traces.

Wouldn't this change make sense in the user code?

--- attachment-0001.c~	2015-02-25 09:17:43.496445640 +0100
+++ attachment-0001.c	2015-02-26 11:43:09.795191765 +0100
@@ -70,8 +70,8 @@
 	}

         rt_dev_write(device, "h", 2);
-        size = rt_dev_read (device, (void *)buf, 1024);
         sleep(1);
+        size = rt_dev_read (device, (void *)buf, 1024);
         printf("%s: '%s'\n", __func__, buf);


-- 
Philippe.

