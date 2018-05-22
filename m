MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 22 May 2018 11:31:34 -0700
Message-ID: <CA+K1mPGwUjmabtZFz0Taeinj22ACT2WJ3=fZADugRZj5Ua-05A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I think I may have found a bug in the rtl_16550A driver when using shared
interrupts. (I am on Xenomai 2.6.5. Kernel 3.18.20.)

I think the interrupt handler is not sending an EOI to the lower (ISA 8259)
interrupt controller, though it certainly is doing the right thing for
higher IRQs above 16.

I used a Moxa 4-port serial card in the PCI bus which has all 4 ports
sharing IRQ 17. The rtl_16550A driver can use all 4 ports OK.

But the rtl_16550A driver stalls after one interrupt when I use multiple
serial ports on my motherboard where all the serial ports share IRQ 5. This
is indicated by the fact that I can send one byte out the port, or I can
get a single byte into the port, before the port can no longer send or
receive anything further.

I diffed the Xenomai 3.0.5 source versus the 2.6.5 rtl_16550A.c source and
the code is very similar so the liability is in both branches I assume.

-C Smith
