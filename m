From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Thu, 8 Nov 2007 00:50:03 +0100
References: <200709201549.13035.lepalom@domain.hid> <4731D205.9020004@domain.hid>
	<200711071612.11444.lepalom@domain.hid>
In-Reply-To: <200711071612.11444.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711080050.04298.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
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


> > > jr3pci: no version for "comedi_add_drv" found: kernel tainted.

After having a quick look at linux/kernel/module.c, it appears this warning is 
only printed if the option "CONFIG_MODVERSIONS" is enabled in your kernel 
configuration.

The symbol is resolved but its version is not found. I do not know why yet 
(maybe because the symbol is located in comedi not in the kernel...).

Disabling "CONFIG_MODVERSIONS" will not solve your "console hanged" problem as 
the module seems properly loaded and the module_init function is called.

Alexis.


