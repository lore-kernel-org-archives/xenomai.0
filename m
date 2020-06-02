Subject: Re: an xhci problem on raspberry pi 4b
References: <5ed4bf2d.1c69fb81.29f0f.b36cSMTPIN_ADDED_BROKEN@mx.google.com>
 <CALLqZ8QXO7zg7a7qAFkSSHnY9jcv2bQs3L+cWNomYqBFS=Kz2A@mail.gmail.com>
 <0d8b0098-16b6-1ba1-029a-2e642624967e@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5ED6132A.9090909@tj.kylinos.cn>+D1E144A43DE1BE2E
Date: Tue, 2 Jun 2020 16:51:54 +0800
MIME-Version: 1.0
In-Reply-To: <0d8b0098-16b6-1ba1-029a-2e642624967e@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>



On 2020年06月02日 15:49, Jan Kiszka wrote:
> On 01.06.20 15:51, Greg Gallagher via Xenomai wrote:
>> I'm not sure if the rpi4 is in mainline yet but you may have more
>> success trying this with the mainline kernel
>>
>
> The RPi4 is still far aways from mainline, unfortunately. The usual
> downstream mess.

any thought about "[    0.712926] irq 38 handler xhci_msi_irq+0x0/0x30 
enabled interrupts " in kernel/irq/handle.c:153?

call stack is like：irqs_diabled -- raw_irqs_diabled -- 
arch_irqs_diabled -- ipipe_test_root

Not handled msi irq domain(Brcm_MSI) approprately?
>
> Jan
>



