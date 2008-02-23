Resent-To: Xenomai-core@domain.hid
Resent-Message-Id: <47C0246E.6020005@domain.hid>
Message-ID: <47C020A9.3050704@domain.hid>
Date: Sat, 23 Feb 2008 14:33:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 0/4] Fixes and improvements around xnlock
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi,

I'm happy to announce a patch series which actually started like "hey,
let's check if we can have this nice FIFO ticket spinlock algorithm also
for our recursive xnlock." The result is a critical bug fix and a
massive text size reduction of nucleus and skins, both concerning SMP
systems. Furthermore, there are now optional ticket locks available for
larger SMP boxes. :)

This series consists of

 1. Refactoring of asm-generic/system.h
    (+ some optimization of xnlock_get)

 2. SMP-critical memory barrier fix for xnlock_put
    (+ optimization for production code)

 3. Uninlining of xnlock_get_irqsave/xnlock_put_irqrestore on SMP
    (xeno_nucleus text, x86-64, non-debug: 112482 -> 79453 bytes!)

 4. Optional FIFO ticket spinlock for strict deterministic spin times
    on xnlocks (still highly experimental!)

The second patch is stable stuff, so we should merge 1+2 into 2.4.x as well.

Jan




