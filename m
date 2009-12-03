Message-ID: <4B177A13.8070309@domain.hid>
Date: Thu, 03 Dec 2009 09:42:59 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <c024fefc0912011838r6d34e396se2a276e5d7316786@domain.hid>	<4B162421.20907@domain.hid>	<c024fefc0912020042v7bfe223q8f67c7787284c066@domain.hid>	<4B163F13.90400@domain.hid>
	<c024fefc0912022223g63f6fd1ep4c340c8e91ac83e5@domain.hid>
In-Reply-To: <c024fefc0912022223g63f6fd1ep4c340c8e91ac83e5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Ready PC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <me@domain.hid>
Cc: xenomai@xenomai.org

Adrian Boeing wrote:
> Hi Wolfgang & Gilles,
> 
> Thanks for the list of Xenomai-supported PCI cards:
> 
> 034 config XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI
> 039         This driver is for the IXXAT PC-I 04/PCI card (1 or 2 channel)
> 040         from the IXXAT Automation GmbH (http://www.ixxat.de). To get
> 041         the second channel working, Xenomai's shared interrupt support
> 042         must be enabled
> 
> Exactly which card is this?
> (IXXAT has a list here:
> http://www.ixxat.de/overview-pc-can-interface-board_de.html)
> Is it the iPC-I 320/PCI II?

No, it's just for the passive CAN hardware, PC-I 04/PCI. Active hardware
does not allow to access the SJA1000 directly.

Wolfgang.

