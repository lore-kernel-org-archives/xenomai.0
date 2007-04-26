Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 26 Apr 2007 19:35:46 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
Message-ID: <20070426173546.291520@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Errors compiling kernel 2.6.20 with xenomai 2.3.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

-------- Original-Nachricht --------
Datum: Thu, 26 Apr 2007 18:38:46 +0200
Von: Jan Kiszka <jan.kiszka@domain.hid>
An: Karl Reichert <Karl-Trampe@domain.hid>
CC: Xenomai-help@domain.hid
Betreff: Re: [Xenomai-help] Errors compiling kernel 2.6.20 with xenomai 2.3.1

> Karl Reichert wrote:
> > Hello,
> > 
> > I'm trying to compile my kernel with xenomai 2.3.1 and I get lots of
> errors.
> > I'm using standard kernel (from kernel.org), version 2.6.20 and ubuntu
> 7.04 and gcc 5.97
> 
> gcc-what? Please try "gcc --version". Should be something with 3.x or
> 4.x (+some Ubuntu/Debian sub-revision).
> 
It's gcc (GCC) 4.1.2 (Ubuntu 4.1.2-0ubuntu4). Sorry for the mistake.
> > I used the guide from http://www.captain.at/xenomai-2.1-installation.php
> and patching kernel sources works fine, but when I do a "make menuconfig",
> I get a lot of errors (see below).
> 
> [looking...] Where? Please try again. :)
> 
Link is working for me. But used now tutorial from http://www.rcode.net/blog/tlaurenzo/2007/03/
> > 
> > Does anybody has an idea what's the problem here?
> > Maybe I'm using wrong kernel or gcc version? I saw that xenomai 2.3.1
> supports kernel 2.6.20 so maybe gcc is in wrong version? Which one do I have
> to use?
> 
> Any gcc that is fine with the kernel (4.1 is said to make troubles,
> sometimes) should also work with Xenomai.
> 
> > Which system do you use out there running xenomai 2.3.1?
> 
> OpenSUSE and home-brewed, but Ubuntu must work as well.
> 
> Jan
> 
Solved the problem now. It didn't installed all dependencies.

But now I have a different problem. When compiling (building deb-package), I get the following error:

====== making target install/linux-image-2.6.20 [new prereqs: ]======
This is kernel package version 10.065ubuntu5.
echo "The UTS Release version in include/linux/utsrelease.h"; echo "     \"2.6.20-adeos-xenomai2.3.0\" "; echo "does not match current version:"; echo "     \"2.6.20\" "; echo "Please correct this."; exit 2
The UTS Release version in include/linux/utsrelease.h
     "2.6.20-adeos-xenomai2.3.0" 
does not match current version:
     "2.6.20" 
Please correct this.
make: *** [install/linux-image-2.6.20] Fehler 2


Thanks a lot for the fast reply!

Karl

-- 
von Karl Reichert

"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

