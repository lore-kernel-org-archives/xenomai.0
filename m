Message-ID: <4B8D1B17.6000507@domain.hid>
Date: Tue, 02 Mar 2010 15:05:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>	<4B8C2490.1040604@domain.hid>
	<4B8C25B9.8090705@domain.hid>	<4B8C26F7.3020306@domain.hid>
	<4B8C2797.2000501@domain.hid>	<4B8C29E1.7070404@domain.hid>
	<4B8C2B3E.8020505@domain.hid>	<4B8C2C35.6030006@domain.hid>
	<4B8C2FE6.5000406@domain.hid>	<4B8C30DA.3000705@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE994@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE995@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2006483DE995@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> While I was debugging this problem, it looked like I could change ksrc/skins/native/cond.c by modifying the rt_cond_wait_inner function as follows:
> --- xenomai-2.5.1_bak/ksrc/skins/native/cond.c  2010-01-15 19:09:31.000000000 -0500
> +++ xenomai-2.5.1/ksrc/skins/native/cond.c      2010-03-01 17:17:22.000000000 -0500
> @@ -468,15 +468,22 @@
>  {
>         unsigned lockcnt;
>         int err;
> +        int err_save;
> 
>         err = rt_cond_wait_prologue(cond, mutex, &lockcnt,
>                                     timeout_mode, timeout);
> 
> +        err_save = err;
>         if(!err || err == -ETIMEDOUT || err == -EINTR)
>                 do {
>                         err = rt_cond_wait_epilogue(mutex, lockcnt);
>                 } while (err == -EINTR);
> 
> +        if (err_save == -ETIMEDOUT)
> +        {
> +          err = err_save;
> +        }
> +
>         return err;
>  }
>  /**

That is for in-kernel cond_wait only.

> 
> When I made these changes and put a printk in rt_cond_wait_inner also the printk did not get printed and the change above did not seem to make any difference.  So should I revert these changes or should they be made in addition to the syscall.c kernel and cond.c user space changes as follows:
> 
> --- xenomai-2.5.1_bak/ksrc/skins/native/syscall.c       2010-02-01 20:01:09.000000000 -0500
> +++ xenomai-2.5.1/ksrc/skins/native/syscall.c   2010-03-01 16:13:20.000000000 -0500
> @@ -1869,8 +1869,12 @@
> 
>         err = rt_cond_wait_prologue(cond, mutex, &lockcnt, timeout_mode, timeout);
> 
> -       if (err == 0 || err == -ETIMEDOUT)
> -               err = rt_cond_wait_epilogue(mutex, lockcnt);
> +        if (err == 0 || err == -ETIMEDOUT) {
> +                int loc_err = rt_cond_wait_epilogue(mutex, lockcnt);
> +                if (loc_err < 0)
> +                       err = loc_err;
> +        }
> +
> 
>         if (err == -EINTR && __xn_reg_arg3(regs)
>             && __xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
> 
> --- xenomai-2.5.1_bak/src/skins/native/cond.c   2010-01-15 19:09:32.000000000 -0500
> +++ xenomai-2.5.1/src/skins/native/cond.c       2010-03-01 16:44:48.000000000 -0500
> @@ -41,7 +41,7 @@                                                                  
>                                                                                    
>  int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)                   
>  {                                                                                 
> -       int saved_lockcnt, err;                                                    
> +  int saved_lockcnt, err, saved_err;                                              
>                                                                                    
>  #ifdef CONFIG_XENO_FASTSYNCH                                                      
>         saved_lockcnt = mutex->lockcnt;                                            
> @@ -49,7 +49,7 @@                                                                  
>         err = XENOMAI_SKINCALL5(__native_muxid,                                    
>                                 __native_cond_wait_prologue, cond, mutex,          
>                                 NULL, XN_RELATIVE, &timeout);                      
> -                                                                                  
> +        saved_err = err;                                                          
>         while (err == -EINTR)                                                      
>                 err = XENOMAI_SKINCALL2(__native_muxid,                            
>                                         __native_cond_wait_epilogue, mutex,        
> @@ -62,6 +62,7 @@                                                                  
>                                  __native_cond_wait_prologue, cond, mutex,         
>                                  &saved_lockcnt, XN_RELATIVE, &timeout);           
>                                                                                    
> +        saved_err = err;                                                          
>         while (err == -EINTR)                                                      
>                 err = XENOMAI_SKINCALL2(__native_muxid,                            
>                                         __native_cond_wait_epilogue, mutex,        
> @@ -69,12 +70,12 @@                                                                
>                                                                                    
>  #endif /* !CONFIG_XENO_FASTSYNCH */
> 
> -       return err;
> +       return saved_err;
>  }
> 
>  int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
>  {
> -       int saved_lockcnt, err;
> +  int saved_lockcnt, err, saved_err;
> 
>  #ifdef CONFIG_XENO_FASTSYNCH
>         saved_lockcnt = mutex->lockcnt;
> @@ -82,7 +83,7 @@
>         err = XENOMAI_SKINCALL5(__native_muxid,
>                                 __native_cond_wait_prologue, cond, mutex,
>                                 NULL, XN_REALTIME, &timeout);
> -
> +        saved_err = err;
>         while (err == -EINTR)
>                 err = XENOMAI_SKINCALL2(__native_muxid,
>                                         __native_cond_wait_epilogue, mutex,
> @@ -94,14 +95,14 @@
>         err = XENOMAI_SKINCALL5(__native_muxid,
>                                 __native_cond_wait_prologue, cond, mutex,
>                                 &saved_lockcnt, XN_REALTIME, &timeout);
> -
> +        saved_err = err;
>         while (err == -EINTR)
> -               err = -XENOMAI_SKINCALL2(__native_muxid,
> +               err = XENOMAI_SKINCALL2(__native_muxid,
>                                          __native_cond_wait_epilogue, mutex,
>                                          saved_lockcnt);
>  #endif /* !CONFIG_XENO_FASTSYNCH */
> 
> -       return err;
> +       return saved_err;
>  }
> 
>  int rt_cond_signal(RT_COND *cond)
> 

Yep, the easiest approach for you is to throw away the epilogue error
for now (just loop over -EINTR). That's what 2.4.x did as well. We are
still struggling with proper fixes for all corner cases.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

