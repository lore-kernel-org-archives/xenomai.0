Message-ID: <507528E4.4050809@xenomai.org>
Date: Wed, 10 Oct 2012 09:51:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr>	<505EBD61.1050009@wanadoo.fr>	<505F0D40.9030105@xenomai.org>	<50741C5B.4060206@wanadoo.fr>
	<5074986C.8000509@xenomai.org> <50749A03.9090607@xenomai.org>
	<50749C71.2020100@xenomai.org> <5075260E.2050402@wanadoo.fr>
In-Reply-To: <5075260E.2050402@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org

On 10/10/2012 09:38 AM, Thierry Bultel wrote:
> Hi Gilles,
> 
> Many thanks,
> The first patch does not work, the second does.
> I think the reason for 1st patch why is that in rtcan_virt, we have
> 
> rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
> rtdm_lock_get(&rtcan_socket_lock);
> 
> ...
> --->        rtcan_rcv(rx_dev, &skb);
> ....
> 
> rtdm_lock_put(&rtcan_socket_lock);
> rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
> 
> and rtcan_rcv->rtcan_rcv_deliver->rtdm_sem_up(&sock->recv_sem);
> 
> thus the same re-scheduling stuff with interrupts locked.
> 
> Are you not not afraid of side effects with the second patch, 
> since you change the overall behaviour ?
> Won't you prefer a only locally modified rtcan_virt ?

We should ask Jan's opinion. In any case, if we adopt the second patch,
we might want to try and reduce the overhead of xnpod_unlock_sched.

-- 
					    Gilles.

