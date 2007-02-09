Subject: Re: [Xenomai-core] [PATCH] Fix warnings for kernel 2.4 builds
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45CC3866.8070706@domain.hid>
References: <45CC3866.8070706@domain.hid>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 10:16:18 +0100
Message-Id: <1171012579.25642.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2007-02-09 at 10:01 +0100, Jan Kiszka wrote:
> Index: include/asm-generic/wrappers.h
> ===================================================================
> --- include/asm-generic/wrappers.h	(Revision 2167)
> +++ include/asm-generic/wrappers.h	(Arbeitskopie)
> @@ -257,8 +257,6 @@ unsigned long __va_to_kva(unsigned long 
>  					   &(p)->pending.signal, \
>  					   &(p)->signal->shared_pending.signal)
>  
> -#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
> -
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,20)
>  #define DECLARE_WORK_NODATA(f, n)	DECLARE_WORK(f, n, NULL)
>  #define DECLARE_WORK_FUNC(f)		void f(void *cookie)
> @@ -267,4 +265,6 @@ unsigned long __va_to_kva(unsigned long 
>  #define DECLARE_WORK_FUNC(f)		void f(struct work_struct *work)
>  #endif /* >= 2.6.20 */
>  
> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
> +
>  #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
> 

Merged, thanks.

-- 
Philippe.



