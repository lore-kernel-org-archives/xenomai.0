Subject: Re: [PATCH] recipes-kernel: disable more debugs that influence
 latency performance
References: <20210918010850.23821-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <03ef3a34-bd9b-3490-b688-cf31cb1da467@siemens.com>
Date: Tue, 5 Oct 2021 15:09:54 +0200
MIME-Version: 1.0
In-Reply-To: <20210918010850.23821-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 18.09.21 03:08, Hongzhan Chen via Xenomai wrote:
> For dovetail-based xenomai, max lat may drop from 203.800 us
> to 9.807 us in 10 hours stressed latency test on Maxtang 8565U board
> with lava test.
> 

Signed-off missing. And please tag such patches with
"[xenomai-images][PATCH]...".

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
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

