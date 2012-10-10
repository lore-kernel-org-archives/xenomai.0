Message-ID: <5075260E.2050402@wanadoo.fr>
Date: Wed, 10 Oct 2012 09:38:54 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr>	<505EBD61.1050009@wanadoo.fr>	<505F0D40.9030105@xenomai.org>	<50741C5B.4060206@wanadoo.fr>
	<5074986C.8000509@xenomai.org> <50749A03.9090607@xenomai.org>
	<50749C71.2020100@xenomai.org>
In-Reply-To: <50749C71.2020100@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Many thanks,
The first patch does not work, the second does.
I think the reason for 1st patch why is that in rtcan_virt, we have

rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
rtdm_lock_get(&rtcan_socket_lock);

...
--->        rtcan_rcv(rx_dev, &skb);
....

rtdm_lock_put(&rtcan_socket_lock);
rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);

and rtcan_rcv->rtcan_rcv_deliver->rtdm_sem_up(&sock->recv_sem);

thus the same re-scheduling stuff with interrupts locked.

Are you not not afraid of side effects with the second patch,=20
since you change the overall behaviour ?
Won't you prefer a only locally modified rtcan_virt ?

eg something (not tested) like:

    xnpod_lock_sched()
    rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
    rtdm_lock_get(&rtcan_socket_lock);

...

                rtcan_rcv(rx_dev, &skb);

....

    rtdm_lock_put(&rtcan_socket_lock);
    rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
    xnpod_unlock_sched()

Cheers
Thierry


Le 09/10/2012 23:51, Gilles Chanteperdrix a =C3=A9crit :
> On 10/09/2012 11:41 PM, Gilles Chanteperdrix wrote:
>
>> Another possible fix would be to lock xenomai scheduler when taking an
>> rtdm_spin_lock, as it is almost always wrong to call xnpod_schedule in
>> such a situation. It works for other RT-CAN drivers, because they call
>> rtdm_sem_up from interrupt context where the scheduler is locked by th=
e
>> XNINIRQ bit.
>>
>
> IOW, something like:
>
> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
> index 68135e4..7b18c34 100644
> --- a/include/rtdm/rtdm_driver.h
> +++ b/include/rtdm/rtdm_driver.h
> @@ -730,6 +730,7 @@ typedef unsigned long rtdm_lockctx_t;
>  	do {							\
>  		XENO_BUGON(RTDM, !rthal_local_irq_disabled());	\
>  		rthal_spin_lock(lock);				\
> +		xnpod_lock_sched();				\
>  	} while (0)
>  #endif
> =20
> @@ -749,7 +750,11 @@ typedef unsigned long rtdm_lockctx_t;
>   *
>   * Rescheduling: never.
>   */
> -#define rtdm_lock_put(lock)	rthal_spin_unlock(lock)
> +#define rtdm_lock_put(lock)					\
> +	do {							\
> +		rthal_spin_unlock(lock);			\
> +		xnpod_unlock_sched();				\
> +	} while (0)
> =20
>  /**
>   * Acquire lock and disable preemption
> @@ -768,8 +773,11 @@ typedef unsigned long rtdm_lockctx_t;
>   *
>   * Rescheduling: never.
>   */
> -#define rtdm_lock_get_irqsave(lock, context)	\
> -	rthal_spin_lock_irqsave(lock, context)
> +#define rtdm_lock_get_irqsave(lock, context)				\
> +	do {								\
> +		rthal_spin_lock_irqsave(lock, context);			\
> +		xnpod_lock_sched();					\
> +	} while (0)
> =20
>  /**
>   * Release lock and restore preemption state
> @@ -788,8 +796,12 @@ typedef unsigned long rtdm_lockctx_t;
>   *
>   * Rescheduling: possible.
>   */
> -#define rtdm_lock_put_irqrestore(lock, context)	\
> -	rthal_spin_unlock_irqrestore(lock, context)
> +#define rtdm_lock_put_irqrestore(lock, context)			\
> +	do {							\
> +		rthal_spin_unlock(lock);			\
> +		xnpod_unlock_sched();				\
> +		rthal_local_irq_restore(context);		\
> +	} while (0)
> =20
>  /**
>   * Disable preemption locally
>
>
>


