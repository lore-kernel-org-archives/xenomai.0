MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18148.5503.43798.880010@domain.hid>
Date: Sun, 9 Sep 2007 17:47:11 +0200
In-Reply-To: <46E3FCDE.8060203@domain.hid>
References: <46E3FCDE.8060203@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] acpi and irq
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
 > Hi,
 > 
 > I am having trouble with shared irq on two NIC's that I am trying to 
 > sort out.
 > 
 > Googling for solutions I notice that acpi has a lot to do with this. I 
 > recall somewhere that ACPI support can be disabled in the config when 
 > patching with xenomai. I was jsut wondering whether this can be related 
 > to the problem I have?

I'd say you are confusion ACPI and APIC, and yes, enabling the APIC
makes more IRQs available, so maybe this could help Linux avoiding IRQ
sharing. Changing cards from slot usually also helps.

-- 


					    Gilles Chanteperdrix.

