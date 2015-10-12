References: <20151011130536.GA1765@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <561B6002.3010409@siemens.com>
Date: Mon, 12 Oct 2015 09:23:46 +0200
MIME-Version: 1.0
In-Reply-To: <20151011130536.GA1765@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue with CONFIG_PREEMPT_VOLUNTARY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2015-10-11 15:05, Gilles Chanteperdrix wrote:
> Hi,
> 
> It seems commit fdb5d54d04b8c3b6b6a6ad7ac2b6248cf0b415e0 in the
> I-pipe kernels cause a warning when CONFIG_PREEMPT_VOLUNTARY and
> CONFIG_IPIPE_DEBUG_INTERNAL are enabled. The culprit is the call to
> __ipipe_root_p.

Compiler warning? Runtime warning? Which architecture? I assume that
ftrace is on then, right?

> 
> The following patch avoids this warning:

How?

> 
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index 0320453..a5e440d 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1730,17 +1730,19 @@ int notrace __ipipe_check_percpu_access(void)
>  	if (raw_irqs_disabled_flags(flags))
>  		goto out;
>  
> +	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> +		goto out;
> +

This approach looks a bit odd, but I simply may not understand it yet.
We need to know what it actually aims at, i.e. which line causes the
error you see.

>  	/*
>  	 * Last chance: hw interrupts were enabled on entry while
>  	 * running over the root domain, but the root stage might be
>  	 * currently stalled, in which case preemption would be
>  	 * disabled, and no migration could occur.
>  	 */
> -	if (this_domain == ipipe_root_domain) {

This test is indeed redundant, but removing it should be a separate
patch with a commit log referring to the test that is not visible in the
context.

> -		p = raw_cpu_ptr(&ipipe_percpu.root);
> -		if (test_bit(IPIPE_STALL_FLAG, &p->status) || preempt_count())
> +
> +	p = raw_cpu_ptr(&ipipe_percpu.root);
> +	if (test_bit(IPIPE_STALL_FLAG, &p->status) || preempt_count())
>  			goto out;

You probably want to adjust the indention of this line then.

> -	}
>  	/*
>  	 * Our caller may end up accessing the wrong per-cpu variable
>  	 * instance due to CPU migration; tell it to complain about
> 
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

