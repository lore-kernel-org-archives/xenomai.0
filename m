Message-ID: <43B3D9FD.802@domain.hid>
Date: Thu, 29 Dec 2005 13:43:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] fixing modprobe hint in libs
References: <43B26C65.7020807@domain.hid>
In-Reply-To: <43B26C65.7020807@domain.hid>
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
> this patches fixes the hint a user sees when trying to start some
> RT-application without the related core service being available. Might
> be frustrating for a newbie if the suggested command fails...
> 

Applied, thanks.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: src/skins/uvm/init.c
> ===================================================================
> --- src/skins/uvm/init.c	(Revision 304)
> +++ src/skins/uvm/init.c	(Arbeitskopie)
> @@ -56,7 +56,7 @@
>  	case -ESRCH:
>  
>  	    fprintf(stderr,"Xenomai: UVM skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
> -	    fprintf(stderr,"(modprobe xeno_uvm.ko?)\n");
> +	    fprintf(stderr,"(modprobe xeno_uvm?)\n");
>  	    exit(1);
>  
>  	default:
> Index: src/skins/rtai/init.c
> ===================================================================
> --- src/skins/rtai/init.c	(Revision 304)
> +++ src/skins/rtai/init.c	(Arbeitskopie)
> @@ -53,7 +53,7 @@
>  	case -ESRCH:
>  
>  	    fprintf(stderr,"Xenomai: RTAI skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
> -	    fprintf(stderr,"(modprobe xeno_rtai.ko?)\n");
> +	    fprintf(stderr,"(modprobe xeno_rtai?)\n");
>  	    exit(1);
>  
>  	default:
> Index: src/skins/posix/init.c
> ===================================================================
> --- src/skins/posix/init.c	(Revision 304)
> +++ src/skins/posix/init.c	(Arbeitskopie)
> @@ -59,7 +59,7 @@
>  	case -ESRCH:
>  
>  	    fprintf(stderr,"Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
> -	    fprintf(stderr,"(modprobe xeno_posix.ko?)\n");
> +	    fprintf(stderr,"(modprobe xeno_posix?)\n");
>  	    exit(1);
>  
>  	default:
> Index: src/skins/native/init.c
> ===================================================================
> --- src/skins/native/init.c	(Revision 304)
> +++ src/skins/native/init.c	(Arbeitskopie)
> @@ -65,7 +65,7 @@
>  	case -ESRCH:
>  
>  	    fprintf(stderr,"Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
> -	    fprintf(stderr,"(modprobe xeno_native.ko?)\n");
> +	    fprintf(stderr,"(modprobe xeno_native?)\n");
>  	    exit(1);
>  
>  	default:
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

