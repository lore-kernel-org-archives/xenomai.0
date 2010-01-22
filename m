From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B59D952.30202@domain.hid>
References: <4B59D952.30202@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 22 Jan 2010 18:37:39 +0100
Message-ID: <1264181859.2350.152.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2010-01-22 at 17:58 +0100, Jan Kiszka wrote: 
> Hi guys,
> 
> we are currently trying to catch an ugly Linux pipeline state corruption
> on x86-64.
> 
> Conceptual question: If a Xenomai task causes a fault, we enter
> ipipe_trap_notify over the primary domain and leave it over the root
> domain, right? Now, if the root domain happened to be stalled when the
> exception happened, where should it normally be unstalled again,
> *for_that_task*? Our problem is that we generate a code path where this
> does not happen.

xnhadow_relax -> ipipe_reenter_root -> finish_task_switch ->
finish_lock_switch -> unstall

Since xnshadow_relax is called on behalf the event dispatcher, we should
expect it to return with the root domain unstalled after a domain
downgrade, from primary to root.

Normally.

> 
> Jan
> 


-- 
Philippe.




