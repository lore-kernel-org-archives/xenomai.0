Message-ID: <4C6A742B.2000506@domain.hid>
Date: Tue, 17 Aug 2010 13:36:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C6A6FE7.6030508@domain.hid> <4C6A70D7.4040306@domain.hid>
	<4C6A73D0.3040401@domain.hid>
In-Reply-To: <4C6A73D0.3040401@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Deadlock-prone ipipe_critical_enter
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Hi,
>>>
>>> it turned out ipipe_critical_enter is broken on SMP > 2 CPUs: On one
>>> CPU, Linux may have acquired an rwlock for reading when being preempted
>>> by the critical IPI. On some other CPU, Linux may have entered
>>> write_lock_irq[save] before the IPI arrived. The reader will be stuck in
>>> __ipipe_do_critical_sync, the writer in __write_lock_failed - forever.
>>> First seen on real silicon (once per "few" hundreds of boots), finally
>>> caught under KVM and nailed down.
>>>
>>> Two approaches to resolve this issue come to my mind so far. The first
>>> one is to restart the whole ipipe_critical_enter after some (how many?)
>>> cycles of futile waiting. The other is to accept the critical IPI even
>>> if the top-most domain is stalled (as it sits in write_lock_irq), but
>>> I'm not 100% that our optimistic IRQ mask will always allow this when
>>> Linux is on the top (I assume we can safely require other domains to
>>> avoid such deadlocks by design).
>>>
>>> Comments? Better ideas?
>> I guess, the rwlocks are ipipe rwlocks, right?
> 
> Nope, plain Linux tasklist_lock. No Xenomai domain active at this point,
> just Linux.

Then how could this happen? Is not the critical IPI always able to
preempt Linux?

-- 
					    Gilles.

