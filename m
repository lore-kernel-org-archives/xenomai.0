Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Sun, 8 Nov 2009 16:13:56 +0100
References: <0016e64cae6a9b846804779c4a17@domain.hid>
In-Reply-To: <0016e64cae6a9b846804779c4a17@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200911081613.57021.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] real-time parallel port communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: peter.pastor@domain.hid
Cc: xenomai@xenomai.org

Hi,

On Thursday 05 November 2009 10:24:17 peter.pastor@domain.hid wrote:
> Hey Alexis,
> 
> Thanks for the response !!
> 
> > Does the comedi driver suit your need ?
> 
> I actually can't tell since I haven't tried it out. I will try whether outb
> does the job. However, it would be really cool if you could port the comedi
> driver for the parallel port to analogy (hope this does not take too long).

I integrated the parport driver into analogy. So far, the driver is only 
available in my git repository (branch: analogy).

This driver is quite peculiar even within the comedi drivers set. The way the 
instructions "config" are handled is different from other drivers. That means 
that your user app must setup instructions' data differently according to the 
driver it uses. I think it should be not left like this; I will fix that.

However, The driver is functional. You can use it. That would be nice to send 
some feedback. 

Here is the "analoy_config" command to attach it:
# analogy_config analogy0 analogy_parport 0x378,7

Here are some notes located in the sources; they will help you:

   A cheap and easy way to get a few more digital I/O lines.  Steal
   additional parallel ports from old computers or your neighbors'
   computers.

   Option list:
   0: I/O port base for the parallel port.
   1: IRQ

   Parallel Port Lines:

   pin     subdev  chan    aka
   ---     ------  ----    ---
   1       2       0       strobe
   2       0       0       data 0
   3       0       1       data 1
   4       0       2       data 2
   5       0       3       data 3
   6       0       4       data 4
   7       0       5       data 5
   8       0       6       data 6
   9       0       7       data 7
   10      1       3       acknowledge
   11      1       4       busy
   12      1       2       output
   13      1       1       printer selected
   14      2       1       auto LF
   15      1       0       error
   16      2       2       init
   17      2       3       select printer
   18-25   ground

   Notes:

   Subdevices 0 is digital I/O, subdevice 1 is digital input, and
   subdevice 2 is digital output.  Unlike other Analogy devices,
   subdevice 0 defaults to output.

   Pins 13 and 14 are inverted once by Analogy and once by the
   hardware, thus cancelling the effect.

   Pin 1 is a strobe, thus acts like one.  There's no way in software
   to change this, at least on a standard parallel port.

   Subdevice 3 pretends to be a digital input subdevice, but it always
   returns 0 when read.  However, if you run a command with
   scan_begin_src=TRIG_EXT, it uses pin 10 as a external triggering
   pin, which can be used to wake up tasks.

   see http://www.beyondlogic.org/ for information.
   or http://www.linux-magazin.de/ausgabe/1999/10/IO/io.html

> Thanks a lot,
> Peter
> 
> On Nov 5, 2009 1:01am, Alexis Berlemont <berlemont.hauw@domain.hid> wrote:
> > Hi,
> >
> >
> >
> > On Thu, Nov 5, 2009 at 6:05 AM, Peter Pastor peter.pastor@domain.hid>
> >
> > wrote:
> > > Hello there,
> > >
> > >
> > >
> > > I need to get real-time communication over a parallel port working. I
> >
> > got
> >
> > > the serial port to run in real-time using the drivers provided by
> >
> > xenomai.
> >
> > > However, I haven't found similar drivers for the parallel port yet.
> >
> > Does the
> >
> > > new analogy branch contain real-time drivers for the parallel port ??
> >
> > No. But there is a comedi driver for the parallel port. That would not
> >
> > take too long to convert it for analogy.
> >
> >
> >
> > Does the comedi driver suit your need ?
> >
> > > I would be happy for any hints. Also, would be cool if somebody could
> >
> > point
> >
> > > me to some example programs.
> > >
> > >
> > >
> > > Thanks,
> > >
> > > peter
> >
> > Alexis.
> 

Alexis.

