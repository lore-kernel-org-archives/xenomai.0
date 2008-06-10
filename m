Message-ID: <484E9EE7.4030904@domain.hid>
Date: Tue, 10 Jun 2008 17:33:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200806101714.14019.leo@domain.hid>
In-Reply-To: <200806101714.14019.leo@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] kernel patches
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> trying to compile a new kernel I have realised that with every new version of 
> xenomai, you update to the new kernel version deleting the patch for the old 
> version of the kernel.
> 
> There's some special reason? I don't understand it.
> 

The Adeos project has officially released 722 patches over 7 different
architectures since June 6 2002; now, just imagine how the various patches/
directories would look like if we did not remove the older versions. On i386, we
have patches for almost all kernels ranging from 2.4.2x to 2.6.25.

The patches/ directory contains material which has been used to validate the
Xenomai release in question; this does not mean that no other patches may be
used. We actually have a decent record of maintaining backward compatibility in
that area.

There is a recent FAQ entry giving some hints: http://www.xenomai.org/index.php/FAQs

-- 
Philippe.

