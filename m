Message-ID: <475E80A2.5080203@domain.hid>
Date: Tue, 11 Dec 2007 13:20:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <00a501c83bee$de20b5c0$2903050a@domain.hid>
In-Reply-To: <00a501c83bee$de20b5c0$2903050a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Interrupt Handling in Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
Cc: xenomai@xenomai.org

kapilkumar.jain wrote:
> Hello all,
> 
> The problem i faced in Registering Interrupt in Xenomai, if my interrupt line is shared with the ethernet irqs.
> 
> If we register for the interrupt line which is shared by ethernet irqs we will get the continuous interrupt.
> 
> According to the Xenomai interrupt handling - we should return RTDM_IRQ_NONE for unhandled interrupt.
> and RTDM_IRQ_HANDLED for interrupt handled.
> 
> the problem if I return RTDM_IRQ_NONE, system get hanged with message
> __XINTIRQ_ No Body cared for IRQ 19
> 
> IRQ 19 - same irq sharing with ethernet & my module.
> 
> If instead of RTDM_IRQ_NONE i will return 0; it will not hang.
> but i am not sure about the functionality when it wil share with some other irq which is important.
> 
> what is the meaning of returning 0 from Xenomai ISR?

Using 0 directly is not valid, always use the constants, they (or they
docs) explain their meaning.

I guess you are rather looking for this explanation:

http://www.xenomai.org/index.php/FAQs
"What can I do if Xenomai and Linux devices share the same IRQ?"

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

