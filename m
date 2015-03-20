Date: Fri, 20 Mar 2015 19:39:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150320183948.GC27775@hermes.click-hack.org>
References: <CADvZd9Z8LSPRMAJWb1Tp91i4i9N5wLGMxb3_suaDyFRwRiJd-w@mail.gmail.com>
 <CAEMXjGzNnwnrZOG4AFPbgKrJUpdHiuuVRFOAoKNasy-eVJQ0yg@mail.gmail.com>
 <CADvZd9bRzWJKP4ye48T6Jq-Y8wQH=GhpnqsUCcxGo0BMhi0BBg@mail.gmail.com>
 <CADvZd9aGmH0_xsYJ=CVn6813AWCE-B78zYrgh0vNhrBHZU=rfg@mail.gmail.com>
 <CADvZd9ZGNcYTt4WNLPJRL+J+MgLpRPRZsyQ9MY4ammYh+7B5Rg@mail.gmail.com>
 <550BD231.5020002@web.de>
 <CADvZd9b9vxCGkWKGcdwudCKvMAsFFrZ0t-OHPFn53B4qE+DdDw@mail.gmail.com>
 <CAEMXjGz8o5UWpNhznHC5-RsjRh_FBRW6ug7rpR-Z5tPvHY34GA@mail.gmail.com>
 <20150320181638.GB27775@hermes.click-hack.org>
 <CAEMXjGwMj1TAr-HUwLXwD+Na0DFBWm9qD5siSzLd_fkpdd9q3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGwMj1TAr-HUwLXwD+Na0DFBWm9qD5siSzLd_fkpdd9q3g@mail.gmail.com>
Subject: Re: [Xenomai] RT-CAN question (was: CAN bus on beaglebone black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Fri, Mar 20, 2015 at 11:28:21AM -0700, Steve B wrote:
> On Fri, Mar 20, 2015 at 11:16 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
> > On Fri, Mar 20, 2015 at 10:42:05AM -0700, Steve B wrote:
> > > Michael,
> > > At least for the Beaglebone Black case, it is looking like you will have
> > a
> > > good and simple way of picking which driver you load.
> > > I am working on getting the driver integrated to the Xenomai tree and in
> > > the process making minor tweaks.. by changing the "compatibility" string
> > to
> > > something unique it looks like you can match the CAN device to the driver
> > > in your device tree overlay. Should be no more having to load the
> > original
> > > driver first.
> > >
> > > I have a bit of an issue that I'm trying to work around with splitting
> > the
> > > driver into the multiple source files, but once I get that sorted out it
> > > should be ready to work that way!
> >
> > From what I understood, the device tree is a description of the
> > hardware, so the compatibility string describes what hardware a
> > board/controller is based on. So, it does not make sense to change
> > the compatibility string to change the driver used. This is contrary
> > to the spirit of the device tree. A device tree is supposed to be OS
> > independent, the device tree files licenses for instance, have been
> > chosen to not prevent a device tree file from being used with BSD.
> >
> > --
> >                                             Gilles.
> >
> 
> OK, sorry if I have it backwards. But if I have both drivers in my kernel
> build and they both have the same compatibility string, they both get
> loaded when I load my device tree overlay. In that case how are we supposed
> to specify which one gets loaded?

Loading a driver, but not initializing it is not a problem. I
believe the kernel will not start two drivers for the same device.
At least that is the way it works with other buses (like PCIe or USB).

You can unbind a device to a driver with sysfs files. Then bind the
device to another driver. I do not know if you can do this with
kernel command line arguments.

See for instance:
https://lwn.net/Articles/143397/

-- 
					    Gilles.

