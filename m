Subject: Re: [PATCH] cobalt/arm64: fpu: fixup for kernel 4.19+
References: <20190901092753.13425-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fb7449be-ead1-2161-b593-fc3fbe00589c@siemens.com>
Date: Sun, 1 Sep 2019 18:22:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190901092753.13425-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 01.09.19 11:27, Philippe Gerum wrote:
> Starting from kernel 4.19, we need to restore the FPU context from our
> scheduling tail.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/cobalt/arch/arm64/thread.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/cobalt/arch/arm64/thread.c b/kernel/cobalt/arch/arm64/thread.c
> index 270c99f92..719c30a62 100644
> --- a/kernel/cobalt/arch/arm64/thread.c
> +++ b/kernel/cobalt/arch/arm64/thread.c
> @@ -139,6 +139,9 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>   	(void)last;
>   #else
>   	switch_to(prev, next, last);
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0)
> +	fpsimd_restore_current_state();
> +#endif
>   #endif
>   }
>   
> 

Applied, thanks.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

