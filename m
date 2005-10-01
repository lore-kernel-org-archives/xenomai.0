Message-ID: <433E648A.1050203@domain.hid>
Date: Sat, 01 Oct 2005 12:27:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] PATCH: fail to compile with CONFIG_IPIPE=n
References: <433D1E21.70005@domain.hid>
In-Reply-To: <433D1E21.70005@domain.hid>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wen-chien Jesse Sung <jesse@domain.hid>
Cc: adeos-main@gna.org

Wen-chien Jesse Sung wrote:
> Hi,
> 
> When ipipe is disabled, ipipe_reset_stats() is not defined, but it is
> still referenced in init/main.c:rest_init().
> 
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> init/built-in.o: In function `rest_init':
> : undefined reference to `ipipe_reset_stats'
> make: *** [.tmp_vmlinux1] Error 1
> 

This one was already in my log; thanks anyway.

> 
> 
> ------------------------------------------------------------------------
> 
> Index: linux-2.6.13-js1/include/linux/ipipe.h
> ===================================================================
> --- linux-2.6.13-js1.orig/include/linux/ipipe.h	2005-09-30 14:53:01.000000000 +0800
> +++ linux-2.6.13-js1/include/linux/ipipe.h	2005-09-30 18:56:32.000000000 +0800
> @@ -702,6 +702,8 @@
>  #define ipipe_irq_lock(irq)	do { } while(0)
>  #define ipipe_irq_unlock(irq)	do { } while(0)
>  
> +#define ipipe_reset_stats()	do { } while(0)
> +
>  #endif	/* CONFIG_IPIPE */
>  
>  #endif	/* !__LINUX_IPIPE_H */
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

