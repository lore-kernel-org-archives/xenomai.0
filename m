From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 31 Oct 2007 01:17:44 +0100
References: <200709201549.13035.lepalom@domain.hid> <472740DE.2040908@domain.hid>
	<200710301604.45488.lepalom@domain.hid>
In-Reply-To: <200710301604.45488.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710310117.44938.berlemont.hauw@domain.hid>
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

> > modprobe firmware?
>
> $:/usr/src/xenomai-comedi-rtdm-dev$ sudo modprobe firmware
> FATAL: Module firmware not found.
>

Would you mind checking, in your kernel ".config" file, that the option 
CONFIG_FW_LOADER is enabled?

> > >
> > > Ok, I have download, compiled and installed. I'm using xenomai 2.4-rc4.
> > > All have compiled without any problem. Howeber I don't know how to use
> > > it.

If you manage to insmod this driver, the second step would be : trying to 
attach the jr3_pci driver to a comedi (rtdm) device:

comedi_bin/bin_nrt/comedi_config comedi0 jr3_pci

This should initialize the hardware and download the firmware (available in 
the comedi-non-free package from www.comedi.org, I think).
The instructions are located in the driver source header: 

/*
Driver: jr3_pci
Description: JR3/PCI force sensor board
Author: Anders Blomdell <anders.blomdell@domain.hid>
Devices: [JR3] PCI force sensor board (jr3_pci)

  The DSP on the board requires initialization code, which can 
  be loaded by placing it in /lib/firmware/comedi.  
  The initialization code should be somewhere on the media you got 
  with your card. One version is available from http://www.comedi.org
  in the comedi_nonfree_firmware tarball.

...
*/

I may be unreachable until the end of this week.

Many thanks for your tests!

Regards.

Alexis.


