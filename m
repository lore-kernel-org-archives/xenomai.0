Message-ID: <43B256F1.6070801@domain.hid>
Date: Wed, 28 Dec 2005 10:12:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] load librtdm without xeno_rtdm
References: <43AB1429.2090300@domain.hid>
In-Reply-To: <43AB1429.2090300@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
> Hi,
> 
> as suggested in an earlier mail, here is a patch that - as I think -
> improves the behaviour of librtdm. It will let applications start even
> if the kernel services of RTDM are not available. Instead, -ENODEV or
> -EAFNOSUPPORT will be returned in this case when the user tries to open
> some device or socket later - just like there is no appropriate driver
> loaded, which is actually true!
> 
> Please apply.

Applied, thanks.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: src/skins/rtdm/core.c
> ===================================================================
> --- src/skins/rtdm/core.c	(Revision 292)
> +++ src/skins/rtdm/core.c	(Arbeitskopie)
> @@ -18,6 +18,7 @@
>  
>  #include <stdarg.h>
>  #include <stddef.h>
> +#include <errno.h>
>  
>  #include <xenomai/rtdm/rtdm.h>
>  #include <xenomai/rtdm/syscall.h>
> @@ -27,19 +28,25 @@
>  
>  int rt_dev_open(const char *path, int oflag, ...)
>  {
> -  return XENOMAI_SKINCALL2( __rtdm_muxid,
> -                            __rtdm_open,
> -                            path,
> -                            oflag);
> +    if (__rtdm_muxid < 0)
> +        return -ENODEV;
> +
> +    return XENOMAI_SKINCALL2( __rtdm_muxid,
> +                              __rtdm_open,
> +                              path,
> +                              oflag);
>  }
>  
>  int rt_dev_socket(int protocol_family, int socket_type, int protocol)
>  {
> -  return XENOMAI_SKINCALL3( __rtdm_muxid,
> -                            __rtdm_socket,
> -                            protocol_family,
> -                            socket_type,
> -                            protocol);
> +    if (__rtdm_muxid < 0)
> +        return -EAFNOSUPPORT;
> +
> +    return XENOMAI_SKINCALL3( __rtdm_muxid,
> +                              __rtdm_socket,
> +                              protocol_family,
> +                              socket_type,
> +                              protocol);
>  }
>  
>  int rt_dev_close(int fd)
> Index: src/skins/rtdm/init.c
> ===================================================================
> --- src/skins/rtdm/init.c	(Revision 292)
> +++ src/skins/rtdm/init.c	(Arbeitskopie)
> @@ -53,9 +53,9 @@
>  	case -ENOSYS:
>  	case -ESRCH:
>  
> -	    fprintf(stderr,"Xenomai: RTDM skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
> -	    fprintf(stderr,"(modprobe xeno_rtdm.ko?)\n");
> -	    exit(1);
> +	    /* we ignore this and fail later when the user tries to open
> +	       a device or socket. */
> +	    break;
>  
>  	default:
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

