From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
Date: Fri, 17 Nov 2006 09:03:42 +0100
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
	<455CC9DE.6030601@domain.hid>
	<54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
In-Reply-To: <54b161f50611162357o71b7f689v1bf68072861c753e@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GkyhL-00012j-2w@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Frits de Klark wrote:
> Hi,
>
> to get back on my earlier question: IF the memory mapping might work for
> me, how should I call it?
> The PCI card has two CAN ports. Here's (a part of) the output of lspci -vv:
>
> Interrupt: pin A routed to IRQ 11
> Region 0: Memory at e1003000 (32-bit, non prefetchable) [size=128]
> Region 2: I/O ports at d800 [size=128]
> Region 3: I/O ports at dc00 [size=128]

Wild guess: Could it be that you can use io=0xd800,0xdc00 (Not memory mapped)?

--
Sebastian

