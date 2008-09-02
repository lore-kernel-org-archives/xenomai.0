Message-ID: <48BCEA5F.6000409@domain.hid>
Date: Tue, 02 Sep 2008 09:25:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C4E2375D.857%samf48@domain.hid>
In-Reply-To: <C4E2375D.857%samf48@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai kernel compile issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sam Ferguson <samf48@domain.hid>
Cc: xenomai@xenomai.org

Sam Ferguson wrote:
> Hello, I’m trying to compile Xenomai by following the Xenomai Quick build
> guide found on this page: <
> http://www.xenomai.org/index.php/Xenomai_quick_build_quide> however I run
> across a compiling error shown here:
> igvc@domain.hid$ sudo cp /boot/config-2.6.25.11
> .config
> igvc@domain.hid$ sudo make menuconfig
> scripts/kconfig/mconf arch/x86/Kconfig
> #
> # configuration written to .config
> #
> 
> 
> *** End of Linux kernel configuration.
> *** Execute 'make' to build the kernel or try 'make help'.
> 
> igvc@domain.hid$ sudo make

You do not need to compile as root. It is actually safer to compile as a
simple user. Could you post your .config ?

-- 
					    Gilles.

