Message-ID: <4CEE91CB.3060303@domain.hid>
Date: Thu, 25 Nov 2010 17:41:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [git pull] Updates for ipipe-2.6.35-x86
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

The following changes since commit 00b6a9994fe4d8c978a9a56d20d01c49fde0a2c3:

  Merge branch 'ipipe-2.6.35-noarch' into ipipe-2.6.35-x86 (2010-11-05 13:59:15 +0100)

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.35-x86

[edited changelog]
Jan Kiszka (8):
      ipipe: Provide wrapper for IRQ mask/unmask at chip level
      ipipe: Drop spurious irq_enter/exit from __ipipe_sync_stage
      ipipe: Provide __ipipe_spin_trylock_irq for !CONFIG_IPIPE
      Merge commit 'v2.6.35.9' into queues/2.6.35-noarch
      Merge branch 'queues/2.6.35-noarch' into queues/2.6.35-x86
      ipipe: x86-32: Drop IRQ flag virtualization from syscall/interrupt entry/exit
      ipipe: x86: Push IF as set to stack of root IRQ handlers
      ipipe: x86: Fix up root state after __do_root_[vx]irq under CONFIG_TRACE_IRQFLAGS

Will follow up with the x86-specific ipipe patches for review.

