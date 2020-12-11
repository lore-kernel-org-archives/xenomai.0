Subject: Re: [PATCH] ipipe: export symbol of __ipipe_dispatch_irq
References: <20201207130418.6978-1-fino.meng@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <96f6e37a-c87f-ec90-b516-d9236ae8c7bb@siemens.com>
Date: Fri, 11 Dec 2020 07:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <20201207130418.6978-1-fino.meng@linux.intel.com>
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
To: Fino Meng <fino.meng@linux.intel.com>, xenomai@xenomai.org

On 07.12.20 14:04, Fino Meng via Xenomai wrote:
> some drivers referenced __ipipe_dispatch_irq may compile as kernel

More concretely, we are talking about ipipe_handle_demuxed_irq() which
contains __ipipe_dispatch_irq() - adjusting the commit message accordingly.

> module, which need __ipipe_dispatch_irq exported otherwise build will
> fail.
> 
> Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
> ---
>  kernel/ipipe/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index 60f74291f22a..99a88e4d620e 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1573,6 +1573,7 @@ void __ipipe_dispatch_irq(unsigned int irq, int flags) /* hw interrupts off */
>  sync:
>  	__ipipe_sync_pipeline(ipipe_head_domain);
>  }
> +EXPORT_SYMBOL_GPL(__ipipe_dispatch_irq);
>  
>  void ipipe_raise_irq(unsigned int irq)
>  {
> 

Affects 4.19 as well, so I'm also taking it there. And it affects all archs.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

