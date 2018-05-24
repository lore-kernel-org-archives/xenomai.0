References: <CA+K1mPEPjyR4=qiE-dYCMvNp1HykLbPiMnjyBR4380of0vsHow@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <86fe1167-ae9d-32c8-6505-a89fc1da4695@siemens.com>
Date: Thu, 24 May 2018 09:34:32 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPEPjyR4=qiE-dYCMvNp1HykLbPiMnjyBR4380of0vsHow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 2018-05-24 09:24, C Smith wrote:
> Jan Kiska wrote:
>> Just like under Linux, the driver does not have to worry about that
>> details. Xenomai will EOI the IRQ when needed. The driver handler just
>> need to tell if a particular invocation was (also) triggered by the
>> device it drives.
> 
> I trust the EOI is taken care of automatically, as you say.
> 
> However I am on a special industrial motherboard whose BIOS allows the use
> of IRQ 5 for certain serial ports. There is no mistake, I chose IRQ 5 in
> the BIOS (only choices are 5 and 10, but 10 conflicts with a PCI card).
> Here is the kernel's dmesg at boot:
> [    0.536089] 00:05: ttyS1 at I/O 0x2f8 (irq = 5, base_baud = 115200) is a
> 16550A
> Here is setserial /dev/ttyS1 after boot:
> /dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 5
> 
> When xeno_16550A module is invoked with one of the ports on IRQ 5 like this:
> xeno_16550A io=0x02e0,0x02f8,0x3f8 irq=10,5,4 baud_base=115200,115200,115200
> The port at 0x02f8 IRQ 5 behaves fine and transmits and receives OK.
> 
> But when the xeno_16550A module is invoked with more than one of the ports
> set to IRQ 5 in the BIOS like this:
> xeno_16550A io=0x02e0,0x02f8,0x03e8,0x02e8 irq=5,5,5,5
> baud_base=115200,115200,115200,115200
> All those ports fail to work, only one byte can be transmitted or received.
> 
> On this same motherboard, a Moxa PCI card can share IRQ17 between 4 ports
> OK using xeno_16550A, demonstrating that the kernel/modules are compiled
> correctly.
> But there seems to be a problem with sharing IRQ 5.
> 

Platform UART IRQs are assumed to be edge-triggered (see irqtype
variable) - maybe your special board is different in this regard as
well. Try removing RTDM_IRQTYPE_EDGE.

Jan
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

