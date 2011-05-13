From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <BANLkTim1tWxvzUx2gUwLbQVbob4tRqbCFw@domain.hid>
References: <BANLkTim1tWxvzUx2gUwLbQVbob4tRqbCFw@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 May 2011 08:50:02 +0200
Message-ID: <1305269402.2147.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] I suspect the shared memory of Xenomai has bug.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: arethe rtai <arethe.rtai@domain.hid>
Cc: Xenomai-core@domain.hid

On Fri, 2011-05-13 at 09:25 +0800, arethe rtai wrote:
> HI all:
>        I always got null while I request a shared memory through RTAI
> skins in the user space.
>        Some bugs maybe exist in the sub-system. I traced the execution
> stream of rt_shm_alloc, and found the mmap() operation always return
> -22. I suspect the problem should be same while we use other skins,
> because the mmap operation is implemented in /ksrc/nucleus/heap.c.
>        Is there anyone encountered this problem?

No. The fact is that the RTAI skin has not been actively maintained for
years now, so a local bug there is possible. Due to the lack of users
and interest, this skin was removed from the upcoming 2.6.x series.

> Regards Arethe.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



