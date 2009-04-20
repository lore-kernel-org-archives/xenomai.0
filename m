MIME-Version: 1.0
In-Reply-To: <49ECBC46.3020601@domain.hid>
References: <d6c8ef150904101628r60c02baal3568b2ece287ce1f@domain.hid>
	<49E0F949.5040900@domain.hid>
	<d6c8ef150904151613j39f43928xd1a25f37184ad30b@domain.hid>
	<d6c8ef150904151626r5c36df10yb9f8e93ea59640df@domain.hid>
	<49E67198.3080801@domain.hid>
	<d6c8ef150904200424g5691b220l1cea34d9268f747d@domain.hid>
	<49ECBC46.3020601@domain.hid>
Date: Tue, 21 Apr 2009 01:21:12 +0200
Message-ID: <d6c8ef150904201621md0fd3dcq329207f0d235aac8@domain.hid>
From: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Intel EP80579 support
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

thank you for your answers. I'm doing pretty much the same thing as I
did on ARM platform - I'm using one of GPIO pins as Interrupt source.
On ARM platform I was using one of the GPIO pins as IRQ 110, also
without having it in /proc/interrupts.

Intel provides API (accessible through ioctl()) which I use to set
GPIO pin (#25 in my case) in input mode and, as manual says, it can be
used as Interrupt source (for #25 it says IRQ 38).

Sincerely,
Bosko

