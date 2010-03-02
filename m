Message-ID: <4B8D0359.4070504@domain.hid>
Date: Tue, 02 Mar 2010 13:23:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NmR5I-0003k9-N5@domain.hid>
In-Reply-To: <E1NmR5I-0003k9-N5@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Native: Fix return
 code of in-kernel rt_cond_wait[_until]
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
> Commit: f1dfda551b6997f74141986759932e2723a9f024
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=f1dfda551b6997f74141986759932e2723a9f024
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Tue Mar  2 13:17:35 2010 +0100
> 
> Native: Fix return code of in-kernel rt_cond_wait[_until]
> 
> In rt_cond_wait_inner, do not let rt_cond_wait_epilogue overwrite the
> primary error code of rt_cond_wait_prologue. This restores the in-kernel
> semantics of rt_cond_wait[_until] that were valid before 97323b3287.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
> ---
> 
>  ksrc/skins/native/cond.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ksrc/skins/native/cond.c b/ksrc/skins/native/cond.c
> index 10727d1..2dc0069 100644
> --- a/ksrc/skins/native/cond.c
> +++ b/ksrc/skins/native/cond.c
> @@ -472,10 +472,10 @@ static int rt_cond_wait_inner(RT_COND *cond, RT_MUTEX *mutex,
>  	err = rt_cond_wait_prologue(cond, mutex, &lockcnt, 
>  				    timeout_mode, timeout);
>  
> -	if(!err || err == -ETIMEDOUT || err == -EINTR)
> -		do {
> -			err = rt_cond_wait_epilogue(mutex, lockcnt);
> -		} while (err == -EINTR);
> +	if (!err || err == -ETIMEDOUT || err == -EINTR) {
> +		while (rt_cond_wait_epilogue(mutex, lockcnt) == -EINTR)
> +			; /* empty */
> +	}

Not ok. If rt_cond_wait_epilogue returns an error other than -EINTR, we
want this error to be returned.


-- 
					    Gilles.

