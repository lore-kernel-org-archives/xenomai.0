From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Fri, 9 Nov 2007 00:14:57 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200711080012.01964.berlemont.hauw@domain.hid>
	<200711080024.58927.lepalom@domain.hid>
In-Reply-To: <200711080024.58927.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711090014.57185.berlemont.hauw@domain.hid>
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

Hi,

> > > jr3pci: no version for "comedi_add_drv" found: kernel tainted.
> > > comedi_add_drv: name=jr3_pci
> > > comedi_lct_drv: name=jr3_pci
> >
> > Could you remind me which kernel version / xenomai version, you are using
> > ?
>
> 2.6.22 + xenomai-2.4-rc5 (the lastest)
> and I have tested:
> 2.6.23 + xenomai-2.4-rc5 (the lastest)

Even with your configurations, I am still unable to reproduce the problem.

Could you send me your kernel configuration file?

Could you check the CPU charge (is the CPU idle?) after having "insmoded" 
jr3pci.ko?

Many thanks in advance.

Alexis.


