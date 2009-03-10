Message-Id: <3B2A832D-D5D2-401B-A091-04B46F6DCF09@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49B634F1.2040101@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 10 Mar 2009 14:21:19 -0400
References: <67b6b3430903091727o4a60a28ay91c7ba35ad7d08ef@domain.hid>
	<49B634F1.2040101@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write return 1, with no receiver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

The reader waits forever (TM_INFINITE) on the queue. We used values  
from rt_timer_read() to timestamp some logging messages that go out  
another queue to confirm that the reader thread is busy and not  
reading from the queue. We get a log at time x1 before we do the  
write, and then another time value at x2 before we do the read. The  
higher priority thread is doing the writing.

Hopefully it's a problem with our testing.

Steven

On Mar 10, 2009, at 5:37 AM, Philippe Gerum wrote:

> Mark Saiia wrote:
>> Hello all,
>>
>> Running Xenomai 2.4.7 w/ linux 2.6.27.19 on Geode GX1.
>>
>> We are writing to a queue.  This write is returning a 1, and we
>> believe that there is no corresponding read pending.  Are the API  
>> docs
>> correct in regards to the return value of rt_queue_write?
>
> Yes, the docs are correct, and the code looks sane as well. You may  
> want to
> double-check your findings using rt_queue_inquire() before calling
> rt_queue_write(), even if this won't be 100% reliable in case your  
> reader is
> polling the queue.
>
>   Has anyone
>> seen anything related to this issue?
>>
>> Thanks,
>>
>> Mark
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>
>
> -- 
> Philippe.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


