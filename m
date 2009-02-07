Message-ID: <498D56C7.7020504@domain.hid>
Date: Sat, 07 Feb 2009 10:39:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090204141542.GA9557@domain.hid>	<20090204161903.GA27688@domain.hid>
	<20090205093528.GC11556@domain.hid>
In-Reply-To: <20090205093528.GC11556@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] posix shm problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Schouten <tom@domain.hid>
Cc: xenomai@xenomai.org

Tom Schouten wrote:
> Hello,
> 
> I tried with a different kernel .config (right.config) which made the 
> userspace posix shm problem go away.  The significant difference I can see 
> is this:
> 
> ## cat right.config |grep SHM
> CONFIG_SHMEM=y
> # CONFIG_TINY_SHMEM is not set
> # CONFIG_XENO_OPT_POSIX_SHM is not set

Ok. In this case, you use Linux' shared memories, not xenomai's.

There is something I do not understand, though. Is right.config the
config that you use with 2.4.4 too ? Just to know if the problem comes
from recent changes or has always been there.

> 
> 
> ## cat wrong.config |grep SHM
> CONFIG_SHMEM=y
> # CONFIG_TINY_SHMEM is not set
> CONFIG_XENO_OPT_POSIX_SHM=y
> 
> Cheers,
> Tom
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
					    Gilles.

