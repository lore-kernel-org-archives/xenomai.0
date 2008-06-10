From: Leopold Palomo-Avellaneda <leo@domain.hid>
Date: Tue, 10 Jun 2008 17:46:43 +0200
References: <200806101714.14019.leo@domain.hid>
	<484E9EE7.4030904@domain.hid>
In-Reply-To: <484E9EE7.4030904@domain.hid>
MIME-Version: 1.0
Message-Id: <200806101746.43292.leo@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: Re: [Xenomai-help] kernel patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

A Dimarts 10 Juny 2008, Philippe Gerum va escriure:
> Leopold Palomo-Avellaneda wrote:
> > Hi,
> >
> > trying to compile a new kernel I have realised that with every new
> > version of xenomai, you update to the new kernel version deleting the
> > patch for the old version of the kernel.
> >
> > There's some special reason? I don't understand it.
>
> The Adeos project has officially released 722 patches over 7 different
> architectures since June 6 2002; now, just imagine how the various patches/
> directories would look like if we did not remove the older versions. On
> i386, we have patches for almost all kernels ranging from 2.4.2x to 2.6.25.
>
> The patches/ directory contains material which has been used to validate
> the Xenomai release in question; this does not mean that no other patches
> may be used. We actually have a decent record of maintaining backward
> compatibility in that area.
>
> There is a recent FAQ entry giving some hints:
> http://www.xenomai.org/index.php/FAQs

Ok, I understand. Thank for the explanation.

I have had a problem building the debian xenomai package till I have realised 
that I didn't have the correct patch, so I have investigated and I have found 
that you, in general, keeps the patch for the last kernel.

"Maybe", 
keep the patch last two kernels wouldn't be too much afford. I have to addmitt 
that I was thinking in debian, because the xenomai debian package is shipped 
with a patch for a kernel version that it's not in debian. But, you knows, 
someone that use xenomai knows to download a vanilla kernel.

Regards,

Leo

