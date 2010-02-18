Message-ID: <4B7DC3A4.7000503@domain.hid>
Date: Thu, 18 Feb 2010 14:48:04 -0800
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid> <4B7DC07C.5@domain.hid>
In-Reply-To: <4B7DC07C.5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy DIO speed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

>  It is not that bad, no ? Does anybody have an accurate idea on the
>  duration of a common ioctl on such a powerful machine ?

Yikes! My limited and possibly out of date understanding of the PCI bus 
would say that you risk a much larger latency and jitter in just getting 
access to the bus. I'd be happy with anything in the 1us range (1-5?) 
which afaicr is what it takes to negotiate the bus and to write one or a 
few longwords to a device. This is without something already on the bus 
doing DMA or some other block transfer which could push up the latency 
much higher since a block transfer is not required to give up the bus 
for some larger amount of time (please excuse my possible mangled use of 
terms which may have other specific meaning in the PCI spec).

If folks expect much better performance (perhaps from modern revs of 
PCI??) I'd like to hear of their experience...

                                   - Tom


