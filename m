Message-ID: <4551DA2A.90607@domain.hid>
Date: Wed, 08 Nov 2006 14:22:50 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] ISR arguments with Native skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hallo,

I just realized, that the ISR registered with rt_intr_create() must be 
of type:

   int isr(struct xnintr *irq)

I expected "RT_INTR *" as type of the argument. The documentation is not 
clear about that (what rt_isr_t) is. A hyper-link would be nice.

Thanks.

Wolfgang.

