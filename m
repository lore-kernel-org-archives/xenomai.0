MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18487.7736.634161.816552@domain.hid>
Date: Fri, 23 May 2008 21:42:48 +0200
In-Reply-To: <d6c8ef150805231234m7c65aec5l5fa15c028ce96249@domain.hid>
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<18487.5656.377471.470581@domain.hid>
	<d6c8ef150805231234m7c65aec5l5fa15c028ce96249@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Bosko Radivojevic wrote:
 > > Interrupt priority only matters when two interrupts are pending at the
 > > same time. If ethernet interrupt is treated at Linux level, then it is
 > > fully preemptible by Xenomai,
 > 
 > Ethernet is handled by Linux (dm9000 driver).

Then what I have said is irrelevant, your interrupt handler is fully
preemptible by Xenomai.

 > 
 > > - re-enable interrupts in the ethernet interrupt handler
 > 
 > What will happen with interrupted ethernet interrupt handler? :)
 > 
 > > But as far as I understood, your problem is not the interrupt latency,
 > > but rather the ISR duration, and changing the interrupt priority will
 > > not change this at all.
 > 
 > Both latency and duration are my problems. But, I had some explanation
 > for latency problem (irqs disabled during Eth handler).

How are they disabled ? If they are disabled using Linux functions, then
they are really enabled for Adeos, that is one of the intended effects
of the Adeos patch.

-- 


					    Gilles.

