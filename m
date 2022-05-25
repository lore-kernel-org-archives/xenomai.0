MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 24 May 2022 17:17:49 -0700
Message-ID: <CA+K1mPGZhf9Rg+ywyoffiy+jn0BuM_n7D4C7exyS5MKQK+UW6Q@mail.gmail.com>
Subject: 16550A IRQ not enabled
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

We are using Xenomai 3.1.2 on kernel 4.19.229, X86 CPU
We have a (Moxa CP-104ul) serial card on an isolated PCI bus interrupt 17.
lspci -v confirms that the serial card is isolated and that no other
peripheral uses this interrupt.

We have the 16550A serial driver loaded, and an external serial device
trying to initiate a serial connection, but no interrupts are being
generated. The interrupt counter in /proc/xenomai/irq stay at 0.

[user@device~]$ cat /proc/xenomai/irq
  IRQ         CPU0        CPU1        CPU2        CPU3
   17:           0           0           0           0         rtser2
rtser3 rtser4 rtser5

As an experiment: if we enable the Azalia sound chip in the BIOS, and
load its Alsa sound driver, the Serial card will then share IRQ 17
with that sound chip, and then the serial card works. The serial
interrupt counter is incrementing in /proc/xenomai/irq and our serial
peripheral can utilize the serial port OK.

We don't want the sound driver enabled, but this test indicates that
16550A somehow failed to enable its interrupt, whereas the sound
driver succeeded in doing so.

How can we check a PIC, etc. to verify that the serial interrupt is
truly enabled when the 16550A driver is loaded alone?

