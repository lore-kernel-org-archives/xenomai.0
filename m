References: <20170504165257.6915-1-henning.schild@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bce08bc3-cb12-3067-a2be-f1b6c89fc7ab@xenomai.org>
Date: Fri, 5 May 2017 16:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170504165257.6915-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] x86/ipipe: fix compilation for x86_32
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org
Cc: Michael Smith <2michael.smith@gmail.com>

On 05/04/2017 06:52 PM, Henning Schild wrote:
> AMD MCE is just relevant for the 64Bit case and causes linking problems
> for 32.
> 
> Reported-by: Michael Smith <2michael.smith@gmail.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  arch/x86/kernel/ipipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index b207502..e3f5dc0 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -134,7 +134,7 @@ void __init __ipipe_enable_pipeline(void)
>  			  __ipipe_ack_apic);
>  #endif
>  
> -#ifdef CONFIG_X86_MCE_AMD
> +#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_X86_64)
>  	ipipe_request_irq(ipipe_root_domain,
>  			  ipipe_apic_vector_irq(DEFERRED_ERROR_VECTOR),
>  			  __ipipe_do_IRQ, smp_deferred_error_interrupt,
> 

Merged, thanks.

-- 
Philippe.

