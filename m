Message-ID: <4B8D323C.5050306@domain.hid>
Date: Tue, 02 Mar 2010 16:43:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NmUAX-0004WJ-Eq@domain.hid>
In-Reply-To: <E1NmUAX-0004WJ-Eq@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Native: Work around
 for error code corruption in rt_cond_wait[ _until]
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: 4b5370dce6f3a655ac104b93b032f3b639206fd5
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=4b5370dce6f3a655ac104b93b032f3b639206fd5
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Tue Mar  2 16:24:59 2010 +0100
> 
> Native: Work around for error code corruption in rt_cond_wait[_until]
> 
> User space suffers from losing the error code of the cond wait prologue.
> We actually had to return the prologue error to user space and use that
> one after the epilogue succeeded, but the existing kernel ABI does not
> allow this, nor is existing user space prepared for this.
> 
> As a work around, keep the prologue error code in xnthread's errcode and
> restore it from there when user space re-enters the kernel for the
> epilogue. This requires no ABI changes, but suffers from potential
> overwriting if the same or some other errcode touching service is called
> from a user space signal handler in between the calls. Moreover, current
> user space also prevents that we can return -EINTR on interruption while
> blocked on the condition variable, which was possible before.
> 
> A true fix will require a new syscall and updated user space libs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
> ---
> 
>  ksrc/skins/native/syscall.c |   19 +++++++++++++++----
>  1 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
> index 462ee7e..930a28d 100644
> --- a/ksrc/skins/native/syscall.c
> +++ b/ksrc/skins/native/syscall.c
> @@ -1841,7 +1841,7 @@ static int __rt_cond_wait_prologue(struct pt_regs *regs)
>  	RT_MUTEX *mutex;
>  	RT_COND *cond;
>  	RTIME timeout;
> -	int err;
> +	int err, epilogue_err;
>  
>  	if (__xn_safe_copy_from_user(&cph, (void __user *)__xn_reg_arg1(regs),
>  				     sizeof(cph)))
> @@ -1868,11 +1868,15 @@ static int __rt_cond_wait_prologue(struct pt_regs *regs)
>  		return -EFAULT;
>  
>  	err = rt_cond_wait_prologue(cond, mutex, &lockcnt, timeout_mode, timeout);
> +	xnpod_current_thread()->errcode = err;
>  
>  	/* Reacquire the mutex if it was unlocked in the prologue and we were
>  	   not interrupted. */
> -	if (lockcnt && err != -EINTR)
> -		err = rt_cond_wait_epilogue(mutex, lockcnt);
> +	if (lockcnt && err != -EINTR) {
> +		epilogue_err = rt_cond_wait_epilogue(mutex, lockcnt);
> +		if (!err)
> +			err = epilogue_err;

IMO, Here should be:
		if (epilogue_err < 0)
			err = epilogue_err;

-- 
					    Gilles.


