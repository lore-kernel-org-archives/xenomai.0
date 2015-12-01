References: <CAG7USP01084WJwhUF+24+BcGGyrvSkfs53U9xkOmxJ6-9=5n+A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <565D4C05.7000907@siemens.com>
Date: Tue, 1 Dec 2015 08:28:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAG7USP01084WJwhUF+24+BcGGyrvSkfs53U9xkOmxJ6-9=5n+A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Disabling shared IRQ line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JPQtdGA0LDRgdGR0LI=?= <alexey.gerasev@gmail.com>, xenomai@xenomai.org

On 2015-12-01 06:35, Алексей Герасёв wrote:
> Hello everyone!
> 
> I have x86_64 PC with CAN adapter served by PLX PCI driver on board. I've
> installed Xenomai 3.0.1 Cobalt on Linux kernel 3.16.7 with
> ipipe-core-3.16.7-x86-5 patch. My CAN adapter has two channels, and they're
> registered on one IRQ line (in my case it's 19). Shared interrupts were
> enabled. When one channel is up and other is down, I have strange error:
> when I sent 500 and received 500 frames through one channel interface, the
> IRQ line became disabled with message: '[Xenomai] xnintr_vec_handler: IRQ19
> not handled. Disabling IRQ line'. When both channels are up, there is no
> such error.
> 
> I've found in 'xnintr_vec_handler' in 'xenomai-3/kernel/cobalt/intr.c' file
> of xenomai source that if at least one handler on shared IRQ line returns
> 'XN_IRQ_NONE', then 'vec->unhandled' counter is incremented, and when it
> reaches 1000, the corresponding IRQ line is disabled. In my case the
> handler of the first channel, which is up, returns 'XN_IRQ_HANDLED' but the
> second one, which is down, returns 'XN_IRQ_NONE'.
> 
> The question is: is this behavior in 'xnintr_vec_handler' correct? Do I
> always need to enable both channels although I use only one of them?

No, this is a regression of aefaab5d03. I'll push a patch to fix this to
my upstream queue. Thanks for reporting!

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

