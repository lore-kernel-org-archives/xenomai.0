References: <20210918010850.23821-1-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] recipes-kernel: disable more debugs that influence
 latency performance
In-reply-to: <20210918010850.23821-1-hongzhan.chen@intel.com>
Date: Sat, 18 Sep 2021 10:10:36 +0200
Message-ID: <87h7ei1eyr.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>
Cc: xenomai@xenomai.org


Hongzhan Chen via Xenomai <xenomai@xenomai.org> writes:

> For dovetail-based xenomai, max lat may drop from 203.800 us
> to 9.807 us in 10 hours stressed latency test on Maxtang 8565U board
> with lava test.
>
> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
> index d7d87c5..29b3522 100644
> --- a/recipes-kernel/linux/files/common_nodbg.cfg
> +++ b/recipes-kernel/linux/files/common_nodbg.cfg
> @@ -1,2 +1,9 @@
>  # CONFIG_IPIPE_DEBUG is not set
>  # CONFIG_XENO_OPT_DEBUG is not set
> +# CONFIG_PROVE_LOCKING is not set
> +# CONFIG_DEBUG_RT_MUTEXES is not set
> +# CONFIG_DEBUG_SPINLOCK is not set
> +# CONFIG_DEBUG_MUTEXES is not set
> +# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> +# CONFIG_DEBUG_RWSEMS is not set
> +# CONFIG_DEBUG_LOCK_ALLOC is not set

Maybe it's time to backport the evl-check utility [1] from xenomai4 to
xenomai3, this is a very simple kconfig checker which helps in detecting
problematic settings. One just feeds it with a set of constraints like
[2] in order to perform such detection. FWIW, this command is documented
here.

[1] https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/utils/evl-check.c
[2]
https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/utils/kconf-checklist.evl
[3] https://evlproject.org/core/commands/#evl-check-command

-- 
Philippe.

