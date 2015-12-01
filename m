MIME-Version: 1.0
Date: Tue, 1 Dec 2015 11:35:23 +0600
Message-ID: <CAG7USP01084WJwhUF+24+BcGGyrvSkfs53U9xkOmxJ6-9=5n+A@mail.gmail.com>
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JPQtdGA0LDRgdGR0LI=?=
 <alexey.gerasev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Disabling shared IRQ line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone!

I have x86_64 PC with CAN adapter served by PLX PCI driver on board. I've
installed Xenomai 3.0.1 Cobalt on Linux kernel 3.16.7 with
ipipe-core-3.16.7-x86-5 patch. My CAN adapter has two channels, and they're
registered on one IRQ line (in my case it's 19). Shared interrupts were
enabled. When one channel is up and other is down, I have strange error:
when I sent 500 and received 500 frames through one channel interface, the
IRQ line became disabled with message: '[Xenomai] xnintr_vec_handler: IRQ19
not handled. Disabling IRQ line'. When both channels are up, there is no
such error.

I've found in 'xnintr_vec_handler' in 'xenomai-3/kernel/cobalt/intr.c' file
of xenomai source that if at least one handler on shared IRQ line returns
'XN_IRQ_NONE', then 'vec->unhandled' counter is incremented, and when it
reaches 1000, the corresponding IRQ line is disabled. In my case the
handler of the first channel, which is up, returns 'XN_IRQ_HANDLED' but the
second one, which is down, returns 'XN_IRQ_NONE'.

The question is: is this behavior in 'xnintr_vec_handler' correct? Do I
always need to enable both channels although I use only one of them?

Best regards,
Alexey
