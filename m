Message-ID: <47BE8E0E.7060104@domain.hid>
Date: Fri, 22 Feb 2008 09:55:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200802202358.25792.ngustavson@domain.hid>	<200802210944.56033.ngustavson@domain.hid>	<47BD9763.1040304@domain.hid>
	<200802212145.31122.ngustavson@domain.hid>
In-Reply-To: <200802212145.31122.ngustavson@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] writing from user space through fifo problems
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <metalninjadragon@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

NZG wrote:
> On Thursday 21 February 2008 10:23:15 am Jan Kiszka wrote:
>> That's good. This test will also allow you to check it against
>>  - more recent Xenomai (please check the Changelog for pipe-related
>>    changes since 2.3.1, I bet there are a few)
>>  - some other arch, specifically x86 (IIRC, there is still some Linux
>>    scheduling artifact left in the I-pipe patch for blackfin, but it
>>    shouldn't make a difference here - well, who knows...)
> Well, in the process of writing a simple test I kindof found the problem.
> My user space program is writing and then immediatly closing, which appears to 
> destroy the data if it hasn't been read by then. Inserting a sleep between 
> write and close causes it to work.
>

Yes, releasing a fildes flushes the input queue from lingering data
before closing the user-space side.

> I noticed this because my test program was working because it just so happened 
> to pause until the real time task ended before closing the fd.
> 
> I remember doing this before, now that it's figured out, but it's still kind 
> of problematic because it doesn't appear to be possible to block on user 
> space writes.
> 
> Opening with O_SYNC does not cause it to block, and fsync(fd) doesn't seem to 
> do anything.

O_SYNC support has to be implemented by the driver, and Xenomai
implements this for the pipe driver since 2.4-rc1. Therefore, passing
O_SYNC to open() using 2.3.1 will just lead to a nop.

 anybody have any suggestions on how to know data has been
> received before closing a pipe after a write? Surely somebody's done this 
> before.
> 

The only way I see with 2.3.1 would be to make a non-realtime shadow
from your user-space thread (rt_task_shadow() with priority 0), then
have it pend on a Xenomai semaphore signaled by your real-time task when
it has consumed the packet.

> thanks,
> NZG
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

