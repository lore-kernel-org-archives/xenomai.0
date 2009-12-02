Message-ID: <4B1633A6.40902@domain.hid>
Date: Wed, 02 Dec 2009 10:30:14 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <c024fefc0912011838r6d34e396se2a276e5d7316786@domain.hid>
In-Reply-To: <c024fefc0912011838r6d34e396se2a276e5d7316786@domain.hid>
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

Hi Adrian,

Adrian Boeing wrote:
> Hi,
> 
> We require an industrial PC with CAN, and want to run Xenomai on it.
> 
> Are there any vendors who already sell a complete PC package with
> Xenomai & CAN drivers pre-loaded?
> (I have seen that Peak Systems sell a CAN card with Xenomai drivers,
> but does anyone sell a complete package?)
> 
> We have been having some difficulty getting Xenomai/Linux working on
> some industrial PCs.

There are "good" and "bad" PC for real-time (with Xenomai), I know.
Unfortunately, I can not give valuable recommendations. But for CAN with
Xenomai you should use RT-Socket-CAN, which supports various SJA1000
based CAN cards. A (x)PCI card is preferred. See:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/sja1000/Kconfig

Wolfgang.

