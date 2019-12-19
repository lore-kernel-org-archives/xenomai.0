Subject: Re: [PATCH] powerpc: ipipe: Do full exit checks after
 __ipipe_call_mayday
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
Message-ID: <fd31a72f-ac46-034b-bfc6-4e125b4fde78@siemens.com>
Date: Thu, 19 Dec 2019 17:53:36 +0100
MIME-Version: 1.0
In-Reply-To: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
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
To: Steven Seeger <steven.seeger@flightsystems.net>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 19.12.19 17:46, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The mayday event tends to push us into root mode. So we must check
> __ipipe_root_p again afterwards.
> 
> This fixes the gdb synchronous stop test case in Xenomai.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Ho, ho, this is an early X-mas gift.
> 
>   arch/powerpc/kernel/ipipe.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ipipe.c b/arch/powerpc/kernel/ipipe.c
> index 30c56d922a2c..fefb0542acd8 100644
> --- a/arch/powerpc/kernel/ipipe.c
> +++ b/arch/powerpc/kernel/ipipe.c
> @@ -240,9 +240,7 @@ EXPORT_SYMBOL_GPL(ipipe_get_sysinfo);
>   
>   static int __ipipe_exit_irq(struct pt_regs *regs)
>   {
> -	int root = __ipipe_root_p;
> -
> -	if (root) {
> +	if (__ipipe_root_p) {
>   #ifdef CONFIG_PPC_970_NAP
>   		struct thread_info *ti = current_thread_info();
>   		/* Emulate the napping check when 100% sure we do run
> @@ -258,7 +256,8 @@ static int __ipipe_exit_irq(struct pt_regs *regs)
>   	if (user_mode(regs) && ipipe_test_thread_flag(TIP_MAYDAY))
>   		__ipipe_call_mayday(regs);
>   
> -	if (root && !test_bit(IPIPE_STALL_FLAG, &__ipipe_root_status))
> +	if (__ipipe_root_p &&
> +	    !test_bit(IPIPE_STALL_FLAG, &__ipipe_root_status))
>   		return 1;
>   
>   	return 0;
> 

Looking at DoSyscall in entry_32.S, it seems we lack such a careful 
check there as well. But that's too much assembly for me ATM.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

