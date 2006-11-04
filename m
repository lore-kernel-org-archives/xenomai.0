Subject: Re: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <454B345A.9050606@domain.hid>
References: <4548C170.1000504@domain.hid> <4548F8BE.90809@domain.hid>
	<454901B6.80606@domain.hid> <454B0FA0.9080307@domain.hid>
	<454B1363.8080805@domain.hid> <454B15C5.1050803@domain.hid>
	<454B17A1.7000805@domain.hid>  <454B345A.9050606@domain.hid>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 15:30:18 +0100
Message-Id: <1162650618.4978.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Fri, 2006-11-03 at 13:21 +0100, Jan Kiszka wrote:

[...]

> This patch fixes the issue for me.
> 
> Jan
> plain text document attachment (disable-mmx_memcpy.patch)
> ---
>  arch/i386/lib/mmx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.17.13/arch/i386/lib/mmx.c
> ===================================================================
> --- linux-2.6.17.13.orig/arch/i386/lib/mmx.c
> +++ linux-2.6.17.13/arch/i386/lib/mmx.c
> @@ -32,7 +32,7 @@ void *_mmx_memcpy(void *to, const void *
>  	void *p;
>  	int i;
>  
> -	if (unlikely(in_interrupt()))
> +	if (unlikely(!ipipe_root_domain_p || in_interrupt()))
>  		return __memcpy(to, from, len);
>  
>  	p = to;

Merged, thanks.

-- 
Philippe.



