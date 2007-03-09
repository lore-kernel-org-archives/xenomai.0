Message-ID: <45F12FF9.6030209@domain.hid>
Date: Fri, 09 Mar 2007 10:59:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTCAN and tsc
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>	<!&!AAAAAAAAAAAYAAAAAAAAAOtQApUEfglBvKTF3jr1t1bigwAAEAAAALx+DKgbdNVEi6wAAVh/Ga4BAAAAAA==@ac6.fr>	<45F05EC7.6070907@domain.hid>
	<E1HPbgo-0001DJ-EN@mailer.emlix.com>
In-Reply-To: <E1HPbgo-0001DJ-EN@mailer.emlix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Sebastian Smolorz wrote:
> If an RX interrupt appears it it necessary to read out up to 14 SJA1000 regs 
> and write one register before a CAN message can be distributed to the 
> sockets. Do you really suggest that the reading of the SJA1000 registers 
> should be interruptible? One step towards chaos, I would say.

Maybe it would make sense to handle the message reception in a thread (a
kind of bottom half), and to only disable the CAN irq when doing the
reception work. This way, the system would still be able to handle other
events while the can reception takes place.

-- 
                                                 Gilles Chanteperdrix

