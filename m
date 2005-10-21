Message-ID: <43592876.10001@domain.hid>
Date: Fri, 21 Oct 2005 19:42:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] rtdm without CONFIG_XENO_OPT_PERVASIVE
References: <43581E3B.7050005@domain.hid>
In-Reply-To: <43581E3B.7050005@domain.hid>
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Hi,
> 
> this fixes an unresolved symbol in xeno_rtdm when
> CONFIG_XENO_OPT_PERVASIVE is switched off.
>

Applied, thanks.


> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: skins/rtdm/device.c
> ===================================================================
> --- skins/rtdm/device.c	(Revision 53)
> +++ skins/rtdm/device.c	(Arbeitskopie)
> @@ -30,7 +30,6 @@
>  
>  #include <rtdm/device.h>
>  #include <rtdm/proc.h>
> -#include <rtdm/syscall.h>
>  
>  
>  #define SET_DEFAULT_OP(device, operation)                               \
> @@ -68,6 +67,12 @@
>  #endif /* CONFIG_SMP */
>  
>  
> +int rtdm_no_support(void)
> +{
> +    return -ENOSYS;
> +}
> +
> +
>  static inline int get_name_hash(const char *str, int limit, int hashkey_mask)
>  {
>      int hash = 0;
> Index: skins/rtdm/GNUmakefile.am
> ===================================================================
> --- skins/rtdm/GNUmakefile.am	(Revision 53)
> +++ skins/rtdm/GNUmakefile.am	(Arbeitskopie)
> @@ -10,9 +10,12 @@
>  	device.c \
>  	drvlib.c \
>  	module.c \
> -	proc.c \
> -	syscall.c
> +	proc.c
>  
> +if CONFIG_XENO_OPT_PERVASIVE
> +libmodule_SRC += syscall.c
> +endif
> +
>  include_HEADERS = \
>  	rtdm.h \
>  	rtdm_driver.h \
> Index: skins/rtdm/device.h
> ===================================================================
> --- skins/rtdm/device.h	(Revision 53)
> +++ skins/rtdm/device.h	(Arbeitskopie)
> @@ -40,6 +40,8 @@
>  extern struct list_head *rtdm_protocol_devices;
>  
>  
> +int rtdm_no_support(void);
> +
>  struct rtdm_device *get_named_device(const char *name);
>  struct rtdm_device *get_protocol_device(int protocol_family, int socket_type);
>  
> Index: skins/rtdm/syscall.c
> ===================================================================
> --- skins/rtdm/syscall.c	(Revision 53)
> +++ skins/rtdm/syscall.c	(Arbeitskopie)
> @@ -26,12 +26,6 @@
>  int __rtdm_muxid;
>  
>  
> -int rtdm_no_support(void)
> -{
> -    return -ENOSYS;
> -}
> -
> -
>  static int sys_rtdm_fdcount(struct task_struct *curr, struct pt_regs *regs)
>  {
>      return fd_count;
> Index: skins/rtdm/syscall.h
> ===================================================================
> --- skins/rtdm/syscall.h	(Revision 53)
> +++ skins/rtdm/syscall.h	(Arbeitskopie)
> @@ -46,8 +46,6 @@
>  extern int __rtdm_muxid;
>  
>  
> -int rtdm_no_support(void);
> -
>  int __init rtdm_syscall_init(void);
>  
>  static inline void rtdm_syscall_cleanup(void)
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

