Message-ID: <4CADB8EE.5090007@domain.hid>
Date: Thu, 07 Oct 2010 14:11:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20101007115728.GA24500@domain.hid>
In-Reply-To: <20101007115728.GA24500@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pavel Machek <pma@domain.hid>
Cc: xenomai@xenomai.org

Pavel Machek wrote:
> Hi!
> 
> I have... quite an interesting setup here.
> 
> SMP machine, with special PCI card; that card has GPIOs and serial
> ports. Unfortunately, there's only one interrupt, shared between
> serials and GPIO pins, and serials are way too complex to be handled
> by realtime layer.

If the configuration is fixed, you may handle the shared interrupt in
the way described here, and you should not have the loss of real-time
guarantees:
https://mail.gna.org/public/xenomai-core/2008-07/msg00025.html

-- 
					    Gilles.

