From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4575A1E9.80105@domain.hid>
References: <45704CAB.5060502@domain.hid> <1164992204.4952.109.camel@domain.hid>
	<4575A1E9.80105@domain.hid>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 18:08:04 +0100
Message-Id: <1165424884.7218.148.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: libnative versioning
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

On Tue, 2006-12-05 at 17:44 +0100, Jan Kiszka wrote:
> Index: include/native/mutex.h
> ===================================================================
> --- include/native/mutex.h	(revision 1920)
> +++ include/native/mutex.h	(working copy)
> @@ -121,10 +121,6 @@ int rt_mutex_release(RT_MUTEX *mutex);
>  int rt_mutex_inquire(RT_MUTEX *mutex,
>  		     RT_MUTEX_INFO *info);
>  
> -#ifdef __cplusplus
> -}
> -#endif
> -
>  #ifdef __KERNEL__
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
>  static inline int __deprecated_call__ rt_mutex_lock(RT_MUTEX *mutex, RTIME timeout)
> @@ -146,4 +142,8 @@ int rt_mutex_unlock(RT_MUTEX *mutex);
>  
>  #endif /* __KERNEL__ */
>  
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif /* !_XENO_MUTEX_H */

Applied, thanks.

-- 
Philippe.



