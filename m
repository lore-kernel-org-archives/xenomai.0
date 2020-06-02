Subject: Re: an xhci problem on raspberry pi 4b
References: <5ed4bf2d.1c69fb81.29f0f.b36cSMTPIN_ADDED_BROKEN@mx.google.com>
 <CALLqZ8QXO7zg7a7qAFkSSHnY9jcv2bQs3L+cWNomYqBFS=Kz2A@mail.gmail.com>
 <0d8b0098-16b6-1ba1-029a-2e642624967e@siemens.com>
 <5ED6132A.9090909@tj.kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bc265a74-3c9f-d4ac-3455-45849e42e484@siemens.com>
Date: Tue, 2 Jun 2020 11:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <5ED6132A.9090909@tj.kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chensong <chensong@tj.kylinos.cn>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 02.06.20 10:51, chensong wrote:
> 
> 
> On 2020年06月02日 15:49, Jan Kiszka wrote:
>> On 01.06.20 15:51, Greg Gallagher via Xenomai wrote:
>>> I'm not sure if the rpi4 is in mainline yet but you may have more
>>> success trying this with the mainline kernel
>>>
>>
>> The RPi4 is still far aways from mainline, unfortunately. The usual
>> downstream mess.
> 
> any thought about "[    0.712926] irq 38 handler xhci_msi_irq+0x0/0x30
> enabled interrupts " in kernel/irq/handle.c:153?
> 
> call stack is like：irqs_diabled -- raw_irqs_diabled --
> arch_irqs_diabled -- ipipe_test_root
> 
> Not handled msi irq domain(Brcm_MSI) approprately?

Often this means that some code path along the early interrupt handling
is not I-pipe aware (un-hardened spinlock etc.). Did you already try
enabling all I-pipe debug options?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

