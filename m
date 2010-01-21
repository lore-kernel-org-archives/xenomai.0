Message-ID: <4B582AC4.5030104@domain.hid>
Date: Thu, 21 Jan 2010 11:21:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B57134A.3090702@domain.hid> <4B5816E7.2080108@domain.hid>
	<4B58233A.4070708@domain.hid>
In-Reply-To: <4B58233A.4070708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] assert RTS signal during transmit in
 EIA-485 half duplex mode for 16550A compatible controllers.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexandre Coffignal <alexandre.coffignal@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Alexandre Coffignal wrote:
> Hello,
> 
> Thanks you for your response.
> 
> I used this patch to communicate with a slave equipment in rs485 (modbus
> protocol). The data is transmitted over a 2-wire twisted pair bus.
> Master initiates all communication activity, by sending data. To do this
> it must set RTS line to high state during all it's transmission. Before
> slave answer, master must lower the RTS line.

Will the slave wait on the deassertion of RTS? Or what will happen if
RTS is still high and the slave starts its answer?

> 
> my slave equipment answer in less than 200us, so i must know when xmit
> is completing to lower the RTS line
> 
> An extension to RTSER_RTIOC_WAIT_EVENT may be a good solution but do you
> know if an extension to RTSER_RTIOC_WAIT_EVENT can guarantee this timing?
> 

Given a proper platform (check its capabilities with the latency or the
irqbench test), yes. It's a myth that such things can only be done in
kernel space.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

