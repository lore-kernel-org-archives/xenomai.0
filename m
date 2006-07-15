Subject: Re: [Xenomai-help] do memory functions switch to secondary mode ?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F9354@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F9354@domain.hid>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 03:38:10 +0200
Message-Id: <1152927490.5027.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2006-07-11 at 14:27 +0200, Roderik_Wildenburg@domain.hid wrote:
> Does any of the memory functions like :
> memcopy,
> memset,
> bzero,
> 
> :
> :
> 
> cause Xenomai to switch to secondary mode ?

No, unless a page fault is raised as a result of treading on the target
memory.

> I am asking as I have a high priority task, which mesures its
> periodicity (set to 1ms).
> This task is using just rt_-functions and memcpy.
> When in low priority tasks memory intensively is used (memset,
> rt_heap_alloc, rt_heap_create, NFS-transfers in Linux threads), the
> cycle time of the high priority task inreases to nearly twice the time
> it has been set up (2ms++; at least 1 time, as I just measure maxima).
> 
> Is this possible, or am I doing something wrong ?
> 

Do you observe this weird behaviour at the same time the kernel emits
allocation failure messages?

> Tanks a lot
> Roderik
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



