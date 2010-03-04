Message-ID: <4B8FB794.9060406@domain.hid>
Date: Thu, 04 Mar 2010 14:37:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8D9711.5090704@domain.hid> <4B8F8E11.9060902@domain.hid>
	<2520b84ba5be01527e6b777596df9119@domain.hid>
In-Reply-To: <2520b84ba5be01527e6b777596df9119@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] ADEOS patch for LPC3250
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Pierre Ficheux <pierre.ficheux@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Pierre Ficheux wrote:
> Hi all,
> 
> Do you know if there is any work on porting ADEOS to NXP LPC3250
> (ARM926EJ-S) ?
> 
> http://ics.nxp.com/products/lpc3000/lpc32x0

It would be nice if you could avoid replying a random mail when asking
an un related question. I would have expected a better knowledge of
netiquette from an old-timer as you, Pierre :-)

No, I have not heard of any I-pipe port to NXP LPC3250. The ARM core
does not really matter for an ARM port, as the timer, interrupt
controller, and GPIO demux are the only thing which need to be
considered and are not part of the core.

Regards.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

