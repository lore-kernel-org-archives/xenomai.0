Message-ID: <4C2A518F.8030302@domain.hid>
Date: Tue, 29 Jun 2010 22:03:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
In-Reply-To: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fredrik Asplund <fasplund@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Fredrik Asplund wrote:
> Hello, I am trying to get Xenomai to work with Gumstix Overo. I
> managed to set up a working build for the User Side, but when I tried
> to patch the Kernel source folder (which contains
> linux-omap3-2.6.33-r78 downloaded using
> "git://www.sakoman.com/git/linux-omap-2.6;branch=omap3-2.6.33") using
> the prepare-kernel.sh script I ran into problems. I guess the problem
> is that the patches do not work with that Kernel Version (see the
> attached log for details)? But how should I proceed to fix this? 
> Sincerely, / Fredrik

Xenomai 2.5.3 was tested on OMAP3 with the mainline kernel. If you
absolutely want to use this vendor branch, you will have to fix the
patch rejects by hand.

-- 
					    Gilles.

