Message-ID: <b647ffbd0702160120kd993582y51080c1a45a97e88@domain.hid>
Date: Fri, 16 Feb 2007 10:20:12 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Sharing interrupts between several RT pci devices
	and non RT devices
In-Reply-To: <20070216081932.323430@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070216081932.323430@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steffen Mehlfeld <S.Mehlfeld@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

> But as soon as i start returning XN_ISR_PROPAGATE from the isr, i get the message
> "Xenomai: xnintr_edge_shirq_handler(): failed to get the IRQ9 line free.", which i think
> doesn't mean, that all is going well.

Try returning XN_ISR_NONE | XN_ISR_PROPAGATE.

I can't see an analog for XN_ISR_PROPAGATE in the rtdm though. So it's
somewhat not recommended.

However, an interrupt line will remain disabled until the linux domain
gets control back and a corresponding eth driver handles an interrupt
(and then linux does .end == unmask the irq line).
i.e. Interrupts from your RT devices won't be seen in the mean time
and, in fact, you lose any determinism wrt rt interrupt handling.

Actually, masking an edge-triggered interrupt line is not a _must_ to
handle it properly... but that would require some rework of the
interrupt handling path; can't say right now whether it would nicely
fit into the existing framework.

Another approach was illustrated by an additional patch posted once by
Jan, there must be a link somewhere around. Non-rt driver must provide
a tiny rt-stub function which will be executed from the rt domain and
"shut up" a corresponding device if it's issued this interrupt. The
actual handling is done in the linux domain later but we are not
dependent on how soon as the line is free for rt devices.


-- 
Best regards,
Dmitry Adamushko

