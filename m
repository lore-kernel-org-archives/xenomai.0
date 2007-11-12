From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Mon, 12 Nov 2007 10:25:29 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200711090037.14484.lepalom@domain.hid>
	<200711120155.17967.berlemont.hauw@domain.hid>
In-Reply-To: <200711120155.17967.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Message-Id: <200711121025.29720.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

A Dilluns 12 Novembre 2007, Alexis Berlemont va escriure:
> Hi,
>
> > > Could you send me your kernel configuration file?
> >
> > send ...
>
> Thanks to your configuration file, I was able to reproduce the bug on my
> emulator.
>
> It was one of my many bugs: a queue initialization was missing. Then, a
> spinlock was not initialized and triggers in your case the spinning of the
> task insmod.
>
> Fixed in svn. Please update.

updated, compiled, executed and no problem :-)

jr3pci: no version for "comedi_add_drv" found: kernel tainted.
comedi_add_drv: name=jr3_pci
comedi_lct_drv: name=jr3_pci

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 8469 palomo    20   0 45200 4080 2912 R    1  0.2   0:00.04 top
    1 root      20   0  6128  692  568 S    0  0.0   0:01.10 init
    2 root      15  -5     0    0    0 S    0  0.0   0:00.00 kthreadd


Leo

