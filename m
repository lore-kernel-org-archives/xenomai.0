Message-Id: <A04AB540-BCCC-43EA-8B4F-47DE9AEC8E04@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49AFA197.9090704@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 5 Mar 2009 06:45:27 -0500
References: <67b6b3430903041631p107682bdyf5d5fb9c0e70d86d@domain.hid>
	<49AFA197.9090704@domain.hid>
Subject: Re: [Xenomai-help] ipipe error
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

> Additionally, what happens if you stop asking rt_task_set_mode() to  
> clear
> primary mode via toggling the T_PRIMARY flag? (which you should very  
> likely NOT
> do, btw. Forcing the current mode is counter-productive most of the  
> time; this
> is an internal feature for very, very specific needs of some Xenomai  
> library code).

I am not even sure why that code is there. it's around a call to  
rt_queue_read() which will go to primary mode anyway. Perhaps it is  
left over from some debug mode. I'll ask Mark to remove it.

Thanks for he tip.

Steven


