Message-ID: <4CEE8FF0.6000704@domain.hid>
Date: Thu, 25 Nov 2010 17:33:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Subject: [Adeos-main] [git pull] Updates for ipipe-2.6.36-noarch
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

The following changes since commit 4c83ab8e3ac5b194695e38bbc253f78e6072ad24:

  ipipe: tell __ipipe_run_irqtail about the latest IRQ number (2010-11-05 13:52:55 +0100)

are available in the git repository at:
  git://git.kiszka.org/ipipe-2.6 queues/2.6.35-noarch

[edited log]
Jan Kiszka (4):
      ipipe: Provide wrapper for IRQ mask/unmask at chip level
      ipipe: Drop spurious irq_enter/exit from __ipipe_sync_stage
      ipipe: Provide __ipipe_spin_trylock_irq for !CONFIG_IPIPE
      Merge commit 'v2.6.35.9' into queues/2.6.35-noarch

Will follow up with the ipipe specific patches for review.

