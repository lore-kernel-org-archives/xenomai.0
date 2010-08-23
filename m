Message-ID: <4C724E56.7000202@domain.hid>
Date: Mon, 23 Aug 2010 12:32:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <mailman.63.1282557625.26045.xenomai-git@xenomai.org>
In-Reply-To: <mailman.63.1282557625.26045.xenomai-git@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai-git Digest, Vol 17, Issue 18
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
> Module: xenomai-2.5
> Branch: master
> Commit: edaf1e2e54343b6e4bf5cf6ece9175ec0ab21cad
> URL:    http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=edaf1e2e54343b6e4bf5cf6ece9175ec0ab21cad
> 
> Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Date:   Sun Aug 22 15:37:11 2010 +0200
> 
> Do not assume that XN_NO_HANDLE is NULL
> 
> ---
> 
>  src/skins/common/current.c |    1 +
>  src/skins/native/mutex.c   |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/skins/common/current.c b/src/skins/common/current.c
> index 7f36991..4e75690 100644
> --- a/src/skins/common/current.c
> +++ b/src/skins/common/current.c
> @@ -46,6 +46,7 @@ static inline int create_current_key(void)
>  
>  static inline void __xeno_set_current(xnhandle_t current)
>  {
> +	current = (current == XN_NO_HANDLE ? current : (xnhandle_t)(0));

I think you meant "!=" here.

Jan

>  	pthread_setspecific(xeno_current_key, (void *)current);
>  }
>  
> diff --git a/src/skins/native/mutex.c b/src/skins/native/mutex.c
> index 55d502f..8e2a57c 100644
> --- a/src/skins/native/mutex.c
> +++ b/src/skins/native/mutex.c
> @@ -76,7 +76,7 @@ static int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout, xntmode_t mode
>  	xnhandle_t cur;
>  
>  	cur = xeno_get_current();
> -	if (!cur)
> +	if (cur == XN_NO_HANDLE)
>  		return -EPERM;
>  
>  	if (likely(!(xeno_get_current_mode() & XNRELAX))) {
> @@ -140,7 +140,7 @@ int rt_mutex_release(RT_MUTEX *mutex)
>  	xnhandle_t cur;
>  
>  	cur = xeno_get_current();
> -	if (!cur)
> +	if (cur == XN_NO_HANDLE)
>  		return -EPERM;
>  
>  	if (unlikely(xnsynch_fast_owner_check(mutex->fastlock, cur) != 0))
> 

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

