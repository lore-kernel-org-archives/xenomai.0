From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 19 Nov 2008 00:32:43 +0100
References: <9c789a000811080850q47f5b429k130fff3f64985aa3@domain.hid>
	<9c789a000811180033v414e7c84h9959a526bd6042c1@domain.hid>
	<9c789a000811180033n1ec54d6pa4f4e1abb4c72e7f@domain.hid>
In-Reply-To: <9c789a000811180033n1ec54d6pa4f4e1abb4c72e7f@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811190032.43191.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] SegFault on all multiple apps!!
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

> >
> > > But a problem when running ./cmd_write I get :
> > >     cmd_write: comedi_get_chinfo failed (ret=-22)
> > > So it cannot find any channel info , so is it possible that an error
> >
> > ocured
> >
> > > when loading a specific file descriptor??
> >
> > Did you attach a driver to a specific Comedi device (thanks to
> > comedi_config) ?
>
> I attached :
>
> $ ./comedi_config -v comedi0 comedi_fake
>
> > > I also would like to check somehow the validity of my Xenomai and
> > > Comedi installation. Is it possible to do this ??
> >
> > Could you send the results of "cat /proc/comedi/devices"
> > and "cat /proc/comedi/drivers" ?
>
> /usr/xenomai/sbin # cat /proc/comedi/devices
> --  Comedi devices --
>
> | idx | status | driver
> |  00 | Linked | comedi_fake
> |  01 | Unused | No driver
> |  02 | Unused | No driver
> |  03 | Unused | No driver
> |  04 | Unused | No driver
> |  05 | Unused | No driver
> |  06 | Unused | No driver
> |  07 | Unused | No driver
> |  08 | Unused | No driver
> |  09 | Unused | No driver
>
> /usr/xenomai/sbin # cat /proc/comedi/drivers
> --  Comedi drivers --
>
> | idx | driver name
> |  00 | comedi_loop
> |  01 | comedi_fake
>
> When I run
>
> /usr/xenomai/bin # ./cmd_write
> cmd_write: comedi_get_chinfo failed (ret=-22)
>
> and
>
> /usr/xenomai/bin # ./cmd_read
> 0x20 0x1 0x40 0x1 0x60 0x1 0x80 0x1
> 0xa0 0x1 0xc0 0x1 0x0 0x0 0x0 0x2
> 0x20 0x1 0x40 0x1 0x60 0x1 0x80 0x1

The comedi_fake driver provides only one input subdevice; there is no output 
subdevice in it (compared to the comedi_loop driver). Then, cmd_write is not 
supposed to be working with comedi_fake. You have to use comedi_loop.

After the attach procedure, an entry "comedi0" should be available 
in /proc/comedi. This file should hold information about the attached comedi 
device (subdevice list, types, etc.).

There is a lack of information on that point, I will try to add some as soon 
as possible.

Alexis.


