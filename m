Message-ID: <49B634F1.2040101@domain.hid>
Date: Tue, 10 Mar 2009 10:37:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <67b6b3430903091727o4a60a28ay91c7ba35ad7d08ef@domain.hid>
In-Reply-To: <67b6b3430903091727o4a60a28ay91c7ba35ad7d08ef@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_write return 1, with no receiver
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
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Mark Saiia wrote:
> Hello all,
> 
> Running Xenomai 2.4.7 w/ linux 2.6.27.19 on Geode GX1.
> 
> We are writing to a queue.  This write is returning a 1, and we
> believe that there is no corresponding read pending.  Are the API docs
> correct in regards to the return value of rt_queue_write?

Yes, the docs are correct, and the code looks sane as well. You may want to 
double-check your findings using rt_queue_inquire() before calling 
rt_queue_write(), even if this won't be 100% reliable in case your reader is 
polling the queue.

   Has anyone
> seen anything related to this issue?
> 
> Thanks,
> 
> Mark
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

