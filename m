Message-ID: <4DCCBCC1.4090207@domain.hid>
Date: Fri, 13 May 2011 07:08:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTim1tWxvzUx2gUwLbQVbob4tRqbCFw@domain.hid>
In-Reply-To: <BANLkTim1tWxvzUx2gUwLbQVbob4tRqbCFw@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

On 05/13/2011 03:25 AM, arethe rtai wrote:
> HI all:
>        I always got null while I request a shared memory through RTAI
> skins in the user space.
>        Some bugs maybe exist in the sub-system. I traced the execution
> stream of rt_shm_alloc, and found the mmap() operation always return
> -22. I suspect the problem should be same while we use other skins,
> because the mmap operation is implemented in /ksrc/nucleus/heap.c.
>        Is there anyone encountered this problem?

This is the third time you post this incomplete report. See:
http://www.xenomai.org/index.php/Request_for_information

If you want to receive an answer. Because in xenomai 2.5 branch, each
process maps a shared memory when starting. So, if shared memory were
not working, no xenomai process would work, not even the latency test.

-- 
                                                                Gilles.

