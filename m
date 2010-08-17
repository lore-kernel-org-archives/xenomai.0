Message-ID: <4C6A6FE7.6030508@domain.hid>
Date: Tue, 17 Aug 2010 13:17:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Deadlock-prone ipipe_critical_enter
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Hi,

it turned out ipipe_critical_enter is broken on SMP > 2 CPUs: On one
CPU, Linux may have acquired an rwlock for reading when being preempted
by the critical IPI. On some other CPU, Linux may have entered
write_lock_irq[save] before the IPI arrived. The reader will be stuck in
__ipipe_do_critical_sync, the writer in __write_lock_failed - forever.
First seen on real silicon (once per "few" hundreds of boots), finally
caught under KVM and nailed down.

Two approaches to resolve this issue come to my mind so far. The first
one is to restart the whole ipipe_critical_enter after some (how many?)
cycles of futile waiting. The other is to accept the critical IPI even
if the top-most domain is stalled (as it sits in write_lock_irq), but
I'm not 100% that our optimistic IRQ mask will always allow this when
Linux is on the top (I assume we can safely require other domains to
avoid such deadlocks by design).

Comments? Better ideas?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

