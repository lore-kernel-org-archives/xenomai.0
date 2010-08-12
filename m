From: Tim Cussins <timcussins@domain.hid>
In-Reply-To: <4C62D640.6080304@domain.hid>
References: <1278943817.7023.18.camel@domain.hid>  <4C3EF6D6.6040907@domain.hid>
	<1279210298.1995.38.camel@domain.hid>
	<1279623645.2187.35.camel@domain.hid>  <4C469259.3000708@domain.hid>
	<1281538723.2246.120.camel@domain.hid>
	<1281540487.1730.20.camel@domain.hid>
	<1281543863.2246.149.camel@domain.hid>
	<1281544161.1730.23.camel@domain.hid>
	<1281545075.2246.167.camel@domain.hid>  <4C62D640.6080304@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Aug 2010 16:04:17 +0100
Message-ID: <1281625457.2211.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Marvell sheeva support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2010-08-11 at 18:56 +0200, Gilles Chanteperdrix wrote:
> Tim Cussins wrote:
> > On Wed, 2010-08-11 at 18:29 +0200, Philippe Gerum wrote:
> >> On Wed, 2010-08-11 at 17:24 +0100, Tim Cussins wrote:
> >>> On Wed, 2010-08-11 at 17:28 +0200, Philippe Gerum wrote:
> >>>> On Wed, 2010-08-11 at 15:58 +0100, Tim Cussins wrote:

> >>>>> However, I've got a problem with busybox/getty and /dev/ttyS0 so I can't
> >>>>> log in via console OR telnet. Once that's solved, I'll be able to run
> >>>>> the xenomai tests. (In case you've seen it before - /var/log/messages is
> >>>>> slowly filling with:
> >>>>>
> >>>>> Aug 11 16:03:36 init: starting pid 638, tty '/dev/ttyS0': '/sbin/getty
> >>>>> 115200 ttyS0'
> >>>>> Aug 11 16:03:36 getty[638]: ttyS0: TCGETS: Inappropriate ioctl for
> >>>>> device
> >>>>>
> >>>>> )
> >>>>>
> >>>> Does /dev/ttyS0 have major=4, minor=64 on your rootfs?
> >>> dev.txt (from mkrootfs) would imply that it is 4,64. Without being able
> >>> to log in, I can't confirm though :) Unless you know a cunning trick? :D
> >> Well, maybe. ls -l on the nfs server side exporting your rootfs :>
> > 
> > Pfff :D All the nodes appear as regular files that way - I assumed that
> > was normal, and that some special magic was happening in busybox to
> > replace them with nodes... Is there something I'm not doing right?
> > 
> > I've mounted a debian rootfs over nfs no problems - that tree has *real*
> > nodes in it, and the show up as such using the ls -l , uh, 'trick' :P
> 
> It means we have an issue with fakeroot. Just run make clean, then make
> again to see if it fixes it.

For anyone following this: the files in /dev were regular files instead
of real device nodes - hence the ioctl failure.

The nodes were created in a staging tree using fakeroot. I exported the
tree by invoking tar directly, so the files appear as regular empty
files.

The solution is to invoke tar using fakeroot: this ensures you'll get
real device nodes in /dev.

Cheers,
Tim


