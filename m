Date: Wed, 2 Mar 2011 16:16:03 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110302151603.GA14557@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I am running Xenomai 2.5 git master on a P2020 with kernel 2.6.36.

We have a custom PCIe card that raise a MSI, with a normal (not rtdm)
driver. It appears that the interrupt comes just once and then is
stuck. It work under plain Linux, but I cannot rule out a HW timing
bug either.

The wiki pages 

   http://www.xenomai.org/index.php/FAQs
   http://www.xenomai.org/index.php/Configuring_x86_kernels

say not to enable MSI on x86, with a link to a very old (2008)
discussion. I found a newer mail

   https://mail.gna.org/public/xenomai-help/2010-01/msg00095.html

claiming that MSI is okay.

Is there a known problem with MSI and Xenomai?

If so, where/how can I start to get working on fixing it?

(I don't need the MSI in a rtdm or adeos context.)

Thanks,

Richard


