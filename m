Subject: Re: [PATCH 5/6] x86/ipipe: fix build with CONFIG_X86_UV enabled
References: <20200907130938.416831-1-rpm@xenomai.org>
 <20200907130938.416831-5-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e9de4ff9-49e6-6e3b-e578-0c3a17008b75@siemens.com>
Date: Mon, 7 Sep 2020 16:45:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200907130938.416831-5-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 07.09.20 15:09, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  arch/x86/kernel/ipipe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index 3f3afcecc1b9..c5ebfdf2dfb3 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -72,6 +72,7 @@ void smp_irq_move_cleanup_interrupt(struct pt_regs *regs);
>  void smp_reboot_interrupt(void);
>  void smp_thermal_interrupt(struct pt_regs *regs);
>  void smp_threshold_interrupt(struct pt_regs *regs);
> +void uv_bau_message_interrupt(struct pt_regs *regs);
>  
>  void __ipipe_do_IRQ(unsigned int irq, void *cookie);
>  
> 

IIRC, I broke that intentionally. There is more needed, and no one
should get something building but subtly not working. But we may better do

    depends on !IPIPE

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

