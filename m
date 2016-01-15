References: <CANOAZgyVur3nUyowUGWe4k4RnhkSFQtiDMY5tMoD1muPStuNbA@mail.gmail.com>
 <5682DACA.5090609@grandegger.com>
 <CANOAZgzL6NmnyEmdteu7RyhjvhMYnxaeQaUWv0bso5quhNkvfw@mail.gmail.com>
 <56838979.40305@grandegger.com>
 <CANOAZgwPvmtC_PgaKB2N8v2venWmB1okpBMSfGinHdG3YZo_+Q@mail.gmail.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <5698EEE7.8070003@grandegger.com>
Date: Fri, 15 Jan 2016 14:06:47 +0100
MIME-Version: 1.0
In-Reply-To: <CANOAZgwPvmtC_PgaKB2N8v2venWmB1okpBMSfGinHdG3YZo_+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTCAN problem with PEAK PCIe & miniPCIe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wuwei He <whe@neocisinc.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hello,

please don't drop the CC to the Xenomai mailing list.

Am 14.01.2016 um 22:24 schrieb Wuwei He:
>
>
> Hello,
>
> With my limited understanding of Xenomai, I assume that these problems
> would not appear if we use Xenomai in single kernel configuration?

With "single kernel configuration" you mean Xenomai 3!? Good question!
I think it will not be good for the latency either.

> Also, I tried to google and did not find a "single kernel Xenomai
> installation" for people who don't know much about Linux kernel hacks.
> Such, I used info from a lot of links like this:
> http://jbohren.com/articles/xenomai-precise/
> Would you know good place to start with? While I am fight through this
> whole new domain.

I didn't work with Xenomai 3 recently. Maybe other ppl on this list can 
help.

Wolfgang.

> On Wed, Dec 30, 2015 at 2:36 AM, Wolfgang Grandegger <wg@grandegger.com
> <mailto:wg@grandegger.com>> wrote:
>
>     Hello,
>
>     Am 29.12.2015 um 20:48 schrieb Wuwei He:
>
>         Hello,
>
>         Thanks for your response. Here is what happens and the logs.
>
>         I have the single channel PCIe card plugged in. I sent  a CAN
>         message
>         from my Windows machine over a CAN cable, and received no
>         message from
>         Xenomai:
>         Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
>         rtcan0            1000000 active            0          0          0
>
>         Then, sending from Xenomai:
>         /usr/xenomai/bin/rtcansend rtcan0 --verbose 0xdd 0xaa
>         interface rtcan0
>         s=0, ifr_name=rtcan0
>         <0x001> [2] dd aa
>         Cleaning up...
>
>         I received from Windows.   And Xenomai end gives:
>         cat /proc/rtcan/devices
>         Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
>         rtcan0            1000000 active            1          0          0
>
>         After that, I saved all the logs.
>
>         =====
>
>         You can find logs named: dmesg_result: is from dmesg > etc.
>         Includes:
>         dmesg
>
>
>
>
>         lspci
>         proc/interrupts/
>
>
>
>     $ grep " 16:" proc_interrupts_result
>       16:          0          0          1          0   IO-APIC-fasteoi
>     ehci_hcd:usb1
>
>     The irq 16 is shared with the Linux device "ehci_hcd:usb1".
>
>         proc/xenomai/irq
>
>
>     $ cat proc_xenomai_irq_result
>     IRQ         CPU0        CPU1        CPU2        CPU3
>       16:           6           0         915          79         SJA1000
>
>     The device seem to get interrupts but they may come from the Linux
>     device "ehci_hcd:usb1". Anyway, Xenomai devices should not share IRQ
>     lines with Linux devices. See:
>
>
>     https://xenomai.org/2014/06/what-if-xenomai-and-linux-devices-share-the-same-irq/
>
>     Try using a different PCI slot, check and maybe modify the bios
>     settings to use a different IRQ or unload the Linux device using
>     that IRQ as well.
>
>
>         I am not qualified to debug IRQ problems and now start to learn
>         about
>         it. If you could give them a look, it would help me a lot.
>         *Still, sorry for sending all the log files and I really
>         appreciate your
>         time.
>
>
>     You are welcome.
>
>     Wolfgang.
>
>         On Tue, Dec 29, 2015 at 2:11 PM, Wolfgang Grandegger
>         <wg@grandegger.com <mailto:wg@grandegger.com>
>         <mailto:wg@grandegger.com <mailto:wg@grandegger.com>>> wrote:
>
>              Am 29.12.2015 um 17:16 schrieb Wuwei He:
>
>                  Hello, all
>
>                  I have a problem with the PEAK PCIe card: I could never
>         receive CAN
>                  messages and can only send one message.
>
>
>                  Using /usr/xenomai/bin/rtcansend and rtcanrecv:
>                  When receiving, RX_Counter does not increase.
>                  When sending, TX_Counter increase to 1, and message is
>         received
>                  from the
>                  receive end. Then sending a second message, it gets
>         blocked and no
>                  response. Checking with /proc/rtcan/devices, no error
>         status though.
>
>
>              Interrupts seems not to be triggered. Could you please post the
>              output of:
>
>                 # cat /proc/xenomai/irq
>                 # cat /proc/interrupts
>
>                  I am using Xenomai 2.6.3, Linux kernel 3.5.7, under
>         Ubuntu 12.04.
>                  Same results for two different PC -- hardware. Tested
>         with PEAK
>                  dual PCIe
>                  and dual miniPCIe.
>                  Tried with SHARED_IRQ enabled. When not enabled, the
>         devices
>                  won't be
>                  loaded.
>
>
>              You may need it because both CAN controllers share one
>         interrupt line.
>
>                  Also, when using dual PCI card, no such problems. Same
>         error
>                  behavior with
>                  dual PCIe and miniPCIe.
>
>                  Would any one knows what kind of problem I am in?
>
>
>              Also the output of "lspci -vv" for the PEAK PCIe cards
>         would provide
>              some useful input.
>
>              Wolfgang.
>
>
>

