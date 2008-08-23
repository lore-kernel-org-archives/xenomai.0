Message-ID: <48AFDF2F.7050802@domain.hid>
Date: Sat, 23 Aug 2008 11:58:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48AFCCED.30102@domain.hid>
In-Reply-To: <48AFCCED.30102@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Remove redundant LOCK prefix
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> According to Linux and the Intel spec, this prefix is not needed.
>

Obviously, it's not, since the whole purpose of xchg() is to guarantee bus
locking for memory operands anyway. Please merge.

> ---
>  include/asm-x86/atomic_32.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/include/asm-x86/atomic_32.h
> ===================================================================
> --- a/include/asm-x86/atomic_32.h
> +++ b/include/asm-x86/atomic_32.h
> @@ -64,7 +64,7 @@ struct __xeno_xchg_dummy { unsigned long
>  static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
>  						unsigned long x)
>  {
> -	__asm__ __volatile__(LOCK_PREFIX "xchgl %0,%1"
> +	__asm__ __volatile__("xchgl %0,%1"
>  			     :"=r" (x)
>  			     :"m" (*__xeno_xg(ptr)), "0" (x)
>  			     :"memory");
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

