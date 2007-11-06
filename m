From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Tue, 6 Nov 2007 11:02:12 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200710311036.01469.lepalom@domain.hid>
	<200711060032.36444.berlemont.hauw@domain.hid>
In-Reply-To: <200711060032.36444.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Message-Id: <200711061102.13154.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
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
To: xenomai@xenomai.org

A Dimarts 06 Novembre 2007, Alexis Berlemont va escriure:
> Hi
>
> > And after, the jr3 driver, but I got with dmesg:
> >
> > jr3pci: module license 'unspecified' taints kernel.
> > jr3pci: no version for "comedi_add_drv" found: kernel tainted.
> > jr3pci: Unknown symbol device_unregister
> > jr3pci: Unknown symbol device_register
> >
> >
> > so, I cannot load the driver. What I'm doing grong?
>
> Oops. My fault. Fixed in subversion.
>
> Please update.
>
done, but when I do:
sudo insmod comedi_drivers/misc_drivers/jr3pci.ko

I got a console hangs, with no response and the dmesg says:
jr3pci: no version for "comedi_add_drv" found: kernel tainted.
comedi_add_drv: name=jr3_pci
comedi_lct_drv: name=jr3_pci


Now, I'm still blocked ....

Regards,

Leo

