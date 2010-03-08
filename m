Message-ID: <4B9533D9.7050203@domain.hid>
Date: Mon, 08 Mar 2010 18:28:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <mailman.4536.1268063545.8399.xenomai-git@xenomai.org>
In-Reply-To: <mailman.4536.1268063545.8399.xenomai-git@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [Xenomai-git] posix: fix pthread_cond_*wait return
	value overwriting
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

xenomai-git-request@domain.hid wrote:
> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
> index 6c3ec3a..2a97a2d 100644
> --- a/ksrc/skins/posix/syscall.c
> +++ b/ksrc/skins/posix/syscall.c
> @@ -1520,7 +1520,7 @@ static int __pthread_cond_wait_prologue(struct pt_regs *regs)
>  	union __xeno_mutex mx, *umx;
>  	unsigned timed, count;
>  	struct timespec ts;
> -	int err;
> +	int err, perr = 0;
>  
>  	ucnd = (union __xeno_cond *)__xn_reg_arg1(regs);
>  	umx = (union __xeno_mutex *)__xn_reg_arg2(regs);
> @@ -1560,7 +1560,10 @@ static int __pthread_cond_wait_prologue(struct pt_regs *regs)
>  						    &mx.shadow_mutex,
>  						    &count, timed, XN_INFINITE);
>  
> -	if (err == 0 || err == ETIMEDOUT) {
> +	switch(err) {
> +	case 0:
> +	case ETIMEDOUT:
> +		perr = errno = err;
>  		err = -pse51_cond_timedwait_epilogue(cur, &cnd.shadow_cond,
>  					    	    &mx.shadow_mutex, count);
>  		if (err == 0 &&
> @@ -1569,14 +1572,20 @@ static int __pthread_cond_wait_prologue(struct pt_regs *regs)
>  					   &mx.shadow_mutex.lockcnt,
>  					   sizeof(umx->shadow_mutex.lockcnt)))
>  			return -EFAULT;
> +		break;
> +
> +	case EINTR:
> +		perr = err;

Minor cleanup: This is not needed as err != 0, so perr will not be
evaluated anymore. Same for native.

> +		errno = 0;	/* epilogue should return 0. */
> +		break;
>  	}
>  
> -	if (err == EINTR
> -	    && __xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
> -				      &count, sizeof(count)))
> +	if (err == EINTR 
> +	    &&__xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
> +				     &count, sizeof(count)))
>  			return -EFAULT;
> -	
> -	return -err;
> +
> +	return err == 0 ? -perr : -err;
>  }
>  
>  /* pthread_cond_wait_epilogue(cond, mutex, count) */

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

