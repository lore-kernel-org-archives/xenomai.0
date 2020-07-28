Date: Tue, 28 Jul 2020 18:13:54 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH][4.19] x86: ipipe: Harden racy path in __fpu__restore_sig
Message-ID: <20200728181354.10bfe537@md1za8fc.ad001.siemens.net>
In-Reply-To: <5d66a318-89d9-1866-95d6-c0aafb7a4481@siemens.com>
References: <5d66a318-89d9-1866-95d6-c0aafb7a4481@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, 28 Jul 2020 17:53:10 +0200
Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is needed because I-pipe can interrupt at a point where
> fpu->initialized is already set but the (internally hardened)
> fpu__restore() was not run yet. As the context switch uses
> 'initialized' to decide whether to activate the FPU for the target
> thread, we may prematurely activate it.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> I'm still struggling to find out what all could go wrong for us. The 
> patch originates from 4.4 where this missing protection triggers a 
> warning, and more was missing (https://lkml.org/lkml/2020/7/24/932).

LGTM, and i am afraid i have no clue what else could go wrong.

Henning

>  arch/x86/kernel/fpu/signal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c
> b/arch/x86/kernel/fpu/signal.c index d99a8ee9e185..ea846a28300a 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -315,6 +315,7 @@ static int __fpu__restore_sig(void __user *buf,
> void __user *buf_fx, int size)
>  		 * header. Validate and sanitize the copied state.
>  		 */
>  		struct user_i387_ia32_struct env;
> +		unsigned long flags;
>  		int err = 0;
>  
>  		/*
> @@ -345,8 +346,10 @@ static int __fpu__restore_sig(void __user *buf,
> void __user *buf_fx, int size) }
>  
>  		local_bh_disable();
> +		flags = hard_cond_local_irq_save();
>  		fpu->initialized = 1;
>  		fpu__restore(fpu);
> +		hard_cond_local_irq_restore(flags);
>  		local_bh_enable();
>  
>  		return err;


