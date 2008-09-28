From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 28 Sep 2008 23:21:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809282321.25635.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Problems using rt_intr_wait on PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

Based on the user_irq.c I created a simple test program for my PPC405GPr 
board.

We have a FPGA which generates an interrupt every millisecond.
It seems to work as simple test (fire it once and assure that it
sets the interrupt-bit).

When I connect it to the irq_server however (letting the main task
sleep 1 second) I get around 2321964 error and not a single OK from 
rt_intr_wait.
Also my debug LED flicker very fast.
The FPGA is connected to the External Interrupt 0, which has the number 25.

I think that I either got the polarity/level/edge register wrong or
I am playing with the wrong interrupt.

Could anybody tell me, whether I used the correct interrupt number?
Does Linux somewhere overwrite the values for the UIC polarity/level, etc
settings written by U-Boot (e.g. for my board in board_early_init_f)

Any hints are welcome.

Best regards

-- 
NIklaus Giger


