Message-ID: <4891E83A.9060208@domain.hid>
Date: Thu, 31 Jul 2008 18:28:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48760BCD.3080505@domain.hid>
In-Reply-To: <48760BCD.3080505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] Provide owner name via
	rt_mutex_inquire
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

Jan Kiszka wrote:
> This can be helpful for debugging the (futile) release attempts of
> mutexes by tasks that do not own them.
> 
> Returning the RT_TASK reference may appear more consistent on first
> sight, but it cannot be guaranteed that the owner is actually a native
> task. Therefore this patch uses the symbolic name.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 

Applied to the trunk/, thanks.

PS: no 2.4.x backport due to the ABI breakage this involves.

---
>  include/native/mutex.h    |    3 +++
>  ksrc/skins/native/mutex.c |    5 +++++
>  2 files changed, 8 insertions(+)
> 
> Index: b/include/native/mutex.h
> ===================================================================
> --- a/include/native/mutex.h
> +++ b/include/native/mutex.h
> @@ -38,6 +38,9 @@ typedef struct rt_mutex_info {
>  
>  	char name[XNOBJECT_NAME_LEN]; /**< Symbolic name. */
>  
> +	char owner[XNOBJECT_NAME_LEN]; /**< Symbolic name of the current owner,
> +					    empty if unlocked. */
> +
>  } RT_MUTEX_INFO;
>  
>  typedef struct rt_mutex_placeholder {
> Index: b/ksrc/skins/native/mutex.c
> ===================================================================
> --- a/ksrc/skins/native/mutex.c
> +++ b/ksrc/skins/native/mutex.c
> @@ -597,6 +597,11 @@ int rt_mutex_inquire(RT_MUTEX *mutex, RT
>  	strcpy(info->name, mutex->name);
>  	info->lockcnt = mutex->lockcnt;
>  	info->nwaiters = xnsynch_nsleepers(&mutex->synch_base);
> +	if (mutex->lockcnt)
> +		strcpy(info->owner,
> +		       xnthread_name(xnsynch_owner(&mutex->synch_base)));
> +	else
> +		info->owner[0] = 0;
>  
>        unlock_and_exit:
>  
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

