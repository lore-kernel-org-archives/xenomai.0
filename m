Message-ID: <d6c8ef150805231234m7c65aec5l5fa15c028ce96249@domain.hid>
Date: Fri, 23 May 2008 21:34:37 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <18487.5656.377471.470581@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<18487.5656.377471.470581@domain.hid>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

> Interrupt priority only matters when two interrupts are pending at the
> same time. If ethernet interrupt is treated at Linux level, then it is
> fully preemptible by Xenomai,

Ethernet is handled by Linux (dm9000 driver).

> - re-enable interrupts in the ethernet interrupt handler

What will happen with interrupted ethernet interrupt handler? :)

> But as far as I understood, your problem is not the interrupt latency,
> but rather the ISR duration, and changing the interrupt priority will
> not change this at all.

Both latency and duration are my problems. But, I had some explanation
for latency problem (irqs disabled during Eth handler).

Thanks.

