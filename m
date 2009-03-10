Message-Id: <D8EB3A02-F76F-442A-8B0D-7F26D4E16D16@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49B634F1.2040101@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 10 Mar 2009 14:57:03 -0400
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

> Yes, the docs are correct, and the code looks sane as well. You may  
> want to
> double-check your findings using rt_queue_inquire() before calling
> rt_queue_write(), even if this won't be 100% reliable in case your  
> reader is
> polling the queue.


Philippe,

We took your advice and tried rt_queue_inquire(). If we use a timeout  
on the read, It seems there are always 3 waiters, which is strange  
because we have only one thread reading from the queue. If we remove  
the timout, there is either 1 or 2 waiters. It got 0 waiters once and  
still hung. Very strange.

Thanks,
Steven


