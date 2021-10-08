Subject: Re: [xenomai-images][PATCH] recipes-kernel: Disable more debugs that
 influence latency performance
References: <20211008024047.24581-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c9428eb4-de20-fcdc-bed5-07e42aa2960d@siemens.com>
Date: Fri, 8 Oct 2021 10:10:05 +0200
MIME-Version: 1.0
In-Reply-To: <20211008024047.24581-1-hongzhan.chen@intel.com>
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

On 08.10.21 04:40, Hongzhan Chen via Xenomai wrote:
> For dovetail-based Xenomai, some debugs may increase latency and
> need to disable them for better latency performance.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
> index d7d87c5..a57463b 100644
> --- a/recipes-kernel/linux/files/common_nodbg.cfg
> +++ b/recipes-kernel/linux/files/common_nodbg.cfg
> @@ -1,2 +1,9 @@
>  # CONFIG_IPIPE_DEBUG is not set
>  # CONFIG_XENO_OPT_DEBUG is not set
> +# CONFIG_DEBUG_VM is not set
> +# CONFIG_DEBUG_LIST is not set
> +# CONFIG_BUG_ON_DATA_CORRUPTION is not set
> +# CONFIG_FTRACE is not set
> +# CONFIG_PROVE_LOCKING is not set
> +# CONFIG_DEBUG_LOCK_ALLOC is not set
> +# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

