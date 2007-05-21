From: Paul <paul_c@domain.hid>
Date: Mon, 21 May 2007 14:56:12 +0100
References: <46180AB8.3000905@domain.hid> <200705201118.30019.paul_c@domain.hid>
	<46516A6A.9030007@domain.hid>
In-Reply-To: <46516A6A.9030007@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705211456.12330.paul_c@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Live CD
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org

On Monday 21 May 2007 10:46, Theo Veenker wrote:
> Paul wrote:
> > Hi Theo
> >
> > On Sunday 08 April 2007 09:07, Theo Veenker wrote:
> >>> [Side note: I already do nightly Sarge based Morphix modules, so
> >>> slipping in a Xenomai version once in a while is possible].
> >>
> >> Would be nice. I'm very interested in having a (small) live cd which I
> >> can customize and give to my clients.
> >
> > Finally got round to setting up an Etch based build system for the
> > Morphix project[1] so am now in a position to look again at a minimal
> > live CD. An assortment of kernel packages were compiled overnight for
> > various CPU flavours (586, 686, k7, & k8) and the initial base ISO boots
> > without any problem under qemu.
> >
> >  Aside from the core Xenomai tools and libraries, what are the main
> > packages you require - We have a blank canvas here, so just about
> > anything can be added.
>
> In my case I would need X-Windows (gnome wm) + ALSA, my user application +
> kernel module (which of course needs to be recompiled for the particular
> kernel). My preference would be to have something I can change and build
> myself. Even if it is just an ISO image that I have unpack, add my own
> stuff to it and turn it into an ISO again. As long as it's clear where
> to put what I'm happy with anything that works.

This is where Morphix is well suited - A main module with the window manager, 
sound support, and general purpose utilities. A secondary mini module (or 
just a tarball) would hold just the custom application & kernel module.. Once 
the main components have been built, should you need to change your custom 
application, only the mini-module/tarball needs to be remastered before 
running mkisofs.

A bare Gnome module (complete with Xorg) weighs in at around 272M, and the 
base module containing a Xenomai patched kernel & libraries adds another 47M. 
After I've had a chance to run further tests, I'll put them on a server along 
with the XML templates and kernel packages.


Regards, Paul.

