Message-ID: <4958F420.7030109@domain.hid>
Date: Mon, 29 Dec 2008 17:00:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4958E439.9040503@domain.hid>
In-Reply-To: <4958E439.9040503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] Fix include for kernel/panic.c
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
> Not all archs include ipipe_trace.h implicitly so that bulding
> kernel/panic.c may break in oops_enter (seen on ARM with tracer
> disabled). Fix this with a proper include.
>

Thanks. Fix a bit earlier on ppc as well. I will push my tree soon now since
things seem to have gone back to normal wrt 2.6.27.

> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
> ---
>  kernel/panic.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: b/kernel/panic.c
> ===================================================================
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -21,6 +21,7 @@
>  #include <linux/debug_locks.h>
>  #include <linux/random.h>
>  #include <linux/kallsyms.h>
> +#include <linux/ipipe_trace.h>
>  
>  int panic_on_oops;
>  int tainted;
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.

