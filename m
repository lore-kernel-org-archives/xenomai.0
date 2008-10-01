Message-ID: <48E362DE.8080408@domain.hid>
Date: Wed, 01 Oct 2008 13:45:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48E35F06.10801@domain.hid>
In-Reply-To: <48E35F06.10801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] Fix CONFIG_IPIPE_DEBUG_CONTEXT in 2.0-12
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Philippe,
> 
> hunk below is missing from the merge of my topmost-stalled-warning patch
> -v2 into ipipe-git. This fixes CONFIG_IPIPE_DEBUG_CONTEXT build of
> ipipe-2.6.26-x86-2.0-12.
> 

Merged, thanks.

> Jan
> 
> ---
>  kernel/ipipe/core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: b/kernel/ipipe/core.c
> ===================================================================
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1571,6 +1571,7 @@ void __init ipipe_init_proc(void)
>  #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
>  
>  DEFINE_PER_CPU(int, ipipe_percpu_context_check) = { 1 };
> +DEFINE_PER_CPU(int, ipipe_saved_context_check_state);
>  
>  void ipipe_check_context(struct ipipe_domain *border_ipd)
>  {
> 


-- 
Philippe.

