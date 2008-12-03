From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Thu, 4 Dec 2008 00:55:02 +0100
References: <4934EB57.9080305@domain.hid> <49356C83.8050909@domain.hid>
In-Reply-To: <49356C83.8050909@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812040055.02455.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Calling comedi from a RT task
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
> > I am using Xenomai 2.3.1 and comedi with driver "ni_pcimio". I am able
> > to create a RT task that triggers each msec. But calling the comedi API
> > kicks me out of RT as indicated by /proc/xenomai/stat (column MSW). The
> > modules loaded are:
> >
> > comedi_fc   3584 1 ni_pcimio
> > kcomedilib 20868 0
> > comedi     33248 6 ni_pcimio, ni_tio, comedi_fc, mite, 8255, kcomedilib
> > licModule  44272 1 kcomedilib
> >
> > The comedi modules are from a 2.6.20-14-ipipe/comedi/driver directory.
> > How do I use the comedi API so that the task will stay realtime? What do
> > I have to check?
>
> You should have a look at the RT-capable comedi stack that currently
> only lives in Xenomai SVN trunk. How to get your device supported by
> that stack, ie. how to port the existing driver to RT-comedi, that's
> something Alexis can tell you more about. 

If you consider porting the ni_pcimio driver to the RTDM version of Comedi, 
please tell me; I am trying to do the same thing. You could save my time or I 
could save yours ;). Anyway, your help would be very valuable as I have no 
acquisition card...

> And/or have a look at the fake 
> and loop drivers that are already included.

You can also have a look at the doxygen documentation available in the SVN 
trunk. The section "Comedi API -> Driver API" (driverfacilities) should help 
you.

> Jan


