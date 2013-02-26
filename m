Message-ID: <512C9E78.1060208@siemens.com>
Date: Tue, 26 Feb 2013 12:37:28 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>
In-Reply-To: <512C806F.2020209@hilscher.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: xenomai@xenomai.org

On 2013-02-26 10:29, Jerome Poncin wrote:
> Hello,
> 
> I have a problem with driver for Hilscher cifx with IRQ.
> 
> All driver run good (I verified in polling mode) but in case I activate
> IRQ the system freeze.
> 
> I checked parameters of "rtdm_irq_request" function without success (all
> seems good) ! I tried to see on internet to get some information about
> the use of "rtdm_irq_request", or compare my code with other driver but
> it's not easy...
> I give you in attached file my code because I have no idea about my
> problem, and it's really difficult to have some information or trace
> after system freeze...
> Do you have an idea about my problem ?

> static inline int cifx_handler(rtdm_irq_t *irq)
         ^^^^^^
But I suspect the compiler is smart enough to ignore this.

Is the line you are registering for shared with other devices? Check
/proc/interrupts and lspci -v. If yes, resolve that conflict.

If not, add printk to your IRQ handler, redirect the kernel messages to
a serial console and try to find out how far and how ofter you get into
the handler.

Well, and then there is the option of source-level debugging. kgdb for
I-pipe patches aren't merged yet, but more convenient is KVM-based
debugging anyway. See [1] for the concept. Just requires VT-d or AMD
IOMMU on your target.

Jan

PS: Still no kernel coding style. Specifically the long lines makes it
hard to read.

[1]
http://chemnitzer.linux-tage.de/2012/vortraege/folien/1061-VirtualDebugging.pdf

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

