Message-ID: <4B5CCF35.2040402@domain.hid>
Date: Sun, 24 Jan 2010 23:52:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B5B02E3.8060103@domain.hid>
In-Reply-To: <4B5B02E3.8060103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] x86: Fix root domain state
 restoring on exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> If we enter __ipipe_handle_exception over a non-root domain and leave it
> due to migration in the event handler over root, we must not restore the
> root domain state so far saved on entry. This caused subtle pipeline
> state corruptions. Actually, we only need to save the state if we enter
> over the root domain and have to align its state to the hardware
> interrupt mask.
> 
> Moreover, the x86-32 regs.eflags fix-up must happen based on the current
> root domain state to avoid more spurious corruptions.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> 
> This patch is so far running fine on the x86-64 boxes of our colleagues
> @Healthcare. It currently makes most sense to me, also for (untested)
> x86-32, but maybe I'm still missing a problematic scenario.
> 
>  arch/x86/kernel/ipipe.c |   64 ++++++++++++++++++++++++++--------------------
>  1 files changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index 4442d96..8253993 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -702,19 +702,17 @@ static int __ipipe_xlate_signo[] = {
>  
>  int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>  {
> -	unsigned long flags;
> -
> -	/* Pick up the root domain state of the interrupted context. */
> -	local_save_flags(flags);
> +	bool restore_flags = false;
> +	unsigned long flags = 0;
>  
> -	if (ipipe_root_domain_p) {
> +	if (ipipe_root_domain_p && irqs_disabled_hw()) {

I really do not understand this hunk. It differs a lot from the current
situation. In the current situation __fixup_if really does something,
even if irqs were not masked on entry.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

